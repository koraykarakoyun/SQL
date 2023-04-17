use VeriBilimi

declare @sayi1 tinyint =5;
declare @sayi2 tinyint =3;


--declare @sayi3 tinyint,@sayi4 tinyint;
--set @sayi3=10;
--set @sayi4=20;

--set @sayi2=6;

if @sayi1>@sayi2
begin
print(@sayi1);
end
else if @sayi1<@sayi2
begin
print(@sayi2);
end
else if @sayi1=@sayi2
begin
print('iki sayi esittir');
end
else 
begin
print('iki sayi esit degildir');
end


declare @adi char(4)='Yeni',@soyadi char(5) ='yeni1'; 
select * from Personeller where Ad=@adi and Soyad=@soyadi

if @@ROWCOUNT>0
begin
print('boyle bir kullanýcý vardir')
end
else
begin
print('boyle bir kullanýcý yoktur')
insert into Personeller (Ad,Soyad) values(@adi,@soyadi)
print('kullanýcý kaydedildi')
end

--sorgu sonucu deger varmý yokmu sorgulamasýný yapar
if EXISTS(select * from Adresler)
begin
print('dolu')
end
else
begin
print('bos')
end