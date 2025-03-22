# استخدم صورة Python الرسمية
FROM python:3.12.8-slim

# تعيين مسار العمل
WORKDIR /app

# نسخ الملفات إلى الحاوية
COPY requirements.txt .

# تحديث pip وتثبيت المتطلبات
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# نسخ بقية ملفات المشروع
COPY . .

# تشغيل البوت
CMD ["python", "grgr.py"]
