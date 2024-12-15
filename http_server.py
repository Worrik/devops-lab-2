from fastapi import FastAPI
from pydantic import BaseModel
from typing import List
from func_a import TrigonometricFunction

import time
import asyncio


app = FastAPI()


class CalculateResponse(BaseModel):
    values: List[float]
    elapsed_time_seconds: float


@app.get("/")
async def calculate(x: float, n: int) -> CalculateResponse:
    start_time = time.time()
    values = TrigonometricFunction.func_a(x, n)
    values.sort()
    elapsed_time = time.time() - start_time

    if elapsed_time < 10:
        await asyncio.sleep(10 - elapsed_time)

    elapsed_time = time.time() - start_time
    return CalculateResponse(values=values, elapsed_time_seconds=elapsed_time)
