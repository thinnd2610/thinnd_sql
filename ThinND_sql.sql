create FUNCTION dbo.bai1
(
@str AS nvarchar(100)
)
RETURNS nvarchar(100)
AS
BEGIN

DECLARE
@return_str AS NVARCHAR(100),
@pos AS int,
@len AS int

SELECT
@return_str = N' ' + LOWER(@str),
@pos = 1,
@len = LEN(@str) + 1

WHILE @pos > 0 AND @pos < @len
BEGIN
SET @return_str = STUFF(@return_str,
@pos + 1,
1,
LOWER(SUBSTRING(@return_str,@pos + 1, 1)))
SET @pos = CHARINDEX(N' ', @return_str, @pos + 1)
END

RETURN RIGHT(@return_str, @len - 1)

END
select dbo.chuHoa('NGO DUC THIN')
---------------------------------
--Tạo function chuyển số thành chữ, input đầu vào là số bất kỳ
Create FUNCTION dbo.bai2
(@Number int)
RETURNS nvarchar(4000) AS
BEGIN
DECLARE @sNumber nvarchar(4000)
DECLARE @Return nvarchar(4000)
DECLARE @mLen int
DECLARE @i int
DECLARE @mDigit int
DECLARE @mGroup int
DECLARE @mTemp nvarchar(4000)
DECLARE @mNumText nvarchar(4000)
SELECT @sNumber=LTRIM(STR(@Number))
SELECT @mLen = Len(@sNumber)
SELECT @i=1
SELECT @mTemp=''
WHILE @i <= @mLen
BEGIN
SELECT @mDigit=SUBSTRING(@sNumber, @i, 1)
IF @mDigit=0 SELECT @mNumText=N'không'
ELSE
BEGIN
    IF @mDigit=1 SELECT @mNumText=N'một'
    ELSE
    IF @mDigit=2 SELECT @mNumText=N'hai'
    ELSE
    IF @mDigit=3 SELECT @mNumText=N'ba'
    ELSE
    IF @mDigit=4 SELECT @mNumText=N'bốn'
    ELSE
    IF @mDigit=5 SELECT @mNumText=N'năm'
    ELSE
    IF @mDigit=6 SELECT @mNumText=N'sáu'
    ELSE
    IF @mDigit=7 SELECT @mNumText=N'bảy'
    ELSE
    IF @mDigit=8 SELECT @mNumText=N'tám'
    ELSE
    IF @mDigit=9 SELECT @mNumText=N'chín'
END
SELECT @mTemp = @mTemp + ' ' + @mNumText
IF (@mLen = @i) BREAK
Select @mGroup=(@mLen - @i) % 9
IF @mGroup=0
BEGIN
    SELECT @mTemp = @mTemp + N' tỷ'
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
END
ELSE
IF @mGroup=6
BEGIN
    SELECT @mTemp = @mTemp + N' triệu'
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
END
ELSE
IF @mGroup=3
BEGIN
    SELECT @mTemp = @mTemp + N' nghìn'
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
END
ELSE
BEGIN
    Select @mGroup=(@mLen - @i) % 3
    IF @mGroup=2   
    SELECT @mTemp = @mTemp + N' trăm'
    ELSE
    IF @mGroup=1
    SELECT @mTemp = @mTemp + N' mươi'  
END
SELECT @i=@i+1
END
--'Loại bỏ trường hợp x00
SELECT @mTemp = Replace(@mTemp, N'không mươi không', '')
--'Loại bỏ trường hợp 00x
SELECT @mTemp = Replace(@mTemp, N'không mươi ', N'linh ')
--'Loại bỏ trường hợp x0, x>=2
SELECT @mTemp = Replace(@mTemp, N'mươi không', N'mươi')
--'Fix trường hợp 10
SELECT @mTemp = Replace(@mTemp, N'một mươi', N'mười')
--'Fix trường hợp x4, x>=2
SELECT @mTemp = Replace(@mTemp, N'mươi bốn', N'mươi tư')
--'Fix trường hợp x04
SELECT @mTemp = Replace(@mTemp, N'linh bốn', N'linh tư')
--'Fix trường hợp x5, x>=2
SELECT @mTemp = Replace(@mTemp, N'mươi năm', N'mươi lăm')
--'Fix trường hợp x1, x>=2
SELECT @mTemp = Replace(@mTemp, N'mươi một', N'mươi mốt')
--'Fix trường hợp x15
SELECT @mTemp = Replace(@mTemp, N'mười năm', N'mười lăm')
--'Bỏ ký tự space
SELECT @mTemp = LTrim(@mTemp)
--'Ucase ký tự đầu tiên
SELECT @Return=UPPER(Left(@mTemp, 1)) + SUBSTRING(@mTemp,2, 4000)
RETURN @Return
END
select dbo.bai2(10000) as [doc]