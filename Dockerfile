FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Alpine: apk ist unter /sbin/apk
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

RUN mkdir -p /data && chown -R node:node /data

USER node
