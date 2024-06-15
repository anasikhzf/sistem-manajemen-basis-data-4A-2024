CREATE DATABASE MODUL5;
USE MODUL5;
DROP DATABASE MODUL5;

CREATE TABLE IF NOT EXISTS anggota (
id_anggota VARCHAR(10) NOT NULL PRIMARY KEY,
nama_anggota VARCHAR(20) NOT NULL, 
angkatan_anggota VARCHAR(6) NOT NULL,
tempat_lahir_anggota VARCHAR(20) NOT NULL,
tanggal_lahir_anggota DATE,
no_telp INT(12) NOT NULL,
jenis_kelamin VARCHAR(15) NOT NULL,
status_pinjam VARCHAR(15) NOT NULL  
);

CREATE TABLE IF NOT EXISTS petugas (
id_petugas VARCHAR(10) NOT NULL PRIMARY KEY,
username VARCHAR(15) NOT NULL,
PASSWORD VARCHAR(15) NOT NULL,
nama VARCHAR(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS  buku (
kode_buku VARCHAR(10) NOT NULL PRIMARY KEY ,
judul_buku VARCHAR(25),
pengarang_buku VARCHAR(30) NOT NULL,
tahun_buku YEAR NOT NULL,
jumlah_buku VARCHAR(5) NOT NULL,
status_buku VARCHAR (10) NOT NULL,
klasifikasi_buku VARCHAR (20) NOT NULL
);

CREATE TABLE IF NOT EXISTS peminjaman (
kode_peminjaman VARCHAR (10) NOT NULL PRIMARY KEY,
id_anggota VARCHAR (10) NOT NULL,
id_petugas VARCHAR (10) NOT NULL,
tanggal_pinjam DATE,
tanggal_kembali DATE,
kode_buku VARCHAR (10) NOT NULL,
FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota),
FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas),
FOREIGN KEY (kode_buku) REFERENCES buku (kode_buku)
);

CREATE TABLE IF NOT EXISTS pengembalian (
kode_kembali VARCHAR (10) NOT NULL PRIMARY KEY,
id_anggota VARCHAR (10) NOT NULL,
kode_buku VARCHAR (10) NOT NULL,
id_petugas VARCHAR (10) NOT NULL,
tgl_pinjam DATE,
tgl_kembali DATE,
denda VARCHAR (15) NOT NULL,
FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota),
FOREIGN KEY (kode_buku) REFERENCES buku(kode_buku),
FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas)
);

SHOW TABLES;


INSERT INTO anggota VALUES 
('A001','Tomo','23','Jakarta','2004-06-22',085211112222,'Laki-Laki','Pinjam'),
('A002','Siska','20','Surabaya','2002-03-15',085233334444,'Perempuan','Pinjam'),
('A003','Budi','20','Bandung','2001-11-08',085255556666,'Laki-Laki','Kembali'),
('A004','Dewi','21','Yogyakarta','2002-09-30',085277778888,'Perempuan','Pinjam'),
('A005','Hadi','22','Gresik','2003-07-12',085299990000,'Laki-Laki','Kembali'),
('A006','Rina','24','Lamongan','2005-05-24',085211112233,'Perempuan','Pinjam'),
('A007','Adi','19','Bandung','2001-01-18',085211112244,'Laki-Laki','Pinjam'),
('A008','Lina','18','Jombang','2000-08-03',085211112255,'Perempuan','Kembali'),
('A009','Andi','22','Bojonegoro','2004-04-06',085211112266,'Laki-Laki','Pinjam'),
('A010','Rani','23','Sidoarjo','2004-12-29',085211112277,'Perempuan','Kembali');
SELECT * FROM anggota;

INSERT INTO buku VALUES 
('B001','Pulang','Tereliye','2017','9','Tersedia','Fiksi'),
('B002','Matahari','Tereliye','2019','8','Tersedia','Fantasi'),
('B003','Senja','Biru','2018','7','Tersedia','Romantis'),
('B004','Pelangi','Jompi','2020','6','Tersedia','Anak-anak'),
('B005','Cahaya','Sukarso','2016','5','Tersedia','Pendidikan'),
('B006','Bulan','Tereliye','2015','4','Tersedia','Fiksi'),
('B007','Mimpi','Dono','2021','3','Tersedia','Komedi'),
('B008','Harapan','Pidie Baiq','2014','2','Tersedia','Drama'),
('B009','Bintang','Tereliye','2023','1','Tersedia','Misteri'),
('B010','Menara','Joko','2022','3','Tersedia','Sastra');

INSERT INTO buku VALUES
('B011',NULL,'Joko','2022','13','Tersedia','Sastra');
('B012',NULL,'Joko','2022','11','Tersedia','Sastra');

SELECT * FROM buku;

INSERT INTO petugas VALUES 
('P001','Jay12','Jy01','Jayadi'),
('P002','Lia34','Li02','Liana'),
('P003','Dan45','Da03','Dandi'),
('P004','Ria56','Ri04','Riana'),
('P005','Yan67','Ya05','Yani'),
('P006','Rio78','Ro06','Rio'),
('P007','Fitri89','Fi07','Fitria'),
('P008','Anto90','An08','Anton'),
('P009','Sari01','Sa09','Sarita'),
('P010','Dian12','Di10','Diana');
SELECT * FROM petugas;

INSERT INTO peminjaman VALUES 
('PM001','A004','P004','2024-01-25','2024-02-03','B001'),
('PM002','A001','P005','2024-03-12','2024-03-20','B009'),
('PM003','A006','P003','2024-01-05','2024-02-15','B006'),
('PM004','A009','P007','2024-01-21','2024-01-29','B004'),
('PM005','A008','P008','2024-02-10','2024-02-18','B003'),
('PM006','A003','P003','2024-02-03','2024-02-11','B008'),
('PM007','A005','P010','2024-01-15','2024-03-23','B010'),
('PM008','A002','P001','2024-02-02','2024-03-10','B007'),
('PM009','A010','P002','2024-03-19','2024-03-27','B005'),
('PM010','A007','P003','2024-01-07','2024-02-15','B002'),
('PM011','A005','P005','2024-01-19','2024-02-04', 'B008'),
('PM012','A005','P005','2024-01-23','2024-02-07', 'B003'),
('PM013','A005','P003','2024-01-31','2024-02-14', 'B001'),
('PM014','A005','P003','2024-01-31','2024-02-12', 'B009');
SELECT * FROM peminjaman;

INSERT INTO peminjaman VALUES 
('PM015','A005','P002','2024-02-17','2024-02-22','B010');

INSERT INTO peminjaman VALUES 
('PM016','A005','P002','2024-02-17','2024-02-22','B011');



UPDATE peminjaman SET kode_buku = 'B002' WHERE kode_peminjaman = 'PM015'; 
UPDATE peminjaman SET kode_buku = 'B002' WHERE kode_peminjaman = 'PM012'; 

INSERT INTO pengembalian VALUES 
('PG001','A009','B004','P007','2024-01-21','2024-01-29','Rp.0'),
('PG002','A001','B009','P002','2024-03-12','2024-03-20','Rp.0'),
('PG003','A006','B006','P003','2024-01-05','2024-03-15','Rp.30000');



USE modul5;
-- Nomor 1

DELIMITER //
CREATE PROCEDURE Pencari(
    INOUT tanggal_pinjam DATE
)
BEGIN 
    SELECT 
    kode_buku,c.id_anggota, a.id_petugas, nama_anggota, nama AS nama_petugas, tgl_pinjam, tgl_kembali
    FROM petugas a 
    JOIN pengembalian b ON a.id_petugas = b.id_petugas
    JOIN anggota c ON b.id_anggota = c.id_anggota
    WHERE 
        b.tgl_pinjam = tanggal_pinjam;
END//
DELIMITER ;

SET @tanggal_pinjam = '2024-03-12';
CALL Pencari(@tanggal_pinjam)
DROP PROCEDURE Pencari;

-- Nomor 2

DELIMITER //
CREATE PROCEDURE DataPinjam(
    INOUT peminjaman VARCHAR (20)
)
BEGIN 
 SELECT * FROM anggota
    WHERE 
        status_pinjam = peminjaman;
        
END//
DELIMITER ;

SET @peminjaman = 'Pinjam';
CALL DataPinjam(@peminjaman)
DROP PROCEDURE DataPinjam


-- Nomor 3 
DELIMITER //
CREATE PROCEDURE daftarAnggota (
OUT anggot INT,
IN pinjam VARCHAR(50))   
BEGIN
	SELECT COUNT(*) INTO anggot FROM anggota WHERE status_pinjam = pinjam;
	
	IF @anggot > 0 THEN
	SELECT * FROM anggota WHERE status_pinjam = pinjam ;
	END IF;
	
END // 
DELIMITER;

DROP PROCEDURE DaftarAnggota;
CALL daftarAnggota(@anggot,'Pinjam');



SET @peminjaman = 'Pinjam';
CALL Pinjam(@peminjaman);
DROP PROCEDURE Pinjam;

-- Nomor 4
DELIMITER //
CREATE PROCEDURE InsertBuku (
    IN vKode_Buku VARCHAR(10),
    IN vJudul_Buku VARCHAR(30),
    IN vPengarang_Buku VARCHAR(30),
    IN vTahun_Buku VARCHAR(10),
    IN vStatus_Buku VARCHAR(10),
    IN vKlasifikasi VARCHAR(10)
)
BEGIN
    DECLARE Keterangan VARCHAR(100);
    DECLARE buku_count INT;
    
    SELECT COUNT(*) INTO buku_count
    FROM buku 
    WHERE kode_buku = vKode_Buku;
    
    IF buku_count > 0 THEN
    SET Keterangan = CONCAT('Data Buku ', vKode_Buku, ' Telah Tersedia');
    
    ELSE
    INSERT INTO buku (kode_buku, judul_buku, pengarang_buku, tahun_buku, status_buku, klasifikasi_buku)
    VALUES (vKode_Buku, vJudul_Buku, vPengarang_Buku, vTahun_Buku, vStatus_Buku, vKlasifikasi);
    SET Keterangan = 'Data Buku Berhasil Ditambahkan';
    
    END IF;
    
    SELECT Keterangan;

END//
DELIMITER ;

DROP PROCEDURE InsertBuku;
CALL InsertBuku('B011', 'Bumi', 'Tereliye', '2014', 'Tersedia', 'Fantasi');
CALL InsertBuku ('B012','Api','Joko Anwar','2022','Tersedia','Fantasi');


-- Nomor 5
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS HapusMhs (
    IN nomor VARCHAR(10)
)
BEGIN 
    DECLARE jumlah_pinjaman INT;
    DECLARE Keterangan VARCHAR(100);

    SELECT COUNT(*) INTO jumlah_pinjaman FROM anggota WHERE id_anggota = nomor AND status_pinjam = 'Pinjam';

    IF jumlah_pinjaman > 0 THEN    
	SET Keterangan = 'Buku Belum Dikembalikan';
    
    ELSE 
	DELETE FROM anggota WHERE  id_anggota = nomor;
	SET Keterangan = 'Buku Berhasil Dihapus'; 
    END IF;
    
    SELECT Keterangan;
END //
DELIMITER ;

CALL HapusMhs('A001')



-- Nomor 6
CREATE DATABASE FJoin;
USE FJoin;
DROP DATABASE FJoin


CREATE TABLE buku (
    kode_buku INT PRIMARY KEY,
    judul_buku VARCHAR(255) NOT NULL,
    tahun_buku INT NOT NULL
);


CREATE TABLE Stok (
    kode_peminjaman INT PRIMARY KEY,
    kode_buku INT,
    jumlah_buku INT
);

INSERT INTO buku  VALUES
(1, 'Pulang', 2020),
(2, 'Pergi', 2020),
(3, 'Pulang Pergi',2022),
(4, 'Bumi', 2021);

SELECT * FROM buku;

INSERT INTO Stok VALUES
(101, 1, 2),
(102, NULL, 9),
(103, NULL, 4),
(104, 4, 5);
DROP TABLE peminjaman

SELECT * FROM peminjaman;

CREATE VIEW iner AS
SELECT kode_peminjaman,judul_buku,jumlah_buku
FROM buku a
INNER JOIN Stok b ON a.kode_buku = b.kode_buku
GROUP BY kode_peminjaman
HAVING SUM(jumlah_buku) > 3;

SELECT * FROM iner;

CREATE VIEW ri AS
SELECT kode_peminjaman,judul_buku,jumlah_buku
FROM buku a
RIGHT JOIN Stok b ON a.kode_buku = b.kode_buku
GROUP BY kode_peminjaman
HAVING SUM(jumlah_buku) > 3;

SELECT * FROM ri;


CREATE VIEW lef AS
SELECT kode_peminjaman,judul_buku,jumlah_buku
FROM buku a
LEFT JOIN Stok b ON a.kode_buku = b.kode_buku
GROUP BY kode_peminjaman;

DROP VIEW lef;

SELECT * FROM lef


