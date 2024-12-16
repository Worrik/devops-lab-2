FROM python:3.10-alpine as builder

WORKDIR /app

RUN apk add --no-cache git

RUN git clone --branch branchHTTPservMutli https://github.com/Worrik/devops-lab-2.git .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

FROM python:3.10-alpine

WORKDIR /app

COPY --from=builder /app /app
COPY --from=builder /install /usr/local

EXPOSE 8000

CMD ["uvicorn", "http_server:app", "--host", "0.0.0.0", "--port", "8000"]
