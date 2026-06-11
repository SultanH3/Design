#!/usr/bin/env bash
# setup.sh — Auto-runs on every session start via SessionStart hook.
# Installs all tools needed to build anything. Idempotent: safe to run repeatedly.

set -euo pipefail

LOGFILE="/tmp/setup.log"

log() { echo "[setup] $1" | tee -a "$LOGFILE"; }

log "Starting environment setup..."

# ── Python packages ───────────────────────────────────────────────────────────
PYTHON_PKGS=(
  anthropic openai
  fastapi uvicorn[standard] flask flask-cors django djangorestframework
  sqlalchemy alembic psycopg2-binary pymongo motor redis celery
  pydantic python-dotenv pyjwt cryptography passlib bcrypt
  requests httpx aiohttp websockets paramiko
  stripe twilio sendgrid
  boto3 google-cloud-storage google-cloud-bigquery
  numpy pandas matplotlib seaborn scikit-learn pillow
  beautifulsoup4 lxml playwright
  python-docx openpyxl reportlab fpdf2
  rich typer click
)

log "Checking Python packages..."
MISSING_PY=()
for pkg in "${PYTHON_PKGS[@]}"; do
  base="${pkg%%[*}"   # strip extras like [standard]
  base="${base%%>*}"  # strip version constraints
  if ! python3 -c "import ${base//-/_}" &>/dev/null && \
     ! python3 -c "import ${base}" &>/dev/null; then
    MISSING_PY+=("$pkg")
  fi
done

if [[ ${#MISSING_PY[@]} -gt 0 ]]; then
  log "Installing ${#MISSING_PY[@]} Python packages..."
  pip3 install -q "${MISSING_PY[@]}" 2>>"$LOGFILE" || \
    pip3 install -q --break-system-packages "${MISSING_PY[@]}" 2>>"$LOGFILE" || true
else
  log "All Python packages present."
fi

# ── Node.js global packages ──────────────────────────────────────────────────
NODE_PKGS=(
  typescript ts-node tsx
  next react react-dom
  express fastify
  prisma @prisma/client drizzle-orm
  tailwindcss shadcn-ui
  vite vitest jest
  playwright puppeteer
  socket.io
  stripe nodemailer
  graphql apollo-server
  zod
  axios cheerio
  dotenv
  pm2
  @anthropic-ai/sdk
)

log "Checking Node.js packages..."
MISSING_NODE=()
for pkg in "${NODE_PKGS[@]}"; do
  if ! npm list -g "$pkg" &>/dev/null 2>&1; then
    MISSING_NODE+=("$pkg")
  fi
done

if [[ ${#MISSING_NODE[@]} -gt 0 ]]; then
  log "Installing ${#MISSING_NODE[@]} Node packages..."
  npm install -g -q "${MISSING_NODE[@]}" 2>>"$LOGFILE" || true
else
  log "All Node packages present."
fi

# ── System tools ─────────────────────────────────────────────────────────────
SYSTEM_TOOLS=(ffmpeg imagemagick sqlite3 tree jq)
MISSING_SYS=()
for tool in "${SYSTEM_TOOLS[@]}"; do
  command -v "$tool" &>/dev/null || MISSING_SYS+=("$tool")
done

if [[ ${#MISSING_SYS[@]} -gt 0 ]]; then
  log "Installing system tools: ${MISSING_SYS[*]}"
  apt-get install -y -q --fix-missing "${MISSING_SYS[@]}" 2>>"$LOGFILE" || true
fi

log "Setup complete. Log: $LOGFILE"
