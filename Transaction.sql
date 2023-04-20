use Northwind

--Transaction,veritaban� �zerinde yap�lan i�lemler default olarak transaction e�li�inde y�r�t�l�r.
--Veritaban� ile ilgili i�lemler ba�lat�l�rken 'begin transaction' keyword� ile ba�lat�l�r.
--��lem sonucunda ba�ar�l� olma durumunda 'commit transaction' keyword� ile transaction sonland�r�l�r.
--��lem esnas�nda herhangi bir sorun olu�ma durumunda ise 'rollback' keyword� kullan�larak yap�lan i�lemler geri al�narak eski durumuna getirilir ve transaction sonland�rl�r.

begin transaction
select * from Personeller
declare @rowcount tinyint=@@rowcount
if(@rowcount=10)
begin
	insert into Personeller (Adi,SoyAdi) values ('11.Adi','11.Soyadi')
	set @rowcount=@@ROWCOUNT
	if(@rowcount=1)
		begin
			print('rowcount:'+CAST(@rowcount as varchar(20)))
			commit transaction
		end
	else
	begin
		print('rowcount:'+CAST(@rowcount as varchar(20)))
		rollback transaction
	end
end
else
begin
	print(@rowcount)
	commit transaction
end
