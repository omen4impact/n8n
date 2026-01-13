FROM docker.n8n.io/n8nio/n8n:latest

USER root

# 1. System auf Debian-Art aktualisieren und Pakete installieren
# Wir brauchen curl und python3 für yt-dlp
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
# 2. yt-dlp direkt von GitHub holen (damit es aktuell ist)
    curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp && \
    chmod a+rx /usr/local/bin/yt-dlp && \
# 3. Aufräumen (apt cache leeren)
    rm -rf /var/lib/apt/lists/*

# Ordner /data anlegen und node-Benutzer Rechte geben
RUN mkdir -p /data && chown -R node:node /data

USER node
