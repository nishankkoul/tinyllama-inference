FROM ghcr.io/ggml-org/llama.cpp:server

# Create the model directory
RUN mkdir -p /models

# Copy the model into container
COPY models/tinyllama.gguf /models/tinyllama.gguf

# Expose the API port
EXPOSE 8080

# Just pass the arguments; base image already has the entrypoint set
CMD ["-m", "/models/tinyllama.gguf", "--port", "8080", "--host", "0.0.0.0"]