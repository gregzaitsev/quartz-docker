# Run Quartz Node in Docker

This is a tool for building and running the local Quartz node from the specified branch.

## Step 0 (temporary): Get access to unique-chain git repository

1. Ask Unique team for read access to the repository

2. Generate personal access token in Github with full access to private repositories

3. Copy .env.example into .env file

4. Add your user name and personal access token to .env file:

Note: You can use your password instead of access token if you don't have 2FA setup.

```
GITHUB_USERNAME=<put your GitHub user name here>
GITHUB_ACCESS_TOKEN=<put your GitHub personal access token (or password) here>
UNIQUE_BRANCH=release/opal-v912210
```

## Step 1: Run

```
docker-compose up -d --build
```

## Step 2: Check

Open this URL in the browser to check that the node is running:

https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9844#/explorer

Note: New blocks will appear after both Quartz and Kusama nodes fully sync. This may take up to a few hours.

## Step 3: Use

The node can be used locally on this URL: ws://127.0.0.1:9844
