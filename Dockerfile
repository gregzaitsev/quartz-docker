# ===== Rust builder =====
FROM phusion/baseimage:0.10.2 as builder
LABEL maintainer="Unique.Network"

ARG RUST_TOOLCHAIN=1.56.1
ARG UNIQUE_BRANCH=develop
ARG GITHUB_ACCESS_TOKEN=
ARG GITHUB_USERNAME=
ARG PROFILE=release

ENV RUST_TOOLCHAIN $RUST_TOOLCHAIN
ENV UNIQUE_BRANCH $UNIQUE_BRANCH
ENV GITHUB_ACCESS_TOKEN $GITHUB_ACCESS_TOKEN
ENV GITHUB_USERNAME $GITHUB_USERNAME

ENV CARGO_HOME="/cargo-home"
ENV PATH="/cargo-home/bin:$PATH"

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain none

RUN apt-get update && \
    apt-get dist-upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y cmake pkg-config libssl-dev git clang libclang-3.9-dev

RUN rustup toolchain uninstall $(rustup toolchain list) && \
    rustup toolchain install $RUST_TOOLCHAIN && \
    rustup default $RUST_TOOLCHAIN && \
    rustup target list --installed

RUN mkdir unique_parachain
WORKDIR /unique_parachain

RUN git clone https://$GITHUB_USERNAME:$GITHUB_ACCESS_TOKEN@github.com/uniquenetwork/unique-chain --branch "$UNIQUE_BRANCH" /unique_parachain
RUN export PATH="$PATH:$HOME/.cargo/bin" && \
    export SKIP_WASM_BUILD=1 && \
    rustup show && \
    git branch && \
    cargo build "--$PROFILE"

RUN cd target/release && ls -la

# ===== RUN ======

FROM phusion/baseimage:0.10.2
ARG PROFILE=release

COPY --from=builder /unique_parachain/target/$PROFILE/unique-collator /usr/local/bin

RUN ls -la /usr/local/bin

EXPOSE 9844
EXPOSE 9833
EXPOSE 40333
EXPOSE 30333

VOLUME ["/chain-data"]

# Copy and run start script
COPY ["./run.sh", "./run.sh"]
COPY ["./chain-specs/kusama-v0.9.11.json", "./kusama-v0.9.11.json"]
COPY ["./chain-specs/quartz-v0.9.11.json", "./quartz-v0.9.11.json"]
RUN chmod +x ./run.sh
CMD ["bash", "-c", "./run.sh"]