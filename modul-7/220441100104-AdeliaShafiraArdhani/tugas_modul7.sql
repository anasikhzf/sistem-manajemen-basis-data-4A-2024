CREATE DATABASE rental;

USE rental;

CREATE TABLE mobil (
id_mobil VARCHAR(10) NOT NULL PRIMARY KEY,
platno VARCHAR(10) NOT NULL,
merk VARCHAR(20) NOT NULL,
jenis VARCHAR(20) NOT NULL,
harga_sewa_perhari INT(10) NOT NULL
);

CREATE TABLE pelanggan(
id_pelanggan VARCHAR(10) NOT NULL PRIMARY KEY,
alamat VARCHAR(50) NOT NULL,
nik VARCHAR(17) NOT NULL,
no_telepon VARCHAR(13) NOT NULL,
jenis_kelamin VARCHAR(1) NOT NULL
);

CREATE TABLE pinjaman(
id1 varchar(10) not null primary key,
id_mobil VARCHAR(10) NOT NULL,
id_pelanggan VARCHAR(10) NOT NULL,
tgl_pinjam date not null,
tgl_rencana_kembali date not null,
total_hari int(5) not null,
total_bayar int(10) not null,
tgl_kembali date NOT NULL,
denda int(10),
foreign key (id_mobil) references mobil (id_mobil),
FOREIGN KEY (id_pelanggan) REFERENCES pelanggan (id_pelanggan)
);

insert into mobil values
('mb001', 'W 1234 NBA', 'XPander', 'MPV', 900000),
('mb002', 'W 2345 NBA', 'Toyota Calya', 'MPV', 950000),
('mb003', 'W 3456 NBA', 'Hyundai Creta', 'SUV', 1000000),
('mb004', 'W 4567 NBA', 'Hyundai Palisade', 'SUV', 1200000),
('mb005', 'W 5678 NBA', 'Honda HRV', 'Crossover', 1500000),
('mb006', 'W 6789 NBA', 'Lexus RZ', 'Crossover', 1800000);

insert into pelanggan values
('plg001', 'sidoarjo', '1234567890987654', '089515820573', 'p'),
('plg002', 'surabaya', '1234567890987651', '089515820123', 'l'),
('plg003', 'lamongan', '1234567890987652', '089515820234', 'p'),
('plg004', 'gresik', '1234567890987653', '089515820456', 'l'),
('plg005', 'mojokerto', '1234567890987655', '089515820865', 'p'),
('plg006', 'sidoarjo', '1234567890987656', '089515820108', 'l');

-- 1. Pastikan tgl_rencana_kembali tidak lebih awal dari tgl_pinjam
DELIMITER //
CREATE PROCEDURE insert_pinjaman (
	in ID1 varchar(10),
	in idMobil VARCHAR(10),
	IN idPelanggan VARCHAR(10),
	IN tglPinjam DATE,
	IN tglRencana_kembali DATE,
	IN totalHari INT(5),
	IN totalBayar INT(10),
	IN tglKembali DATE,
	bayarDenda int(10)
)
BEGIN
    IF tglRencana_kembali < tglPinjam THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tanggal rencana kembali tidak boleh lebih awal dari tanggal pinjam';
    ELSE
        INSERT INTO pinjaman (id1, id_mobil, id_pelanggan, tgl_pinjam, tgl_rencana_kembali, total_hari, total_bayar, tgl_kembali,denda)
        VALUES (ID1, idMobil, idPelanggan, tglPinjam, tglRencana_kembali, totalHari, totalBayar, tglKembali, bayarDenda);
    END IF;
END //
DELIMITER ;

call insert_pinjaman('pj002', 'mb002', 'plg002', '2024-05-28', '2024-05-27', 1, 900000, '2024-05-29', 0);
drop trigger dikembalikan;
-- 2. Ketika mobil dikembalikan, tgl_kembali di isi, juga menghitung total_bayar dan denda (jika ada)
DELIMITER //
CREATE TRIGGER dikembalikan
BEFORE UPDATE ON pinjaman
FOR EACH ROW
BEGIN
    DECLARE total_hari INT;
    DECLARE sewa_perhari DECIMAL(10, 2);
    DECLARE overdue_days INT;
    DECLARE denda_perhari DECIMAL(10, 2);
    
	-- Pastikan bahwa ini adalah pembaruan pertama pada kolom TGL_KEMBALI
	IF NEW.tgl_kembali <> OLD.tgl_kembali OR new.tgl_kembali IS NOT NULL THEN
        -- Menghitung total hari sewa
        SET total_hari = DATEDIFF(NEW.tgl_kembali, NEW.tgl_pinjam);
        SET NEW.total_hari = total_hari;
        
        -- Mendapatkan harga sewa per hari
        SELECT harga_sewa_perhari INTO sewa_perhari FROM MOBIL WHERE id_mobil = NEW.id_mobil;
        
        -- Menghitung total bayar
        SET NEW.total_bayar = total_hari * sewa_perhari;
        
        -- Menghitung denda jika ada
        IF NEW.tgl_kembali > NEW.tgl_rencana_kembali THEN
            SET overdue_days = DATEDIFF(NEW.tgl_kembali, NEW.tgl_rencana_kembali);
            SET sewa_perhari = 0.1 * sewa_perhari; -- Denda 10% dari harga sewa per hari
            SET NEW.denda = overdue_days * sewa_perhari;
        ELSE
            SET NEW.denda = 0;
        END IF;
    END IF;
END//
DELIMITER ;

UPDATE pinjaman
SET tgl_kembali = '2024-06-31'
WHERE id1 = ('pj002');

SELECT * FROM pinjaman;

/*DELIMITER //
CREATE TRIGGER hitungDenda_dan_totalBayar
BEFORE UPDATE ON pinjaman
FOR EACH ROW
BEGIN
	DECLARE hari_telat INT(3);
	DECLARE tgl_rencana_kembali DATE;
	DECLARE sewa DECIMAL(10,2);
	dECLARE denda_per_hari DECIMAL(10,2);

	SELECT harga_sewa_perhari FROM mobil JOIN pinjaman
	USING(id_mobil) WHERE id1 = NEW.id1 INTO sewa;
	
	SET denda_per_hari = sewa * 0.5;

	SET tgl_rencana_kembali = OLD.tgl_rencana_kembali;

	SET hari_telat = DATEDIFF(NEW.tgl_kembali, tgl_rencana_kembali);
	
	IF hari_telat > 0 THEN
	SET NEW.denda = hari_telat * denda_per_hari;
	SET NEW.total_bayar = (sewa * OLD.total_hari) + NEW.denda;
	ELSE
	SET NEW.denda = 0;
	SET NEW.total_bayar = sewa * OLD.total_hari;
	END IF;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE mobil_kembali (IN id_pinjaman VARCHAR(10))
BEGIN
	UPDATE pinjaman
	SET tgl_kembali = CURDATE()
	WHERE id1 = id_pinjaman;
END //
DELIMITER;

CALL mobil_kembali('pj001');*/

drop procedure mobil_kembali;
-- 3. Ketika insert data ke tabel pelanggan, pastikan panjang NIK sesuai dengan aturan yang berlaku
DELIMITER //
CREATE TRIGGER panjangNik
BEFORE INSERT ON pelanggan
FOR EACH ROW
BEGIN
    IF LENGTH(NEW.nik) != 16 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'NIK harus terdiri dari 16 karakter';
    END IF;
END //
DELIMITER ;

insert into pelanggan values('plg008', 'krian', '1234567890987651224', '098122439', 'l');
-- 4. Ketika insert data ke tabel mobil, pastikan di kolom platno, 1/2 karakter awal harus huruf
DELIMITER//
CREATE TRIGGER cekPlat
BEFORE INSERT ON mobil
FOR EACH ROW
BEGIN
    DECLARE platSalah BOOLEAN;

    -- Cek apakah 1 atau 2 karakter pertama adalah huruf
    SET platSalah = NOT (LEFT(NEW.platno, 1) REGEXP '^[A-Za-z]$' AND
                             (CHAR_LENGTH(NEW.platno) = 1 OR 
                              LEFT(NEW.platno, 2) REGEXP '^[A-Za-z]{2}$'));

    -- Jika tidak valid, berikan pesan kesalahan
    IF platSalah THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Kolom platno harus memiliki 1 atau 2 karakter awal yang berupa huruf';
    END IF;
END//
DELIMITER ;

insert into mobil values ('mb007', '0987 NBA', 'HR-V Prestige', 'SUV', 1200000);