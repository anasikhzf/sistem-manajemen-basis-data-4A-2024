USE library;

-- NO 1 --
DELIMITER//
CREATE PROCEDURE pencaritgl(
	INOUT tanggal DATE
)
BEGIN 

	SELECT 
	a.Kode_Kembali,
	b.Nama_Anggota,
	c.Judul_Buku,
	d.Nama AS nama_petugas,
	a.Tgl_Pinjam,
	a.Tgl_Kembali,
	a.Denda
	FROM pengembalian a JOIN anggota b ON a.idAnggota = b.idAnggota
	JOIN buku c ON a.Kode_Buku = c.Kode_Buku 
	JOIN petugas d ON a.idPetugas = d.idPetugas
	WHERE a.Tgl_kembali = tanggal;
	
END//
DELIMITER//

SET @tanggal = '2024-03-30';
CALL pencaritgl(@tanggal);

DROP PROCEDURE pencaritgl;

INSERT INTO pengembalian VALUES
(416, 111, 'B205', '930', '2024-03-29' ,'2024-03-30', '2000');

SELECT * FROM pengembalian;

-- NO 2 --

DELIMITER//
CREATE PROCEDURE cari_status(
	INOUT input_status VARCHAR(50))
BEGIN 
	SELECT * FROM anggota WHERE 
        status_pinjam = input_status;
	
END//
DELIMITER//

SET @input_status = 'Pinjam';
CALL cari_status(@input_status);

DROP PROCEDURE cari_status;

SELECT * FROM anggota;

-- NO 3 --

DELIMITER//
CREATE PROCEDURE cari_status2(
	IN input_status VARCHAR(50))
BEGIN 
	SELECT * FROM anggota WHERE 
        status_pinjam = input_status;
	
END//
DELIMITER//

SET @input_status = 'Tidak Pinjam';
CALL cari_status2(@input_status);

DROP PROCEDURE cari_status2;

-- NO 4 --

DELIMITER //

CREATE PROCEDURE TambahBuku(
    IN p_Kode_Buku VARCHAR(10),
    IN p_Judul_Buku VARCHAR(25),
    IN p_Pengarang_Buku VARCHAR(30),
    IN p_Penerbit_Buku VARCHAR(30),
    IN p_Tahun_Buku VARCHAR(10),
    IN p_Jumlah_Buku INT,
    IN p_Status_Buku VARCHAR(10),
    IN p_Klasifikasi_Buku VARCHAR(20)
)
BEGIN
    
    INSERT INTO buku (Kode_Buku, Judul_Buku, Pengarang_Buku, Penerbit_Buku, Tahun_Buku, Jumlah_Buku, Status_Buku, Klasifikasi_Buku)
    VALUES (p_Kode_Buku, p_Judul_Buku, p_Pengarang_Buku, p_Penerbit_Buku, p_Tahun_Buku, p_Jumlah_Buku, p_Status_Buku, p_Klasifikasi_Buku);
    
    SELECT CONCAT('Data buku dengan judul "', p_Judul_Buku, '" telah berhasil ditambahkan.') AS PesanKonfirmasi;
END //
DELIMITER ;

CALL TambahBuku('B211', 'Laskar Pelangi', 'Andrea Hirata', 'Bentang Pustaka', '2005', 100, 'Lama', 'Novel Fiksi');

SELECT * FROM buku;


-- NO 5 --

DELIMITER//
CREATE PROCEDURE hapus_anggota(
	IN id_anggota INT 
)
BEGIN 
	DECLARE peringatan VARCHAR(50);
	DECLARE anggota INT;
	
	SELECT COUNT(*) INTO anggota FROM peminjaman WHERE idAnggota = id_anggota;
	
    IF anggota = 0 THEN
	DELETE FROM anggota WHERE idAnggota = id_anggota;
        SET peringatan = 'Anggota berhasil dihapus';
    ELSE 
        SET peringatan = 'Anggota gagal dihapus';
    END IF;
    
    SELECT peringatan;
	
END//
DELIMITER//

CALL hapus_anggota(112);

SELECT * FROM anggota;

DROP PROCEDURE hapus_anggota;

-- NO 6 --

CREATE VIEW vw_TotalBukuDipinjam AS
SELECT a.idAnggota, a.Nama_Anggota, COUNT(p.Kode_Buku) AS Total_Buku_Dipinjam
FROM anggota a
INNER JOIN peminjaman p ON a.idAnggota = p.idAnggota
GROUP BY a.idAnggota, a.Nama_Anggota;

SELECT * FROM vw_TotalBukuDipinjam;
DROP VIEW vw_TotalBukuDipinjam;

CREATE VIEW vw_TotalDendaAnggota AS
SELECT a.idAnggota, a.Nama_Anggota, SUM(b.Denda) AS Total_Denda
FROM anggota a
RIGHT JOIN pengembalian b ON a.idAnggota = b.idAnggota
GROUP BY a.idAnggota, a.Nama_Anggota;

SELECT * FROM vw_TotalDendaAnggota;
DROP VIEW vw_TotalDendaAnggota;

CREATE VIEW vw_TotalBukuDipinjamkanPetugas AS
SELECT pt.idPetugas, pt.Nama, COUNT(p.Kode_Buku) AS Total_Buku_Dipinjam
FROM petugas pt
RIGHT JOIN peminjaman p ON pt.idPetugas = p.idPetugas
GROUP BY pt.idPetugas, pt.Nama;

SELECT * FROM vw_TotalBukuDipinjamkanPetugas;
DROP VIEW vw_TotalBukuDipinjamkanPetugas;

SELECT * FROM petugas;

/* 1 membuat stored procedure dimana bisa menambahkan denda otomatis, 
dan di set gaboleh lebih dari 5 hari peminjaman biar ga kena denda 

2 membuat stored procedure dimana peminjaman lebih dari nol status nya pinjam kalau 
nol status nya tidak pinjam*/

DELIMITER //
CREATE PROCEDURE tambah_denda(
    IN kodeKembali INT,
    IN id_anggota INT,
    IN kodeBuku VARCHAR(10),
    IN id_petugas VARCHAR(10),
    IN tglPinjam DATE,
    IN tglKembali DATE
)
BEGIN 
    DECLARE hari_kembali INT;
    DECLARE kelipatan INT;
    DECLARE denda INT;

    SET hari_kembali = DATEDIFF(tglKembali, tglPinjam);
    SET kelipatan = FLOOR(hari_kembali / 5);

    IF hari_kembali >= 5 THEN 
        SET denda = kelipatan * 2000;
    ELSE 
        SET denda = 0;
    END IF;

    INSERT INTO pengembalian (Kode_Kembali, idAnggota, Kode_Buku, idPetugas, Tgl_Pinjam, Tgl_Kembali, Denda)
    VALUES (kodeKembali, id_anggota, kodeBuku, id_petugas, tglPinjam, tglKembali, denda);
END //
DELIMITER ;

CALL tambah_denda(422, 117, 'B205', '930', '2024-04-20', '2024-05-05')

SELECT * FROM pengembalian;

DROP PROCEDURE tambah_denda;


DELIMITER//
CREATE PROCEDURE cek_status(
	IN id_anggota INT
)
BEGIN
	DECLARE pinjam INT;
	
	SELECT COUNT(*) INTO pinjam FROM peminjaman WHERE idAnggota = id_anggota;
	
	IF pinjam >= 1 THEN
		UPDATE anggota SET Status_Pinjam = 'Pinjam' WHERE idAnggota = id_anggota;
	ELSE 
		UPDATE anggota SET Status_Pinjam = 'Tidak Pinjam' WHERE idAnggota = id_anggota;
	END IF;
	
	SELECT * FROM anggota;

END//
DELIMITER//

CALL cek_status(111);

DROP PROCEDURE cek_status;

SELECT * FROM anggota;

INSERT INTO anggota VALUES
(119, 'Rohman', '2021', 'Jombang', '2003-06-21', '08763652528', 'Laki-Laki', 'Belum');

DELIMITER//
CREATE PROCEDURE pengembalian(IN kode_pinjam INT)
BEGIN
	DECLARE id_anggota INT;
	DECLARE pinjam INT;
	DECLARE info VARCHAR(30);
	
	SELECT idAnggota INTO id_anggota FROM peminjaman WHERE Kode_Peminjaman = kode_pinjam;
	
	DELETE FROM peminjaman WHERE Kode_Peminjaman = kode_pinjam;
	
	SELECT COUNT(*) INTO pinjam FROM peminjaman WHERE idAnggota = id_anggota;
	
	IF pinjam >= 1 THEN
		SET info = 'Pinjam';
	ELSE 
		SET info = 'Tidak Pinjam';
	END IF;
	UPDATE anggota SET Status_Pinjam = info WHERE idAnggota = id_anggota;
END//
DELIMITER//

CALL pengembalian(311);

SELECT* FROM anggota;

DROP PROCEDURE pengembalian;
