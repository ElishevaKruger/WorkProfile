# ===================== STAGE 1 - Build =====================
FROM python:3.9-slim AS builder

# התקנת כלים הדרושים רק לבנייה
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .

# מתקין את כל התלויות בסביבה נפרדת שנעתיק אחר כך
RUN pip install --user --no-cache-dir -r requirements.txt

# ===================== STAGE 2 - Runtime =====================
FROM python:3.9-slim

WORKDIR /app

# נעתיק רק את התלויות מהשלב הקודם
COPY --from=builder /root/.local /root/.local

# נוודא שפייתון מוצא את ההתקנות האלו
ENV PATH=/root/.local/bin:$PATH

# נעתיק את כל קבצי האפליקציה
COPY static/ static/
COPY templates/ templates/
COPY app.py dbcontext.py person.py ./

# הרצת האפליקציה
CMD ["python", "app.py"]

