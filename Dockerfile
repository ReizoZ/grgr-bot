# استخدم صورة Python الرسمية
FROM python:3.12.8-slim

# تعيين مسار العمل
WORKDIR /app

# نسخ الملفات إلى الحاوية
COPY requirements.txt .
# تثبيت cron
RUN apt-get update && apt-get install -y cron
# تحديث pip وتثبيت المتطلبات
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt
# نسخ ملف المهام المجدولة
COPY crontab /etc/cron.d/update-libs
RUN chmod 0644 /etc/cron.d/update-libs && crontab /etc/cron.d/update-libs
# نسخ بقية ملفات المشروع
COPY . .



# تشغيل cron مع البوت
CMD service cron start && python grgr.py