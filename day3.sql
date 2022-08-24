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

--FOREIGN KEY--
CREATE table adresler( 	
adres_id char(5), 
sokak varchar(20), 
cadde varchar(30),
sehir varchar(20),
CONSTRAINT id_fk Foreign key (adres_id) references  calisanlar(id)
);

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

select * from adresler;

INSERT INTO adresler VALUES('100012','Ağa Sok', '30.Cad.','Antep');

--Parent tablo da olmayan id ile child tabloyaq ekleme yapamayiz


INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');

--Calisanlar id  ile adresler tablosundaki adres_id ile eslesenlere bakmak icin

select * from calisanlar, adresler where calisanlar.id =adresler.adres_id;

Drop table calisanlar

--hat verdi Parent tabloyu yani primary key olan tabloyu silmek istedigimizde silmez
--once child tabloyu silmemiz gerekir

delete from calisanlar where id='10002' --Parent

delete from adresler where adres_id='10002'; --Child

drop table calisanlar;

--ON DELETE CASCADE--
-- Her defasinda once child tablodaki verileri silmek yerine ON DELETE CASCADE silme ozelligini aktif hale getirebiliriz
-- bunun icin fk olan satirin en sonuna ON DELETE CASCADE komutunu yazmamiz yeterli

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from talebeler
select * from notlar

delete  from notlar where talebe_id='123'
delete from talebeler where id='126' --  on delete cascade kullandigimiz icin parent tabnle dan direk silebildik

--parent table dan sildigimiz icin child  table dan da silinmis oldu

delete from talebeler

drop table  talebeler cascade; --Parent tabloyu kaldirmak istersek Drop table tablo_adi ndan sonra CASCADE komutunu kullaniriz

--talebeler tablosundaki isim tablosuna NOT NULL kisitlamsi ekleyiniz ve veri tipini VARCHAR(30) olarak degistiriniz

alter table talebeler
alter column isim TYPE VARCHAR(30),
alter column isim SET not NULL;

--talebeler tablosundaki yazili_notu sutununa 60 dan buyuk rakam girilebilsin
alter table talebeler
ADD CONSTRAINT sinir check (yazili_notu>60);



INSERT INTO talebeler VALUES(128, 'Mustafa Bak', 'HASAN',45);
delete from talebeler where id='128' --Parent

create table ogrenciler3(
id int,
isim varchar(45),
adres varchar(100),
sinav_notu int
);


Create table ogrenci_adres
AS
SELECT id, adres from ogrenciler3;

select * from ogrenciler3 
select * from ogrenci_adres

-- tabnlodaki bir sutuna primary key ekleme

alter table ogrenciler3
add primary key (id);

--Primary key olusturma 2. yol

alter table ogrenciler3
add constraint pk_id primary key (id);

----pk den sonra fk atamasi

alter table ogrenci_adres
add foreign key(id) references ogrenciler3;


-- child tabloyu parent tablodan olusturdugumuz icin sutun adi verilmedi

--pk yi silme CONSTRAINT SILME
alter table ogrenciler3 DROP CONSTRAINT ogrenciler3_pkey; 

--FK yi silme constarint silme
alter table ogrenci_adres DROP CONSTRAINT ogrenci_adres_id_fkey;

--yazili notu 85 den buyuk talebe bilgilerini getirin

Select * from talebeler where yazili_notu>85;

-- ismi Mustafa Bak olan talebenin tüm bilgilerini getitrin

select * from talebeler where isim='Mustafa Bak'

--Select komutunda -- BETWEEN kosulu
-- between belirttiginizn 2 veri arasindaki bilgileri listeler
-- between de belirttigimiz degerlerde listelemeye dahildir

create table personel
(
id char(4),
isim varchar(50),
maas int
);

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);

/*
    AND (ve): Belirtilen şartların her ikiside gerçekleşiyorsa o kayıt listelenir
Bir tanesi gerçekleşmezse listelemez
    Select * from matematik sinav1 > 50 AND sınav2 > 50
Hem sınav1 hemde sınav2 alanı, 50'den büyük olan kayıtları listeler
    OR (VEYA): Belirtilen şartlardan biri gerçekleşirse, kayıt listelenir
    select * From matematik sınav>50 OR sınav2>50 
Hem sınav1 veya sınav2 alanı, 50 den büyük olan kayıtları listeler    
*/

select * from personel

--id'si 1003 ile 1005 arasında olan personel bilgisini listeleyiniz

select *from personel where id between '1003' and '1005';

-- 2. yolu
select * from personel where id>='1003' and id<='1005';

-- Derya Soylu ile Yavuz Bal arasindaki personel bilgisini listeleyiniz

select * from personel where isim between 'Derya Soylu' and 'Yavuz Bal'

--maasi 70000 ve ismi sena olan personeli listele

select * from personel where maas=70000 or isim='Sena Beyaz';

--IN : Birden fazla mantıksal ifade ile tanımlayabileceğimiz durumları tek komutta yazabilme imkanı verir
--Farklı sütunlar için IN kullanılamaz

--id'si 1001,1002 ve 1004 olan personelin bilgilerini listele

select * from personel where id = '1001' or id='1002' or id='1004';
-- 2. yol 

select * from personel where id in ('1001','1002','1004');

--maasi sadece 70000, 100000 olan personeli listele
select * from personel where maas in ('70000','100000');

/*
SELECT - LIKE koşulu
LIKE : Sorgulama yaparken belirli kalıp ifadeleri kullanabilmemizi sağlar
ILIKE : Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir
LIKE : ~~
ILIKE : ~~*
NOT LIKE : !~~
NOT ILIKE :!~~*
% --> 0 veya daha fazla karakteri belirtir.
_ --> Tek bir karakteri belirtir
*/

-- Ismi A harfi ile baslayan personeli listele
select * from personel WHERE isim like 'A%';
-- Ismi t harfi ile biten personeli listele
select * from personel WHERE isim like '%t';

-- Isminin 2. harfi e olan personeli listeleyiniz
select * from personel WHERE isim like '_e%'
