from fastapi import FastAPI

app = FastAPI(title="Rentals API")

@app.get("/health")
def health():
  return {"status": "ok"}

