CREATE DATABASE library_system;
USE library_system;

-- Membuat tabel buku
CREATE TABLE buku (
  id_buku INT PRIMARY KEY AUTO_INCREMENT,
  judul VARCHAR(255) NOT NULL,
  pengarang VARCHAR(255) NOT NULL,
  penerbit VARCHAR(255) NOT NULL,
  tahun_terbit INT NOT NULL
);
-- Membuat tabel anggota
CREATE TABLE anggota (
  id_anggota INT PRIMARY KEY AUTO_INCREMENT,
  nama VARCHAR(255) NOT NULL,
  alamat VARCHAR(255) NOT NULL,
  no_telepon VARCHAR(255) NOT NULL,
  status_pinjam VARCHAR(20) NOT NULL
);
-- Membuat tabel petugas
CREATE TABLE petugas (
  id_petugas INT PRIMARY KEY AUTO_INCREMENT,
  nama_petugas VARCHAR(255) NOT NULL
);
-- Membuat tabel pengembalian
CREATE TABLE pengembalian (
  id_pengembalian INT PRIMARY KEY AUTO_INCREMENT,
  id_anggota INT NOT NULL,
  id_petugas INT NOT NULL,
  tgl_pengembalian DATE NOT NULL,
  FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota),
  FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas)
);
-- Membuat tabel peminjaman
CREATE TABLE peminjaman (
  id_peminjaman INT PRIMARY KEY AUTO_INCREMENT,
  id_anggota INT NOT NULL,
  id_buku INT NOT NULL,
  tgl_pinjam DATE NOT NULL,
  tgl_rencana_kembali DATE NOT NULL,
  tgl_kembali DATE DEFAULT NULL,
  total_hari INT DEFAULT 0,
  total_bayar INT DEFAULT 0,
  denda INT DEFAULT 0,
  FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota),
  FOREIGN KEY (id_buku) REFERENCES buku(id_buku)
);
INSERT INTO anggota (nama, alamat, no_telepon, status_pinjam)
VALUES
  ('Anggota A', 'Jl. A No. 1', '0811111111', 'meminjam'),
  ('Anggota B', 'Jl. B No. 2', '0822222222', 'tidak meminjam'),
  ('Anggota C', 'Jl. C No. 3', '0833333333', 'meminjam'),
  ('Anggota D', 'Jl. D No. 4', '0844444444', 'tidak meminjam'),
  ('Anggota E', 'Jl. E No. 5', '0855555555', 'meminjam');
INSERT INTO buku (judul, pengarang, penerbit, tahun_terbit)
VALUES
  ('Buku A', 'Pengarang A', 'Penerbit A', 2020),
  ('Buku B', 'Pengarang B', 'Penerbit B', 2021),
  ('Buku C', 'Pengarang C', 'Penerbit C', 2022),
  ('Buku D', 'Pengarang D', 'Penerbit D', 2023),
  ('Buku E', 'Pengarang E', 'Penerbit E', 2024);
INSERT INTO petugas (nama_petugas)
VALUES
  ('Petugas A'),
  ('Petugas B'),
  ('Petugas C'),
  ('Petugas D'),
  ('Petugas E');
INSERT INTO pengembalian (id_anggota, id_petugas, tgl_pengembalian)
VALUES
  (1, 1, '2024-06-01'),
  (2, 2, '2024-06-02'),
  (3, 3, '2024-06-03'),
  (4, 4, '2024-06-04'),
  (5, 5, '2024-06-05');
INSERT INTO peminjaman (id_anggota, id_buku, tgl_pinjam, tgl_rencana_kembali)
VALUES
  (1, 1, '2024-05-01', '2024-05-10'),
  (2, 2, '2024-05-02', '2024-05-12'),
  (3, 3, '2024-05-03', '2024-05-15'),
  (4, 4, '2024-05-04', '2024-05-20'),
  (5, 5, '2024-05-05', '2024-05-25');


DELIMITER //
	CREATE PROCEDURE cari_pengembalian_by_tanggal(
	  IN tgl DATE,
	  OUT hasil_pengembalian TEXT
	)
	BEGIN
	  SELECT GROUP_CONCAT(CONCAT_WS(', ', pengembalian.id_pengembalian, anggota.nama, petugas.nama_petugas, pengembalian.tgl_pengembalian) SEPARATOR '; ')
	  INTO hasil_pengembalian
	  FROM pengembalian
	  JOIN anggota ON pengembalian.id_anggota = anggota.id_anggota
	  JOIN petugas ON pengembalian.id_petugas = petugas.id_petugas
	  WHERE pengembalian.tgl_pengembalian = tgl;
	END//
DELIMITER ;
-- Contoh panggilan prosedur
CALL cari_pengembalian_by_tanggal('2024-06-01', @hasil);
SELECT @hasil;

DELIMITER //
CREATE PROCEDURE cari_anggota_by_status_pinjam(
  IN status_pinjam VARCHAR(20),
  OUT hasil_anggota TEXT
)
BEGIN
  SELECT GROUP_CONCAT(CONCAT_WS(', ', id_anggota, nama, alamat, no_telepon, status_pinjam) SEPARATOR '; ')
  INTO hasil_anggota
  FROM anggota
  WHERE anggota.status_pinjam = status_pinjam;
END//
DELIMITER ;
-- Contoh panggilan prosedur
CALL cari_anggota_by_status_pinjam('meminjam', @hasil);
SELECT @hasil;

DELIMITER //
CREATE PROCEDURE daftar_anggota_by_status_pinjam(
  IN status_pinjam VARCHAR(20),
  OUT hasil_anggota TEXT
)
BEGIN
  SELECT GROUP_CONCAT(CONCAT_WS(', ', id_anggota, nama, alamat, no_telepon, status_pinjam) SEPARATOR '; ')
  INTO hasil_anggota
  FROM anggota
  WHERE anggota.status_pinjam = status_pinjam;
END//
DELIMITER ;
-- Contoh panggilan prosedur
CALL daftar_anggota_by_status_pinjam('meminjam', @hasil);
SELECT @hasil;

DELIMITER //
CREATE PROCEDURE tambah_buku(
  IN judul_buku VARCHAR(255),
  IN pengarang_buku VARCHAR(255),
  IN penerbit_buku VARCHAR(255),
  IN tahun_terbit_buku INT
)
BEGIN
  INSERT INTO buku (judul, pengarang, penerbit, tahun_terbit)
  VALUES (judul_buku, pengarang_buku, penerbit_buku, tahun_terbit_buku);
  SELECT 'Data buku telah berhasil ditambahkan' AS pesan;
END//
DELIMITER ;
-- Contoh panggilan prosedur
CALL tambah_buku('Buku Baru', 'Pengarang Baru', 'Penerbit Baru', 2024);


DELIMITER //
	CREATE PROCEDURE hapus_anggota(
	  IN anggota_id INT
	)
	BEGIN
	  DECLARE jumlah_pinjam INT;
	  -- Mengecek apakah anggota memiliki pinjaman yang belum dikembalikan
	  SELECT COUNT(*) INTO jumlah_pinjam
	  FROM peminjaman
	  WHERE id_anggota = anggota_id AND tgl_kembali IS NULL;

	  IF jumlah_pinjam > 0 THEN
	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Anggota masih memiliki pinjaman yang belum dikembalikan';
	  ELSE
	    DELETE FROM anggota WHERE id_anggota = anggota_id;
	    SELECT 'Data anggota telah berhasil dihapus' AS pesan;
	  END IF;
	END//
DELIMITER ;
-- Contoh panggilan prosedur
CALL hapus_anggota(1);


CREATE VIEW anggota_dan_pengembalian_right AS
SELECT anggota.nama, pengembalian.tgl_pengembalian, pengembalian.id_pengembalian
FROM anggota
RIGHT JOIN pengembalian ON anggota.id_anggota = pengembalian.id_anggota;
-- Contoh query untuk melihat data
SELECT * FROM anggota_dan_pengembalian_right;

CREATE VIEW anggota_dan_pengembalian_inner AS
SELECT anggota.nama, pengembalian.tgl_pengembalian, pengembalian.id_pengembalian
FROM anggota
INNER JOIN pengembalian ON anggota.id_anggota = pengembalian.id_anggota;
-- Contoh query untuk melihat data
SELECT * FROM anggota_dan_pengembalian_inner;

CREATE VIEW anggota_dan_pengembalian_left AS
SELECT anggota.nama, pengembalian.tgl_pengembalian, pengembalian.id_pengembalian
FROM anggota
LEFT JOIN pengembalian ON anggota.id_anggota = pengembalian.id_anggota;
-- Contoh query untuk melihat data
SELECT * FROM anggota_dan_pengembalian_left;

CREATE VIEW jumlah_pengembalian_per_anggota AS
SELECT anggota.nama, COUNT(pengembalian.id_pengembalian) AS jumlah_pengembalian
FROM anggota
LEFT JOIN pengembalian ON anggota.id_anggota = pengembalian.id_anggota
GROUP BY anggota.id_anggota;
-- Contoh query untuk melihat data
SELECT * FROM jumlah_pengembalian_per_anggota;
