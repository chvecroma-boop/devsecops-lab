# ===== Стадия 1: builder — ставим зависимости в полном образе =====
FROM python:3.11-slim AS builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir --target=/app/packages -r requirements.txt

# ===== Стадия 2: финал — минимальный distroless, только нужное =====
FROM gcr.io/distroless/python3-debian12:nonroot

WORKDIR /app
ENV PYTHONPATH=/app/packages
COPY --from=builder /app/packages /app/packages
COPY app.py .

EXPOSE 5000
CMD ["app.py"]