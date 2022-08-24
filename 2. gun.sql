--Personel isminde bir tablo oluşturalım
create table personel(
pers_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)
);
--Varolan personel tablosundan pers_id,sehir,adres fieldlarına sahip personel_adres adında yeni tablo olusturalım
create table personel_adres
as
select pers_id, sehir, adres from personel;

--Personel isminde bir tablo oluşturalım
create table personel(
pers_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)
);
--Varolan personel tablosundan pers_id,sehir,adres fieldlarına sahip personel_adres adında yeni tablo olusturalım
create table personel_adres
as
select pers_id, sehir, adres from personel;
select * from personel

-- DML --> Data Manupulation Lang.
-- INSERT - UPDATE - DELETE
--Tabloya veri ekleme, tablodan veri güncelleme ve silme işlemlerinde kullanılan komutlar
--INSERT
create table student
(
id varchar(4),
st_name varchar(30),
age int
);
INSERT into student VALUES ('1001','Ali Can',25);
INSERT into student VALUES ('1002','Veli Can',35);
INSERT into student VALUES ('1003','Ayse Can',45);
INSERT into student VALUES ('1004','Derya Can',55);

--Tabloya parçalı veri ekleme
insert into student(st_name,age) values ('Murat Can',65);

--DQL --> Data Query Lang.
--SELECT
select * from student;
select st_name from student;
--SELECT KOMUTU WHERE KOŞULU
select * from student WHERE age>35;

-- TCL TRANSECTION CONTROL LANG:

--Begin- Savepoint- rolback --commit
--Transaction veritabani sistemlerinde bir islem basladiginda baslar ve islem bitince sona erer
-- bu islemleer veri tabani olusturma silme güncelleme ve geri getirme gibi islemler olabilir

CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);
Begin;
insert into ogrenciler2 values (default, 'Ali Can','Hasan Can',75.5);
insert into ogrenciler2 values (default, 'Canan Gul','Mehmet Can',90.5);
savepoint x;
insert into ogrenciler2 values (default, 'Kemal Tul','Selim Tun',70.5);
insert into ogrenciler2 values (default, 'Huseyin Yel','Mehmet zan',50.5);


ROLLBACK TO x;


SELECT * from ogrenciler2;

commit;

--Transaction kullanımında SERIAL data türü kullanımı tavsiye edilmez.
--savepointten sonra eklediğimiz veride sayaç mantığı ile çalıştığı için
--sayacta en son hangi sayıda kaldıysa ordan devam eder
-- NOT : PostgreSQL de transaction kullanımı için 'Begin' komutuyla başlarız sonrasında tekrar yanlış bir veriyi
-- düzeltmek veya bizim için önemli olan verilerden sonra ekleme yapabilmek için 'SAVEPOINT savepointadi'
-- kullanırız ve bu savepointe dönebilmek için 'ROLLBACK TO savepointismi'
-- komutunu kullanırız ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki verileri tabloda bize
-- verir ve son olarak Transaction'ı sonlandırmak için mutlaka 'COMMIT' komutu kullanırız. MySQL de
-- transaction olmadanda kullanılır

-- DML - DELETE - 
--DELETE FROM tablo_adi --> tablo nun tüm icerigini siler 
--Veriyi secerek silmek icin WHERE kosulu kullanilir
-- DELETE FROM tablo_adi WHERE sutun_adi =veri--> tablo daki istedigimiz veriyi siler

CREATE TABLE ogrenciler
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Ali', 99);

select * from ogrenciler;

-- Soru : id'si 124 olan öğrenciyi siliniz

DELETE FROM ogrenciler WHERE id =124;

-- soru : ismi Kemal Yasa olan satiri siliniz

DELETE FROM ogrenciler where isim='Kemal Yasa';

--Soru: ismi Nesibe Yilmaz veya Mustafa Bak olan kayitlari silelim

Delete from ogrenciler where isim ='Nesibe Yilmaz'
or isim='Mustafa Bak';

-- Soru : ismi Ali Can ve id si 123 olan kaydi siliniz

DELETE FROM ogrenciler where isim='Ali Can' or id=123;

--tablodaki butun verileri sileleim


DeLETE from ogrenciler

--DELETE - TRUNCATE--

--TRUNCATE komutu DELET komutu gibi bir tablodaki verilerin tamamini siler 
-- ancak secmeli silme yapamaz

SELECT * from ogrenciler;
TRUNCATE TABLE ogrenciler

--DDL Data Definition Lang.

--CREATE - ALTER -- DROP
-- ALTER TABLE --
-- ALTER TABLE tabloda ADD, TYPE, RENAME veya DROP COLUMNS islemleri icin kullanilir

--Persone tablosuna cinsiyet Varchar(20) ve yas int seklinde yeni sutunlar ekleyin

--Personel isminde bir tablo oluşturalım
create table personel(
pers_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)
);
select * from isciler; 
 
alter table personel add cinsiyet Varchar(20), add yas int;

--Personel tablosundan sirket field ini siliniz

alter table personel drop column sirket;

--Personel tablosundaki sehir sutununun adini ulke olarak degistirelim

alter table personel rename column sehir to ulke;

--Personel tablosunun adini isciler olarak degistiriniz

alter table personel rename to isciler;

--DDL - DROP komutu

drop table isciler;

-- CONSTRANINT -- Kısıtlamalar
-- Primary Key --> Bir sutunun NULL içermemesini ve sutundaki verilerin BENZERSİZ olmasını sağlar (NOT NULL - UNIQUE)
-- FOREGIN KEY --> Başka bir tablodaki PRİMARY KEY'i referans göstermek için kullanılır. Böylelikle, tablolar arasında ilişki kurmuş oluruz.
-- UNIQUE --> Bir sutundaki tüm değerlerin BENZERSİZ yani tek olmasını sağlar
-- NOT NULL --> Bir sutunun NULL içermemesini yani boş olmamasını sağlar
-- NOT NULL kısıtlaması için CONSTRAINT ismi tanımlanmaz. Bu kısıtlama veri türünden hemen sonra yerleştirilir
-- CHECK --> Bir sutuna yerleştirilebilecek değer aralığını sınırlamak için kullanılır.

CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,
maas int NOT NULL,
ise_baslama DATE
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); --Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');--UNIQUE
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');--NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');--PRIMARY KEY
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');--PRIMARY KEY
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');--PRIMARY KEY

SELECT * FROM calisanlar;

create table calisanlar2(	
id CHAR(5), 
isim VARCHAR(50), 
maas int NOT NULL,	
ise_baslama DATE, 
CONSTRAINT pk_id PRIMARY KEY(id), 
CONSTRAINT isim_unq UNIQUE(isim)	
	
);




