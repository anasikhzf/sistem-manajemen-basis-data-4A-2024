CREATE DATABASE perpustakaan3;
USE perpustakaan3;

CREATE TABLE IF NOT EXISTS petugas(
IdPetugas VARCHAR(10) NOT NULL PRIMARY KEY,
Username VARCHAR(15) NOT NULL,
Pass VARCHAR(15) NOT NULL,
Nama VARCHAR(25) NOT NULL
); 

INSERT INTO petugas VALUES
('P001', 'admin1', 'pass123', 'Admin Satu'),
('P002', 'admin2', 'pass456', 'Admin Dua'),
('P003', 'staff1', 'staffpass', 'Staff Satu'),
('P004', 'staff2', 'staff123', 'Staff Dua'),
('P005', 'staff3', 'staff456', 'Staff Tiga');

SELECT * FROM petugas;


CREATE TABLE IF NOT EXISTS buku(
Kode_Buku VARCHAR(10) NOT NULL PRIMARY KEY,
Judul_Buku VARCHAR(25) NOT NULL,
Pengarang_Buku VARCHAR(30) NOT NULL,
Penerbit_Buku VARCHAR(30) NOT NULL,
Tahun_Buku VARCHAR(10) NOT NULL,
Jumlah_Buku VARCHAR(5) NOT NULL,
Status_Buku VARCHAR(10) NOT NULL,
Klasifikasi_Buku VARCHAR(20) NOT NULL
);

INSERT INTO buku VALUES
('B001', 'Laskar Pelangi', 'Andrea Hirata', 'Bentang Pustaka', '2005', '10', 'Tersedia', 'Novel'),
('B002', 'Ayat-ayat Cinta', 'Habiburrahman El-Shirazy', 'Republika', '2004', '9', 'Tersedia', 'Novel'),
('B003', 'Bumi Manusia', 'Pramoedya Ananta Toer', 'Hasta Mitra', '1980', '8', 'Tersedia', 'Fiksi Sejarah'),
('B004', 'Negeri 5 Menara', 'Ahmad Fuadi', 'Gramedia Pustaka Utama', '2009', '7', 'Tersedia', 'Novel'),
('B005', 'Pulang', 'Tere Liye', 'Gramedia Pustaka Utama', '2014', '6', 'Tersedia', 'Novel'),
('B006', 'Sang Pemimpi', 'Andrea Hirata', 'Bentang Pustaka', '2006', '5', 'Tersedia', 'Novel'),
('B007', 'Perahu Kertas', 'Dee Lestari', 'Bentang Pustaka', '2009', '8', 'Tersedia', 'Novel'),
('B008', 'Ronggeng Dukuh Paruk', 'Ahmad Tohari', 'Gramedia Pustaka Utama', '1982', '7', 'Tersedia', 'Novel'),
('B009', 'Jejak Langkah', 'Pramoedya Ananta Toer', 'Hasta Mitra', '1985', '7', 'Tersedia', 'Fiksi Sejarah'),
('B010', 'Cantik Itu Luka', 'Eka Kurniawan', 'Gramedia Pustaka Utama', '2002', '6', 'Tersedia', 'Novel');

SELECT * FROM buku;


CREATE TABLE IF NOT EXISTS anggota(
IdAnggota VARCHAR(10) NOT NULL PRIMARY KEY,
Nama_Anggota VARCHAR(20) NOT NULL,
Angkatan_Anggota VARCHAR(6) NOT NULL,
Tempat_Lahir_Anggota VARCHAR(20) NOT NULL,
Tanggal_Lahir_Anggota DATE NOT NULL,
No_Tlp INT(12) NOT NULL,
Jenis_Kelamin VARCHAR(15) NOT NULL,
Status_Pinjam VARCHAR(15) NOT NULL
);

INSERT INTO anggota VALUES
('A001', 'Agus', '2020', 'Jakarta', '2000-01-15', 622123456, 'Laki-laki', 'Tidak Meminjam'),
('A002', 'Budi', '2022', 'Surabaya', '2001-03-20', 629876532, 'Laki-laki', 'Tidak Meminjam'),
('A003', 'Citra', '2020', 'Bandung', '1999-05-10', 621122344, 'Perempuan', 'Meminjam'),
('A004', 'Dewi', '2021', 'Yogyakarta', '2002-07-25', 629887766, 'Perempuan', 'Meminjam'),
('A005', 'Eka', '2020', 'Semarang', '1999-09-05', 625543322, 'Laki-laki', 'Tidak Meminjam'),
('A006', 'Fani', '2022', 'Malang', '2000-11-12', 622234455, 'Perempuan', 'Meminjam'),
('A007', 'Gita', '2022', 'Solo', '2001-04-30', 626655433, 'Perempuan', 'Meminjam'),
('A008', 'Hadi', '2020', 'Denpasar', '1999-06-18', 677889900, 'Laki-laki', 'Tidak Meminjam'),
('A009', 'Indra', '2021', 'Medan', '2002-08-07', 621001100, 'Laki-laki', 'Tidak Meminjam'),
('A010', 'Joko', '2023', 'Palembang', '2003-10-15', 612312312, 'Laki-laki', 'Meminjam');

SELECT * FROM anggota;


CREATE TABLE peminjaman(
Kode_Peminjaman VARCHAR(10) NOT NULL PRIMARY KEY,
IdAnggota VARCHAR(10) NOT NULL,
IdPetugas VARCHAR(10) NOT NULL,
Tanggal_Pinjam DATE NOT NULL,
Tanggal_Kembali DATE NOT NULL,
Kode_Buku VARCHAR(10) NOT NULL
);

INSERT INTO peminjaman VALUES
('PJ2024001','A003','P003','2024-01-01','2024-01-07','B001'),
('PJ2024002','A004','P003','2024-01-01','2024-01-07','B002'),
('PJ2024003','A006','P003','2024-01-01','2024-01-07','B003'),
('PJ2024004','A007','P004','2024-01-02','2024-01-08','B004'),
('PJ2024005','A010','P004','2024-01-02','2024-01-08','B005'),
('PJ2024006','A007','P004','2024-01-08','2024-01-14','B006'),
('PJ2024007','A003','P003','2024-01-14','2024-01-20','B007'),
('PJ2024008','A007','P003','2024-01-14','2024-01-20','B008'),
('PJ2024009','A007','P004','2024-01-20','2024-01-26','B009'),
('PJ2024010','A007','P004','2024-01-26','2024-02-01','B010'),
('PJ2024011','A010','P005','2024-01-26','2024-02-01','B001'),
('PJ2024012','A007','P005','2024-02-01','2024-02-07','B001'),
('PJ2024013','A010','P003','2024-02-01','2024-02-07','B001'),
('PJ2024014','A003','P004','2024-02-01','2024-02-07','B001'),
('PJ2024015','A004','P004','2024-02-01','2024-02-07','B001');

SELECT * FROM peminjaman;


CREATE TABLE IF NOT EXISTS pengembalian(
Kode_Kembali VARCHAR(10) NOT NULL PRIMARY KEY,
IdAnggota VARCHAR(10) NOT NULL,
Kode_Buku VARCHAR(10) NOT NULL,
IdPetugas VARCHAR(10) NOT NULL,
Tgl_Pinjam DATE NOT NULL,
Tgl_Kembali DATE NOT NULL,
Denda VARCHAR(15) NOT NULL
);

INSERT INTO pengembalian VALUES
('PK2024001','A003','B001','P003','2024-01-01','2024-01-07','Kosong'),
('PK2024002','A004','B002','P003','2024-01-01','2024-01-07','Kosong'),
('PK2024003','A007','B004','P004','2024-01-02','2024-01-08','Kosong'),
('PK2024004','A010','B005','P004','2024-01-02','2024-01-08','Kosong'),
('PK2024005','A007','B006','P004','2024-01-08','2024-01-14','Kosong'),
('PK2024006','A006','B003','P004','2024-01-01','2024-01-14','20000'),
('PK2024007','A003','B007','P003','2024-01-14','2024-01-20','Kosong'),
('PK2024008','A007','B008','P003','2024-01-14','2024-01-20','Kosong'),
('PK2024009','A007','B009','P004','2024-01-20','2024-01-26','Kosong'),
('PK2024010','A007','B010','P004','2024-01-26','2024-02-01','Kosong'),
('PK2024011','A010','B001','P005','2024-01-26','2024-02-01','Kosong'),
('PK2024012','A007','B001','P005','2024-02-01','2024-02-07','Kosong'),
('PK2024013','A010','B001','P003','2024-02-01','2024-02-07','Kosong'),
('PK2024014','A003','B001','P004','2024-02-01','2024-02-07','Kosong'),
('PK2024015','A004','B001','P004','2024-02-01','2024-02-07','Kosong');

SELECT * FROM pengembalian;


ALTER TABLE peminjaman ADD CONSTRAINT fkPinjamAnggota FOREIGN KEY (IdAnggota) REFERENCES anggota(IdAnggota);
ALTER TABLE peminjaman ADD CONSTRAINT fkPinjamPetugas FOREIGN KEY (IdPetugas) REFERENCES petugas(IdPetugas);
ALTER TABLE peminjaman ADD CONSTRAINT fkPinjamBuku FOREIGN KEY (Kode_Buku) REFERENCES buku(Kode_Buku);
ALTER TABLE pengembalian ADD CONSTRAINT fkKembaliAnggota FOREIGN KEY (IdAnggota) REFERENCES anggota(IdAnggota);
ALTER TABLE pengembalian ADD CONSTRAINT fkKembaliPetugas FOREIGN KEY (IdPetugas) REFERENCES petugas(IdPetugas);
ALTER TABLE pengembalian ADD CONSTRAINT fkKembaliBuku FOREIGN KEY (Kode_Buku) REFERENCES buku(Kode_Buku);


-- nomor 1
DELIMITER //
CREATE PROCEDURE PengembalianBerdasarkanTanggal(
	INOUT tanggalCari DATE
)
BEGIN
	SELECT c.Kode_Kembali, c.IdAnggota, a.Nama_Anggota, c.Kode_Buku, b.Judul_Buku, c.IdPetugas, d.Nama AS Nama_Petugas,
		c.Tgl_Pinjam, c.Tgl_Kembali, c.Denda FROM pengembalian c
		JOIN anggota a ON c.IdAnggota = a.IdAnggota
		JOIN petugas d ON c.IdPetugas = d.IdPetugas
		JOIN buku b ON c.Kode_Buku = b.Kode_Buku
		WHERE c.Tgl_Kembali = tanggalCari;
END //
DELIMITER ;
SET @tanggalCari = '2024-02-01';
CALL PengembalianBerdasarkanTanggal(@tanggalCari);


-- nomor 2
DELIMITER //
CREATE PROCEDURE DaftarAnggotaBerdasarkanStatusPinjam(
	INOUT statusPinjam VARCHAR(15)
)
BEGIN
	SELECT * FROM anggota
	WHERE Status_Pinjam = statusPinjam;
END //
DELIMITER ;
SET @statusPinjam = 'Meminjam';
CALL DaftarAnggotaBerdasarkanStatusPinjam(@statusPinjam);


-- nomor 3
DELIMITER //
CREATE PROCEDURE AnggotaDariStatusPinjam(
	IN statusPinjam VARCHAR(15)
)
BEGIN
	SELECT * FROM anggota WHERE Status_Pinjam = statusPinjam;
END//
DELIMITER ;
CALL AnggotaDariStatusPinjam('Meminjam');
DROP PROCEDURE AnggotaDariStatusPinjam;

-- nomor 4
DELIMITER //
CREATE PROCEDURE TambahDataBuku(
    IN kodeBuku VARCHAR(10),
    IN judulBuku VARCHAR(25),
    IN pengarangBuku VARCHAR(30),
    IN penerbitBuku VARCHAR(30),
    IN tahunBuku VARCHAR(10),
    IN jumlahBuku VARCHAR(5),
    IN statusBuku VARCHAR(10),
    IN klasifikasiBuku VARCHAR(20)
)
BEGIN
    INSERT INTO buku (Kode_Buku, Judul_Buku, Pengarang_Buku, Penerbit_Buku, Tahun_Buku, Jumlah_Buku, Status_Buku, Klasifikasi_Buku)
    VALUES (kodeBuku, judulBuku, pengarangBuku, penerbitBuku, tahunBuku, jumlahBuku, statusBuku, klasifikasiBuku);

    SELECT 'Buku berhasil ditambahkan' AS 'Pesan Konfirmasi';
END //
DELIMITER ;
CALL TambahDataBuku('B011', 'Hujan Bulan Juni', 'Sapardi Djoko Damono', 'Bentang Pustaka', '1994', '5', 'Tersedia', 'Puisi');
SELECT * FROM buku;


-- nomor 5
DELIMITER //
CREATE PROCEDURE HapusDataAnggota(
    IN id_anggota VARCHAR(10)
)
BEGIN
    DECLARE jumlahPinjam INT;
    SELECT COUNT(*) INTO jumlahPinjam FROM peminjaman WHERE IdAnggota = id_anggota;
    IF jumlahPinjam > 0 THEN
        SELECT 'Gagal menghapus data anggota. Anggota memiliki pinjaman yang belum dikembalikan.' AS 'Pesan Kesalahan';
    ELSE
        DELETE FROM anggota WHERE IdAnggota = id_anggota;
        SELECT 'Data anggota berhasil dihapus' AS 'Pesan Konfirmasi';
    END IF;
END //
DELIMITER ;
CALL HapusDataAnggota('A010');


-- nomor 6
-- right join
CREATE VIEW right_join AS
	SELECT b.Kode_Buku, b.Judul_Buku, MAX(a.Tanggal_Pinjam) AS Tanggal_Pinjam_Terakhir
	FROM buku b RIGHT JOIN 
	peminjaman a ON b.Kode_Buku = a.Kode_Buku
	GROUP BY b.Kode_Buku, b.Judul_Buku;
	
SELECT * FROM right_join;


-- inner join
CREATE VIEW inner_join AS
	SELECT b.Kode_Buku, b.Judul_Buku, MAX(a.Tanggal_Pinjam) AS Tanggal_Pinjam_Terakhir
	FROM buku b INNER JOIN 
	peminjaman a ON b.Kode_Buku = a.Kode_Buku
	GROUP BY b.Kode_Buku, b.Judul_Buku;

SELECT * FROM inner_join;


-- left join
CREATE VIEW left_join AS
	SELECT b.Kode_Buku, b.Judul_Buku, MAX(a.Tanggal_Pinjam) AS Tanggal_Pinjam_Terakhir
	FROM buku b LEFT JOIN 
	peminjaman a ON b.Kode_Buku = a.Kode_Buku
	GROUP BY b.Kode_Buku, b.Judul_Buku;

SELECT * FROM left_join;

DROP VIEW left_join;
DROP VIEW right_join;
DROP VIEW inner_join;