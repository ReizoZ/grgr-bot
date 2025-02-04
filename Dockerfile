# Use Python 3.12.8 official image
FROM python:3.12.8-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt



# Command to run your bot
CMD ["python", "grgr.py"]
