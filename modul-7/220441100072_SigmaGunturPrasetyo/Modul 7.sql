CREATE DATABASE Modul7;
DROP DATABASE Modul7;
USE Modul7;

CREATE TABLE IF NOT EXISTS mobil (
id_mobil VARCHAR(10)  NOT NULL PRIMARY KEY,
platno VARCHAR(10) NOT NULL,
merk VARCHAR(30) NOT NULL,
jenis VARCHAR(10) NOT NULL,
harga_sewa_perhari INT (10) NOT NULL
);



CREATE TABLE IF NOT EXISTS peminjaman (
id1 VARCHAR (10) NOT NULL PRIMARY KEY,
id_mobil VARCHAR (10) NOT NULL,
id_pelanggan VARCHAR (10) NOT NULL,
tgl_pinjam DATE , 
tgl_rencana_kembali DATE,
total_hari INT (20) NOT NULL,
total_bayar INT (20) NOT NULL,
tgl_kembali DATE ,
denda INT (10) NOT NULL,
FOREIGN KEY (id_mobil) REFERENCES mobil (id_mobil),
FOREIGN KEY (id_pelanggan) REFERENCES pelanggan (id_pelanggan)
);


CREATE TABLE IF NOT EXISTS pelanggan (
id_pelanggan VARCHAR (10) NOT NULL PRIMARY KEY,
nama VARCHAR (100) NOT NULL,
alamat VARCHAR (40) NOT NULL,
nik INT (16) NOT NULL,
no_telepon INT (12) NOT NULL,
jenis_kelamin VARCHAR (2) NOT NULL
);


SHOW TABLES;
DROP TABLE pelanggan;
DROP TABLE peminjaman;
DROP TABLE mobil;

-- Ganti Nilai Sesuai Ketentuan

INSERT INTO mobil  VALUES
('M001', 'S1234B', 'Honda Jazz', 'Matic', 200000),
('M002', 'L5434PP', 'Honda Brio', 'Matic', 150000),
('M003', 'A4279CC', 'Meserati J10', 'Manual', 400000),
('M004', 'D4234AA', 'Mustang Horse', 'Manual', 350000),
('M005', 'AB5244GH', 'Daihatsu Xenia', 'Matic', 100000);

INSERT INTO pelanggan VALUES 
('P001','Tyo','Surabaya',34324324234312345,081231371,'L'),
('P002','Tymo','Gresik',2442342234527803,081234551,'L'),
('P003','Siti','Malang',234524135780123,085131351,'P'),
('P004','Mila','Sidoarjo',1323420987567514,082231321,'P'),
('P005','Jamal','Pasuruan',9892428980287643,089232431,'L');

INSERT INTO peminjaman VALUES 
('PM001', 'M003', 'P001', '2024-05-25', '2024-05-30', 2, 800000, '2024-05-30', 0),
('PM002', 'M005', 'P005', '2024-05-22', '2024-05-28', 6, 600000, '2024-05-31', 0),
('PM003', 'M001', 'P003', '2024-05-24', '2024-05-27', 3, 600000, '2024-05-28', 0),
('PM004', 'M004', 'P002', '2024-05-23', '2024-05-27', 2, 700000, '2024-05-26', 50000),
('PM005', 'M002', 'P004', '2024-05-23', '2024-05-26', 3, 300000, '2024-05-26', 0);

UPDATE peminjaman SET tgl_kembali = '2024-06-26' WHERE id1 = 'PM005'; 

SELECT * FROM pelanggan;
SELECT * FROM peminjaman;
SELECT * FROM mobil;


use modul7;
-- Nomor 1 AMAN
DELIMITER //
CREATE TRIGGER check_tgl_rencana_kembali 
BEFORE INSERT ON peminjaman
FOR EACH ROW
BEGIN
    IF NEW.tgl_rencana_kembali < NEW.tgl_pinjam THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tanggal rencana kembali tidak boleh lebih awal dari tanggal pinjam';
    END IF;
END//
DELIMITER ;

DROP TABLE peminjaman;

INSERT INTO peminjaman VALUES 
('PM007', 'M002', 'P004', '2024-05-23', '2024-05-25', 3, 300000, '2024-05-25', 0);

select * from peminjaman;



-- NOMOR 2 
DELIMITER //
CREATE TRIGGER update_peminjaman 
BEFORE UPDATE ON peminjaman
FOR EACH ROW
BEGIN
    
    DECLARE v_harga_sewa_perhari int(10);
    
    SELECT harga_sewa_perhari
    INTO v_harga_sewa_perhari
    FROM mobil
    WHERE id_mobil = NEW.id_mobil;

    IF NEW.tgl_kembali IS NOT NULL THEN
        SET NEW.total_hari = DATEDIFF(NEW.tgl_kembali, OLD.tgl_pinjam);
        SET NEW.total_bayar = NEW.total_hari * v_harga_sewa_perhari;
        
        IF NEW.tgl_kembali > OLD.tgl_rencana_kembali THEN
            SET NEW.denda = DATEDIFF(NEW.tgl_kembali, OLD.tgl_rencana_kembali) * v_harga_sewa_perhari;
        ELSE
            SET NEW.denda = 0;
        END IF;
    END IF;
END//
DELIMITER ;

drop trigger update_peminjaman;

UPDATE peminjaman SET tgl_kembali = '2024-05-26' WHERE id1 = 'PM005';
SELECT * FROM peminjaman WHERE id1 = 'PM005';




-- Nomor 3
DELIMITER //
CREATE TRIGGER Validasi_NIK
BEFORE INSERT ON pelanggan
FOR EACH ROW
BEGIN
    IF LENGTH(NEW.nik) != 16 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Panjang Harus 16 Digit';
    END IF;
END //
DELIMITER ;

INSERT INTO pelanggan VALUES
('P007','Jeki','Pasuruan',2,089232431,'L');

--  Nomor 4

DELIMITER //
CREATE TRIGGER validasi_platno
BEFORE INSERT ON mobil
FOR EACH ROW
BEGIN
    DECLARE first_char CHAR(1);

    SET first_char = LEFT(NEW.platno, 1);

    IF NOT (first_char BETWEEN 'A' AND 'Z' OR first_char BETWEEN 'a' AND 'z') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Karakter pertama pada Plat Nomor harus huruf';
    END IF;
END//
DELIMITER ;

INSERT INTO mobil VALUES 
('M007', '1244GH', 'Toyota Inova', 'Manual', 200000);

