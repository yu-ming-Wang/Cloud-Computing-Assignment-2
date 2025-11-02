# 使用官方 Python 3.11 精簡映像
FROM python:3.9-slim

# Set the working dir in the container
WORKDIR /app

# 複製需求清單並安裝
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 複製全部檔案進容器
COPY . .

# Set ENV Variable
ENV FLASK_ENV=production
EXPOSE 5000

# Start Flask
CMD ["python", "app.py"]
