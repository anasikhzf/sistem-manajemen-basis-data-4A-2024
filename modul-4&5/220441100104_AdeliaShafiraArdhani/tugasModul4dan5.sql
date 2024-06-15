CREATE DATABASE perpustakaan;

USE perpustakaan;

CREATE TABLE petugas(
id_petugas VARCHAR(10) NOT NULL PRIMARY KEY,
username VARCHAR(15) NOT NULL,
PASSWORD VARCHAR(15) NOT NULL,
nama VARCHAR(25) NOT NULL
);

CREATE TABLE buku(
kode_buku VARCHAR(10) NOT NULL PRIMARY KEY,
judul_buku VARCHAR(25) NOT NULL,
pengarang VARCHAR(30) NOT NULL,
penerbit VARCHAR(30) NOT NULL,
tahun_buku VARCHAR(10) NOT NULL,
jumlah_buku VARCHAR(5) NOT NULL,
status_buku VARCHAR(10) NOT NULL,
klasifikasi_buku VARCHAR(20)
);

CREATE TABLE anggota(
id_anggota VARCHAR(10) NOT NULL PRIMARY KEY,
nama_anggota VARCHAR(20) NOT NULL,
angkatan_anggota VARCHAR(6) NOT NULL,
tempat_lahir VARCHAR(20) NOT NULL,
tanggal_lahir DATE NOT NULL,
no_telp INT(12) NOT NULL,
jenis_kelamin VARCHAR(15) NOT NULL,
status_pinjaman VARCHAR(15) NOT NULL
);

CREATE TABLE pinjaman(
kode_pinjaman VARCHAR(10) NOT NULL PRIMARY KEY,
id_anggota VARCHAR(10) NOT NULL,
id_petugas VARCHAR(10) NOT NULL,
tanggal_pinjam DATE NOT NULL,
tanggal_kembali DATE NOT NULL,
kode_buku VARCHAR(10) NOT NULL,
FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota),
FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas),
FOREIGN KEY (kode_buku) REFERENCES buku(kode_buku)
);

CREATE TABLE pengembalian(
kode_kembali VARCHAR(10) NOT NULL PRIMARY KEY,
id_anggota VARCHAR(10) NOT NULL,
kode_buku VARCHAR(10) NOT NULL,
id_petugas VARCHAR(10) NOT NULL,
tanggal_pinjam DATE NOT NULL,
tanggal_kembali DATE NOT NULL,
denda VARCHAR(15),
FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas),
FOREIGN KEY (kode_buku) REFERENCES buku(kode_buku),
FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas)
);

ALTER TABLE pengembalian ADD CONSTRAINT fk_id_anggota FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota);

INSERT INTO petugas VALUES
('pt001', 'adelia001', 'adelia123', 'adelia'),
('pt002', 'fira002', 'fira234', 'fira'),
('pt003', 'arum003', 'arum345', 'arum'),
('pt004', 'devi004', 'devi456', 'devi'),
('pt005', 'depi005', 'depi567', 'depi');

INSERT INTO anggota VALUES
('agt001', 'adelia', 22, 'sidoarjo', '2004-09-24', 08951582057, 'perempuan', 'kembali'),
('agt002', 'fira', 22, 'lamongan', '2004-03-26', 08123456890, 'perempuan', 'kembali'),
('agt003', 'arum', 22, 'pasuruan', '2004-10-24', 08391730163, 'perempuan', 'pinjam'),
('agt004', 'devi', 22, 'lamongan', '2003-09-18', 085928461936, 'perempuan', 'pinjam'),
('agt005', 'depi', 22, 'tuban', '2004-03-25', 089173524781, 'perempuan', 'pinjam'),
('agt006', 'genta', 21, 'nganjuk', '2003-01-01', 08951123567, 'laki-laki', 'kembali'),
('agt007', 'rafi', 21, 'lamongan', '2002-03-26', 08123458315, 'laki-laki', 'kembali'),
('agt008', 'irham', 21, 'sidoarjo', '2003-10-24', 0839182648, 'laki-laki', 'pinjam'),
('agt009', 'syahrul', 21, 'surabaya', '2003-09-18', 089284692, 'laki-laki', 'pinjam');

INSERT INTO buku VALUES
('bk001', 'buku1', 'pengarang1', 'penerbit1', 2021, 10, 'ada', 'sql'),
('bk002', 'buku2', 'pengarang2', 'penerbit2', 2021, 10, 'kembali', 'data mining'),
('bk003', 'buku3', 'pengarang3', 'penerbit3', 2021, 10, 'ada', 'java'),
('bk004', 'buku4', 'pengarang4', 'penerbit4', 2021, 10, 'ada', 'php'),
('bk005', 'buku5', 'pengarang5', 'penerbit5', 2021, 10, 'dipinjam', 'html'),
('bk006', 'buku6', 'pengarang6', 'penerbit6', 2022, 10, 'ada', 'python'),
('bk007', 'buku7', 'pengarang7', 'penerbit7', 2022, 10, 'ada', 'kotlin'),
('bk008', 'buku8', 'pengarang8', 'penerbit8', 2022, 10, 'dipinjam', 'pemrograman dasar'),
('bk009', 'buku9', 'pengarang9', 'penerbit9', 2022, 10, 'ada', 'dataset'),
('bk0010', 'buku10', 'pengarang10', 'penerbit10', 2022, 10, 'ada', 'database');

INSERT INTO pinjaman VALUES
('pj001', 'ang003', 'pt002', '2024-03-01', '2024-03-08', 'bk007'),
('pj002', 'ang004', 'pt002', '2024-03-01', '2024-03-08', 'bk007'),
('pj003', 'ang005', 'pt002', '2024-03-01', '2024-03-08', 'bk007'),
('pj004', 'ang008', 'pt001', '2024-03-02', '2024-03-09', 'bk007'),
('pj005', 'ang001', 'pt001', '2024-03-02', '2024-03-09', 'bk007'),
('pj006', 'ang009', 'pt001', '2024-03-03', '2024-03-10', 'bk007'),
('pj007', 'ang009', 'pt001', '2024-03-03', '2024-03-10', 'bk008'),
('pj008', 'ang009', 'pt001', '2024-03-03', '2024-03-10', 'bk009'),
('pj009', 'ang009', 'pt001', '2024-03-03', '2024-03-10', 'bk001'),
('pj0010', 'ang009', 'pt001', '2024-03-03', '2024-03-10', 'bk002'),
('pj0011', 'ang009', 'pt001', '2024-03-03', '2024-03-10', 'bk003');

INSERT INTO pengembalian VALUES
('kbl001', 'ang002', 'bk005', 'pt003', '2024-02-21', '2024-02-29', '5.000'),
('kbl002', 'ang006', 'bk006', 'pt003', '2024-02-21', '2024-02-28', '0'),
('kbl003', 'ang007', 'bk008', 'pt004', '2024-02-22', '2024-03-01', '5.000');

/*1. Buatlah Stored Procedure INOUT, yang berguna untuk pencarian pengembalian 
berdasarkan tanggal yang kita inginkan dan hasilnya berupa keseluruhan data dalam tabel 
pengembalian yang sesuai dengan tanggal yang sudah diinputkan! Jika pada tabel 
pengembalian terdapat ID Anggota ataupun ID Petugas, maka tampilkan nama anggota & 
petugas berdasarkan ID tersebut!*/

DELIMITER//
CREATE PROCEDURE pengembalian(
	INOUT tgl_kembali DATE -- menetapkan parameter in/out/inout
)
BEGIN
	SELECT k.kode_kembali, k.id_anggota, a.nama_anggota, k.id_petugas, p.nama, k.tanggal_kembali -- perintah sql yg akan dijalankan
	FROM kembali k 
	JOIN anggota a ON k.id_anggota = a.id_anggota
	JOIN petugas p ON k.id_petugas = p.id_petugas 
	WHERE k.tanggal_kembali LIKE CONCAT('%', tgl_kembali, '%'); 
END//								
DELIMITER;
-- pakai (%)
DROP PROCEDURE pengembalian;
SET @tgl_kembali = '2024-02';
CALL pengembalian(@tgl_kembali);

/*2. Buatlah stored procedure INOUT yang berguna untuk menampilkan daftar anggota 
berdasarkan status pinjam yang kita inginkan. Hasilnya berupa keseluruhan data dalam tabel 
anggota yang sesuai dengan status pinjam yang sudah diinputkan*/

DELIMITER//
CREATE PROCEDURE statusPinjam(INOUT status_pinjaman VARCHAR(15)) -- menetapkan parameter in/out/inout
BEGIN
	SELECT id_anggota, 
	nama_anggota, 
	angkatan_anggota, 
	tempat_lahir, 
	tanggal_lahir,
	no_telp, 
	jenis_kelamin, 
	status_pinjaman
	FROM anggota WHERE status_pinjaman = status_pinjaman;
END//
DELIMITER;

SET @status_pinjaman = 'pinjam';
CALL statusPinjam(@status_pinjaman);

/*3. Buatlah stored procedure dengan parameter OUT yang berfungsi untuk menampilkan 
daftar anggota berdasarkan status pinjam yang kita inginkan*/

DELIMITER//
CREATE PROCEDURE statusPinjam_out(
	IN status_pinjaman VARCHAR(15),
	OUT result TEXT)
BEGIN
	DECLARE temp_result TEXT DEFAULT '';

    SELECT GROUP_CONCAT(CONCAT(  -- GROUP CONCAT: untuk menggabungkan hasil kueri menjadi satu string dengan pemisah ';'
        'ID: ', id_anggota, ', ', -- CONCAT: untuk menggabungkan kolom menjadi string
        'Nama: ', nama_anggota, ', ',
        'Angkatan: ', angkatan_anggota, ', ',
        'Tempat Lahir: ', tempat_lahir, ', ',
        'Tanggal Lahir: ', tanggal_lahir, ', ',
        'No Telp: ', no_telp, ', ',
        'Jenis Kelamin: ', jenis_kelamin, ', ',
        'Status Pinjaman: ', status_pinjaman
    ) SEPARATOR '; ')
    INTO temp_result -- menyiman hasil GROUP CONCAT
    FROM anggota
    WHERE status_pinjaman = status_pinjaman;

    SET result = temp_result;
END //
DELIMITER ;

SET @status_pinjaman = 'kembali';
SELECT @status_pinjaman;
CALL statusPinjam_out(@status_pinjaman, @result);

SELECT @result;

-- nomor3
DELIMITER//
CREATE PROCEDURE nomor3(OUT status_pinjaman VARCHAR(15))
BEGIN
	SELECT id_anggota, 
	nama_anggota, 
	angkatan_anggota, 
	tempat_lahir, 
	tanggal_lahir,
	no_telp, 
	jenis_kelamin, 
	status_pinjaman
	FROM anggota WHERE status_pinjaman = status_pinjaman;
END//
DELIMITER;
DROP PROCEDURE nomor3;
SET @status_pinjaman = 'kembali';
CALL nomor3(@status_pinjaman);

/*4. Buatlah Stored Procedure dengan parameter IN yang berfungsi untuk menambahkan data 
baru ke tabel buku. Stored procedure ini harus menerima parameter tentang buku. Setelah 
data berhasil dimasukkan, stored procedure ini harus mengembalikan pesan konfirmasi 
bahwa data buku telah berhasil ditambahkan.*/

DELIMITER//
CREATE PROCEDURE insertToBuku(
	IN id_buku VARCHAR(10),
	IN judulBuku VARCHAR(25),
	IN Pengarang VARCHAR(30),
	IN Penerbit VARCHAR(30),
	IN thn_buku VARCHAR(10),
	IN jml_buku VARCHAR(5),
	IN stts_buku VARCHAR(10),
	IN klas_buku VARCHAR(20)
	)
BEGIN
	DECLARE buku_baru INT;

	SELECT COUNT(*)
	INTO buku_baru
	FROM buku
	WHERE kode_buku = id_buku;
	
	IF buku_baru < 0 THEN
		SELECT 'kode buku sudah ada!' AS message;
	ELSE
		INSERT INTO buku 
	VALUES (id_buku, judulBuku, Pengarang, Penerbit, thn_buku, jml_buku, stts_buku, klas_buku);
		SELECT 'Data berhasil ditambahkan' AS message;
	END IF;
END//
DELIMITER;
DROP PROCEDURE insertToBuku;
-- tambahkan message
CALL insertToBuku('bk012', 'buku12', 'pengarang10', 'penerbit10', '2023', '15', 'ada', 'datamining');

/*5. buatlah Stored Procedure dengan parameter IN yang berfungsi untuk menghapus data 
anggota berdasarkan ID Anggota. Stored procedure ini harus menerima parameter ID 
Anggota yang ingin dihapus dari tabel anggota. Setelah data berhasil dihapus, stored 
procedure ini harus return pesan konfirmasi bahwa data anggota telah berhasil dihapus. 
Selain itu, stored procedure ini juga harus memeriksa terlebih dahulu apakah anggota tersebut 
memiliki pinjaman yang belum dikembalikan, jika iya, proses penghapusan harus dibatalkan 
dan mengembalikan pesan kesalahan.*/

DELIMITER//
CREATE PROCEDURE hapusAnggota(
	IN kode_anggota VARCHAR(10)
)
BEGIN
	DECLARE status_pinjaman VARCHAR(15); -- deklarasi variabel lokal
	DECLARE keterangan VARCHAR(100);
	
	DELETE FROM anggota WHERE id_anggota = kode_anggota AND status_pinjaman = 'kembali';

	IF status_pinjaman = 'kembali' THEN
		SELECT CONCAT('Data anggota dengan ID ', kode_anggota, ' telah berhasil dihapus.') AS keterangan;
	ELSE
		DELETE FROM anggota WHERE id_anggota = kode_anggota;
		SELECT CONCAT('Gagal menghapus Anggota ', kode_anggota, ' karena masih memiliki pinjaman yang belum dikembalikan.') AS keterangan;
        END IF;
END //
DELIMITER ;
-- dicari tahu salahnya dan diperbaiki
CALL hapusAnggota('agt003');

DELIMITER //
CREATE PROCEDURE soalNo5 (
    IN p_IdAnggota VARCHAR(250),
    OUT p_Pesan VARCHAR(100)
)
BEGIN
    DECLARE pesan VARCHAR(100);

    IF EXISTS (SELECT * FROM pinjaman WHERE id_anggota = p_IdAnggota AND tanggal_kembali IS NULL) THEN
        SET pesan = 'Tidak dapat menghapus anggota karena masih memiliki pinjaman yang belum dikembalikan.';
    ELSE
	DELETE FROM pinjaman WHERE id_anggota = p_IdAnggota;
        DELETE FROM kembali WHERE id_anggota = p_IdAnggota;
        DELETE FROM anggota WHERE id_anggota = p_IdAnggota;
         
        
        SET pesan = 'Data anggota berhasil dihapus.';
    END IF;

    SET p_Pesan = pesan;
END//
DELIMITER ;

CALL soalNo5('agt002', @pesan);
SELECT @pesan AS Pesan;

/*6. Buatlah 3 Views, yang menggunakan fungsi JOIN, baik Right Join, Inner, dan Left. Pada 
tabel yang saling berelasi. Dan jelaskan perbedaannya. Serta Berikan tambahan agregasi dan 
pengelompokan dalam Views tersebut, lalu analisislah hasilnya. Setiap Praktikan tidak 
diperbolehkan sama Studi Kasusnya!*/

-- right join 
CREATE VIEW vw_rightJoin AS
SELECT 
    b.kode_buku,
    b.judul_buku,
    p.kode_pinjaman,
    p.id_anggota
FROM 
    buku b
RIGHT JOIN 
    pinjaman p ON b.kode_buku = p.kode_buku;

SELECT * FROM vw_rightJoin;

-- inner join
CREATE VIEW vw_innerJoin AS
SELECT 
    b.kode_buku,
    b.judul_buku,
    p.kode_pinjaman,
    p.id_anggota
FROM 
    buku b
INNER JOIN 
    pinjaman p ON b.kode_buku = p.kode_buku;

SELECT * FROM vw_innerJoin;

-- left join
CREATE VIEW vw_leftJoin AS
SELECT 
    b.kode_buku,
    b.judul_buku,
    p.kode_pinjaman,
    p.id_anggota
FROM 
    buku b
LEFT JOIN 
    pinjaman p ON b.kode_buku = p.kode_buku;

SELECT * FROM vw_leftJoin;