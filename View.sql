use VeriBilimi

--View,kompleks sorgularýn bir kere yazýlýp veritabaný nesnesi olarak kaydedilmesini,
--daha sonra bu nesnelerin üzerinde CRUD iþlemleri yapýlabilmesini saðlar;

--View Oluþturma
select * from Personeller;
select * from Adresler;
create view ornek_view
as
select Personeller.Id,Personeller.Ad,Personeller.Soyad,Personeller.Yas,Personeller.Maas,Adresler.Il,Adresler.Ilce from Personeller inner join Adresler on Personeller.AdresId=Adresler.Id 

--View kullanýmý

--view üzerinde yapýlan iþlemler gerçek fiziksel tablolara da yansýtýlýr.
select * from ornek_view order by Ad asc
--insert into Personeller values ('View Deneme Ad','View Deneme Soyad',12345.22,4,10);
--insert into Adresler values (4,'View Il','View Ilce')

--Not:Viewler oluþturulurken order by kullanmak için top komutunu kullanmak gerekir

--View'i sifreleyerek olusturmak icin 'with encryption' komutu kullanýlýr
create view sifreli_view
with encryption
as 
select Personeller.Id,Personeller.Ad,Personeller.Soyad,Personeller.Yas,Personeller.Maas,Adresler.Il,Adresler.Ilce from Personeller inner join Adresler on Personeller.AdresId=Adresler.Id 

--'with schemabinding' komutu ile view'in kullandýðý tablolar üzerinde deðiþiklik yapýlacaðý zaman uyarý verilmesini saðlar.
--Kullanýrken dikkat edilmesi gereken nokta tablo adlarý 'þema adý' ile birlikte kullanýlmalýdýr.
create view ornek_view_2
with schemabinding
as
select dbo.Personeller.Id,dbo.Personeller.Ad,dbo.Personeller.Soyad,dbo.Personeller.Yas,dbo.Personeller.Maas,dbo.Adresler.Il,dbo.Adresler.Ilce from dbo.Personeller inner join dbo.Adresler on dbo.Personeller.AdresId=dbo.Adresler.Id 

--Bu sorgu hata mesajý fýrlatýr
alter table personeller
alter column ad varchar(100)

--with check option,view içerisine where þartlarýna uymayan deðerlerin eklenmesini önler.

create view ornek_view_3
as
select * from Personeller where Ad like 'a%'
with check option

select * from ornek_view_3
insert into ornek_view_3 values ('B_ad','c_soyad',123.12,5,33)
--burada view sorgusundaki adi a harfi ile baþlayanlar filtresine uygun olmadýðý için veri eklenemez