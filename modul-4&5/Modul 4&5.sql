/*NOMOR 1*/
DELIMITER //
CREATE PROCEDURE Nomor1(
    INOUT cari_tanggal DATE
)
BEGIN
    SELECT
        a.kode_kembali,
        a.id_anggota,
        b.nama_anggota,
        a.kode_buku,
        a.id_petugas,
        c.nama AS nama_petugas,
        a.tgl_pinjam,
        a.tgl_kembali,
        a.denda
    FROM
        pengembalian a
    LEFT JOIN
        anggota b ON a.id_anggota = b.id_anggota
    LEFT JOIN
        petugas c ON a.id_petugas = c.id_petugas
    WHERE
        a.tgl_kembali = cari_tanggal;
END //
DELIMITER ;

SET @cari_tanggal = '2024-02-28';
CALL Nomor1(@cari_tanggal);


/*NOMOR 2*/
DELIMITER //
CREATE PROCEDURE Nomor2(INOUT input_status VARCHAR(15))
BEGIN
    SELECT 
        id_anggota,
        nama_anggota,
        angkatan_anggota,
        tempat_lahir_anggota,
        tanggal_lahir_anggota,
        no_telp,
        jenis_kelamin,
        status_pinjam
    FROM 
        anggota
    WHERE 
        status_pinjam = input_status;
END //
DELIMITER 

SET @input_status = "Aktif";
CALL Nomor2(@input_status);

/*NOMOR 3*/
DELIMITER//
CREATE PROCEDURE Nomor3(INOUT statuss VARCHAR(15))
BEGIN 
	SELECT * FROM anggota WHERE 
        status_pinjam = statuss;
	
END//
DELIMITER;

SET @statuss = "Tidak Aktif";
CALL Nomor3(@statuss);

/*NOMOR 4*/
DELIMITER //
CREATE PROCEDURE Nomor4(
    IN judul_buku VARCHAR(25),
    IN pengarang_buku VARCHAR(30),
    IN penerbit_buku VARCHAR(30),
    IN tahun_buku VARCHAR(10),
    IN jumlah_buku VARCHAR(5),
    IN status_buku VARCHAR(10),
    IN klasifikasi_buku VARCHAR(20)
)
BEGIN
    INSERT INTO buku (judul_buku, pengarang_buku, penerbit_buku, tahun_buku, jumlah_buku, status_buku, klasifikasi_buku)
    VALUES (judul_buku, pengarang_buku, penerbit_buku, tahun_buku, jumlah_buku, status_buku, klasifikasi_buku);
    SELECT CONCAT('Buku "', judul_buku, '" berhasil ditambahkan.') AS Pesan;
END //
DELIMITER ;

CALL Nomor4("Dia Angkasa", "Devi Dwi N", "Sinar Dunia", "2024", "8",  "Tersedia", "Romansa");
SELECT * FROM buku;


/*NOMOR 5*/
DELIMITER //
CREATE PROCEDURE Nomor5(
    IN no_anggota INT
)
BEGIN
    DECLARE status_pinjaman VARCHAR(20);
    
    SELECT status_pinjam INTO status_pinjaman
    FROM anggota
    WHERE id_anggota = no_anggota;
    
    IF status_pinjaman = "pinjam" THEN
        SELECT CONCAT("Gagal menghapus anggota. Anggota dengan ID ", no_anggota, " masih memiliki pinjaman yang belum dikembalikan.") AS pesan;
    ELSE
        DELETE FROM anggota WHERE id_anggota = no_anggota;
        
        SELECT CONCAT("Anggota dengan ID ", no_anggota, " berhasil dihapus.") AS pesan;
    END IF;
END //
DELIMITER ;

CALL Nomor5(7);
SELECT * FROM anggota;


/*NOMOR 6*/
CREATE VIEW inner_join AS
SELECT 
    anggota.id_anggota,
    anggota.nama_anggota,
    buku.judul_buku,
    peminjaman.kode_buku,
    COUNT(peminjaman.kode_peminjaman) AS jumlah
FROM 
    anggota
INNER JOIN
    peminjaman ON anggota.id_anggota = peminjaman.id_anggota
INNER JOIN
    buku ON peminjaman.kode_buku = buku.kode_buku
GROUP BY
    anggota.id_anggota,
    anggota.nama_anggota,
    peminjaman.kode_buku,
    buku.judul_buku;
SELECT * FROM inner_join;

CREATE VIEW left_join AS
SELECT anggota.id_anggota,
	anggota.nama_anggota,
	MAX(peminjaman.tanggal_kembali) AS tgl_terakhir
FROM anggota
LEFT JOIN 
	peminjaman ON anggota.id_anggota = peminjaman.id_anggota
GROUP BY 
	anggota.id_anggota, 
	anggota.nama_anggota;
SELECT * FROM left_join;

CREATE VIEW right_join AS
SELECT 
	a.kode_buku, a.judul_buku, COUNT(b.kode_peminjaman) AS jumlah_peminjaman
FROM 
	buku a
RIGHT JOIN 
	peminjaman b ON a.kode_buku = b.kode_buku
GROUP BY 
	a.kode_buku, a.judul_buku;
SELECT * FROM right_join;
