CREATE DATABASE penyewaan_mobil; 
USE penyewaan_mobil; 
 
CREATE TABLE mobil(
id_mobil INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
platno VARCHAR(50) NOT NULL,
merk VARCHAR(50) NOT NULL,
jenis VARCHAR(50) NOT NULL,
harga_sewa_perhari INT(50) NOT NULL);
 
CREATE TABLE pelanggan ( 
id_pelanggan INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT, 
nama VARCHAR(50) NOT NULL, 
alamat VARCHAR(50) NOT NULL, 
nik VARCHAR(50) NOT NULL, 
no_telepon VARCHAR(50) NOT NULL,  
jenis_kelamin VARCHAR(15) NOT NULL); 
 
CREATE TABLE peminjaman ( 
id_peminjaman INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT, 
id_mobil INT(10) NOT NULL, 
id_pelanggan INT(10) NOT NULL, 
tgl_pinjam DATE, 
tgl_rencana_kembali DATE, 
total_hari INT(100) NOT NULL, 
total_bayar INT(100) NOT NULL,  
tgl_kembali DATE,  
denda INT(100) NOT NULL,  
FOREIGN KEY (id_mobil) REFERENCES mobil(id_mobil),
FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)); 
 
INSERT INTO mobil (platno, merk, jenis, harga_sewa_perhari) VALUES 
('S 5909 JBF', 'Honda', 'Sedan', 190000),
('S 2304 ESR', 'Mitsubishi', 'SUV', 250000), 
('S 5761 JDK', 'Toyota', 'SUV', 275000), 
('S 3245 EGH', 'Ford', 'SUV', 290000), 
('S 0987 NMJ', 'Nissan', 'Sedan', 180000), 
('S 9876 GBV', 'Chevrolet', 'Sedan', 180000), 
('S 1675 WDF', 'Avanza', 'SUV', 200000), 
('S 2872 PLO', 'Mitsubishi', 'Sedan', 280000), 
('S 2278 SHB', 'Honda', 'SUV', 190000), 
('S 9456 CFT', 'Nissan', 'SUV', 200000);
 
INSERT INTO pelanggan (nama, alamat, nik, no_telepon, jenis_kelamin) VALUES 
('Devi Dwi', 'Lamongan', '220441100090', '089529753775', 'P'),
('Dedy Eka', 'Malang', '190441100080', '089612340987', 'L'),
('Eri Nana', 'Bojonegoro', '190441100009', '089765472345', 'P'),
('Adelia Shafira', 'Sidoarjo', '220441100104', '089178651234', 'P'),
('Arum Rahma', 'Pasuruan', '220441100074', '081234567890', 'P'),
('Ayuningtyas', 'Mojokerto', '220441100062', '082578900987', 'P'),
('Alimmuddin', 'Gresik', '220441100084', '089765431234', 'L'),
('Rozikhin', 'Pamekasan', '220441100140', '081523455432', 'L'),
('Nizar Akhdan', 'Surabaya', '230441100101', '082567876787', 'L'),
('Arvan Denanta', 'Kediri', '230441100102', '082434568765', 'L');
 
INSERT INTO peminjaman (id_mobil, id_pelanggan, tgl_pinjam, tgl_rencana_kembali, total_hari, total_bayar, tgl_kembali, denda) VALUES 
(2, 3, '2024-05-10', '2024-05-17', 3, NULL, NULL, NULL),
(1, 2, '2024-04-12', '2024-04-17', 2, NULL, NULL, NULL), 
(2, 1, '2024-04-11', '2024-04-17', 4, NULL, NULL, NULL), 
(2, 2, '2024-03-19', '2024-03-20', 3, NULL, NULL, NULL), 
(3, 3, '2024-05-20', '2024-05-22', 6, NULL, NULL, NULL), 
(3, 5, '2024-03-09', '2024-03-10', 5, NULL, NULL, NULL), 
(7, 8, '2024-04-01', '2024-04-17', 2, NULL, NULL, NULL), 
(8, 9, '2024-03-10', '2024-03-12', 3, NULL, NULL, NULL), 
(9, 10, '2024-05-14', '2024-05-16', 2, NULL, NULL, NULL), 
(8, 10, '2024-05-18', '2024-05-21', 3, NULL, NULL, NULL);

/*Nomor 1*/
DELIMITER // 
CREATE TRIGGER nomor1 BEFORE INSERT ON peminjaman 
FOR EACH ROW 
BEGIN 
	IF (new.tgl_pinjam > new.tgl_rencana_kembali) THEN 
	SIGNAL SQLSTATE '45000' 
	SET MESSAGE_TEXT = 'Tanggal Rencana Kembali Tidak Lebih Awal dari Tanggal Pinjam!'; 
	END IF; 
END// 
DELIMITER ; 
INSERT INTO peminjaman (id_mobil, id_pelanggan, tgl_pinjam, tgl_rencana_kembali, total_hari, total_bayar, tgl_kembali, denda) 
VALUES (2, 4, '2023-05-18', '2023-05-15', 5, 1500000, '2023-05-15', 0); 
SELECT * FROM peminjaman; 

/*Nomor 2*/
DELIMITER //
CREATE TRIGGER nomor2
BEFORE UPDATE ON peminjaman
FOR EACH ROW
BEGIN
    DECLARE total_hari INT;
    DECLARE sewa_perhari INT;
    DECLARE overdue_days INT;
    DECLARE denda_perhari INT;
    
	/* Memastikan bahwa ini adalah pembaruan pertama pada kolom TGL_KEMBALI*/
	IF NEW.tgl_kembali <> OLD.tgl_kembali OR new.tgl_kembali IS NOT NULL THEN
        /* Menghitung total hari sewa*/
        SET total_hari = DATEDIFF(NEW.tgl_kembali, NEW.tgl_pinjam);
        SET NEW.total_hari = total_hari;
        /* Mendapatkan harga sewa per hari*/
        SELECT HARGA_SEWA_PERHARI INTO sewa_perhari FROM mobil WHERE id_mobil = NEW.id_mobil;
        /* Menghitung total bayar*/
        SET NEW.total_bayar = total_hari * sewa_perhari;
        /* Menghitung denda*/
        IF NEW.tgl_kembali > NEW.tgl_rencana_kembali THEN
            SET overdue_days = DATEDIFF(NEW.tgl_kembali, NEW.tgl_rencana_kembali);
            SET sewa_perhari = 0.1 * sewa_perhari; /* Denda 10% dari harga sewa per hari*/
            SET NEW.denda = overdue_days * sewa_perhari;
        ELSE
            SET NEW.denda = 0;
        END IF;
    END IF;
END//
DELIMITER ;

DROP TRIGGER nomor2
UPDATE peminjaman SET tgl_kembali = '2024-05-18' WHERE id_peminjaman = 1;
SELECT * FROM peminjaman;

/*Nomor 3*/
DELIMITER // 
CREATE TRIGGER nomor3 
BEFORE INSERT ON pelanggan
FOR EACH ROW 
BEGIN 
    DECLARE panjang_nik INT(50); 
     
    SET panjang_nik = LENGTH(NEW.nik); 
     
    IF panjang_nik <> 12 THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Panjang NIK tidak sesuai, cek lagi apakah ada yang salah'; 
    END IF; 
END // 
DELIMITER ; 
DROP TRIGGER nomor3;
 
INSERT INTO pelanggan (nama, alamat, nik, no_telepon, jenis_kelamin) VALUES 
('Shafira Zahra', 'Palembang', '220441100005', '081234567890', 'P');
INSERT INTO pelanggan (nama, alamat, nik, no_telepon, jenis_kelamin) VALUES 
('Haris Zidan', 'Jakarta', '2204411000052', '08927890367', 'L');
SELECT * FROM pelanggan;

/*Nomor 4*/
DELIMITER // 
CREATE TRIGGER nomor4 
BEFORE INSERT ON mobil
FOR EACH ROW 
BEGIN 
     
    IF (LEFT(NEW.platno,1) REGEXP '^[A-Za-z]+$') OR (LEFT(NEW.platno,2) REGEXP '^[A-Za-z]+$') THEN 
        SET NEW.platno = NEW.platno; 
    ELSE 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PLAT NO tidak sesuai, cek lagi apakah ada yang salah'; 
    END IF; 
END // 
DELIMITER ; 
 
INSERT INTO mobil (platno, merk, jenis, harga_sewa_perhari) VALUES
('DEVI 18', 'Toyota', 'Sedan', 200000);
INSERT INTO mobil (platno, merk, jenis, harga_sewa_perhari) VALUES
('12 S ABC', 'Toyota', 'Sedan', 200000);
SELECT * FROM mobil;

