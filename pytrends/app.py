from fastapi import FastAPI, HTTPException, Query
from pytrends.request import TrendReq

app = FastAPI(
    title="pytrends-service",
    description="Liefert Google-Trends-Daten für n8n",
    version="1.0.0",
)

pytrend_session = TrendReq(
    hl="de-DE",
    tz=360,
    timeout=(10, 30),
    retries=2,
    backoff_factor=2,
)

@app.get("/health")
async def healthcheck():
    return {"status": "ok"}

@app.get("/trends")
async def get_trends(
    keyword: str = Query(..., description="Suchbegriff", min_length=1),
    geo: str = Query("DE", description="Region, z. B. DE, US"),
    timeframe: str = Query("today 12-m", description="z. B. today 12-m, now 7-d"),
):
    try:
        pytrend_session.build_payload([keyword], geo=geo, timeframe=timeframe)
        df = pytrend_session.interest_over_time()
        if df.empty:
            return {
                "keyword": keyword,
                "geo": geo,
                "timeframe": timeframe,
                "data": [],
                "note": "Keine Daten gefunden",
            }

        df = df.reset_index().rename(columns={"date": "timestamp"})
        return {
            "keyword": keyword,
            "geo": geo,
            "timeframe": timeframe,
            "data": df.to_dict(orient="records"),
        }
    except Exception as exc:
        raise HTTPException(status_code=500, detail=str(exc))
