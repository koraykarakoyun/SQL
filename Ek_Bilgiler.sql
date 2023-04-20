use Northwind

--@@Identity degiskeni,bir veritaban� nesnesidir.En son yap�lan i�leme g�re veritaban� �zerindeki tablolarda,son i�lemdeki tabloda bulunan 'son primary key' de�erinin verir.
insert into Personeller(Adi,SoyAdi) values('Ad','Soyad')
select @@identity as BulunanSonPKDegeri

--@@Rowcount degiskeni,bir tablo �zerinde yap�lan islemden etkilenen 'sat�r say�s�n�' buludurur.
insert into Personeller(Adi,SoyAdi) values('Ad2','Soyad2')
select @@ROWCOUNT as EtkilenenSatirSayisi

select * from Personeller
select @@ROWCOUNT as EtkilenenSatirSayisi

--IDENT-CURRENT, fonksiyonu tablo ad�n� parametre alarak tabloda bulunan 'son primary key' de�erinin verir.
select IDENT_CURRENT('Personeller') as PersonellerTablosundakiSonPK

--DBCC checkident fonksiyonu ile herhangi bir tablodaki Identity de�erine m�dahale edilebilir.
DBCC checkident(Personeller,reseed,40)--Personeller tablosundaki idenetity de�eri 41'den devam edecektir.
insert into Personeller(Adi,SoyAdi) values('Ad3','Soyad3')
select * from Personeller

--Isnull fonksiyonu ile null deger kontrol� ve gecici deger atama islemi
select Adi, Isnull(Sehir,'SehirBilgisiYok') from Personeller