CREATE DATABASE penyewaanMobil;

USE penyewaanMobil;
DROP DATABASE penyewaanMobil;

CREATE TABLE IF NOT EXISTS mobil (
    id_mobil VARCHAR(5) NOT NULL PRIMARY KEY,
    platno VARCHAR(20) NOT NULL,
    merk VARCHAR(50) NOT NULL,
    jenis VARCHAR(50) NOT NULL,
    harga_sewa_perhari INT(11)
);

INSERT INTO mobil (id_mobil, platno, merk, jenis, harga_sewa_perhari) VALUES
('M001', 'ABLA0001', 'Toyota', 'Avanza',100000),
('M002', 'BCMB0002', 'Honda', 'Brio',100000),
('M003', 'ADNC0003', 'Suzuki', 'Ertiga',150000),
('M004', 'BEOD0004', 'Nissan', 'Livina',150000),
('M005', 'AFBE0005', 'Mitsubishi', 'Xpander',100000),
('M006', 'BGQF0006', 'Hyundai', 'Creta',100000),
('M007', 'AHRG0007', 'Kia', 'Seltos',100000),
('M008', 'BISH0008', 'Hyundai', 'Palisade',150000),
('M009', 'AJTI0009', 'Kia', 'Rio',120000),
('M010', 'BKUJ0010', 'Mazda', 'CX-5',160000);

DROP TABLE mobil;

CREATE TABLE IF NOT EXISTS pelanggan (
    id_pelanggan VARCHAR(5) NOT NULL PRIMARY KEY,
    nama VARCHAR(50) NOT NULL,
    alamat VARCHAR(100) NOT NULL,
    nik VARCHAR(20) NOT NULL,
    no_tlp VARCHAR(20) NOT NULL,
    jenis_kelamin VARCHAR(10) NOT NULL
);

INSERT INTO pelanggan (id_pelanggan, nama, alamat, nik, no_tlp, jenis_kelamin) VALUES
('P001', 'Rizky Hidayat', 'Jl. Kebon Jeruk No.10, Jakarta', '3211010101010001', '081234567891', 'Laki-laki'),
('P002', 'Maria Ulfa', 'Jl. Braga No.12, Bandung', '3212020202020002', '081987654322', 'Perempuan'),
('P003', 'Andi Wijaya', 'Jl. Ahmad Yani No.15, Surabaya', '3213030303030003', '082123456790', 'Laki-laki'),
('P004', 'Lestari Wulandari', 'Jl. Karya Jasa No.30, Medan', '3214040404040004', '082987654322', 'Perempuan'),
('P005', 'Arif Setiawan', 'Jl. Malioboro No.99, Yogyakarta', '3215050505050005', '083123456790', 'Laki-laki');


CREATE TABLE IF NOT EXISTS peminjaman (
    id_pinjam INT(10) NOT NULL PRIMARY KEY,
    id_mobil VARCHAR(5) NOT NULL,
    id_pelanggan VARCHAR(5) NOT NULL,
    tgl_pinjam DATE NOT NULL,
    tgl_rencana_kembali DATE NOT NULL,
    total_hari INT(20) NOT NULL,
    total_bayar INT(20) NOT NULL,
    tgl_kembali DATE,
    denda INT(20),
    CONSTRAINT fkMobil FOREIGN KEY (id_mobil) REFERENCES mobil(id_mobil),
    CONSTRAINT fkPelanggan FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
);

INSERT INTO peminjaman (id_pinjam, id_mobil, id_pelanggan, tgl_pinjam, tgl_rencana_kembali, total_hari) VALUES
(1, 'M001', 'P001', '2024-05-01', '2024-05-05', 4),
(2, 'M002', 'P002', '2024-05-02', '2024-05-06', 4),
(3, 'M003', 'P003', '2024-05-03', '2024-05-10', 7),
(4, 'M004', 'P004', '2024-05-04', '2024-05-08', 4),
(5, 'M005', 'P005', '2024-05-05', '2024-05-12', 7),
(6, 'M006', 'P001', '2024-05-06', '2024-05-09', 3),
(7, 'M007', 'P002', '2024-05-07', '2024-05-11', 4),
(8, 'M008', 'P003', '2024-05-08', '2024-05-15', 7),
(9, 'M009', 'P004', '2024-05-09', '2024-05-12', 3),
(10, 'M010', 'P005', '2024-05-10', '2024-05-17', 7),
(11, 'M001', 'P001', '2024-05-11', '2024-05-14', 3),
(12, 'M002', 'P002', '2024-05-12', '2024-05-16', 4),
(13, 'M003', 'P003', '2024-05-13', '2024-05-20', 7),
(14, 'M004', 'P004', '2024-05-14', '2024-05-18', 4),
(15, 'M005', 'P005', '2024-05-15', '2024-05-22', 7);
 DROP TABLE peminjaman;

SELECT * FROM mobil;
SELECT * FROM pelanggan;
SELECT * FROM peminjaman;



-- nomor 1
DELIMITER//
CREATE TRIGGER peringatanPeminjaman BEFORE 
INSERT ON peminjaman FOR EACH ROW
BEGIN
	IF new.tgl_pinjam > new.tgl_rencana_kembali THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Tanggal pinjam tidak valid!! Pinjam sebelum tanggal rencana pengembalian!";
	END IF;
END//
DELIMITER//

INSERT INTO peminjaman (id_pinjam, id_mobil, id_pelanggan, tgl_pinjam, tgl_rencana_kembali, total_hari, total_bayar) 
	VALUES (16, 'M001', 'P001', '2024-05-07', '2024-05-05',2, 500000);

DROP TRIGGER peringatanPeminjaman;


-- nomor 2
DELIMITER //
CREATE TRIGGER hitungDenda
BEFORE UPDATE ON peminjaman
FOR EACH ROW
BEGIN
	DECLARE ttlharga INT(20);
	DECLARE hariTelat INT(20);
	DECLARE dnda INT(20);
	DECLARE hrga_sewa INT(20);
	
	SELECT mobil.harga_sewa_perhari INTO hrga_sewa FROM mobil WHERE mobil.id_mobil = NEW.id_mobil;

	-- Menghitung total harga sewa
	SET ttlharga = hrga_sewa * NEW.total_hari;
	

	IF new.tgl_rencana_kembali != new.tgl_kembali THEN
		SET hariTelat = DATEDIFF(new.tgl_kembali, new.tgl_rencana_kembali);
		SET dnda = 50000 * hariTelat;
		SET new.total_bayar = ttlharga, new.denda = dnda;
	ELSE 
		SET new.total_bayar = ttlharga, new.denda = 0;
	END IF;
END //
DROP TRIGGER hitungDenda
UPDATE peminjaman SET tgl_kembali = '2024-05-06' WHERE id_pinjam = 1;
UPDATE peminjaman SET tgl_kembali = '2024-05-06' WHERE id_pinjam = 2;
SELECT * FROM pelanggan;


-- nomor 3
DELIMITER//
CREATE TRIGGER kesalahanNIK BEFORE 
INSERT ON pelanggan FOR EACH ROW
BEGIN
	IF new.nik != 16 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Jumlah NIK yang dimasukkan salah!";
	END IF;
	
END//
DELIMITER//

INSERT INTO pelanggan (id_pelanggan, nama, alamat, nik, no_tlp, jenis_kelamin) VALUES
('P006', 'Herdiyanti Fifin', 'Gresik', '3201010101010005', '081234564590', 'Perempuan');


-- nomor 4
DELIMITER//
CREATE TRIGGER kesalahanPlatno BEFORE 
INSERT ON mobil FOR EACH ROW
BEGIN
	IF NOT (LEFT(new.platno, 4) REGEXP '^[a-zA-Z]{4}') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '4 karakter awal plat nomor harus berupa huruf!!';
	END IF;
END//
DELIMITER//

DROP TRIGGER kesalahanPlatno;

INSERT INTO mobil (id_mobil, platno, merk, jenis) VALUES
('M011', 'S5412JBV', 'Toyota', 'Sedan');

INSERT INTO mobil (id_mobil, platno, merk, jenis) VALUES
('M012', 'AAAA1111', 'Toyota', 'Sedan');

SELECT * FROM mobil;