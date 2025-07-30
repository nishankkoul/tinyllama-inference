FROM ghcr.io/ggml-org/llama.cpp:server

# Create the model directory
RUN mkdir -p /models

# Copy the model into container
COPY models/tinyllama.gguf /models/tinyllama.gguf

# Copy the pre-warming entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the API port
EXPOSE 8080

# Start with the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]