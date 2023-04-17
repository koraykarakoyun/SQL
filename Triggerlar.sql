use Northwind

--Triggerlar,veritaban� veya tablo �zerinde bir i�lem yap�l�rken o i�lem s�recinde tetiklenen ve istenilen ba�ka i�lemlerin yap�lmas�n� sa�layan yap�lard�r.

--Triggerlar DDL ve DML trigger olarak ikiye ayr�l�r.
--DDL triggerlar veritaban� �zerinde create,alter,drop i�lemler yap�ld��� zaman tetiklenir.
--DML triggerlar,tablolar �zerinde insert,update,delete i�lemleri yap�ld��� zaman tetiklenir.

--DML trigger tan�mlama
--Trigger olu�turulurken ilgili tablo veya veritaban� ile ili�kisi belirtilir.

create trigger PersonelEklendigindeTrigger
on Personeller
after insert
as
begin
print('personeller tablosuna kay�t eklendi')
end

insert into Personeller(Adi,SoyAdi) values('Koray','Karakoyun')

--Triggerlar tetiklenirken insert i�leminden sonra i�lem fiziksel tabloya yans�t�lmadan 'inserted' tablosunda veri ge�ici olarak saklan�r.
--Yani yeni eklenen veriye inserted tablosu �zerinden eri�ilebilir.

drop trigger PersonelEklendigindeTrigger

create trigger PersonelEklendigindeTrigger
on Personeller
after insert
as
begin
declare @adi varchar(30),@soyadi varchar(30);
select @adi=Adi,@soyadi=SoyAdi from inserted --Eklenecek olan veriye eri�im
print(@adi+' '+@soyadi)
end
--insert into Personeller(Adi,SoyAdi) values('Kaan','Karakoyun')

--Triggerlar tetiklenirken delete i�leminden sonra i�lem fiziksel tabloya yans�t�lmadan 'deleted' tablosunda veri ge�ici olarak saklan�r.
--Yani silinecek veriye deleted tablosu �zerinden eri�ilebilir.
create trigger PersonelSilindigindeTrigger
on Personeller
after delete
as
begin
declare @adi varchar(30),@soyadi varchar(30);
select @adi=Adi,@soyadi=SoyAdi from deleted --Silinecek olan veriye eri�im
print(@adi+' '+@soyadi)
end
--delete from Personeller where Adi='Kaan'
--select * from Personeller


--Triggerlar tetiklenirken update i�leminden sonra i�lem fiziksel tabloya yans�t�lmadan inserted ve deleted tablosunda veri ge�ici olarak saklan�r.
--Yani yeni eklenen veriye inserted tablosu �zerinden,silinecek veriye deleted tablosu �zerinden  eri�ilebilir.

create trigger PersonelGuncellendiginde
on Personeller
after update
as
begin

declare @eskiadi varchar(30),@eskisoyadi varchar(30), @yeniadi varchar(30), @yenisoyadi varchar(30);
select @yeniadi=Adi,@yenisoyadi=SoyAdi from inserted
select @eskiadi=Adi,@eskisoyadi=SoyAdi from deleted 
print(@eskiadi+' '+@eskisoyadi+' olan veri '+@yeniadi+' '+@yenisoyadi+' olarak '+SUSER_SNAME()+' taraf�ndan'+CAST(GETDATE() as varchar(30))+ ' tarihinde degistirildi.')
end

select * from Personeller where Adi='Kaan'
update Personeller set Adi='Koray',SoyAdi='Karakoyun' where Adi='Kaan'


--DDL trigger tan�mlama

create table LogTablosu(
id smallint primary key identity(1,1),
aciklama varchar(500)
)

create trigger Tabloeklendi�indeTrigger
on Database
for create_table --alter_table,drop_table,create_procedure,drop_procedure,create_function,drop_funciton...
as
begin
insert into LogTablosu values(SUSER_SNAME()+' taraf�ndan '+CAST(GETDATE() as varchar(30))+' tarihinde yeni bir tablo olusturuldu')
end

create table Ornektablo3(
ad varchar(20),
soyad varchar(20)
)

select  * from LogTablosu

--'Instead of' keyword� bir i�lem yap�laca�� zaman o i�lem yerine ba�ka bir i�lemi yapt�rmak i�in kullan�l�r.

create trigger InsteadOfTrigger
on Personeller
instead of delete --Delete i�lemi yerine
as
begin
print('Bu tablodan veri silinemez')
rollback --Yap�lan i�lemleri geri almak i�in kullan�l�r.
end

select * from Personeller

delete from Personeller where PersonelID='13'

--Trigger enadble-disable i�lemi

disable trigger InsteadOfTrigger on Personeller

enable trigger InsteadOfTrigger on Personeller

-----

disable trigger Tabloeklendi�indeTrigger on database

enable trigger Tabloeklendi�indeTrigger on database