/usr/local/bin/unique-collator \
         --name quartz-stage\
         --collator \
         --base-path /chain-data \
         --chain ./quartz-v0.9.11.json \
         --port 30333 \
         --rpc-port 9833 \
         --ws-port 9844 \
         --no-prometheus \
         --no-mdns \
         --no-telemetry \
         --bootnodes /ip4/52.59.37.214/tcp/30333/p2p/12D3KooWQNrMaJNzkEU1p6NWk2wdgs9o2kbsHZ32BSpKdNXqgqRB \
            /ip4/15.188.5.164/tcp/30333/p2p/12D3KooWNtM2RZPAs6NFvb385TPDan46PA87baWu3W5EvKJgeig6 \
            /ip4/108.128.239.62/tcp/30333/p2p/12D3KooWSA9dSichQinjZPfg3LmYgmVyheEgTpmGLobSTvu74F99 \
         --unsafe-ws-external \
         --unsafe-rpc-external \
         -- \
         --execution wasm \
         --chain ./kusama-v0.9.11.json \
         --port 40333 \
         --rpc-port 9933 \
         --ws-port 9944 \
         --no-prometheus \
         --no-mdns \
         --no-telemetry
         