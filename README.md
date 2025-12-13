# LiteLLM Configuration

This directory contains a properly formatted LiteLLM setup based on the [official LiteLLM container](https://github.com/berriai/litellm/pkgs/container/litellm).

## Files Structure

- `docker-compose.yml` - Docker Compose configuration
- `litellm_config.yaml` - LiteLLM configuration file
- `README.md` - This documentation

## Environment Variables Setup

### ⚠️ REQUIRED VARIABLES

You **MUST** set these environment variables before starting LiteLLM:

```bash
# REQUIRED - LiteLLM Core Settings
LITELLM_MASTER_KEY=sk-1234                    # Your master key for the proxy server
LITELLM_SALT_KEY=sk-XXXXXXXX                  # ⚠️ CANNOT CHANGE ONCE SET - Used to encrypt/decrypt credentials
DATABASE_URL=postgres://user:pass@host:5432/db  # PostgreSQL database connection string
```

### Optional Variables

```bash
# Optional LiteLLM Settings
PORT=4000                                     # Server port (default: 4000)
STORE_MODEL_IN_DB=True                       # Allow storing models in database

# API Keys (Set these to your actual values)
OPENAI_API_KEY=your-openai-api-key-here
GROQ_API_KEY=your-groq-api-key-here

# AWS Bedrock (Optional)
AWS_ACCESS_KEY_ID=your-aws-access-key-id
AWS_SECRET_ACCESS_KEY=your-aws-secret-access-key
AWS_REGION=us-east-1
AWS_REGION_NAME=us-east-1

# Redis (Optional - for caching)
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=

# Ollama (if using local models)
OLLAMA_BASE_URL=http://localhost:11434
```

### Database Setup Options

**Option 1: PostgreSQL (Recommended)**
- Use services like [Supabase](https://supabase.com), [Neon](https://neon.tech), or [Railway](https://railway.app)
- Example: `DATABASE_URL=postgres://user:password@host:5432/litellm`

**Option 2: SQLite (Development)**
- For local development only: `DATABASE_URL=sqlite:///litellm.db`

## Quick Start

1. **Create environment file:**
   ```bash
   cp env.template .env
   # Edit .env with your actual values
   ```

2. **Set up database (Choose one):**
   
   **Option A: PostgreSQL (Recommended)**
   - Sign up for [Supabase](https://supabase.com), [Neon](https://neon.tech), or [Railway](https://railway.app)
   - Get your database connection string
   - Update `DATABASE_URL` in `.env`

   **Option B: SQLite (Development only)**
   - Use: `DATABASE_URL=sqlite:///litellm.db`

3. **Set required environment variables:**
   ```bash
   # Edit .env file and set these REQUIRED variables:
   LITELLM_MASTER_KEY=sk-your-unique-master-key
   LITELLM_SALT_KEY=sk-your-unique-salt-key
   DATABASE_URL=your-database-connection-string
   ```

4. **Create logs directory:**
   ```bash
   mkdir -p logs
   ```

5. **Start LiteLLM:**
   ```bash
   docker-compose up -d
   ```

6. **Check status:**
   ```bash
   docker-compose ps
   docker-compose logs litellm
   ```

## Configuration Features

### Models Supported
- **Groq**: Llama 3.1 8B Instant
- **Ollama**: Qwen3 1.7B, Llama3.2 3B, Falcon3 1B (Local)
- **OpenAI**: GPT-4.1 Nano
- **AWS Bedrock**: Claude 3 Sonnet, Amazon Titan

### Features Enabled
- ✅ Health checks
- ✅ Logging with rotation
- ✅ Rate limiting
- ✅ Fallback models
- ✅ Function calling support
- ✅ Redis caching (optional)

## API Usage

Once running, LiteLLM will be available at `http://localhost:4000`

### Example API calls:

```bash
# List models
curl http://localhost:4000/v1/models

# Chat completion
curl -X POST http://localhost:4000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer your-master-key" \
  -d '{
    "model": "groq-llama",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

## Monitoring

- **Health Check**: `http://localhost:4000/health`
- **Logs**: `./logs/litellm.log`
- **Docker Logs**: `docker-compose logs -f litellm`

## Troubleshooting

1. **Check container status:**
   ```bash
   docker-compose ps
   ```

2. **View logs:**
   ```bash
   docker-compose logs litellm
   ```

3. **Restart service:**
   ```bash
   docker-compose restart litellm
   ```

4. **Update to latest image:**
   ```bash
   docker-compose pull
   docker-compose up -d
   ```