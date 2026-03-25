# Oficiálny Playwright obraz — má Chromium + všetky systémové knižnice
FROM mcr.microsoft.com/playwright/python:v1.52.0-noble

WORKDIR /app

# Skopíruj závislosti a nainštaluj
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Skopíruj kód
COPY main.py .

# Render používa port z env premennej PORT
CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}"]
