FROM docker.n8n.io/n8nio/n8n:latest

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ffmpeg \
      yt-dlp \
      imagemagick \
      tesseract-ocr \
      tesseract-ocr-eng \
      tesseract-ocr-deu \
      tesseract-ocr-fra \
      poppler-utils \
      ghostscript \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Ordner /data anlegen und node-Benutzer Rechte geben
RUN mkdir -p /data && chown -R node:node /data

USER node
