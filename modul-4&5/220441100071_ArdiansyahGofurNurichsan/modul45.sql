CREATE DATABASE perpustakaan_new1;
USE perpustakaan_new1;


CREATE TABLE IF NOT EXISTS petugas(
idPetugas VARCHAR (10) PRIMARY KEY NOT NULL,
username VARCHAR (15) NOT NULL,
pasword VARCHAR (15) NOT NULL,
nama VARCHAR (25) NOT NULL
);

CREATE TABLE IF NOT EXISTS buku(
kode_buku VARCHAR (10) PRIMARY KEY NOT NULL,
judul_buku VARCHAR (25) NOT NULL,
pengarang_buku VARCHAR (30) NOT NULL,
penerbit_buku VARCHAR (30) NOT NULL,
tahun_buku VARCHAR (10) NOT NULL,
jumlah_buku VARCHAR (5) NOT NULL,
status_buku VARCHAR (10) NOT NULL,
klasifikasi_buku VARCHAR (20) NOT NULL
);

CREATE TABLE IF NOT EXISTS anggota(
idAnggota VARCHAR (10) PRIMARY KEY NOT NULL,
nama_anggota VARCHAR(20) NOT NULL,
angkatan_anggota VARCHAR (6) NOT NULL,
tempat_lahir_anggota VARCHAR (20) NOT NULL,
tanggal_lahir_anggota DATE,
jenis_kelamin VARCHAR (1)
);

CREATE TABLE IF NOT EXISTS peminjaman(
kode_peminjaman VARCHAR(10) PRIMARY KEY NOT NULL,
idAnggota VARCHAR (10) NOT NULL,
idPetugas VARCHAR (10) NOT NULL,
tanggal_pinjam DATE,
tanggal_kembali DATE,
kode_buku VARCHAR (10) NOT NULL
);

CREATE TABLE IF NOT EXISTS pengembalian(
kode_kembali VARCHAR(10) NOT NULL,
idAnggota VARCHAR(10) NOT NULL,
kode_buku VARCHAR (10) NOT NULL,
idPetugas VARCHAR (10) NOT NULL,
tgl_pinjam DATE NOT NULL,
tgl_kembali DATE,
denda VARCHAR(15) 
);


INSERT INTO anggota VALUES 
('A001', 'Budi ', '2020', 'Jakarta', '2000-01-01', 'L'),
('A002', 'Ani ', '2019', 'Bandung', '2001-02-02', 'P'),
('A003', 'Johan', '2021', 'Surabaya', '1999-03-03', 'L'),
('A004', 'Mily ', '2018', 'Medan', '2002-04-04', 'P'),
('A005', 'David ', '2022', 'Semarang', '1998-05-05', 'L')
;


INSERT INTO buku VALUES 
('B001', 'Harry Potter dan Batu Bertuah', 'J.K. Rowling', 'Scholastic', '1997', '100', 'Tersedia', 'Fantasi'),
('B002', 'Untuk Membunuh Seekor Mockingbird', 'Harper Lee', 'J. B. Lippincott & Co.', '1960', '75', 'Tersedia', 'Fiksi'),
('B003', '1984', 'George Orwell', 'Secker & Warburg', '1949', '50', 'Tersedia', 'Dystopian'),
('B004', 'Gatsby Si Lelaki Besar', 'F. Scott Fitzgerald', 'Scribner', '1925', '60', 'Tersedia', 'Klasik'),
('B005', 'Pride and Prejudice', 'Jane Austen', 'T. Egerton, Whitehall', '1813', '70', 'Tersedia', 'Romansa'),
('B006', 'Pemburu di Tepi Jeram', 'J.D. Salinger', 'Little, Brown and Company', '1951', '45', 'Tersedia', 'Pertumbuhan'),
('B007', 'The Hobbit', 'J.R.R. Tolkien', 'Allen & Unwin', '1937', '80', 'Tersedia', 'Fantasi'),
('B008', 'Moby-Dick', 'Herman Melville', 'Richard Bentley', '1851', '55', 'Tersedia', 'Petualangan'),
('B009', 'Frankenstein', 'Mary Shelley', 'Lackington, Hughes, Harding, Mavor & Jones', '1818', '65', 'Tersedia', 'Gothik'),
('B010', 'The Lord of the Rings', 'J.R.R. Tolkien', 'Allen & Unwin', '1954', '90', 'Tersedia', 'Fantasi')
;


INSERT INTO petugas VALUES 
('P001', 'user1', 'password1', 'Andi'),
('P002', 'user2', 'password2', 'Budi'),
('P003', 'user3', 'password3', 'Cindy'),
('P004', 'user4', 'password4', 'Dedi'),
('P005', 'user5', 'password5', 'Eka')
;


INSERT INTO peminjaman VALUES 
('PM001', 'A001', 'P001', '2024-04-21', '2024-04-21', 'B001'),
('PM002', 'A002', 'P002', '2024-04-21', '2024-04-22', 'B002'),
('PM003', 'A003', 'P003', '2024-04-21', '2024-04-23', 'B003'),
('PM004', 'A004', 'P004', '2024-04-21', '2024-04-24', 'B004'),
('PM005', 'A003', 'P005', '2024-04-21', '2024-04-25', 'B005'),
('PM006', 'A002', 'P005', '2024-04-21', '2024-04-26', 'B006'),
('PM007', 'A002', 'P004', '2024-04-21', '2024-04-27', 'B007'),
('PM008', 'A002', 'P003', '2024-04-21', '2024-04-28', 'B008'),
('PM009', 'A002', 'P002', '2024-04-21', '2024-04-29', 'B009'),
('PM010', 'A003', 'P003', '2024-04-21', '2024-04-30', 'B003')
;



INSERT INTO pengembalian VALUES 
('K001', 'A001', 'B001', 'P001', '2024-04-21', '2024-04-21', '0'),
('K002', 'A002', 'B002', 'P002', '2024-04-21', '2024-04-22', '0'),
('K003', 'A003', 'B003', 'P003', '2024-04-21', '2024-04-23', '0'),
('K004', 'A004', 'B004', 'P004', '2024-04-21', '2024-04-24', '0'),
('K005', 'A003', 'B005', 'P005', '2024-04-21', '2024-04-25', '0'),
('K006', 'A002', 'B006', 'P001', '2024-04-21', '2024-04-26', '0'),
('K007', 'A002', 'B007', 'P002', '2024-04-21', '2024-04-27', '0'),
('K008', 'A002', 'B008', 'P003', '2024-04-21', NULL, '10000'),
('K009', 'A002', 'B009', 'P004', '2024-04-21', NULL, '10000'),
('K010', 'A003', 'B010', 'P003', '2024-04-21', NULL, '10000')
;


ALTER TABLE perpustakaan_new1.pengembalian ADD CONSTRAINT fk_id_anggota FOREIGN KEY (idAnggota) REFERENCES anggota(idAnggota) ON DELETE CASCADE;

ALTER TABLE perpustakaan_new1.pengembalian ADD CONSTRAINT fk_kode_buku FOREIGN KEY (kode_buku) REFERENCES buku(kode_buku);

ALTER TABLE perpustakaan_new1.pengembalian ADD CONSTRAINT fk_id_petugas FOREIGN KEY (idPetugas) REFERENCES petugas(idPetugas);

ALTER TABLE perpustakaan_new1.peminjaman ADD CONSTRAINT fk_id_anggota1 FOREIGN KEY (idAnggota) REFERENCES anggota(idAnggota) ON DELETE CASCADE;

ALTER TABLE perpustakaan_new1.peminjaman ADD CONSTRAINT fk_kode_buku1 FOREIGN KEY (kode_buku) REFERENCES buku(kode_buku);

ALTER TABLE perpustakaan_new1.peminjaman ADD CONSTRAINT fk_id_petugas1 FOREIGN KEY (idPetugas) REFERENCES petugas(idPetugas);


-- nomor 1
DELIMITER //
CREATE PROCEDURE search(
	INOUT cari_tanggal DATE
)
BEGIN
	SELECT a.kode_kembali, c.nama AS namaPetugas, b.nama_anggota,a.tgl_pinjam, a.tgl_kembali, a.kode_buku
	FROM pengembalian a 
	JOIN anggota b ON a.idAnggota = b.idAnggota 
	JOIN petugas c ON a.idPetugas = c.idPetugas  
	WHERE a.tgl_kembali= cari_tanggal; 
END//
DELIMITER;


SET @cari_tanggal = "2024-04-27";
CALL search(@cari_tanggal);
DROP PROCEDURE search;

-- nomor 2
DELIMITER //
CREATE PROCEDURE daftar_anggota(
	INOUT daftar_anggota VARCHAR (10)
)
BEGIN
	SELECT a.*    
	FROM anggota a
	NATURAL JOIN peminjaman b
	WHERE idAnggota = daftar_anggota AND idAnggota IN (SELECT DISTINCT idAnggota FROM peminjaman b);
END //
DELIMITER ;

SET @id_anggota = 'A001';
CALL daftar_anggota(@id_anggota);
DROP PROCEDURE daftar_anggota;


-- nomor 3
  
DELIMITER //
CREATE PROCEDURE tampil(
	OUT hasil VARCHAR (10)
)
BEGIN
	SELECT a.* 
	FROM anggota  a
	WHERE a.IdAnggota  IN (SELECT DISTINCT idAnggota FROM peminjaman);

END //
DELIMITER ;


CALL tampil(@hasil);    
DROP PROCEDURE tampil;

-- nomor 4
DELIMITER //
CREATE PROCEDURE tambah_buku(
	IN pKodeBuku VARCHAR (10),
	IN pJudulBuku VARCHAR (25),
	IN pPengarangBuku VARCHAR (30),
	IN pPenerbitBuku VARCHAR (30),
	IN pTahunBuku VARCHAR (10),
	IN pJumlahBuku VARCHAR (5),
	IN pStatusBuku VARCHAR (10),
	IN pKlasifikasiBuku VARCHAR (20)
)
BEGIN
	DECLARE info VARCHAR (50);
	DECLARE infoJudul VARCHAR (50);
	
	SELECT COUNT(*) INTO info FROM buku WHERE kode_buku = pKodeBuku;
	SELECT COUNT(*) INTO infoJudul FROM buku WHERE judul_buku = pJudulBuku;
	
	IF info > 0 THEN
		SELECT CONCAT('Buku Dengan Kode ' , pKodeBuku, ' Sudah Ada') AS just_info;
	ELSEIF infoJudul > 0 THEN 
		SELECT CONCAT('Buku Dengan Judul ', pJudulBuku, ' Sudah Ada') AS just_info;
	ELSE 
		INSERT INTO buku VALUES (pKodeBuku, pJudulBuku, pPengarangBuku, pPenerbitBuku, pTahunBuku, pJumlahBuku, pStatusBuku, pKlasifikasiBuku);
		SELECT CONCAT ('Buku Dengan Kode ', pKodeBuku, ' dan Judul Buku ', pJudulBuku, ' Berhasil Ditambahkan') AS just_info;
	END IF;
	
END //
DELIMITER ;

CALL tambah_buku('B010', 'Bumi', 'TereLiye', 'Gramedia', '2009', '50', 'Normal', 'Petualangan');
CALL tambah_buku('B012', '1984', 'TereLiye', 'Gramedia', '2009', '50', 'Normal', 'Petualangan');
CALL tambah_buku('B013', 'Matahari', 'TereLiye', 'Gramedia', '2012', '52', 'Normal', 'Fantasi');
SELECT * FROM buku;
DROP PROCEDURE tambah_buku;

-- nomor 5
DELIMITER //
CREATE PROCEDURE hapus_anggota(
	IN pIdAnggota VARCHAR (10)
)
BEGIN
	DECLARE info INT;
	
	SELECT COUNT(*) INTO info FROM pengembalian WHERE idAnggota = pIdAnggota AND tgl_kembali IS NULL;
	
	IF info > 0 THEN 
		SELECT CONCAT('Anggota dengan ID ', pIdAnggota, ' memiliki pinjaman yang belum dikembalikan') AS just_info;
	ELSE
		DELETE FROM anggota WHERE idAnggota = pIdAnggota;
		
		SELECT CONCAT('Data Anggota dengan ID ', pIdAnggota, ' Berhasil Dihapus') AS just_info;
	END IF;
END //
DELIMITER;

CALL hapus_anggota('A004');
SELECT * FROM anggota;
DROP PROCEDURE hapus_anggota;

-- nomor 6
SELECT * FROM peminjaman;
SELECT * FROM buku;
    
-- right join
CREATE VIEW right_peminjaman AS
SELECT c.judul_buku, c.pengarang_buku , COUNT(b.kode_peminjaman) AS jumlah_pinjam
FROM buku c RIGHT JOIN peminjaman b ON c.kode_buku = b.kode_buku
GROUP BY c.judul_buku, c.pengarang_buku; 

SELECT * FROM right_peminjaman;
DROP VIEW right_peminjaman

-- left join
CREATE VIEW left_peminjaman AS
SELECT c.judul_buku, c.pengarang_buku , COUNT(b.kode_peminjaman) AS jumlah_pinjam
FROM buku c LEFT JOIN peminjaman b ON c.kode_buku = b.kode_buku
GROUP BY c.judul_buku, c.pengarang_buku; 
  
SELECT * FROM left_peminjaman;
DROP VIEW left_peminjaman;

-- inner join
CREATE VIEW inner_peminjaman AS
SELECT c.judul_buku, c.pengarang_buku , COUNT(b.kode_peminjaman) AS jumlah_pinjam
FROM buku c INNER JOIN peminjaman b ON c   .kode_buku = b.kode_buku
GROUP BY c.judul_buku, c.pengarang_buku;

SELECT * FROM inner_peminjaman;
DROP VIEW inner_peminjaman;



-- drop
DROP DATABASE perpustakaan_new1;