use VeriBilimi

--Scalar fonksiyonlar,geriye belirli bir tipte de�er d�nen fonksiyonlard�r.
--Scalar fonksiyon olu�turma.
create function Topla(@sayi1 int,@sayi2 int) returns int
as
begin
	return @sayi1+@sayi2
end
--Scalar fonksiyon kullan�m�
select dbo.Topla(6,5)

--Scalar fonksiyon �rnek
create function Yazdir(@isim varchar(20),@sayi1 int) returns varchar(50)
as
begin
	declare @sayi2 varchar(5)=@sayi1+5;
	return ('hosgeldiniz '+@isim+' sayiniz: '+@sayi2)
end

print(dbo.Yazdir('koray',4));
--Not:Scalar fonksiyonlar �a��r�l�ken dbo ile birlikte �a��r�lmal�d�r.


--Inline fonksiyonlar,geriye bir tablo d�nen fonksiyonlard�r.

create function inline_func(@ad varchar(15),@soyad varchar(15)) returns table
as
	return select * from dbo.Personeller where Ad=@ad and Soyad=@soyad

select * from dbo.inline_func('koray','karakoyun');

--with encryption komutu ile fonksiyon �ifrelenerek olu�turulabilir.
--Not:Inline fonksiyonlarda begin end komutlar� kullan�lmaz.

create function yas_ara(@yas int) returns table
with encryption
as
	return select * from dbo.Personeller where Yas=@yas

select * from dbo.yas_ara(22);


--Computed Columns,hesaplanabilir kolonlar fonksiyonlar yard�m�yla veriler ile hesaplama i�lemi yap�lan kolonlard�r.

use Northwind;

create function SatisRaporu(@kategori varchar(20),@urun varchar(20),@birimfiyat int,@stok int) returns varchar(100)
as
begin

	declare @toplam varchar(100) =@kategori+' kategorisindeki '+@urun+' urunun toplam fiyat�: '+CAST(@birimfiyat*@stok as nvarchar(50))+' tldir.'
	return @toplam;
end

select Urunler.UrunAdi ,dbo.SatisRaporu(Kategoriler.KategoriAdi,Urunler.UrunAdi,Urunler.BirimFiyati,Urunler.HedefStokDuzeyi) ToplamFiyat from Urunler inner join Kategoriler on Urunler.KategoriID=Kategoriler.KategoriID


--Toplam satis yapan kisilerin satis sayilar� ornegi

use Northwind

create function SatisSayisi(@personel_adi varchar(30),@satis_sayisi int) returns varchar(60)
as
begin

declare @sonuc varchar(60)=@personel_adi+' personeli '+CAST(@satis_sayisi as varchar(40))+' adet satis yapmistir.'
return @sonuc;

end

select dbo.SatisSayisi(Satislar.PersonelID,Count(Satislar.PersonelID)) from Personeller inner join Satislar on Personeller.PersonelID=Satislar.PersonelID group by Satislar.PersonelID