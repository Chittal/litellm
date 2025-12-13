# Use the official LiteLLM image with database support
FROM ghcr.io/berriai/litellm-database:main-stable

# Set working directory
WORKDIR /app

# Copy configuration file
COPY litellm_config.yaml /app/config.yaml

# Create logs directory
RUN mkdir -p /app/logs

# Expose port
EXPOSE 4000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD curl -f http://localhost:4000/health || exit 1

# Default command
CMD ["litellm", "--config", "/app/config.yaml", "--detailed_debug"]
