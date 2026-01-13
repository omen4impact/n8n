# Wir erzwingen das offizielle Debian-Image von n8n.
# Das garantiert Kompatibilität mit Node.js und einfachen Tool-Installs.
FROM n8nio/n8n:debian

USER root

# Installation via apt-get (Debian Standard)
# Wir installieren python3-venv, da neuere Python-Versionen das für pip/yt-dlp oft verlangen
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    imagemagick \
    ghostscript \
    poppler-utils \
    tesseract-ocr \
    tesseract-ocr-eng \
    tesseract-ocr-deu \
    tesseract-ocr-fra \
    curl \
    python3 \
    python3-venv \
    && \
# yt-dlp direkt von GitHub laden (Debian Repo Version ist oft zu alt für YouTube)
    curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp && \
    chmod a+rx /usr/local/bin/yt-dlp && \
# Aufräumen
    rm -rf /var/lib/apt/lists/*

# Ordnerrechte sicherstellen
RUN mkdir -p /data && chown -R node:node /data

USER node
