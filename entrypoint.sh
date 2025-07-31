#!/bin/bash
set -e

echo "[INFO] Starting LLM server..."
./llama-server -m /models/tinyllama.gguf \
  --port 8080 \
  --host 0.0.0.0 \
  --parallel 4 \
  --cont-batching \

SERVER_PID=$!

# Wait for the server to start up
sleep 2

echo "[INFO] Sending pre-warming request..."
curl -s -X POST http://localhost:8080/completion \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Hello",
    "n_predict": 1
  }' > /dev/null

echo "[INFO] Pre-warming complete."

# Keep the server running
wait $SERVER_PID
