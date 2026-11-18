#Instal Paket RMySQL
install.packages("RMySQL")
#1. Buatlah koneksi ke MySQL dan gunakan/buatlah database yang bernama employees_d
#Tuliskan kode R yang digunakan (untuk koneksi dan menggunakan/membuat database).
#Memuat library
library(RMySQL)
#Membuat koneksi ke MySQL Server
conn <- dbConnect(RMySQL::MySQL(),
                  user = "root",
                  password = "24Raisya07",
                  host = "localhost",
                  port = 3306)
#Membuat database baru
dbExecute(conn, "CREATE DATABASE IF NOT EXISTS employees_db")
#Menggunakan database
dbExecute(conn, "USE employees_db")
#Memeriksa database yang berhasil dibuat
list_db <- dbGetQuery(conn, "SHOW DATABASES")
print(list_db)

#2. Misalkan dalam database employees_db ada tabel bernama employees yang berisi
#informasi karyawan. Tulis kode untuk mengambil semua data dari tabel employees
#dan menyimpannya ke dalam data frame di R. Tuliskan kode R yang digunakan.
#Membuat tabel employees
dbExecute(conn, "CREATE TABLE employees (id INT PRIMARY KEY,
name VARCHAR(100),
position VARCHAR(100),
department VARCHAR(100),
salary INT)")
#Memasukkan 10 data karyawan
dbExecute(conn, "INSERT INTO employees (id, name, position, department, salary)
VALUES
(203, 'Hendra', 'Software Engineer', 'IT', 10500),
(102, 'Andi', 'Data Analyst', 'Data Science', 7200),
(501, 'Qori', 'Sales Staff', 'Sales', 4800),
(302, 'Karin', 'HR Staff', 'Human Resources', 5800),
(401, 'Maya', 'Marketing Specialist', 'Marketing', 8500),
(204, 'Intan', 'Software Engineer', 'IT', 9200),
(105, 'Dina', 'Data Analyst', 'Data Science', 8100),
(503, 'Salsa', 'Sales Staff', 'Sales', 6700),
(301, 'Joko', 'HR Staff', 'Human Resources', 5200),
(402, 'Nanda', 'Marketing Specialist', 'Marketing', 6900)")

#Mengambil seluruh data dari tabel employees
dbGetQuery(conn, "SELECT * FROM employees")

#3. Masih dalam tabel employees, ambil data karyawan yang bekerja di departemen Sales.
#Tuliskan kode R yang digunakan.
dbGetQuery(conn,"SELECT * FROM employees WHERE department = 'Sales'")

#4. Menambahkan data karyawan baru
dbExecute(conn, "INSERT INTO employees (id, name, position, department, salary)
VALUES (101, 'Son Heung Min', 'Data Analyst', 'Data Science', 7000)")
#Menampilkan data karyawan setelah penambahan
dbGetQuery(conn, "SELECT * FROM employees")

#5. Memperbarui gaji karyawan dengan ID 101
dbExecute(conn, "UPDATE employees SET salary = 8000 WHERE id = 101")
#Menampilkan data setelah pembaruan
dbGetQuery(conn, "SELECT * FROM employees")

#6. Menghapus karyawan dengan ID 101
dbExecute(conn, "DELETE FROM employees WHERE id = 101")
#Menampilkan data setelah penghapusan
dbGetQuery(conn, "SELECT * FROM employees")

#Menampilkan Data Analyst dengan urutan nama A-Z
data_analyst <- dbGetQuery(conn, "SELECT * FROM employees
WHERE position = 'Data Analyst'
ORDER BY name ASC")
#Menampilkan hasil
print(data_analyst)

#Mengambil data gaji dari MySQL
data_employees <- dbGetQuery(conn,"SELECT * FROM employees")
#Membuat histogram gaji
hist(data_employees$salary,
     main = "Histogram Gaji Karyawan",
     xlab = "Gaji Karyawan",
     ylab = "Frekuensi")

#7. Menutup koneksi database
dbDisconnect(conn)
