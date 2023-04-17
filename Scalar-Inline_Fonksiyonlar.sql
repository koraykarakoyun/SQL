use VeriBilimi

--Scalar fonksiyonlar,geriye belirli bir tipte deðer dönen fonksiyonlardýr.
--Scalar fonksiyon oluþturma.
create function Topla(@sayi1 int,@sayi2 int) returns int
as
begin
	return @sayi1+@sayi2
end
--Scalar fonksiyon kullanýmý
select dbo.Topla(6,5)

--Scalar fonksiyon örnek
create function Yazdir(@isim varchar(20),@sayi1 int) returns varchar(50)
as
begin
	declare @sayi2 varchar(5)=@sayi1+5;
	return ('hosgeldiniz '+@isim+' sayiniz: '+@sayi2)
end

print(dbo.Yazdir('koray',4));
--Not:Scalar fonksiyonlar çaðýrýlýken dbo ile birlikte çaðýrýlmalýdýr.


--Inline fonksiyonlar,geriye bir tablo dönen fonksiyonlardýr.

create function inline_func(@ad varchar(15),@soyad varchar(15)) returns table
as
	return select * from dbo.Personeller where Ad=@ad and Soyad=@soyad

select * from dbo.inline_func('koray','karakoyun');

--with encryption komutu ile fonksiyon þifrelenerek oluþturulabilir.
--Not:Inline fonksiyonlarda begin end komutlarý kullanýlmaz.

create function yas_ara(@yas int) returns table
with encryption
as
	return select * from dbo.Personeller where Yas=@yas

select * from dbo.yas_ara(22);


--Computed Columns,hesaplanabilir kolonlar fonksiyonlar yardýmýyla veriler ile hesaplama iþlemi yapýlan kolonlardýr.

use Northwind;

create function SatisRaporu(@kategori varchar(20),@urun varchar(20),@birimfiyat int,@stok int) returns varchar(100)
as
begin

	declare @toplam varchar(100) =@kategori+' kategorisindeki '+@urun+' urunun toplam fiyatý: '+CAST(@birimfiyat*@stok as nvarchar(50))+' tldir.'
	return @toplam;
end

select Urunler.UrunAdi ,dbo.SatisRaporu(Kategoriler.KategoriAdi,Urunler.UrunAdi,Urunler.BirimFiyati,Urunler.HedefStokDuzeyi) ToplamFiyat from Urunler inner join Kategoriler on Urunler.KategoriID=Kategoriler.KategoriID


--Toplam satis yapan kisilerin satis sayilarý ornegi

use Northwind

create function SatisSayisi(@personel_adi varchar(30),@satis_sayisi int) returns varchar(60)
as
begin

declare @sonuc varchar(60)=@personel_adi+' personeli '+CAST(@satis_sayisi as varchar(40))+' adet satis yapmistir.'
return @sonuc;

end

select dbo.SatisSayisi(Satislar.PersonelID,Count(Satislar.PersonelID)) from Personeller inner join Satislar on Personeller.PersonelID=Satislar.PersonelID group by Satislar.PersonelID