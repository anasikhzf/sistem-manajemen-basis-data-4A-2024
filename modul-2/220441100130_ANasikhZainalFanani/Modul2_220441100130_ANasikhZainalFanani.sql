CREATE DATABASE IF NOT EXISTS library_database;

USE library_database;

CREATE TABLE IF NOT EXISTS petugas (
    IdPetugas VARCHAR(10),
    Username VARCHAR(15),
    PASSWORD VARCHAR(15),
    Nama VARCHAR(25),
    PRIMARY KEY (IdPetugas)
);

CREATE TABLE IF NOT EXISTS anggota (
    IdAnggota VARCHAR(10),
    Nama_Anggota VARCHAR(30),
    Alamat_Anggota VARCHAR(50),
    Tanggal_Lahir_Anggota DATE,
    No_Telp INT(12),
    PRIMARY KEY (IdAnggota)
);

CREATE TABLE IF NOT EXISTS buku (
    Kode_Buku VARCHAR(10),
    Judul_Buku VARCHAR(30),
    Pengarang VARCHAR(30),
    Penerbit VARCHAR(30),
    Tahun_Terbit INT,
    Jumlah INT,
    Klasifikasi_Buku VARCHAR(20),
    PRIMARY KEY (Kode_Buku)
);

CREATE TABLE IF NOT EXISTS peminjaman (
    Kode_Peminjaman VARCHAR(10),
    IdAnggota VARCHAR(10),
    IdPetugas VARCHAR(10),
    Tanggal_Pinjam DATE,
    Tanggal_Kembali DATE,
    Kode_Buku VARCHAR(10),
    FOREIGN KEY (IdAnggota) REFERENCES anggota(IdAnggota),
    FOREIGN KEY (IdPetugas) REFERENCES petugas(IdPetugas),
    FOREIGN KEY (Kode_Buku) REFERENCES buku(Kode_Buku),
    PRIMARY KEY (Kode_Peminjaman)
);

CREATE TABLE IF NOT EXISTS pengembalian (
    Kode_Kembali VARCHAR(10),
    IdAnggota VARCHAR(10),
    IdPetugas VARCHAR(10),
    Kode_Buku VARCHAR(10),
    Tgl_Pinjam DATE,
    Tgl_Kembali DATE,
    Denda VARCHAR(15),
    FOREIGN KEY (IdAnggota) REFERENCES anggota(IdAnggota),
    FOREIGN KEY (IdPetugas) REFERENCES petugas(IdPetugas),
    FOREIGN KEY (Kode_Buku) REFERENCES buku(Kode_Buku),
    PRIMARY KEY (Kode_Kembali)
);

INSERT INTO anggota (IdAnggota, Nama_Anggota, Alamat_Anggota, Tanggal_Lahir_Anggota, No_Telp)
VALUES ('A001', 'Anggota Satu', 'Alamat Anggota Satu', '1990-01-01', 123456789),
       ('A002', 'Anggota Dua', 'Alamat Anggota Dua', '1995-05-05', 987654321);
INSERT INTO buku (Kode_Buku, Judul_Buku, Pengarang, Penerbit, Tahun_Terbit, Jumlah, Klasifikasi_Buku)
VALUES ('B001', 'Judul Buku Satu', 'Pengarang Satu', 'Penerbit Satu', 2000, 10, 'Klasifikasi Satu'),
       ('B002', 'Judul Buku Dua', 'Pengarang Dua', 'Penerbit Dua', 2010, 15, 'Klasifikasi Dua');
INSERT INTO peminjaman (Kode_Peminjaman, IdAnggota, IdPetugas, Tanggal_Pinjam, Tanggal_Kembali, Kode_Buku)
VALUES ('P001', 'A001', 'PT001', '2024-03-01', '2024-03-15', 'B001'),
       ('P002', 'A001', 'PT002', '2024-03-02', '2024-03-16', 'B001'),
       ('P003', 'A001', 'PT003', '2024-03-01', '2024-03-15', 'B001'),
       ('P004', 'A001', 'PT002', '2024-03-02', '2024-03-16', 'B001'),
       ('P005', 'A001', 'PT001', '2024-03-01', '2024-03-15', 'B001'),
       ('P006', 'A001', 'PT001', '2024-03-02', '2024-03-16', 'B001');
INSERT INTO pengembalian (Kode_Kembali, IdAnggota, IdPetugas, Kode_Buku, Tgl_Pinjam, Tgl_Kembali, Denda)
VALUES ('K001', 'A001', 'PT001', 'B001', '2024-03-01', '2024-03-15', '0'),
       ('K002', 'A002', 'PT002', 'B002', '2024-03-02', '2024-03-16', '0');
INSERT INTO petugas (IdPetugas, Username, PASSWORD, Nama)
VALUES ('PT001', 'petugas1', 'password1', 'Petugas Satu'),
       ('PT002', 'petugas2', 'password2', 'Petugas Dua');



CREATE VIEW tugas1 AS
SELECT a.nama_anggota, COUNT(b.kode_buku) AS jumlah_pinjam
FROM anggota a JOIN peminjaman b ON a.idanggota = b.idanggota
GROUP BY a.nama_anggota
HAVING COUNT(b.kode_buku) > 5;

CREATE VIEW tugas2 AS
SELECT a.nama, COUNT(b.kode_buku) AS jumlah_buku_terpinjam
FROM petugas a JOIN peminjaman b
ON a.idpetugas = b.idpetugas
GROUP BY a.nama;

CREATE VIEW tugas3 AS
SELECT a.nama, COUNT(b.kode_buku) AS jumlah_buku_terpinjam
FROM petugas a JOIN peminjaman b
ON a.idpetugas = b.idpetugas
GROUP BY a.nama
ORDER BY jumlah_buku_terpinjam DESC
LIMIT 1;

CREATE VIEW tugas4 AS
SELECT a.judul_buku AS buku_terbanyak_dipinjam, COUNT(b.kode_buku) AS jumlah
FROM buku a JOIN peminjaman b 
ON a.kode_buku = b.kode_buku
GROUP BY buku_terbanyak_dipinjam
ORDER BY jumlah DESC
LIMIT 1;

DROP DATABASE library_database;
