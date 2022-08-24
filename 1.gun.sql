/*
DDL - DATA DEFINITION LANG.DATA
CREATE - ALTER - DROP

*/
-- CREATE - TABLO OLUSTURMA

create table ogrenci (
	
ogr_no int,
ogr_isim VARCHAR(30),					 
notlar REAL,
yas INT,
adres VARCHAR (50),
kayit_tarih DATE				 
); 
--VAR OLAN TABLODAN YENI BIR TABLO OLUSTURMA
CREATE table ogr_notlari
AS 
SELECT ogr_no, notlar FROM ogrenci;


SELECT * FROM ogrenci;

SELECT *from ogr_notlari;---