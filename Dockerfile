FROM python:3.12-alpine AS builder
WORKDIR /src
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

FROM python:3.12-alpine
WORKDIR /app
COPY --from=builder /install /usr/local
RUN addgroup -S appgroup \
    && adduser -S appuser -G appgroup
COPY --chown=appuser:appgroup . .

ENV PORT=8005

EXPOSE 8005
USER appuser

CMD ["python", "app.py"]
