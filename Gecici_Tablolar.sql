use VeriBilimi

--Fiziksel Tablo Kopyalama
--select * from Personeller
select * into PersonellerKopya from Personeller
select * from PersonellerKopya

--Bellekte Ge�ici Tablo Kopyalama
-- # operat�r� kullan�l�r.
--Bellekte ge�ici olarak kopyalan�r sunucu ile ba�lant� kesildi�inde bellekten silinir.
select * into #PersonellerGecici from Personeller
select * from #PersonellerGecici

--Bellekte Ge�ici Tablo Kopyalama
-- ## operat�r� kullan�l�r.
--Bellekte ge�ici olarak kopyalan�r sunucu ile ba�lant� kesildi�inde bellekten silinir.
--Tabloyu olu�turan ki�inin sunucusuna d��ardan eri�en ki�iler de kullanabilir
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