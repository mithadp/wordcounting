import streamlit as st
from pyspark.sql import SparkSession

# Inisialisasi Spark
spark = SparkSession.builder \
    .appName("WordCountApp") \
    .getOrCreate()

# Judul aplikasi
st.title("Penghitung Jumlah Kata dalam Kalimat")

# Input dari pengguna
text_input = st.text_area("Masukkan teks di sini:")

# Menghitung jumlah kata
if text_input:
    # Membuat DataFrame dari input
    df = spark.createDataFrame([(text_input,)], ["text"])
    word_count = df.selectExpr("size(split(text, ' ')) as word_count").collect()[0].word_count
    st.write(f"Jumlah kata: {word_count}")
else:
    st.write("Silakan masukkan teks untuk menghitung jumlah kata dalam kalimat.")
