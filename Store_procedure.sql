use Northwind

--Store Procedure,k���k i�lemsel par�ac�klard�r.��lemlerin daha verimli �ekilde yap�lmas�n� sa�lar.
--Sadece ilk �al��t���nda execute plana al�n�r.Daha sonraki �al��t�rmalarda al�nmaz bu nedenle daha performansl�d�r.
--Store Procedure yap�s� 'execute' komutu ile �al��t�r�l�r.

--Store procedure olu�turma

create procedure sp_ornek
as
begin
select * from Personeller
end

execute sp_ornek

--Parametreli store procedure

create procedure sp_personeller_ulkefiltresi(@ulkeadi char(50))
as
begin
select * from Personeller where Ulke=@ulkeadi
end

execute sp_personeller_ulkefiltresi 'UK'
execute sp_personeller_ulkefiltresi 'USA'


--Default parametreli store procedure

create procedure  sp_default_urunler_tedarikci(@tedarikci_id tinyint=1,@kategori_id tinyint=1)
as
begin
select * from Urunler inner join Tedarikciler on Urunler.TedarikciID=Tedarikciler.TedarikciID 
inner join Kategoriler on urunler.KategoriID=Kategoriler.KategoriID 
where Urunler.TedarikciID=@tedarikci_id and Urunler.KategoriID=@kategori_id
end

drop procedure sp_default_urunler_tedarikci

execute sp_default_urunler_tedarikci
execute sp_default_urunler_tedarikci 3
execute sp_default_urunler_tedarikci 2,2


--Output parametreli store procedure

create procedure sp_output(@id tinyint,@ad char(20) output,@soyad char(20) output)
as
begin
select @ad=Adi ,@soyad=SoyAdi from Personeller where PersonelID=@id
end

declare @adi varchar(20),@soyadi varchar(20);
execute sp_output 2,@adi output,@soyadi output
select @adi,@soyadi
