use Northwind

--Dynamic Data Masking,verilere kullan�c�lar�n yetkisiz eri�mesini engellemek i�in yetkisiz kullan�c�lara kar�� veriyi maskeleyerek g�sterir.
--Prototipi 'MASKED WITH (FUNCT�ON='...')' �eklindedir.�lgili kolon i�in bu �ekilde tan�mlamak gerekir.

--3 farkl� parametre al�r.
--default() parametre,veri tipine g�re veriyi varsay�lan tan�ml� �ekilde maskeler.
--email() parametre,veriyi email tipine g�re maskeler.
--partial() parametre,veriyi �zelle�tirilmi� �ekilde maskeler.
--partial(2,'XXX',2) tipindeki parametre verinin ilk 2 ve son 2 karakterini g�sterir geri kalan karakterleri 'XXX' �eklinde g�sterir.

create table MaskeTablo (
id smallint identity(1,1) primary key,
ad varchar(20) MASKED WITH(Function='default()'),
soyad varchar(20) MASKED WITH(Function='default()'),
email varchar(30) MASKED WITH(function='email()'),
tcno char(11) MASKED WITH(Function='default()'),
adresbilgisi varchar(100) MASKED WITH(Function='partial(1,"X",3)'),
hakk�nda varchar(100) MASKED WITH(Function='partial(3,"X",2)')
)

select * from MaskeTablo

insert into MaskeTablo values
('a','b','c@hotmail.com','11111111111','aaaaaaaaaaaaaaaaaa','bbbbbbbbbbbbbbbbbb'),
('c','d','e@hotmail.com','22222222222','fffffffffffffffffff','ggggggggggggggggggg')

--Tablodaki kolonun maskeleme �zelli�ini de�i�tirme
alter table MaskeTablo alter column id ADD MASKED WITH(Function='default()')

--Tablodaki kolonun maskeleme �zelli�ini silme
alter table MaskeTablo alter column id DROP MASKED

--Kullaniciya kar�� veriyi maskeleme izni.
--Grant:onayla,Deny:reddet
Grant Unmask TO yetkisiz_kullanici
Deny Unmask TO yetkisiz_kullanici