use Northwind

--Dynamic Data Masking,verilere kullanýcýlarýn yetkisiz eriþmesini engellemek için yetkisiz kullanýcýlara karþý veriyi maskeleyerek gösterir.
--Prototipi 'MASKED WITH (FUNCTÝON='...')' þeklindedir.Ýlgili kolon için bu þekilde tanýmlamak gerekir.

--3 farklý parametre alýr.
--default() parametre,veri tipine göre veriyi varsayýlan tanýmlý þekilde maskeler.
--email() parametre,veriyi email tipine göre maskeler.
--partial() parametre,veriyi özelleþtirilmiþ þekilde maskeler.
--partial(2,'XXX',2) tipindeki parametre verinin ilk 2 ve son 2 karakterini gösterir geri kalan karakterleri 'XXX' þeklinde gösterir.

create table MaskeTablo (
id smallint identity(1,1) primary key,
ad varchar(20) MASKED WITH(Function='default()'),
soyad varchar(20) MASKED WITH(Function='default()'),
email varchar(30) MASKED WITH(function='email()'),
tcno char(11) MASKED WITH(Function='default()'),
adresbilgisi varchar(100) MASKED WITH(Function='partial(1,"X",3)'),
hakkýnda varchar(100) MASKED WITH(Function='partial(3,"X",2)')
)

select * from MaskeTablo

insert into MaskeTablo values
('a','b','c@hotmail.com','11111111111','aaaaaaaaaaaaaaaaaa','bbbbbbbbbbbbbbbbbb'),
('c','d','e@hotmail.com','22222222222','fffffffffffffffffff','ggggggggggggggggggg')

--Tablodaki kolonun maskeleme özelliðini deðiþtirme
alter table MaskeTablo alter column id ADD MASKED WITH(Function='default()')

--Tablodaki kolonun maskeleme özelliðini silme
alter table MaskeTablo alter column id DROP MASKED

--Kullaniciya karþý veriyi maskeleme izni.
--Grant:onayla,Deny:reddet
Grant Unmask TO yetkisiz_kullanici
Deny Unmask TO yetkisiz_kullanici