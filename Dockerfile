# Starte mit dem gleichen Base Image wie n8n
FROM n8nio/n8n:1.121.0 

# Installiere zuerst alle System-Tools
RUN apk add --no-cache \
    ffmpeg \
    yt-dlp \
    imagemagick \
    tesseract-ocr \
    tesseract-ocr-data-eng \
    tesseract-ocr-data-deu \
    tesseract-ocr-data-fra \
    poppler-utils \
    ghostscript \
    tini

# Installiere n8n global
RUN npm install -g n8n

# Erstelle node user falls nicht vorhanden
RUN addgroup -g 1000 node || true && \
    adduser -u 1000 -G node -s /bin/sh -D node || true

# Arbeitsverzeichnis
WORKDIR /home/node

RUN mkdir -p /data && chown -R node:node /data

USER node

EXPOSE 5678

ENTRYPOINT ["tini", "--"]
CMD ["n8n"]
