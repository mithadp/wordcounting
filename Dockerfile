# Menggunakan image dasar Python
FROM python:3.9-slim

# Instal dependensi sistem dan Python
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk-headless curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME untuk PySpark
ENV JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"

# Setel working directory
WORKDIR /app

# Menyalin file requirements
COPY requirements.txt .

# Menginstal dependensi Python
RUN pip install --no-cache-dir -r requirements.txt

# Menyalin aplikasi ke dalam container
COPY . .

# Menjalankan aplikasi Streamlit
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.headless=true"]
