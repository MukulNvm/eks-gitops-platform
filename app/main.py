from fastapi import FastAPI

app = FastAPI(title="Task API", version="0.1.0")


@app.get("/")
def root() -> dict[str, str]:
    return {"service": "task-api", "status": "running"}


@app.get("/healthz")
def health_check() -> dict[str, str]:
    return {"status": "ok"}