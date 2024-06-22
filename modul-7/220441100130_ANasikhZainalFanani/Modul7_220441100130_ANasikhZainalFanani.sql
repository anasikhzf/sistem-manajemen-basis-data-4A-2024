CREATE DATABASE rental_mobil;

USE rental_mobil;

CREATE TABLE mobil (
  id_mobil INT PRIMARY KEY AUTO_INCREMENT,
  platno VARCHAR(10) NOT NULL,
  merk VARCHAR(255) NOT NULL,
  jenis VARCHAR(255) NOT NULL,
  harga_sewa_perhari INT NOT NULL
);

CREATE TABLE pelanggan (
  id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
  nama VARCHAR(255) NOT NULL,
  alamat VARCHAR(255) NOT NULL,
  nik CHAR(16) NOT NULL,
  no_telepon VARCHAR(255) NOT NULL,
  jenis_kelamin CHAR(1) NOT NULL
);

CREATE TABLE peminjaman (
  id_peminjaman INT PRIMARY KEY AUTO_INCREMENT,
  id_mobil INT NOT NULL,
  id_pelanggan INT NOT NULL,
  tgl_pinjam DATETIME NOT NULL,
  tgl_rencana_kembali DATETIME NOT NULL,
  tgl_kembali DATETIME DEFAULT NULL,
  total_hari INT,
  total_bayar INT,
  denda INT,
  FOREIGN KEY (id_mobil) REFERENCES mobil(id_mobil),
  FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
);

INSERT INTO mobil (platno, merk, jenis, harga_sewa_perhari)
VALUES
  ('AB-1234', 'Toyota', 'Avanza', 250000),
  ('CD-5678', 'Honda', 'Mobilio', 200000),
  ('EF-9012', 'Suzuki', 'Ertiga', 180000),
  ('GH-3456', 'Mitsubishi', 'Xpander', 220000),
  ('IJ-7890', 'Daihatsu', 'Sigra', 150000);
INSERT INTO pelanggan (nama, alamat, nik, no_telepon, jenis_kelamin)
VALUES
  ('Budi Santoso', 'Jl. Melati No. 10', '1234567890123456', '08123456789', 'M'),
  ('Anita Dewi', 'Jl. Mawar No. 20', '9876543210987654', '08234567890', 'F'),
  ('Chandra Setiawan', 'Jl. Tulip No. 30', '5678901234567890', '08345678901', 'M'),
  ('Maya Sari', 'Jl. Anggrek No. 40', '3456789012345678', '08456789012', 'F'),
  ('Dimas Pratama', 'Jl. Dahlia No. 50', '1098765432109876', '08567890123', 'M');
INSERT INTO peminjaman (id_mobil, id_pelanggan, tgl_pinjam, tgl_rencana_kembali)
VALUES
  (1, 1, '2024-06-01', '2024-06-05'),
  (2, 2, '2024-06-02', '2024-06-06'),
  (3, 3, '2024-06-03', '2024-06-07'),
  (4, 4, '2024-06-04', '2024-06-08'),
  (5, 5, '2024-06-05', '2024-06-09');

-- Trigger untuk memastikan tgl_rencana_kembali tidak lebih awal dari tgl_pinjam
DELIMITER //
CREATE TRIGGER cek_tgl_rencana_kembali
BEFORE INSERT ON peminjaman
FOR EACH ROW
BEGIN
  IF NEW.tgl_rencana_kembali <= NEW.tgl_pinjam THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tanggal rencana kembali tidak boleh lebih awal dari tanggal pinjam';
  END IF;
END;
//
DELIMITER ;

-- Trigger untuk menghitung total_bayar dan denda ketika mobil dikembalikan
DELIMITER //
CREATE TRIGGER hitung_total_bayar_dan_denda
BEFORE UPDATE ON peminjaman
FOR EACH ROW
BEGIN
  IF NEW.tgl_kembali IS NOT NULL AND OLD.tgl_kembali IS NULL THEN
    DECLARE harga_sewa INT;
    DECLARE hari_telat INT;
    
    -- Mengambil harga sewa per hari mobil
    SELECT harga_sewa_perhari INTO harga_sewa FROM mobil WHERE id_mobil = NEW.id_mobil;

    -- Menghitung total hari pinjam
    SET NEW.total_hari = DATEDIFF(NEW.tgl_kembali, NEW.tgl_pinjam);

    -- Menghitung total bayar
    SET NEW.total_bayar = NEW.total_hari * harga_sewa;

    -- Menghitung denda jika ada keterlambatan
    SET hari_telat = DATEDIFF(NEW.tgl_kembali, NEW.tgl_rencana_kembali);
    IF hari_telat > 0 THEN
      SET NEW.denda = hari_telat * harga_sewa;
    ELSE
      SET NEW.denda = 0;
    END IF;
  END IF;
END;
//
DELIMITER ;

-- Trigger untuk memastikan panjang NIK sesuai aturan
DELIMITER //
CREATE TRIGGER cek_panjang_nik
BEFORE INSERT ON pelanggan
FOR EACH ROW
BEGIN
  IF CHAR_LENGTH(NEW.nik) <> 16 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Panjang NIK harus 16 karakter';
  END IF;
END;
//
DELIMITER ;

-- Trigger untuk memastikan 1/2 karakter awal platno adalah huruf
DELIMITER //
CREATE TRIGGER cek_karakter_awal_platno
BEFORE INSERT ON mobil
FOR EACH ROW
BEGIN
  IF NOT (LEFT(NEW.platno, 1) REGEXP '[A-Z]') OR NOT (LEFT(NEW.platno, 2) REGEXP '[A-Z]{2}') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Karakter awal pada platno harus huruf';
  END IF;
END;
//
DELIMITER ;

-- Contoh Berhasil
UPDATE peminjaman SET tgl_kembali = '2024-06-06 10:00:00' WHERE id_peminjaman = 1; -- Mengupdate tgl_kembali setelah tgl_rencana_kembali
-- Tidak ada kondisi gagal untuk trigger ini, trigger hanya mengupdate field terkait

-- Contoh Berhasil
INSERT INTO pelanggan (nama, alamat, nik, no_telepon, jenis_kelamin)
VALUES ('Test User', 'Jl. Test No. 1', '1234567890123456', '08123456789', 'M'); -- NIK dengan panjang 16 karakter
-- Contoh Gagal
INSERT INTO pelanggan (nama, alamat, nik, no_telepon, jenis_kelamin)
VALUES ('Test User', 'Jl. Test No. 1', '12345678901234', '08123456789', 'M'); -- NIK dengan panjang tidak 16 karakter

-- Contoh Berhasil
INSERT INTO mobil (platno, merk, jenis, harga_sewa_perhari)
VALUES ('XY-1234', 'Toyota', 'Fortuner', 300000); -- Dua karakter awal platno adalah huruf
-- Contoh Gagal
INSERT INTO mobil (platno, merk, jenis, harga_sewa_perhari)
VALUES ('12-XY34', 'Toyota', 'Fortuner', 300000); -- Dua karakter awal platno bukan huruf
