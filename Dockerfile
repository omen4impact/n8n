FROM docker.n8n.io/n8nio/n8n:latest

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ffmpeg \
      imagemagick \
      tesseract-ocr \
      tesseract-ocr-eng \
      tesseract-ocr-deu \
      tesseract-ocr-fra \
      poppler-utils \
      ghostscript \
      python3-pip && \
    pip3 install --break-system-packages yt-dlp && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data && chown -R node:node /data

USER node
