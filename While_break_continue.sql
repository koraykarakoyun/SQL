use VeriBilimi

declare @sayi tinyint;
set @sayi=0;

while @sayi<100
begin
print(@sayi);

if @sayi=55
begin
break
end

else if @sayi%2=0
begin
set @sayi=@sayi+1;
continue
end

else
begin
set @sayi=@sayi+2;
end
end