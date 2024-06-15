/*nomor 1*/
DELIMITER //
CREATE PROCEDURE data_pengembalian(
 IN tanggal DATE,
 OUT Kode_Kembali INT(10),
 OUT Nama_Anggota VARCHAR (30),
 OUT Kode_Buku INT (10),
 OUT Nama_Petugas VARCHAR (30),
 OUT Tgl_Pinjam DATE,
 OUT Tgl_Kembali DATE,
 OUT Denda DECIMAL (10,2)
 )
BEGIN 
 SELECT p.Kode_Kembali, a.Nama_Anggota, p.Kode_Buku, ptgs.Nama AS Nama_Petugas, p.Tgl_Pinjam, p.Tgl_Kembali, p.Denda FROM pengembalian p JOIN anggota a ON p.IdAnggota=a.IdAnggota JOIN petugas ptgs 
 ON p.IdPetugas=ptgs.IdPetugas WHERE p.Tgl_Pinjam = tanggal OR p.Tgl_Kembali=tanggal;  
END //
DELIMITER ;
CALL data_pengembalian('2024-01-08', @Kode_Kembali, @Nama_Anggota, @Kode_Buku, @Nama_Petugas, @Tgl_Pinjam, @Tgl_Kembali, @Denda);


/*Nomor 2*/
DELIMITER //
CREATE PROCEDURE data_anggota(
 IN status_peminjaman VARCHAR (20),
 OUT IdAnggota INT (20),
 OUT Nama_Anggota VARCHAR (30),
 OUT Angkatan_Anggota VARCHAR (50),
 OUT Tempat_Tanggal_Lahir VARCHAR (30),
 OUT Tanggal_Lahir_Anggota DATE,
 OUT No_Telp INT (12),
 OUT Jenis_Kelamin ENUM ('Pr' , 'Lk'),
 OUT Status_Pinjam VARCHAR (20)
 )
BEGIN 
 SELECT IdAnggota, Nama_Anggota, Angkatan_Anggota, Tempat_Lahir_Anggota, 
 Tanggal_Lahir_Anggota, No_Telp, Jenis_Kelamin, Status_Pinjam FROM anggota 
 WHERE status_peminjaman=Status_Pinjam;
END //
DELIMITER ;
CALL data_anggota('tidak', @IdAnggota, @Nama_Anggota, @Angkatan_Anggota, 
@Tempat_Lahir_Anggota, @Tanggal_Lahir_Anggota, @No_Telp, @Jenis_Kelamin, 
@Status_Pinjam);

/*nomor 3*/
/*coba 1*/
DELIMITER //
CREATE PROCEDURE daftar_anggota(
 OUT daftardata VARCHAR (1000)
)
BEGIN
 SELECT CONCAT('id anggota: ', IdAnggota, ', nama anggota: ', Nama_Anggota, ', angkatan: ', Angkatan_Anggota, ', tempat lahir: ', Tempat_Lahir_Anggota,
 ', tanggal lahir: ', Tanggal_Lahir_Anggota, ', telp: ', No_Telp, ', kelamin: ', Jenis_Kelamin, ', status peminjaman: ', Status_Pinjam)
 FROM anggota
 WHERE Status_Pinjam = 'iya'
 INTO daftardata;
END//
DELIMITER ;
CALL daftar_anggota(@daftardata);
SELECT @daftardata;

/*coba 2*/
DELIMITER //
CREATE PROCEDURE daftardataanggota(
 OUT IdAnggota INT (20),
 OUT Nama_Anggota VARCHAR (30),
 OUT Angkatan_Anggota VARCHAR (50),
 OUT Tempat_Tanggal_Lahir VARCHAR (30),
 OUT Tanggal_Lahir_Anggota DATE,
 OUT No_Telp INT (12),
 OUT Jenis_Kelamin VARCHAR (5),
 OUT Status_Pinjam VARCHAR (20)
 )
BEGIN 
 SELECT IdAnggota, Nama_Anggota, Angkatan_Anggota, Tempat_Lahir_Anggota, 
 Tanggal_Lahir_Anggota, No_Telp, Jenis_Kelamin, Status_Pinjam FROM anggota 
 WHERE Status_Pinjam = 'iya';
END //
DELIMITER ;
CALL daftardataanggota(@IdAnggota, @Nama_Anggota, @Angkatan_Anggota, 
@Tempat_Lahir_Anggota, @Tanggal_Lahir_Anggota, @No_Telp, @Jenis_Kelamin, 
@Status_Pinjam);

/*nomor4*/
DELIMITER //
CREATE PROCEDURE data_baru(
IN Kode_Buku INT,
IN Judul_Buku VARCHAR(50),
IN Pengarang_Buku VARCHAR(50),
IN Penerbit_Buku VARCHAR(50),
IN Tahun_Buku YEAR,
IN Jumlah_Buku INT,
IN Status_Buku VARCHAR(20),
IN Klasifikasi_Buku VARCHAR(50),
OUT pesan TEXT
)
BEGIN
 INSERT INTO buku VALUES (Kode_Buku, Judul_Buku, Pengarang_Buku, Penerbit_Buku, Tahun_Buku, Jumlah_Buku, Status_Buku, Klasifikasi_Buku);
 SET pesan = 'Data buku telah berhasil ditambahkan!';
END//
DELIMITER ;
CALL data_baru (9, 'Teknologi Basis Data', 'Nurul Fajrin', 'UPT Pusat Pelatihan ITS', '2017', 1, 'Baru', 'Pengetahuan', @pesan);

/*nomor5*/
DELIMITER //
CREATE PROCEDURE hapusAnggota(
    IN kode_anggota INT(10)
)
BEGIN
    DECLARE status_pinjaman VARCHAR(15);
    DECLARE keterangan VARCHAR(100);

    SELECT Status_Pinjam INTO status_pinjaman FROM anggota WHERE IdAnggota = kode_anggota;

    IF status_pinjaman = 'iya' THEN
        SET keterangan = CONCAT('Gagal menghapus Anggota ', kode_anggota, ' karena masih memiliki pinjaman yang belum dikembalikan.');
    ELSE
        DELETE FROM anggota WHERE IdAnggota = kode_anggota;
        SET keterangan = CONCAT('Data anggota dengan ID ', kode_anggota, ' telah berhasil dihapus.');
    END IF;

    SELECT keterangan;
END //
DELIMITER ;


/*nomor6*/
/*right join dengan tabel peminjaman dibagian kanan tabel anggota*/
CREATE VIEW rght_join AS
SELECT a.Nama_Anggota, a.Angkatan_Anggota, a.Tempat_Lahir_Anggota, a.Tanggal_Lahir_Anggota, a.Jenis_Kelamin, a.Status_Pinjam,
p.Kode_Buku, COUNT(p.Kode_Buku) AS Jumlah_Buku, p.IdPetugas, p.Tanggal_Pinjam, p.Tanggal_Kembali FROM anggota a 
RIGHT JOIN peminjaman p ON a.IdAnggota=p.IdAnggota GROUP BY a.Nama_Anggota, a.Angkatan_Anggota, a.Tempat_Lahir_Anggota, 
a.Tanggal_Lahir_Anggota, a.Jenis_Kelamin, a.Status_Pinjam, p.Kode_Buku, p.IdPetugas, p.Tanggal_Pinjam, p.Tanggal_Kembali;
/*inner join*/
CREATE VIEW inner_join AS
SELECT p.IdPetugas, p.Username, p.PASSWORD, q.Nama
FROM petugas p INNER JOIN petugas q ON p.Nama = q.Nama;
/*left join*/
CREATE VIEW left_join AS
SELECT a.Nama_Anggota, a.Angkatan_Anggota, a.Tempat_Lahir_Anggota, a.Tanggal_Lahir_Anggota, a.Jenis_Kelamin, a.Status_Pinjam,
       p.Kode_Buku, COUNT(p.Kode_Buku) AS Jumlah_Buku, p.IdPetugas, p.Tanggal_Pinjam, p.Tanggal_Kembali
FROM anggota a LEFT JOIN peminjaman p ON a.IdAnggota=p.IdAnggota
GROUP BY a.Nama_Anggota, a.Angkatan_Anggota, a.Tempat_Lahir_Anggota, a.Tanggal_Lahir_Anggota, a.Jenis_Kelamin, a.Status_Pinjam, 
p.Kode_Buku, p.IdPetugas, p.Tanggal_Pinjam, p.Tanggal_Kembali;
SELECT VIEW FROM left_join;