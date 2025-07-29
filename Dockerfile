FROM ghcr.io/ggml-org/llama.cpp:server

# Create the model directory
RUN mkdir -p /models

# Copy the model into container
COPY models/tinyllama.gguf /models/tinyllama.gguf

# Expose the API port
EXPOSE 8080

# Run the LLM server with batching and limited output tokens
CMD ["-m", "/models/tinyllama.gguf", "--port", "8080", "--host", "0.0.0.0", "--parallel", "4", "--cont-batching", "--n-predict", "5"]
