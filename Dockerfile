FROM docker.n8n.io/n8nio/n8n:latest

USER root

RUN apk update && \
    apk add --no-cache \
      ffmpeg \
      imagemagick \
      tesseract-ocr \
      tesseract-ocr-data-eng \
      tesseract-ocr-data-deu \
      tesseract-ocr-data-fra \
      poppler-utils \
      ghostscript \
    && rm -rf /var/cache/apk/*

USER node
