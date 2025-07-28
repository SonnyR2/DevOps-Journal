from fastapi import FastAPI
from dotenv import load_dotenv
from app.controllers import journal_router
import logging

load_dotenv()

# TODO: Setup basic console logging
# Hint: Use logging.basicConfig() with level=logging.INFO
logging.basicConfig(level=logging.INFO)

app = FastAPI()
app.include_router(journal_router)