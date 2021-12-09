# Run Quartz Node in Docker

This is a tool for building and running the local Quartz node from the specified branch.

## Hardware Requirements

- 300GB SSD disk (aws gp3 default iops would be enough)
- 2 real CPU cores (==4 with HT) high performance core (cloud compute instances only)
- 8GB RAM
- 100GB swap (use cloud instances with local disk, do not use network drives for swap)
- Ports 40333, and 30333 should be open for both in- and out-bound traffic
- Port 9844 should be open for in-bound traffic

## Step 0 (temporary): Get access to unique-chain git repository

1. Ask Unique team for read access to the repository

2. Generate personal access token in Github with full access to private repositories

3. Copy .env.example into .env file

4. Add your user name and personal access token to .env file:

Note: You can use your password instead of access token if you don't have 2FA setup.

```
GITHUB_USERNAME=<put your GitHub user name here>
GITHUB_ACCESS_TOKEN=<put your GitHub personal access token (or password) here>
UNIQUE_BRANCH=release/quartz-v913010
```

## Step 1: Run

```
docker-compose up -d --build
```

## Step 2: Check

Open this URL in the browser to check that the node is running:

https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9844#/explorer

Note: New blocks will appear after both Quartz and Kusama nodes fully sync. Kusama syncing may take up to a few days.

## Step 3: Use

The node can be used locally on this URL: ws://127.0.0.1:9844

## How to update the node

Frequently we release updates following the Kusama updates. In order to apply the Quartz node update, change the branch in the .env file:
```
UNIQUE_BRANCH=<new release branch here>
```

...and build the container again. This will not restart syncing and the node will catch up with blocks immediately:
```
docker-compose down
sudo docker-compose up -d --build
```

## How to clean and restart

If something goes really wrong (like you're seeing lots of error messages in the docker log for the node), the full restart may be performed like following (note that a full resyncing will be required):

1. Cleanup 
```
docker stop quartz_node
docker system prune
sudo rm -rf chain-data
```

2. Restart
```
docker-compose up -d --build
```

