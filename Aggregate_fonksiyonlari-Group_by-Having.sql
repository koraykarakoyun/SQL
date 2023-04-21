use Northwind

--Aggregate fonksiyonlarý,belirli bir tablodaki kolonlarý parametre alarak ilgili fonksiyonel iþlemlerin yapýlmasýný yapar.

--Temel aggregate fonksiyonlarý, MIN(),MAX(),AVG(),COUNT(),SUM() fonksiyonlarýdýr.

--MIN(),fonksiyonu tablonun ilgili kolondaki en küçük degeri verir.
--MAX(),fonksiyonu tablonun ilgili kolondaki en büyük degeri verir.
--AVG(),fonksiyonu tablonun ilgili kolondaki ortalama degeri verir.
--COUNT(),fonksiyonu tablonun ilgili kolonundaki satýr sayýsýný verir.
--SUM(),fonksiyonu tablonun ilgili kolonundaki deðerlerin toplamýný verir.

select * from Satislar
select MIN(NakliyeUcreti) as EnDusukNakliyeUcreti from Satislar
select MAX(NakliyeUcreti) as EnYuksekNakliyeUcreti from Satislar
select AVG(NakliyeUcreti) as OrtalamaNakliyeUcreti from Satislar
select SUM(NakliyeUcreti) as ToplamNakliyeUcreti from Satislar
select COUNT(*) as TablodakiToplamSatirSayisi from Satislar
select COUNT(SatisID) as KolondakiToplamSatirSayisi from Satislar 

--GroupBy komutu ilgili tablodaki belirli bir kolondaki ayný deðerleri gruplamak için kullanýlýr.
--Tablodaki 'herhangi bir kolon ve aggregate fonksiyonu' birlikte çaðýrýldýðýnda group by iþlemi yapmak gerekir.

--Hangi personelin kaç addet satýþ yaptýðýný gösteren sorgu
select PersonelID,COUNT(PersonelID) as PersonelinSatisSayisi from Satislar group by PersonelID

--Bir kategoride kaç adet ürün olduðunu gösteren sorgu
select Kategoriler.KategoriAdi,COUNT(KategoriAdi) as KategoridedekiUrunSayisi from Urunler inner join Kategoriler on Urunler.KategoriID=Kategoriler.KategoriID group by KategoriAdi

--ID'si 3'ten büyük olan personellerin kaç adet satýþ yaptýðýný gösteren sorgu
select PersonelID,COUNT(PersonelID) as PersonelinSatisSayisi from Satislar where PersonelID>3 group by PersonelID

--Having,aggregate fonksiyonlarý üzerinde filtreleme yapmak için kullanýlýr ve group by iþleminden sonra yapýlýr

--50'den fazla satýþ yapan personellerin kaç adet satýþ yaptýðýný gösteren sorgu
select  Personeller.Adi,COUNT(Personeller.Adi) as PersonelinSatisSayisi from Satislar inner join Personeller on Satislar.PersonelID=Personeller.PersonelID  group by Personeller.Adi having COUNT(Personeller.Adi)>50 