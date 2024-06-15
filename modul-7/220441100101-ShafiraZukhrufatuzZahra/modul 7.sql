CREATE DATABASE penyewaan_mobil;
USE penyewaan_mobil;

CREATE TABLE Mobil(
Id_mobil INT (10) PRIMARY KEY AUTO_INCREMENT,
Platno VARCHAR(10),
Merk VARCHAR (50),
Jenis VARCHAR (30),
Harga_Sewa_Perhari DECIMAL(10,2)
);

CREATE TABLE Pelanggan(
Id_pelanggan INT (10) PRIMARY KEY AUTO_INCREMENT,
Nama VARCHAR(10),
Alamat TEXT,
NIK INT (16),
No_Telepon VARCHAR(15),
Jenis_Kelamin ENUM ("L", "P")
);

CREATE TABLE Peminjaman(
Id_peminjaman INT (10) PRIMARY KEY AUTO_INCREMENT,
Id_mobil INT(10),
Id_pelanggan INT(10),
Tgl_pinjam DATETIME,
Tgl_rencana_kembali DATE,
Total_hari INT (10),
Total_bayar DECIMAL (10,2),
Tgl_kembali DATETIME,
Denda DECIMAL (10,2),
FOREIGN KEY (Id_mobil) REFERENCES Mobil(Id_mobil),
FOREIGN KEY (Id_pelanggan) REFERENCES Pelanggan(Id_Pelanggan)
);

INSERT INTO Mobil(Platno, Merk, Jenis, Harga_Sewa_Perhari) VALUES
('T 43 K', 'Toyota','Camry','200000.00'),
('J 43 MIN', 'Honda','Civic','300000.00'),
('J 4 Y', 'Toyota','Corolla','150000.00'),
('S 5909 JBV', 'Hyundai','Sonata','250000.00'),
('P 7I MIN', 'Honda','Pilot','175000.00'),
('L 73 NO', 'Hyundai','Tucson','225000.00');
SELECT * FROM Mobil;

INSERT INTO Pelanggan(Nama, Alamat, NIK, No_Telepon, Jenis_Kelamin) VALUES
('Fiqah','mertani, karanggeneng, Lamongan, Jawa Timur',23781773819,'08936153621', "P"),
('Novia','Bulak Banteng, Kapasan, Surabaya, Jawa Timur',21716876186,'08721837128','P'),
('Aldi','BanyuUrip, Surabaya, Jawa Timur',2617687168416,'08154513323','L'),
('Ibra','Cilegon, Merak, Banten','123179739',08512635813,'L'),
('Zahra','telang, Kamal, Bangkalan, Jawa Timur',123761287128,'08562153515','P'),
('Amelia','Kandangan, Surabaya, Jawa Timur',2371674878,'08387388287','P');
SELECT * FROM Pelanggan;

INSERT INTO Peminjaman(Id_mobil, Id_pelanggan, Tgl_pinjam, Tgl_rencana_kembali, Total_hari, Total_bayar, Tgl_kembali, Denda) VALUES
(7, 1, '2024-05-24 12:38', '2024-05-25', 1, 225000.00, '2024-05-25 13:35', 25000.00),
(9, 2, '2024-05-24 15:55', '2024-05-25', 2, 300000.00, '2024-05-26 15:00', 0),
(8, 3, '2024-05-24 16:00', '2024-05-25', 1, 350000.00, '2024-05-25 18:00', 50000.00),
(11, 4, '2024-05-25 08:33', '2024-05-28', 3, 525000.00, '2024-05-28 08:00', 0),
(10, 5, '2024-05-26 19:45', '2024-05-28', 2, 500000.00, '2024-05-25 17:00', 0),
(12, 6, '2024-05-27 10:24', '2024-05-28', 1, 250000.00, '2024-05-28 10:00', 0);
SELECT * FROM Peminjaman;

/*nomor 1 Pastikan tgl_rencana_kembali tidak lebih awal dari tgl_pinjam*/
DELIMITER //
CREATE TRIGGER cek_tanggal_rencana_kembali
BEFORE INSERT ON peminjaman
FOR EACH ROW
BEGIN
	IF NEW.Tgl_rencana_kembali < NEW.Tgl_pinjam THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'error: tanggal rencana kembali tidak boleh lebih awal dari tanggal pinjam';
	END IF;
END//
DELIMITER ;
INSERT INTO peminjaman (Id_mobil, Id_pelanggan, Tgl_pinjam, Tgl_rencana_kembali, Total_hari, Total_bayar, Tgl_kembali, Denda) VALUES
(8, 1,NOW(), '2024-05-27', 1, 3000000, '2024-05-29', 1000000);

/*2. Ketika mobil dikembalikan, tgl_kembali di isi, juga menghitung total_bayar dan denda
(jika ada) MASIH EROR*/
DELIMITER//
CREATE TRIGGER transaksiPenyewaan
BEFORE UPDATE ON peminjaman
FOR EACH ROW
BEGIN
  DECLARE lama_pinjam INT;
  DECLARE biaya_harian DECIMAL (10,2);
  DECLARE hari_terlambat INT;
  DECLARE biaya_denda DECIMAL (10,2);
  
  IF NEW.Tgl_kembali<>OLD.Tgl_kembali AND NEW.Tgl_kembali IS NOT NULL THEN
     SET lama_pinjam=DATEDIFF(NEW.Tgl_Kembali, NEW.Tgl_pinjam);
     SET NEW.Total_hari =lama_pinjam;
     
  SELECT Harga_Sewa_Perhari INTO biaya_harian FROM mobil WHERE Id_mobil=NEW.Id_mobil;
  SET NEW.Total_bayar = lama_pinjam * biaya_harian;
  IF NEW.Tgl_kembali > NEW.Tgl_rencana_kembali THEN
     SET hari_terlambat = DATEDIFF(NEW.Tgl_kembali, NEW.Tgl_rencana_kembali);
     SET biaya_denda = 0.1 * biaya_harian;
     SET NEW.Denda = hari_terlambat*biaya_denda;
  ELSE 
     SET NEW.Denda = 0;
  END IF;
END IF;
END//
DELIMITER;
UPDATE peminjaman SET Tgl_kembali = '2024-05-29' WHERE Id_peminjaman = 1;
SELECT * FROM peminjaman;


/*3. Ketika insert data ke tabel pelanggan, pastikan panjang NIK sesuai dengan aturan yang
berlaku*/
DELIMITER //
CREATE TRIGGER cek_panjang_NIK
BEFORE INSERT ON pelanggan
FOR EACH ROW
BEGIN
    IF CHAR_LENGTH(new.NIK) <> 16 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'error: panjang nik harus 16';
    END IF;
END//
DELIMITER ;

INSERT INTO Pelanggan(Nama, Alamat, NIK, No_Telepon, Jenis_Kelamin)VALUES  
('Nisa','Malang, Jawa Timur',4279237938291021389,'0838324256','P');

/*4. Ketika insert data ke tabel mobil, pastikan di kolom platno, 1/2 karakter awal harus
huruf*/
DELIMITER //
CREATE TRIGGER cek_awalan_platno
BEFORE INSERT ON Mobil
FOR EACH ROW
BEGIN
    IF NOT (new.platno REGEXP '^[A-Za-z]{1,2}[0-9]{1,4}$') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'error: platno harus dimulai dengan 1 atau 2 huruf diikuti oleh 1 sampai 4 angka';
    END IF;
END//
DELIMITER ;

INSERT INTO Mobil(Platno, Merk, Jenis, Harga_Sewa_Perhari) VALUES 	   
('123 A', 'Toyota', 'Sedan', 150000);
