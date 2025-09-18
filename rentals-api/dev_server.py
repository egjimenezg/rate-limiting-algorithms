from uvicorn import run

def main():
  run("rentals_api.main:app", reload=True, port=8000)
