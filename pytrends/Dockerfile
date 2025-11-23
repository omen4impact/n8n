FROM python:3.11-bullseye

WORKDIR /app

# Neu:
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      python3-dev \
      libffi-dev \
      libssl-dev \
    && rm -rf /var/lib/apt/lists/*

COPY pytrends/requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY pytrends/ .
ENV TZ=Europe/Berlin

EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
