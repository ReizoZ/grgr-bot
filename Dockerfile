FROM python:3.12.8-slim

# تثبيت `cron` وأدوات أخرى
RUN apt update && apt install -y cron && rm -rf /var/lib/apt/lists/*

# نسخ الملفات
COPY requirements.txt .
COPY . .

# إضافة مهمة `cron` لتحديث المكتبات كل ساعة
RUN echo "0 * * * * root pip install --no-cache-dir -r /requirements.txt" > /etc/cron.d/pip_update

# إعطاء صلاحيات تشغيل للكرون
RUN chmod 0644 /etc/cron.d/pip_update && crontab /etc/cron.d/pip_update

# تشغيل الكرون ثم تشغيل البوت
CMD service cron start && python grgr.py
