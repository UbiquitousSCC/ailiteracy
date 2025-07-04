FROM python:3.9-slim

WORKDIR /app

# 複製必要檔案
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY backend/ ./backend/
COPY .env ./

# Railway 會設定 PORT 環境變數
ENV PORT=5000

# 使用 Railway 提供的 PORT
CMD gunicorn --workers 1 --bind 0.0.0.0:$PORT "backend:create_app()"