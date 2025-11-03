FROM python:3.9-slim

# Set the working dir in the container
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Set ENV Variable
ENV FLASK_ENV=production
EXPOSE 5000

# Start Flask
CMD ["python", "app.py"]
