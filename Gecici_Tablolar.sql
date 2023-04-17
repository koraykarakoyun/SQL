use VeriBilimi

--Fiziksel Tablo Kopyalama
--select * from Personeller
select * into PersonellerKopya from Personeller
select * from PersonellerKopya

--Bellekte Geçici Tablo Kopyalama
-- # operatörü kullanýlýr.
--Bellekte geçici olarak kopyalanýr sunucu ile baðlantý kesildiðinde bellekten silinir.
select * into #PersonellerGecici from Personeller
select * from #PersonellerGecici

--Bellekte Geçici Tablo Kopyalama
-- ## operatörü kullanýlýr.
--Bellekte geçici olarak kopyalanýr sunucu ile baðlantý kesildiðinde bellekten silinir.
--Tabloyu oluþturan kiþinin sunucusuna dýþardan eriþen kiþiler de kullanabilir
select * into ##PersonellerGecici from Personeller
select * from ##PersonellerGecici


--Uniqueidentifier veri tipi

create table Uniqueidentifier_Tablosu(
id smallint identity(1,1),
ad char(5),
soyad char(5),
uniqeidentifier_kolon uniqueidentifier
)

select * from Uniqueidentifier_Tablosu

insert into Uniqueidentifier_Tablosu values('C','D',NEWID())