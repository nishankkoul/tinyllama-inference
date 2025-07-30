#!/bin/bash
set -e

echo "[INFO] Starting LLM server..."
./server -m /models/tinyllama.gguf \
  --port 8080 \
  --host 0.0.0.0 \
  --parallel 4 \
  --cont-batching \
  --n-predict 5 &

SERVER_PID=$!

# Wait for the server to boot up
sleep 2

echo "[INFO] Sending pre-warming request..."
curl -s -X POST http://localhost:8080/completion \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Hello",
    "n_predict": 1
  }' > /dev/null

echo "[INFO] Pre-warming complete."

# Keep the server process running
wait $SERVER_PID
