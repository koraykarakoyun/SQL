use Northwind

--Aggregate fonksiyonlar�,belirli bir tablodaki kolonlar� parametre alarak ilgili fonksiyonel i�lemlerin yap�lmas�n� yapar.

--Temel aggregate fonksiyonlar�, MIN(),MAX(),AVG(),COUNT(),SUM() fonksiyonlar�d�r.

--MIN(),fonksiyonu tablonun ilgili kolondaki en k���k degeri verir.
--MAX(),fonksiyonu tablonun ilgili kolondaki en b�y�k degeri verir.
--AVG(),fonksiyonu tablonun ilgili kolondaki ortalama degeri verir.
--COUNT(),fonksiyonu tablonun ilgili kolonundaki sat�r say�s�n� verir.
--SUM(),fonksiyonu tablonun ilgili kolonundaki de�erlerin toplam�n� verir.

select * from Satislar
select MIN(NakliyeUcreti) as EnDusukNakliyeUcreti from Satislar
select MAX(NakliyeUcreti) as EnYuksekNakliyeUcreti from Satislar
select AVG(NakliyeUcreti) as OrtalamaNakliyeUcreti from Satislar
select SUM(NakliyeUcreti) as ToplamNakliyeUcreti from Satislar
select COUNT(*) as TablodakiToplamSatirSayisi from Satislar
select COUNT(SatisID) as KolondakiToplamSatirSayisi from Satislar 

--GroupBy komutu ilgili tablodaki belirli bir kolondaki ayn� de�erleri gruplamak i�in kullan�l�r.
--Tablodaki 'herhangi bir kolon ve aggregate fonksiyonu' birlikte �a��r�ld���nda group by i�lemi yapmak gerekir.

--Hangi personelin ka� addet sat�� yapt���n� g�steren sorgu
select PersonelID,COUNT(PersonelID) as PersonelinSatisSayisi from Satislar group by PersonelID

--Bir kategoride ka� adet �r�n oldu�unu g�steren sorgu
select Kategoriler.KategoriAdi,COUNT(KategoriAdi) as KategoridedekiUrunSayisi from Urunler inner join Kategoriler on Urunler.KategoriID=Kategoriler.KategoriID group by KategoriAdi

--ID'si 3'ten b�y�k olan personellerin ka� adet sat�� yapt���n� g�steren sorgu
select PersonelID,COUNT(PersonelID) as PersonelinSatisSayisi from Satislar where PersonelID>3 group by PersonelID

--Having,aggregate fonksiyonlar� �zerinde filtreleme yapmak i�in kullan�l�r ve group by i�leminden sonra yap�l�r

--50'den fazla sat�� yapan personellerin ka� adet sat�� yapt���n� g�steren sorgu
select  Personeller.Adi,COUNT(Personeller.Adi) as PersonelinSatisSayisi from Satislar inner join Personeller on Satislar.PersonelID=Personeller.PersonelID  group by Personeller.Adi having COUNT(Personeller.Adi)>50 