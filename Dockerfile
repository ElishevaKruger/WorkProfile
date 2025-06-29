FROM python:3.9-slim

# משתנים למניעת קבצי cache
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# התקנת תלות ל-mysqlclient
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# תיקייה לעבודה
WORKDIR /app

# העתקת requirements
COPY requirements.txt .

# התקנת החבילות
RUN pip install --no-cache-dir -r requirements.txt

# העתקת הקוד
COPY static/ static/
COPY templates/ templates/
COPY app.py dbcontext.py person.py ./

EXPOSE 5000

CMD ["python", "app.py"]

