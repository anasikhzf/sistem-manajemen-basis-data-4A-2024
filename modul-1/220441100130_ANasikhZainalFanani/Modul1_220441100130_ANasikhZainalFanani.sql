CREATE DATABASE modul1;
USE modul1;

CREATE TABLE Pelanggan (
    ID_Pelanggan INT PRIMARY KEY,
    Nama_Pelanggan VARCHAR(100),
    Alamat VARCHAR(255)
);

CREATE TABLE Barang (
    ID_Barang INT PRIMARY KEY,
    Nama_Barang VARCHAR(100),
    Harga DECIMAL(10, 2),
    Stok INT
);

CREATE TABLE Transaksi (
    ID_Detail_Transaksi INT PRIMARY KEY,
    ID_Transaksi INT,
    ID_Barang INT,
    Jumlah INT,
    Harga DECIMAL(10, 2),
    Total DECIMAL(10, 2)
);

CREATE TABLE Stok (
    ID_Koreksi INT PRIMARY KEY,
    Tanggal DATE,
    ID_Barang INT,
    Jumlah INT,
    Keterangan VARCHAR(255)
);

CREATE TABLE Pengembalian (
    ID_Pengembalian INT PRIMARY KEY,
    ID_Transaksi INT,
    ID_Barang INT,
    Jumlah INT,
    Tanggal DATE
);



INSERT INTO Pelanggan (ID_Pelanggan, Nama_Pelanggan, Alamat) VALUES
(1, 'Pak Slamet', 'Jl. Raya No. 123'),
(2, 'Bu Siti', 'Jl. Mangga No. 45'),
(3, 'Mas Joko', 'Jl. Melati No. 67'),
(4, 'Mbak Sri', 'Jl. Anggrek No. 89'),
(5, 'Pak Jaka', 'Jl. Dahlia No. 10'),
(6, 'Bu Eni', 'Jl. Mawar No. 22'),
(7, 'Pak Udin', 'Jl. Kenanga No. 33'),
(8, 'Bu Atik', 'Jl. Flamboyan No. 44'),
(9, 'Mas Budi', 'Jl. Cendana No. 55'),
(10, 'Bu Yati', 'Jl. Seroja No. 66');

INSERT INTO Barang (ID_Barang, Nama_Barang, Harga, Stok) VALUES
(1, 'Gula', 10000, 50),
(2, 'Kopi', 20000, 30),
(3, 'Teh', 15000, 40),
(4, 'Mie Instan', 5000, 60),
(5, 'Sabun Mandi', 7000, 70),
(6, 'Shampoo', 12000, 40),
(7, 'Pasta Gigi', 8000, 50),
(8, 'Sikat Gigi', 5000, 60),
(9, 'Beras', 25000, 20),
(10, 'Minyak Goreng', 15000, 30);

INSERT INTO Transaksi ( ID_Transaksi, ID_Barang, Jumlah, Harga, Total) VALUES
( 1, 1, 2, 10000, 20000),
( 2, 2, 1, 20000, 20000),
( 3, 3, 3, 15000, 45000),
( 4, 4, 5, 5000, 25000),
( 5, 5, 2, 7000, 14000),
( 6, 6, 4, 12000, 48000),
( 7, 7, 3, 8000, 24000),
( 8, 8, 2, 5000, 10000),
( 9, 9, 1, 25000, 25000);

INSERT INTO Stok (ID_Koreksi, Tanggal, ID_Barang, Jumlah, Keterangan) VALUES
(1, '2024-03-19', 3, 5, 'Kesalahan input stok awal'),
(2, '2024-03-17', 5, -3, 'Barang rusak'),
(3, '2024-03-15', 7, 2, 'Penerimaan barang tambahan'),
(4, '2024-03-13', 2, -1, 'Barang terjual lebih banyak'),
(5, '2024-03-11', 4, 4, 'Penerimaan barang tambahan'),
(6, '2024-03-09', 6, -2, 'Kadaluarsa'),
(7, '2024-03-07', 8, 3, 'Penerimaan barang tambahan'),
(8, '2024-03-05', 10, -1, 'Barang terjual lebih banyak'),
(9, '2024-03-03', 1, 2, 'Penerimaan barang tambahan'),
(10, '2024-03-01', 3, -3, 'Kesalahan input stok awal');


INSERT INTO Pengembalian (ID_Pengembalian, ID_Transaksi, ID_Barang, Jumlah, Tanggal) VALUES
(1, 2, 4, 3, '2024-03-20'),
(2, 4, 8, 1, '2024-03-18'),
(3, 6, 3, 2, '2024-03-16'),
(4, 8, 10, 2, '2024-03-14'),
(5, 10, 5, 3, '2024-03-12'),
(6, 12, 2, 1, '2024-03-10'),
(7, 14, 9, 2, '2024-03-08'),
(8, 16, 1, 3, '2024-03-06'),
(9, 18, 7, 1, '2024-03-04'),
(10, 20, 6, 2, '2024-03-02');

SELECT * FROM Pelanggan;
SELECT * FROM Barang;
SELECT * FROM Transaksi;
SELECT * FROM Stok;
SELECT * FROM Pengembalian;

ALTER TABLE Stok RENAME TO stok;
DELETE FROM barang WHERE ID_Barang = 10;
UPDATE barang SET Stok=100 WHERE ID_Barang = 1;

DROP DATABASE modul1;
DROP TABLE transaksi;

CREATE TABLE Transaksi (
    ID_Transaksi INT PRIMARY KEY,
    ID_Barang INT,
    Jumlah INT,
    Harga DECIMAL(10, 2),
    Total DECIMAL(10, 2),
    FOREIGN KEY (ID_Barang) REFERENCES Barang (ID_Barang)
);

DESC Barang;