# استخدم صورة Python الرسمية
FROM python:3.12.8-slim

# تعيين مسار العمل
WORKDIR /app

# نسخ الملفات إلى الحاوية
COPY requirements.txt .

# تثبيت cron والمكتبات الأساسية
RUN apt-get update && apt-get install -y cron \
    && rm -rf /var/lib/apt/lists/*  # لتقليل حجم الصورة

# تحديث pip وتثبيت المتطلبات
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# نسخ ملف المهام المجدولة
COPY crontab /etc/cron.d/update-libs
RUN chmod 0644 /etc/cron.d/update-libs \
    && echo "" >> /etc/cron.d/update-libs \
    && crontab -u root /etc/cron.d/update-libs

# نسخ بقية ملفات المشروع
COPY . .

# التأكد من تشغيل cron في الخلفية ثم تشغيل البوت
CMD cron && python grgr.py
