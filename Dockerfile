FROM python:3.10-slim as builder

WORKDIR /app

RUN apt-get update && apt-get install -y git \
    && git clone --branch branchHTTPservMutli https://github.com/Worrik/devops-lab-2.git .

RUN pip install -r requirements.txt

FROM alpine:3.18

WORKDIR /app

COPY --from=builder /app /app

RUN apk add --no-cache python3 py3-pip

EXPOSE 8000

CMD ["uvicorn", "http_server:app", "--host", "0.0.0.0", "--port", "8000"]

