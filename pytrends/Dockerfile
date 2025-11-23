FROM python:3.11-bullseye

WORKDIR /app

COPY pytrends/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY pytrends/ .
ENV TZ=Europe/Berlin

EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
