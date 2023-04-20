use Northwind

--@@Identity degiskeni,bir veritabaný nesnesidir.En son yapýlan iþleme göre veritabaný üzerindeki tablolarda,son iþlemdeki tabloda bulunan 'son primary key' deðerinin verir.
insert into Personeller(Adi,SoyAdi) values('Ad','Soyad')
select @@identity as BulunanSonPKDegeri

--@@Rowcount degiskeni,bir tablo üzerinde yapýlan islemden etkilenen 'satýr sayýsýný' buludurur.
insert into Personeller(Adi,SoyAdi) values('Ad2','Soyad2')
select @@ROWCOUNT as EtkilenenSatirSayisi

select * from Personeller
select @@ROWCOUNT as EtkilenenSatirSayisi

--IDENT-CURRENT, fonksiyonu tablo adýný parametre alarak tabloda bulunan 'son primary key' deðerinin verir.
select IDENT_CURRENT('Personeller') as PersonellerTablosundakiSonPK

--DBCC checkident fonksiyonu ile herhangi bir tablodaki Identity deðerine müdahale edilebilir.
DBCC checkident(Personeller,reseed,40)--Personeller tablosundaki idenetity deðeri 41'den devam edecektir.
insert into Personeller(Adi,SoyAdi) values('Ad3','Soyad3')
select * from Personeller

--Isnull fonksiyonu ile null deger kontrolü ve gecici deger atama islemi
select Adi, Isnull(Sehir,'SehirBilgisiYok') from Personeller