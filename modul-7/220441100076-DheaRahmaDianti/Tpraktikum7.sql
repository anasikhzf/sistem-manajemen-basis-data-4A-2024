CREATE DATABASE retal_mobil;

USE retal_mobil;

CREATE TABLE IF NOT EXISTS mobil(
id_mobil INT(10) NOT NULL PRIMARY KEY,
platno VARCHAR(20) NOT NULL,
merk VARCHAR(100) NOT NULL,
jenis VARCHAR(100) NOT NULL);

INSERT INTO mobil (id_mobil, platno, merk, jenis) VALUES
(210, 'B1234XYZ', 'Toyota', 'Sedan'),
(211, 'D5678ABC', 'Honda', 'SUV'),
(212, 'B9101DEF', 'Suzuki', 'Hatchback'),
(213, 'A2345GHI', 'Nissan', 'Sedan'),
(214, 'B6789JKL', 'Mitsubishi', 'Pickup'),
(215, 'C3456MNO', 'Ford', 'SUV'),
(216, 'D7890PQR', 'Chevrolet', 'Sedan'),
(217, 'E1234STU', 'Hyundai', 'Hatchback'),
(218, 'F5678VWX', 'Kia', 'SUV'),
(219, 'G9101YZA', 'Mazda', 'Sedan');

DROP TABLE mobil;
SELECT * FROM mobil;


CREATE TABLE IF NOT EXISTS pelanggan(
id_pelanggan INT(10) NOT NULL PRIMARY KEY,
nama VARCHAR(50) NOT NULL,
alamat VARCHAR(100) NOT NULL,
nik VARCHAR(20) NOT NULL,
no_tlp VARCHAR(20) NOT NULL,
jenis_kelamin VARCHAR(10) NOT NULL);

INSERT INTO pelanggan (id_pelanggan, nama, alamat, nik, no_tlp, jenis_kelamin) VALUES
(101, 'Ahmad Pratama', 'Jl. Merdeka No.1, Jakarta', '3201010101010001', '081234567890', 'Laki-laki'),
(102, 'Siti Aminah', 'Jl. Sudirman No.45, Bandung', '3202020202020002', '081987654321', 'Perempuan'),
(103, 'Budi Santoso', 'Jl. Diponegoro No.12, Surabaya', '3203030303030003', '082123456789', 'Laki-laki'),
(104, 'Dewi Lestari', 'Jl. Thamrin No.99, Medan', '3204040404040004', '082987654321', 'Perempuan'),
(105, 'Indra Kusuma', 'Jl. Gatot Subroto No.50, Yogyakarta', '3205050505050005', '083123456789', 'Laki-laki');

SELECT * FROM pelanggan;
DROP TABLE pelanggan;

CREATE TABLE IF NOT EXISTS peminjaman(
id_pinjam INT(10) NOT NULL PRIMARY KEY,
id_mobil INT(10) NOT NULL,
id_pelanggan INT(10) NOT NULL,
tgl_pinjam DATE NOT NULL,
tgl_rencana_kembali DATE NOT NULL,
total_hari INT(20) NULL,
total_bayar INT(20) NULL,
tgl_kembali DATE NULL,
denda INT(20) NULL,
FOREIGN KEY (id_mobil) REFERENCES mobil(id_mobil),
FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan));

INSERT INTO peminjaman (id_pinjam, id_mobil, id_pelanggan, tgl_pinjam, tgl_rencana_kembali, total_hari, total_bayar, tgl_kembali, denda) VALUES
(1, 210, 101, '2024-05-01', '2024-05-05', 4, 400000, '2024-05-05', 0),
(2, 211, 102, '2024-05-02', '2024-05-06', 4, 500000, '2024-05-07', 100000),
(3, 212, 103, '2024-05-03', '2024-05-10', 7, 700000, '2024-05-10', 0),
(4, 213, 104, '2024-05-04', '2024-05-08', 4, 450000, '2024-05-08', 0),
(5, 214, 105, '2024-05-05', '2024-05-12', 7, 600000, '2024-05-14', 200000),
(6, 215, 101, '2024-05-06', '2024-05-09', 3, 350000, '2024-05-09', 0),
(7, 216, 102, '2024-05-07', '2024-05-11', 4, 400000, '2024-05-12', 50000),
(8, 217, 103, '2024-05-08', '2024-05-15', 7, 750000, '2024-05-15', 0),
(9, 218, 104, '2024-05-09', '2024-05-12', 3, 320000, '2024-05-12', 0),
(10, 219, 105, '2024-05-10', '2024-05-17', 7, 700000, '2024-05-18', 100000),
(11, 210, 103, '2024-05-11', '2024-05-14', 3, 300000, '2024-05-14', 0),
(12, 211, 104, '2024-05-12', '2024-05-16', 4, 420000, '2024-05-16', 0),
(13, 212, 105, '2024-05-13', '2024-05-20', 7, 780000, '2024-05-20', 0),
(14, 213, 101, '2024-05-14', '2024-05-18', 4, 480000, '2024-05-18', 0),
(15, 214, 102, '2024-05-15', '2024-05-22', 7, 700000, '2024-05-24', 200000);

DROP TABLE peminjaman;
SELECT * FROM peminjaman;


-- NO 1--
DELIMITER//
CREATE TRIGGER pesan_pinjam BEFORE 
INSERT ON peminjaman FOR EACH ROW
BEGIN
	IF new.tgl_pinjam > new.tgl_rencana_kembali THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Tanggal jangan melebihi";
	END IF;
	
END//
DELIMITER//

INSERT INTO peminjaman (id_pinjam, id_mobil, id_pelanggan, tgl_pinjam, tgl_rencana_kembali, total_hari, total_bayar, tgl_kembali, denda) VALUES
(16, 210, 101, '2024-05-06', '2024-05-05', 4, 400000, '2024-05-05', 0);

DROP TRIGGER hitung_denda;

-- NO 2 --

DELIMITER //
CREATE TRIGGER after_return_car BEFORE UPDATE ON peminjaman
FOR EACH ROW
BEGIN
    DECLARE jumlah_hari_sewa INT;
    DECLARE jumlah_hari_lebih INT;
    
    SET jumlah_hari_sewa = DATEDIFF(NEW.tgl_kembali, OLD.tgl_pinjam);
    SET jumlah_hari_lebih = DATEDIFF(NEW.tgl_kembali, OLD.tgl_rencana_kembali);
    
    SET NEW.total_hari = jumlah_hari_sewa;
    
    IF (jumlah_hari_lebih > 0) THEN
        SET NEW.denda = jumlah_hari_lebih * 100000;
        SET NEW.total_bayar = (jumlah_hari_sewa * 200000) + NEW.denda; 
    ELSE 
        SET NEW.denda = 0;
        SET NEW.total_bayar = jumlah_hari_sewa * 200000;
    END IF;
END //
DELIMITER ;

DROP TRIGGER after_return_car;

UPDATE peminjaman SET tgl_kembali = '2024-05-10' WHERE id_pinjam = 19;

INSERT INTO peminjaman (id_pinjam, id_mobil, id_pelanggan, tgl_pinjam, tgl_rencana_kembali) VALUES (20, 210, 101,'2024-05-12', '2024-05-');

SELECT * FROM peminjaman;

-- NO 3 --

DELIMITER//
CREATE TRIGGER pesan_nik BEFORE 
INSERT ON pelanggan FOR EACH ROW
BEGIN
	IF new.nik != 16 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Jumlah NIK tidak sesuai aturan";
	END IF;
	
END//
DELIMITER//

INSERT INTO pelanggan (id_pelanggan, nama, alamat, nik, no_tlp, jenis_kelamin) VALUES
(131, 'Ahmad Pratama', 'Jl. Merdeka No.1, Jakarta', '3201010101010001', '081234567890', 'Laki-laki');

-- NO 4 --

DELIMITER//
CREATE TRIGGER pesan_platno BEFORE 
INSERT ON mobil FOR EACH ROW
BEGIN
	IF NOT (LEFT(new.platno, 4) REGEXP '^[a-zA-Z]{4}') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '1/2 karakter awal plat nomor harus huruf!!';
	END IF;
	
END//
DELIMITER//

DROP TRIGGER pesan_platno;

INSERT INTO mobil (id_mobil, platno, merk, jenis) VALUES
(232, 'S5412JBV', 'Toyota', 'Sedan');