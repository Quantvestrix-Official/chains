#!/bin/bash
# QVTX Expression Chain (chainId 20233) — Quaternary Binary Bridge Architecture
# Deploy script for server 162.0.222.112
# Run as root

CHAIN_DIR="/opt/qvtx_expression_chain"
DATA_DIR="$CHAIN_DIR/data"
GENESIS="$CHAIN_DIR/genesis.json"
GETH="/usr/bin/geth"   # geth v1.16.8

echo "[QVTX] Setting up Expression Chain directories..."
mkdir -p $DATA_DIR

# Write genesis
cat > $GENESIS << 'GENESIS_EOF'
{
  "config": {
    "chainId": 20233,
    "homesteadBlock": 0,
    "eip150Block": 0,
    "eip155Block": 0,
    "eip158Block": 0,
    "byzantiumBlock": 0,
    "constantinopleBlock": 0,
    "petersburgBlock": 0,
    "istanbulBlock": 0,
    "berlinBlock": 0,
    "londonBlock": 0,
    "clique": {
      "period": 4,
      "epoch": 30000
    }
  },
  "difficulty": "0x1",
  "gasLimit": "0x47b760",
  "extradata": "0x000000000000000000000000000000000000000000000000000000000000000004ee586B2B1D15a691C3aD02B465cc69578aAd580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  "alloc": {
    "5838a54238E4595e073b403830D79AF6e4E8d86e": {
      "balance": "0x33b2e3c9fd0803ce8000000"
    },
    "0402e8Da0EfBd357694f7Fe46930d8360EcE45da": {
      "balance": "0x19d971e4fe8401e74000000"
    },
    "04ee586B2B1D15a691C3aD02B465cc69578aAd58": {
      "balance": "0x52b7d2dcc80cd2e4000000"
    },
    "0000000000000000000000000000000000000001": {
      "balance": "0x84595161401484a000000"
    },
    "0000000000000000000000000000000000000002": {
      "balance": "0x84595161401484a000000"
    },
    "0000000000000000000000000000000000000003": {
      "balance": "0x84595161401484a000000"
    },
    "0000000000000000000000000000000000000004": {
      "balance": "0x84595161401484a000000"
    },
    "0000000000000000000000000000000000000005": {
      "balance": "0x84595161401484a000000"
    },
    "0000000000000000000000000000000000000006": {
      "balance": "0x84595161401484a000000"
    },
    "0000000000000000000000000000000000000007": {
      "balance": "0x84595161401484a000000"
    },
    "0000000000000000000000000000000000000008": {
      "balance": "0x84595161401484a000000"
    }
  },
  "coinbase": "0x0000000000000000000000000000000000000000",
  "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "timestamp": "0x00",
  "nonce": "0x0000000000000042"
}
GENESIS_EOF

echo "[QVTX] Initializing Expression Chain with genesis..."
$GETH init --datadir $DATA_DIR $GENESIS

echo "[QVTX] Starting QVTX Expression Chain node..."
nohup $GETH \
  --datadir $DATA_DIR \
  --networkid 20233 \
  --port 30306 \
  --http \
  --http.addr 0.0.0.0 \
  --http.port 8551 \
  --http.api eth,net,web3,miner,admin,txpool \
  --http.corsdomain "*" \
  --ws \
  --ws.addr 0.0.0.0 \
  --ws.port 8552 \
  --ws.api eth,net,web3 \
  --authrpc.port 8553 \
  --mine \
  --miner.etherbase 0x04ee586B2B1D15a691C3aD02B465cc69578aAd58 \
  --allow-insecure-unlock \
  --nodiscover \
  --syncmode full \
  --unlock 0x04ee586B2B1D15a691C3aD02B465cc69578aAd58 \
  --password /dev/null \
  2>&1 | tee $CHAIN_DIR/node.log &

echo "[QVTX] Expression Chain started on port 8551"
echo "[QVTX] ChainId: 20233 | NetworkId: 20233"
echo "[QVTX] Bridge Receptors: ETH BSC POLY SOL BTC ATOM DOT AVAX"
echo "[QVTX] Quaternary states: 00=HOLD 01=BUY 10=SELL 11=BRIDGE"
