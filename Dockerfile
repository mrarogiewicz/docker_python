FROM python:3.11-slim

# Pevná cesta kde bude Chromium — musí byť nastavená PRED inštaláciou aj za runtime
ENV PLAYWRIGHT_BROWSERS_PATH=/pw-browsers

# Systémové knižnice ktoré Chromium potrebuje
RUN apt-get update && apt-get install -y \
    wget curl gnupg ca-certificates \
    libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 \
    libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 \
    libxfixes3 libxrandr2 libgbm1 libasound2 \
    libpango-1.0-0 libpangocairo-1.0-0 \
    fonts-liberation libappindicator3-1 \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Inštaluj Chromium do /pw-browsers
RUN playwright install chromium

COPY main.py .

CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}"]
