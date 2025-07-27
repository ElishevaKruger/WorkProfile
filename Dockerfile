# שימוש בתמונה בסיסית של פייתון
FROM python:3.10-slim

# יצירת תיקייה לאפליקציה
WORKDIR /app

# העתקת קבצי הדרישות
COPY requirements.txt .

# התקנת הספריות
RUN pip install --no-cache-dir -r requirements.txt

# העתקת שאר הקבצים
COPY . .

# פתיחת פורט 5000
EXPOSE 5000

# הרצת האפליקציה
CMD ["python", "app.py"]
