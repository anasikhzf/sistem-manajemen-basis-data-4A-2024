USE perpustakaan;

CREATE TABLE anggota (
IdAnggota VARCHAR(10) PRIMARY KEY,
Nama_Anggota VARCHAR(20) NOT NULL, Tempat_Lahir_Anggota VARCHAR(20) NOT NULL, Tanggal_Lahir_Anggota DATE NOT NULL, Angkatan_Anggota VARCHAR(6) NOT NULL, Jenis_Kelamin VARCHAR(15) NOT NULL, Status_Pinjam VARCHAR(15) NOT NULL
);

CREATE TABLE petugas (
IdPetugas VARCHAR(10) PRIMARY KEY, Username VARCHAR(15) NOT NULL, PASSWORD VARCHAR(15) NOT NULL, Nama VARCHAR(25) NOT NULL
);

CREATE TABLE buku (
Kode_Buku VARCHAR(10) PRIMARY KEY, Judul_Buku VARCHAR(25) NOT NULL,
Pengarang_Buku VARCHAR(30) NOT NULL, Penerbit_Buku VARCHAR(30) NOT NULL, Tahun_Buku VARCHAR(10) NOT NULL,
Klasifikasi_Buku VARCHAR(20) NOT NULL, Status_Buku VARCHAR(10) NOT NULL
);

CREATE TABLE peminjaman (
Kode_Peminjaman VARCHAR(10) PRIMARY KEY, IdAnggota VARCHAR(10) NOT NULL,
Kode_Buku VARCHAR(10) NOT NULL,
Tanggal_Pinjam DATE NOT NULL, Tanggal_Kembali DATE,
IdPetugas VARCHAR(10),
Jumlah_Buku VARCHAR(5) NOT NULL,
FOREIGN KEY (IdAnggota) REFERENCES anggota(IdAnggota), FOREIGN KEY (Kode_Buku) REFERENCES buku(Kode_Buku), FOREIGN KEY (IdPetugas) REFERENCES petugas(IdPetugas)
);
 

CREATE TABLE pengembalian (
Kode_Kembali VARCHAR(10) PRIMARY KEY,
Kode_Peminjaman VARCHAR(10) NOT NULL, Tgl_Pinjam DATE NOT NULL,
Tgl_Kembali DATE NOT NULL, IdPetugas VARCHAR(10),
IdAnggota VARCHAR(10) NOT NULL, Denda VARCHAR(15),
FOREIGN KEY (Kode_Peminjaman) REFERENCES peminjaman(Kode_Peminjaman),
FOREIGN KEY (IdPetugas) REFERENCES petugas(IdPetugas), FOREIGN KEY (IdAnggota) REFERENCES anggota(IdAnggota)
);

INSERT INTO anggota (IdAnggota, Nama_Anggota, Tempat_Lahir_Anggota, Tanggal_Lahir_Anggota, Angkatan_Anggota, Jenis_Kelamin, Status_Pinjam)
VALUES
('A001', 'John Doe', 'Jakarta', '1990-05-15', '2010', 'Laki-laki', 'Tidak Pinjam'),
('A002', 'Jane Smith', 'Bandung', '1992-08-20', '2012', 'Perempuan', 'Tidak Pinjam'),
('A003', 'Michael Johnson', 'Surabaya', '1988-03-10', '2009', 'Laki-laki', 'Tidak Pinjam'),
('A004', 'Emily Davis', 'Medan', '1995-11-25', '2014', 'Perempuan', 'Tidak Pinjam'),
('A005', 'Daniel Brown', 'Yogyakarta', '1993-09-05', '2011', 'Laki-laki', 'Tidak Pinjam');

INSERT INTO petugas (IdPetugas, Username, PASSWORD, Nama) VALUES
('P001', 'admin1', 'password1', 'Admin 1'),
('P002', 'admin2', 'password2', 'Admin 2'),
('P003', 'staff1', 'passstaff1', 'Staff 1'),
('P004', 'staff2', 'passstaff2', 'Staff 2'),
('P005', 'staff3', 'passstaff3', 'Staff 3');

INSERT INTO buku (Kode_Buku, Judul_Buku, Pengarang_Buku, Penerbit_Buku, Tahun_Buku, Klasifikasi_Buku, Status_Buku) VALUES
('B001', 'Harry Potter and the Philosopher\'s Stone', 'J.K. Rowling',
 
'Bloomsbury Publishing', '1997', 'Fiksi Fantasi', 'Tersedia'),
('B002', 'To Kill a Mockingbird', 'Harper Lee', 'J.B. Lippincott & Co.', '1960', 'Fiksi Realistis', 'Tersedia'),
('B003', 'The Great Gatsby', 'F. Scott Fitzgerald', 'Charles Scribner\'s Sons', '1925', 'Fiksi Realistis', 'Tidak Tersedia'),
('B004', '1984', 'George Orwell', 'Secker & Warburg', '1949', 'Fiksi Sains', 'Tersedia'),
('B005', 'Pride and Prejudice', 'Jane Austen', 'T. Egerton, Whitehall', '1813', 'Fiksi Romantis', 'Tersedia');

INSERT INTO peminjaman (Kode_Peminjaman, IdAnggota, Kode_Buku, Tanggal_Pinjam, Tanggal_Kembali, IdPetugas, Jumlah_Buku)
VALUES
('PJ001', 'A001', 'B001', '2024-04-01', '2024-04-15', 'P001', '1'),
('PJ002', 'A002', 'B002', '2024-04-03', '2024-04-17', 'P002', '2'),
('PJ003', 'A003', 'B003', '2024-04-05', '2024-04-20', 'P003', '1'),
('PJ004', 'A004', 'B004', '2024-04-07', '2024-04-22', 'P004', '3'),
('PJ005', 'A005', 'B005', '2024-04-09', '2024-04-24', 'P005', '1');

INSERT INTO pengembalian (Kode_Kembali, Kode_Peminjaman, Tgl_Pinjam, Tgl_Kembali, IdPetugas, IdAnggota, Denda) VALUES
('PK001', 'PJ001', '2024-04-01', '2024-04-15', 'P001', 'A001', '0'),
('PK002', 'PJ002', '2024-04-03', '2024-04-17', 'P002', 'A002', '0'),
('PK003', 'PJ003', '2024-04-05', '2024-04-20', 'P003', 'A003', '0'),
('PK004', 'PJ004', '2024-04-07', '2024-04-22', 'P004', 'A004', '0'),
('PK005', 'PJ005', '2024-04-09', '2024-04-24', 'P005', 'A005', '0');


-- Prosedur dengan Parameter IN Default DELIMITER //
CREATE PROCEDURE TampilkanAnggota( IN IdAnggotaParam VARCHAR(10)
) BEGIN
SELECT * FROM anggota WHERE IdAnggota = IdAnggotaParam;
END // DELIMITER;
CALL TampilkanAnggota('a001')
 
-- Prosedur untuk Menampilkan Data Berdasarkan Atribut/Field DELIMITER //
CREATE PROCEDURE CariAnggotaByNama( IN NamaParam VARCHAR(20)
) BEGIN
SELECT * FROM anggota WHERE Nama_Anggota = NamaParam; END //
DELIMITER;
CALL CariAnggotaByNama('John Doe');

-- Prosedur untuk Menampilkan Data Berdasarkan Dua Atribut/Field DELIMITER //
CREATE PROCEDURE CariAnggotaByTempatDanTanggalLahir( IN TempatParam VARCHAR(20),
IN TanggalParam DATE
) BEGIN
SELECT * FROM anggota WHERE Tempat_Lahir_Anggota = TempatParam AND Tanggal_Lahir_Anggota = TanggalParam;
END // DELIMITER;
CALL CariAnggotaByTempatDanTanggalLahir('medan', '1995-11-25');

-- Prosedur untuk Memasukkan Data pada Tabel DELIMITER //
CREATE PROCEDURE TambahBuku( IN KodeBukuParam VARCHAR(10), IN JudulParam VARCHAR(25),
IN PengarangParam VARCHAR(30), IN PenerbitParam VARCHAR(30), IN TahunParam VARCHAR(10),
IN KlasifikasiParam VARCHAR(20), IN StatusParam VARCHAR(10)
) BEGIN
INSERT INTO buku (Kode_Buku, Judul_Buku, Pengarang_Buku, Penerbit_Buku, Tahun_Buku, Klasifikasi_Buku, Status_Buku)
VALUES (KodeBukuParam, JudulParam, PengarangParam, PenerbitParam, TahunParam, KlasifikasiParam, StatusParam);
END //
 
DELIMITER;
CALL TambahBuku('B006', 'bukuku', 'aku', 'tuhan', '2000', 'terbaik', 'Tersedia');

-- Prosedur untuk Menampilkan Data dengan Parameter OUT DELIMITER //
CREATE PROCEDURE HitungJumlahAnggota( OUT TotalAnggota INT
) BEGIN
SELECT COUNT(*) INTO TotalAnggota FROM anggota; END //
DELIMITER ;
CALL HitungJumlahAnggota(@totalAnggota); SELECT @totalAnggota;

-- Prosedur untuk Menampilkan Data dengan Parameter INOUT DELIMITER //
CREATE PROCEDURE CekKetersediaanBuku( IN KodeBukuParam VARCHAR(10),
INOUT StatusBukuParam VARCHAR(20)
) BEGIN
SELECT Status_Buku INTO StatusBukuParam FROM buku WHERE Kode_Buku = KodeBukuParam;
END // DELIMITER ;
SET @statusBuku = 'Status_Buku';
CALL CekKetersediaanBuku('b003', @statusBuku); SELECT @statusBuku;


DROP PROCEDURE IF EXISTS TampilkanAnggota; DROP PROCEDURE IF EXISTS CariAnggotaByNama;
DROP PROCEDURE IF EXISTS CariAnggotaByTempatDanTanggalLahir; DROP PROCEDURE IF EXISTS CariAnggotaByAngkatanJKDanStatus; DROP PROCEDURE IF EXISTS TambahBuku;
DROP PROCEDURE IF EXISTS HitungJumlahAnggota; DROP PROCEDURE IF EXISTS CekKetersediaanBuku;
