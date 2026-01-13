FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Explizit Shell und PATH setzen
SHELL ["/bin/sh", "-c"]
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

RUN /sbin/apk update && \
    /sbin/apk add --no-cache \
      ffmpeg \
      yt-dlp \
      imagemagick \
      tesseract-ocr \
      tesseract-ocr-data-eng \
      tesseract-ocr-data-deu \
      tesseract-ocr-data-fra \
      poppler-utils \
      ghostscript

# Ordner /data anlegen und node-Benutzer Rechte geben
RUN mkdir -p /data && chown -R node:node /data

USER node
