# Wir nutzen das öffentliche Image vom Docker Hub.
# FAKT: Dieses Image basiert auf Alpine Linux.
FROM n8nio/n8n:latest

USER root

# Da es Alpine ist, MÜSSEN wir 'apk' nutzen.
# (apt-get existiert hier nicht, daher der Fehler 127 vorhin)
RUN apk update && \
    apk add --no-cache \
    ffmpeg \
    imagemagick \
    ghostscript \
    poppler-utils \
    curl \
    python3 \
    py3-pip \
    tesseract-ocr \
    # In Alpine heißen die Sprachpakete zwingend so:
    tesseract-ocr-data-eng \
    tesseract-ocr-data-deu \
    tesseract-ocr-data-fra && \
    # yt-dlp manuell laden
    curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp && \
    chmod a+rx /usr/local/bin/yt-dlp && \
    # Aufräumen
    rm -rf /var/cache/apk/*

# Ordnerrechte sicherstellen
RUN mkdir -p /data && chown -R node:node /data

USER node
