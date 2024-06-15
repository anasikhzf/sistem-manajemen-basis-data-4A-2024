CREATE DATABASE rental_mobil;
USE rental_mobil;

CREATE TABLE IF NOT EXISTS mobil(
id_mobil INT (10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
plat_no VARCHAR (20) NOT NULL ,
merk VARCHAR (20) NOT NULL,
jenis VARCHAR (20) NOT NULL,
harga_sewa_perhari INT (10) NOT NULL
);

CREATE TABLE IF NOT EXISTS pelanggan(
id_pelanggan INT (10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
nama VARCHAR (20) NOT NULL,
alamat VARCHAR (20) NOT NULL,
nik VARCHAR (20) NOT NULL,
no_telepon VARCHAR (12) NOT NULL,
jenis_kelamin VARCHAR (1) NOT NULL
);

CREATE TABLE IF NOT EXISTS peminjaman(
id_peminjaman INT (10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
id_mobil INT (10) NOT NULL,
id_pelanggan INT (10) NOT NULL,
tanggal_pinjam DATE NOT NULL,
tanggal_rencana_kembali DATE NOT NULL,
tanggal_kembali DATE,
total_hari INT (10),
total_bayar INT (10),
denda INT (10)
);


ALTER TABLE rental_mobil.peminjaman ADD CONSTRAINT fk_id_pelanggan FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan);

ALTER TABLE rental_mobil.peminjaman ADD CONSTRAINT fk_id_mobil FOREIGN KEY (id_mobil) REFERENCES mobil(id_mobil);


INSERT INTO mobil VALUES
('', 'AG1234AA', 'Toyota', 'SUV', 500000),
('', 'AG2345BB', 'Honda', 'Sedan', 450000),
('', 'AG3456CC', 'Suzuki', 'PickUp', 200000);

INSERT INTO pelanggan VALUES 
('', 'Bobi', 'Kediri', '1122334455', '081122223333', 'L'),
('', 'Robi', 'Nganjuk', '223311899', '081138729328', 'L'),
('', 'Pupa', 'Bangkalan', '3399229933', '08148392010', 'P');


INSERT INTO peminjaman VALUES
('', 1, 2, '2024-05-29', '2024-06-01', NULL, NULL, NULL, NULL),
('', 2, 1, '2024-05-29', '2024-05-31', NULL, NULL, NULL, NULL);



-- nomor 1
DELIMITER //
CREATE TRIGGER cek_tanggal
BEFORE INSERT ON peminjaman
FOR EACH ROW
BEGIN
	IF new.tanggal_rencana_kembali < new.tanggal_pinjam THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Tanggal Rencana Kembali tidak boleh lebih awal dari Tanggal Pinjam';
	END IF;
END //
DELIMITER ;

INSERT INTO peminjaman VALUES
('', 3, 3, '2024-04-29', '2024-04-17', NULL, NULL, NULL, NULL);


-- nomor 2
DELIMITER //
CREATE TRIGGER hitung_total
BEFORE UPDATE ON peminjaman 
FOR EACH ROW
BEGIN
	DECLARE jumlah_hari INT;
	DECLARE hari_telat INT;
	DECLARE sewa_harian INT;
	DECLARE tarif_denda INT;

	IF NEW.tanggal_kembali IS NOT NULL THEN
		SET jumlah_hari = DATEDIFF(NEW.tanggal_kembali, NEW.tanggal_pinjam);
		SET hari_telat = DATEDIFF(NEW.tanggal_kembali, NEW.tanggal_rencana_kembali);

		SELECT harga_sewa_perhari INTO sewa_harian
		FROM mobil
		WHERE id_mobil = NEW.id_mobil;

		IF hari_telat > 0 THEN
			SET tarif_denda = 0.1 * sewa_harian;
		ELSE
			SET tarif_denda = 0;
		END IF;

		SET NEW.total_hari = jumlah_hari;
		SET NEW.total_bayar = jumlah_hari * sewa_harian;
		SET NEW.denda = hari_telat * tarif_denda;
	END IF;
END //
DELIMITER ;

UPDATE peminjaman SET tanggal_kembali = '2024-06-02' WHERE id_peminjaman = 1;

SELECT * FROM peminjaman;
DROP TRIGGER hitung_total;


-- nomor 3
DELIMITER //
CREATE TRIGGER cek_nik
BEFORE INSERT ON pelanggan
FOR EACH ROW
BEGIN
	IF LENGTH (new.nik) <> 16 THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Panjang NIK harus 16 karakter';
	END IF;
END //
DELIMITER ;

INSERT INTO pelanggan VALUES 
('', 'Radi', 'Surabaya', '09091839382', '08148392010', 'P');


-- nomor4

DELIMITER //

CREATE TRIGGER cek_plat
BEFORE INSERT ON mobil
FOR EACH ROW
BEGIN
    IF LEFT(NEW.plat_no, 2) NOT REGEXP '[A-Za-z]{2}' THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Dua karakter pertama pada kolom plat_no harus huruf';
    END IF;
END //

DELIMITER   ;

INSERT INTO mobil VALUES
('', '111234AA', 'Minshubisi', 'Supra', 459000);


DROP DATABASE rental_mobil;