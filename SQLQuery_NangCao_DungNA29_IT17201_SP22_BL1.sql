-- SQLQuery_NangCao_DungNA29_IT17201_SP22_BL1
-- Sử dụng cơ bản:
-- Ctrl + /: Comment code
-- Sử dụng SQL: 
-- Chạy câu lệnh SQL đang được chọn (Ctrl + E)
-- Chuyển câu lệnh đang chọn thành chữ hoa, chữ thường (Ctrl + Shift + U, Ctrl + Shift + L)
-- Comment và bỏ comment dòng lệnh ( Ctrl + K + C; Ctrl + K + U)

-- Bài 1 Tạo biến bằng lênh DECLARE trong SQL Server
-- 1.1 Để khai báo biến thì bạn sử dụng từ khóa DECLARE với cú pháp như sau:
-- DECLARE @var_name data_type;
-- @var_name là tên của biến, luôn luôn bắt đầu bằng ký tự @
-- data_type là kiểu dữ liệu của biến
-- Ví dụ:
DECLARE @YEAR AS INT;

DECLARE @NAME AS NVARCHAR,
        @YEAR_OF_BIRTH AS INT;

-- 1.2 Gán giá trị cho biến
-- SQL Server để gán giá trị thì bạn sử dụng từ khóa SET và toán tử = với cú pháp sau
-- SET @var_name = value
SET @YEAR = 2022;
SELECT @YEAR;

-- 1.2 Truy xuất giá trị của biến SELECT @<Tên biến> 
DECLARE @ChieuDai int, @ChieuRong int, @DienTich int;
SET @ChieuDai = 6;
SET @ChieuRong = 2;
SET @DienTich = @ChieuDai*@ChieuRong;
SELECT @DienTich;

-- 1.3 Lưu trữ câu truy vấn vào biến
DECLARE @Max_Luong FLOAT
SET @Max_Luong = (SELECT MAX(LuongNV)
FROM nhanvien)
-- SELECT @Max_Luong
PRINT @Max_Luong
PRINT N'Nhân viên có lương lớn nhất là: ' + CONVERT(NVARCHAR(12),@Max_Luong)

-- 1.4 Biến Bảng 
DECLARE @NhanVien_Table TABLE (MaNV NVARCHAR(9),
    TenNV NVARCHAR(20))
--Chèn dữ liệu vào biến bảng
-- Insert rows into table 'TableName' in schema '[dbo]'
INSERT INTO @NhanVien_Table
SELECT MaNhanVien, TenNV
FROM nhanvien
WHERE DiaChi LIKE '%HCM'

SELECT *
FROM @NhanVien_Table
-- Nếu muốn truy cập đến từng cột chỉ định của biến bảng
SELECT TenNV
FROM @NhanVien_Table

-- 1.5  CHÈN DỮ LIỆU VÀO BIẾN BẢNG
DECLARE @NhanVien_Table1 TABLE (MaNV int,
    TenNV NVARCHAR(20))
-- Chèn dữ liệu vào biến bảng
INSERT INTO @NhanVien_Table1
VALUES(1, N'Nguyễn Văn Chương')
SELECT *
FROM @NhanVien_Table1

-- 1.6 Sửa dữ liệu vào biến bảng
DECLARE @NhanVien_Table2 TABLE (MaNV int,
    TenNV NVARCHAR(20))
-- Chèn dữ liệu vào biến bảng
INSERT INTO @NhanVien_Table2
VALUES(1, N'Nguyễn Văn Chương')
SELECT *
FROM @NhanVien_Table2
UPDATE @NhanVien_Table2
SET TenNV = N'Phan Sỹ Thanh Tùng'
WHERE MaNV = 1
SELECT *
FROM @NhanVien_Table2

-- 1.7 Begin và End
/* T-SQL tổ chức theo từng khối lệnh
   Một khối lệnh có thể lồng bên trong một khối lệnh khác
   Một khối lệnh bắt đầu bởi BEGIN và kết thúc bởi
   END, bên trong khối lệnh có nhiều lệnh, và các
   lệnh ngăn cách nhau bởi dấu chấm phẩy	
   BEGIN
    { sql_statement | statement_block}
   END
*/
BEGIN
    SELECT MaNhanVien, TenNV, LuongNV
    FROM nhanvien
    WHERE LuongNV > 4000000

    IF @@ROWCOUNT = 0
    PRINT N'Không có nhân viên nào mức lương như vậy'
    ELSE
    PRINT N'Anh Chương có dữ liệu nè'
END

-- 1.8 Begin và End lồng nhau
BEGIN
    DECLARE @Ten NVARCHAR(MAX)
    SELECT TOP 1
        @Ten = TenNV
    FROM nhanvien
    WHERE TenNV = N'Ánh'
    ORDER BY TenNV ASC

    IF @@ROWCOUNT <> 0
    BEGIN
        PRINT N'Tìm thấy người đầu tiên có tên là ' + @Ten
    END
    ELSE
    BEGIN
        PRINT N'Không tìm thấy nhân viên nào có tên như vậy'
    END
END
-- 1.9 CAST ÉP KIỂU DỮ LIỆU
-- Hàm CAST trong SQL Server chuyển đổi một biểu thức từ một kiểu dữ liệu này sang kiểu dữ liệu khác. 
-- Nếu chuyển đổi không thành công, CAST sẽ báo lỗi, ngược lại nó sẽ trả về giá trị chuyển đổi tương ứng.
-- CAST(bieuthuc AS kieudulieu [(do_dai)])
SELECT CAST(42.15 AS INT)
SELECT CAST(13.5 AS FLOAT)
SELECT CAST(15.6 AS VARCHAR)
SELECT CAST(15.6 AS VARCHAR(4))
SELECT CAST('15.6' AS FLOAT)
SELECT CAST('2022-12-04' AS DATETIME)

-- 2.0 CONVERT 
-- Hàm CONVERT trong SQL Server cho phép bạn có thể chuyển đổi một biểu thức nào đó sang một kiểu dữ liệu 
-- bất kỳ mong muốn nhưng có thể theo một định dạng nào đó (đặc biệt đối với kiểu dữ liệu ngày). 
-- Nếu chuyển đổi không thành công, CONVERT sẽ báo lỗi, ngược lại nó sẽ trả về giá trị chuyển đổi tương ứng.
-- CONVERT(kieudulieu(do_dai), bieuthuc, dinh_dang)
-- dinh_dang (không bắt buộc): là một con số chỉ định việc định dạng cho việc chuyển đổi dữ liệu từ dạng ngày sang dạng chuỗi.
SELECT CONVERT(int,15.6)
-- = 15 cắt bỏ phần thập phân
SELECT CONVERT(float,'16.98')
-- = 16.98 Chuyển từ String về số
SELECT CONVERT(datetime,'2022-12-04')--2022-12-04 00:00:00.000

-- 101 102... chính là tham số định dạng
SELECT CONVERT(varchar,'01/14/2022',101)
-- mm/dd/yyyy
SELECT CONVERT(datetime,'2022.01.14',102)
-- yyy.mm.dd
SELECT CONVERT(datetime,'14/01/2022',103)
-- dd/mm/yyy
-- Còn rất nhiều kiểu định dạng https://www.mssqltips.com/sqlservertip/1145/date-and-time-conversions-using-sql-server/

-- Ví dụ: Hiển thị danh sách ngày sinh của nhân viên theo những định dạng
SELECT NgaySinh,
    CAST(NgaySinh AS varchar) AS 'Ngày sinh 1',
    CONVERT(varchar,NgaySinh,103) AS 'Ngày sinh 2',
    CONVERT(varchar,NgaySinh,104) AS 'Ngày sinh 3',
    CONVERT(varchar,NgaySinh,105) AS 'Ngày sinh 4'
FROM nhanvien

-- 2.1 Các hàm toán học Các hàm toán học (Math) được dùng để thực hiện các phép toán số học trên các giá trị. 
-- Các hàm toán học này áp dụng cho cả SQL SERVER và MySQL.
-- 1. ABS() Hàm ABS() dùng để lấy giá trị tuyệt đối của một số hoặc biểu thức.
-- Hàm ABS() dùng để lấy giá trị tuyệt đối của một số hoặc biểu thức.
SELECT ABS(-3)
-- 2. CEILING()
-- Hàm CEILING() dùng để lấy giá trị cận trên của một số hoặc biểu thức, tức là lấy giá trị số nguyên nhỏ nhất nhưng lớn hơn số hoặc biểu thức tương ứng.
-- CEILING(num_expr)
SELECT CEILING(3.1)
-- 3. FLOOR()
-- Ngược với CEILING(), hàm FLOOR() dùng để lấy cận dưới của một số hoặc một biểu thức, tức là lấy giá trị số nguyên lớn nhất nhưng nhỏ hơn số hoặc biểu thức tướng ứng.
-- FLOOR(num_expr)
SELECT FLOOR(9.9)
-- 4. POWER()
-- POWER() dùng để tính luỹ thừa của một số hoặc biểu thức.
-- POWER(num_expr,luỹ_thừa)
SELECT POWER(3,2)
-- 5. ROUND()
-- Hàm ROUND() dùng để làm tròn một số hay biểu thức.
-- ROUND(num_expr,độ_chính_xác)
SELECT ROUND(9.123456,2)-- = 9.123500
-- 6. SIGN()
-- Hàm SIGN() dùng để lấy dấu của một số hay biểu thức. Hàm trả về +1 nếu số hoặc biểu thức có giá trị dương (>0),
-- -1 nếu số hoặc biểu thức có giá trị âm (<0) và trả về 0 nếu số hoặc biểu thức có giá trị =0.
SELECT SIGN(-99)
SELECT SIGN(100-50)
-- 7. SQRT()
-- Hàm SQRT() dùng để tính căn bậc hai của một số hoặc biểu thức, giá trị trả về của hàm là số có kiểu float.
-- Nếu số hay biểu thức có giá trị âm (<0) thì hàm SQRT() sẽ trả về NULL đối với MySQL, trả về lỗi đối với SQL SERVER.
-- SQRT(float_expr)
SELECT SQRT(9)
SELECT SQRT(9-5)
-- 8. SQUARE()
-- Hàm này dùng để tính bình phương của một số, giá trị trả về có kiểu float. Ví dụ:
SELECT SQUARE(9)
-- 9. LOG()
-- Dùng để tính logarit cơ số E của một số, trả về kiểu float. Ví dụ:
SELECT LOG(9) AS N'Logarit cơ số E của 9'
-- 10. EXP()
-- Hàm này dùng để tính luỹ thừa cơ số E của một số, giá trị trả về có kiểu float. Ví dụ:
SELECT EXP(2)
-- 11. PI()
-- Hàm này trả về số PI = 3.14159265358979.
SELECT PI()
-- 12. ASIN(), ACOS(), ATAN()
-- Các hàm này dùng để tính góc (theo đơn vị radial) của một giá trị. Lưu ý là giá trị hợp lệ đối với 
-- ASIN() và ACOS() phải nằm trong đoạn [-1,1], nếu không sẽ phát sinh lỗi khi thực thi câu lệnh. Ví dụ:
SELECT ASIN(1) as [ASIN(1)], ACOS(1) as [ACOS(1)], ATAN(1) as [ATAN(1)];

-- 2.2 Các hàm xử lý chuỗi làm việc với kiểu chuỗi
/*
 LEN(string)  Trả về số lượng ký tự trong chuỗi, tính cả ký tự trắng đầu chuỗi
 LTRIM(string) Loại bỏ khoảng trắng bên trái
 RTRIM(string)  Loại bỏ khoảng trắng bên phải
 LEFT(string,length) Cắt chuỗi theo vị trí chỉ định từ trái
 RIGHT(string,legnth) Cắt chuỗi theo vị trí chỉ định từ phải
 TRIM(string) Cắt chuỗi nó được xuất hiện từ bản SQL 2017 trở lên mới có
*/
SELECT LEN('SQL SERVER')-- = 10 ký tự tính space
SELECT LTRIM(' SQL SERVER')
SELECT RTRIM(' SQL SERVER ')
SELECT LEFT('SQL SERVER',3)
SELECT RIGHT('SQL SERVER',6)
SELECT LTRIM(RTRIM(' SQL SERVER '))

/*Nếu chuỗi gồm hai hay nhiều thành phần, bạn có thể phân
tách chuỗi thành những thành phần độc lập.
Sử dụng hàm CHARINDEX để định vị những ký tự phân tách.
Sau đó, dùng hàm LEFT, RIGHT, SUBSTRING và LEN để trích ra
những thành phần độc lập*/
DECLARE @Name1_Talbe TABLE (TenNV NVARCHAR(MAX))
-- Chèn dữ liệu vào biến bảng
INSERT INTO @Name1_Talbe
VALUES(N'Nguyễn Văn Chương'),
    (N'Tô Ngọc Hùng')
SELECT TenNV,
    CHARINDEX(' ',TenNV) AS 'CHARINDEX',
    LEN(TenNV) AS 'LEN',
    LEFT(TenNV,CHARINDEX(' ',TenNV)-1) AS N'Họ',
    RIGHT(TenNV,LEN(TenNV)-CHARINDEX(' ',TenNV)) AS N'Tên'
FROM @Name1_Talbe
-- Bài tập: Tạo ra 1 bảng gồm có 3 tên như sau: 
-- Nguyễn Văn Chương, Lê Thị Thanh Tâm
-- 5 cột sẽ bao gồm: Tên Đầy Đủ, Họ, Tên Đệm, Tên Đệm 2, Tên
-- Xử lý phân tách tên thành các phần riêng biệt - 4h45.
-- Cách 1:
DECLARE @Name1_Talbe TABLE (TenNV NVARCHAR(MAX))
-- Chèn dữ liệu vào biến bảng
INSERT INTO @Name1_Talbe
VALUES(N'Nguyễn Văn Chương'),
    (N'Tô Ngọc Hùng')
SELECT TenNV AS N'TÊN ĐẦY ĐỦ',
    LEFT(TenNV, CHARINDEX(' ', TenNV) -1) AS N'HỌ',
    RTRIM(LTRIM(REPLACE(REPLACE(TenNV,SUBSTRING(TenNV , 1, CHARINDEX(' ', TenNV) - 1),''),REVERSE( LEFT( REVERSE(TenNV), CHARINDEX(' ', REVERSE(TenNV))-1 ) ),'')))as N'TÊN ĐỆM',
    RIGHT(TenNV, CHARINDEX(' ', TenNV)) AS N'TÊN'
FROM @Name1_Talbe
-- Cách 2:
DECLARE @Names1_Table TABLE (Fullname NVARCHAR(MAX))
INSERT INTO @Names1_Table
VALUES(N'Nguyễn Tiến Hùng'),
    (N'Nguyễn Hữu Khoa')
SELECT Fullname,
    PARSENAME(REPLACE(Fullname,' ','.'),3) AS N'Họ',
    PARSENAME(REPLACE(Fullname,' ','.'),2) AS N'Tên Đệm',
    PARSENAME(REPLACE(Fullname,' ','.'),1) AS N'Tên'
FROM @Names1_Table

-- 2.3 Charindex Trả về vị trí được tìm thấy của một chuỗi trong chuỗi chỉ định, 
-- ngoài ra có thể kiểm tra từ vị trí mong  muốn
-- CHARINDEX ( string1, string2 [ , start_location ] ) = 1 số nguyên
SELECT CHARINDEX('Poly','FPT POLYTECHNIC')
SELECT CHARINDEX('Poly','FPT POLYTECHNIC',6)

-- 2.4 Substring Cắt chuỗi bắt đầu từ vị trí và độ dài muốn lấy 
-- SUBSTRING(string,start,length)
DECLARE @FullName2 VARCHAR(25)
SET @FullName2 = 'www.poly.edu.vn'
SELECT SUBSTRING(@FullName2,5,LEN(@FullName2))
SELECT SUBSTRING(@FullName2,5,5)

-- 2.5 Replace Hàm thay thế chuỗi theo giá trị cần thay thế và cần thay thế
-- REPLACE(search,find,replace)
SELECT REPLACE('0912-345-678','-','#')
SELECT REPLACE(N'Nguyễn Anh Dũng',N'Anh',N'Tiến')

/* 2.6 
REVERSE(string) Đảo ngược chuỗi truyền vào
LOWER(string)	Biến tất cả chuỗi truyền vào thành chữ thường
UPPER(string)	Biến tất cả chuỗi truyền vào thành chữ hoa
SPACE(integer)	Đếm số lượng khoảng trắng trong chuỗi. 
*/
SELECT LOWER('SQL SERVER 2022')
SELECT UPPER('sql server 2022')
SELECT REVERSE('sql server 2022')
SELECT N'NGUYỄN' + ' ' + 'ANH'
SELECT N'NGUYỄN' + SPACE(5) + 'ANH'


-- 2.7 Các hàm ngày tháng năm
SELECT GETDATE()
SELECT CONVERT(date,GETDATE())
SELECT CONVERT(time,GETDATE())

SELECT YEAR(GETDATE()) AS YEAR,
    MONTH(GETDATE()) AS MONTH,
    DAY(GETDATE()) AS DAY

-- DATENAME: truy cập tới các thành phần liên quan ngày tháng
SELECT DATENAME(YEAR,GETDATE()) AS YEAR,
    DATENAME(MONTH,GETDATE()) AS MONTH,
    DATENAME(DAY,GETDATE()) AS DAY,
    DATENAME(WEEK,GETDATE()) AS WEEK,
    DATENAME(DAYOFYEAR,GETDATE()) AS DAYOFYEAR,
    DATENAME(WEEKDAY,GETDATE()) AS WEEKDAY

-- 2.8 Câu điều kiện IF ELSE trong SQL
/* Lệnh if sẽ kiểm tra một biểu thức có đúng  hay không, nếu đúng thì thực thi nội dung bên trong của IF, nếu sai thì bỏ qua.
IF BIỂU THỨC   
BEGIN
    { statement_block }
END		  */
IF 1=2
BEGIN
    PRINT N'1=1 là đúng'
END
ELSE
BEGIN
    PRINT N'1=2 là Sai'
END

IF 1=2
    PRINT N'1=1 là đúng'
ELSE
    PRINT N'1=2 là Sai'

-- Viết 1 chương trình điểm SQL SERVER NÂNG CAO
DECLARE @DiemCOM2034 FLOAT
SET @DiemCOM2034 = 4.9
IF @DiemCOM2034 < 5
PRINT N'Chúc mừng bạn đã mất 659K'
ELSE
PRINT N'Chúc mừng bạn qua môn'

DECLARE @DiemCOM2034_1 FLOAT
SET @DiemCOM2034_1 = 5
IF @DiemCOM2034_1 < 5
BEGIN
    PRINT N'Chúc mừng bạn đã mất 659K'
END
ELSE
BEGIN
    PRINT N'Chúc mừng bạn qua môn'
    IF @DiemCOM2034_1 <= 7
    PRINT N'Điểm Trung bình môn này thôi nhé'
    ELSE
    PRINT N'Bọn đạt điểm giỏi môn này rồi'
END

/* 2.9 IF EXISTS
IF EXISTS (CaulenhSELECT)
Cau_lenhl | Khoi_lenhl
[ELSE
Cau_lenh2 | Khoi_lenh2] 
*/
-- Kiểm tra xem trong bảng nhân viên có nhân viên nào lương lớn hơn 50tr không?
IF EXISTS(SELECT *
FROM nhanvien
WHERE LuongNV > 5000000)
BEGIN
    PRINT N'Có danh sách nhân viên có lương lớn hơn 5tr đấy'
    SELECT MaNhanVien, TenNV, LuongNV
    FROM nhanvien
    WHERE LuongNV > 5000000
END
ELSE
 PRINT N'Không Có danh sách nhân viên có lương lớn hơn 5tr đấy'

/*
 3.0 Hàm IIF () trả về một giá trị nếu một điều kiện là TRUE hoặc một giá trị khác nếu một điều kiện là FALSE.
IIF(condition, value_if_true, value_if_false)
*/
SELECT IIF(500<1000,'Đúng rồi','Sai rồi')--Giống toán tử 3 ngôi

SELECT MaNhanVien, TenDemNV,
    IIF(IdCuaHang = 1,N'Thuộc cửa hàng 1',N'Không thuộc cửa hàng 1')
FROM nhanvien

/*
3.1 Câu lệnh CASE đi qua các điều kiện và trả về một giá trị khi điều kiện đầu tiên được đáp ứng (như câu lệnh IF-THEN-ELSE). 
Vì vậy, một khi một điều kiện là đúng, nó sẽ ngừng đọc và trả về kết quả. 
Nếu không có điều kiện nào đúng, nó sẽ trả về giá trị trong mệnh đề ELSE.

Nếu không có phần ELSE và không có điều kiện nào đúng, nó sẽ trả về NULL.

CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;
*/
SELECT TenNV =
CASE GioiTinh
WHEN 'Nam' THEN 'Mr.' + TenNV
WHEN N'Nữ' THEN 'Ms.' + TenNV
ELSE N'Không xác định ' + TenNV
END
FROM nhanvien

-- Viết lại theo cách khác
SELECT TenNV =
CASE 
WHEN GioiTinh = 'Nam' THEN 'Mr.' + TenNV
WHEN GioiTinh LIKE N'Nữ' THEN 'Ms.' + TenNV
ELSE N'Không xác định ' + TenNV
END
FROM nhanvien

-- Tạo ra 1 cột tính thuế cho lương nhân viên
SELECT MaNhanVien, TenNV, LuongNV,
    Thue = (CASE
WHEN LuongNV BETWEEN 0 AND 300000 THEN LuongNV*0.05
WHEN LuongNV BETWEEN 300000 AND 600000 THEN LuongNV*0.08
WHEN LuongNV BETWEEN 600000 AND 10000000 THEN LuongNV*0.1
ELSE LuongNV*0.3
END)
FROM nhanvien

/*Vòng lặp WHILE (WHILE LOOP) được sử dụng nếu bạn muốn 
chạy lặp đi lặp lại một đoạn mã khi điều kiện cho trước trả về giá trị là TRUE.*/
DECLARE @DEM INT = 1
WHILE @DEM < 5
BEGIN
    PRINT N'MÔN CSDL NÂNG CAO QUAN TRỌNG PHẢI CHỊU KHÓ CODE'
    SET @DEM += 1
    PRINT @DEM
END
PRINT N'THỰC RA CŨNG KHÔNG KHÓ NHỈ'

-- Ví dụ: Cộng zồn tổng từ 1 đến 5 = ?
DECLARE @NUMBER INT = 0,@I INT = 1
WHILE @I < 6
BEGIN
    SET @NUMBER += @I
    SET @I =@I + 1
END
PRINT @NUMBER

/*Lệnh Break (Ngắt vòng lặp)*/
/* Lệnh Continue: Thực hiện bước lặp tiếp theo bỏ qua các lệnh trong 
bước lặp hiện tại*/
DECLARE @DEM1 INT = 0
WHILE @DEM1 < 10
BEGIN
    IF @DEM1 = 5
    BEGIN
        PRINT @DEM1
        SET @DEM1 = @DEM1 + 1
        CONTINUE
    END
ELSE
    BEGIN
        PRINT N'MÔN CSDL NÂNG CAO QUAN TRỌNG PHẢI CHỊU KHÓ CODE'
        PRINT @DEM1
    -- SET @DEM1 = @DEM1 + 1
    END
    SET @DEM1 = @DEM1 + 1
END
PRINT N'THỰC RA CŨNG KHÔNG KHÓ NHỈ'

/* 3.2 Try...Catch 
SQLServer Transact-SQL cung cấp cơ chế kiểm soát lỗi bằng TRY … CATCH
như trong các ngôn ngữ lập trình phổ dụng hiện nay (Java, C, PHP, C#).
Một số hàm ERROR thường dùng
_
ERROR_NUMBER() : Trả về mã số của lỗi dưới dạng số
ERROR_MESSAGE() Trả lại thông báo lỗi dưới hình thức văn bản 
ERROR_SEVERITY() Trả lại mức độ nghiêm trọng của lỗi kiểu int
ERROR_STATE() Trả lại trạng thái của lỗi dưới dạng số
ERROR_LINE() : Trả lại vị trí dòng lệnh đã phát sinh ra lỗi
ERROR_PROCEDURE() Trả về tên thủ tục/Trigger gây ra lỗi
*/

BEGIN TRY
    SELECT 1 + 'STRING'
END TRY
BEGIN CATCH
    SELECT
    ERROR_NUMBER() AS N'TRẢ VỀ LỖI DƯỚI DẠNG SỐ',
    ERROR_MESSAGE() AS N'TRẢ VỀ LỖI DƯỚI VĂN BẢN'
END CATCH

-- Thử Insert dữ liệu vào 1 bảng
BEGIN TRY
    INSERT INTO chucvu
    (IdChucVu,MaChucVu,TenChucVu)
VALUES(1, 'AA', N'Hoàng')   
END TRY
BEGIN CATCH
   PRINT N'Bạn ơi không insert được rồi'
   PRINT N'Thông báo: ' + ERROR_MESSAGE()
   PRINT N'Thống báo: ' + CONVERT(VARCHAR,ERROR_NUMBER(),1)
END CATCH

/* 3.3 RAISERROR
*/
-- Có dùng RAISE....
BEGIN TRY
    INSERT INTO chucvu
    (IdChucVu,MaChucVu,TenChucVu)
VALUES(1, 'AA', N'Hoàng')   
END TRY
BEGIN CATCH
   DECLARE @ErMESSAGE VARCHAR(MAX), @ErSEVERITY INT, @ErSTATE INT
   SELECT
    @ErMESSAGE = ERROR_MESSAGE(),
    @ErSEVERITY = ERROR_SEVERITY(),
    @ErSTATE = ERROR_STATE()
    RAISERROR(@ErMESSAGE,@ErSEVERITY, @ErSTATE)
END CATCH
-- KHÔNG DÙNg 
BEGIN TRY
    INSERT INTO chucvu
    (IdChucVu,MaChucVu,TenChucVu)
VALUES(1, 'AA', N'Hoàng')   
END TRY
BEGIN CATCH
   DECLARE @ErMESSAGE1 VARCHAR(MAX), @ErSEVERITY1 INT, @ErSTATE1 INT
   SELECT
    @ErMESSAGE1 = ERROR_MESSAGE(),
    @ErSEVERITY1 = ERROR_SEVERITY(),
    @ErSTATE1 = ERROR_STATE()
   PRINT N'Thông báo: ' + @ErMESSAGE1 + ' | ' + CONVERT(VARCHAR,@ErSEVERITY1,1) +
   ' | ' + CONVERT(VARCHAR, @ErSTATE1,1)   
END CATCH

/* 3.4 ý nghĩa của Replicate  */
DECLARE @Ten123 NVARCHAR(50)
SET @Ten123 = REPLICATE(N'CHƯƠNG',9)--Lặp lại số lần với String chuyền vào
PRINT @Ten123

-- Bài tập SP
-- CREATE PROC sp_TimMaNhanVien1
-- AS
-- BEGIN
--     DECLARE  @MaNV NVARCHAR(100) = 'NV01', @IDTang INT = 1
--     WHILE EXISTS (SELECT dbo.nhanvien.MaNhanVien FROM nhanvien WHERE MaNhanVien = @MaNV)
--     BEGIN
-- 		SET @IDTang = @IDTang +1
-- 		SET @MaNV = 'NV' + REPLICATE('0',2 - LEN(CAST(@IDTang AS nvarchar))) + CAST(@IDTang AS nvarchar)
-- 	END
-- END 