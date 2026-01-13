# Wir nutzen das offizielle Docker Hub Image.
# WICHTIG: "n8nio/n8n:latest" ist Debian Bookworm basierend.
FROM n8nio/n8n:latest

USER root

# Installation via apt-get (da Debian Base)
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
# yt-dlp direkt von GitHub laden (da Debian Repo Version oft zu alt für YouTube ist)
    curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp && \
    chmod a+rx /usr/local/bin/yt-dlp && \
# Aufräumen
    rm -rf /var/lib/apt/lists/*

# Ordnerrechte sicherstellen
RUN mkdir -p /data && chown -R node:node /data

USER node
