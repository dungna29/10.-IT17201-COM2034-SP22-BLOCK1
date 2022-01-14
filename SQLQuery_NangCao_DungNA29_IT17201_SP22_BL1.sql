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
SELECT CONVERT(int,15.6) -- = 15 cắt bỏ phần thập phân
SELECT CONVERT(float,'16.98') -- = 16.98 Chuyển từ String về số
SELECT CONVERT(datetime,'2022-12-04')--2022-12-04 00:00:00.000

-- 101 102... chính là tham số định dạng
SELECT CONVERT(varchar,'01/14/2022',101) -- mm/dd/yyyy
SELECT CONVERT(datetime,'2022.01.14',102) -- yyy.mm.dd
SELECT CONVERT(datetime,'14/01/2022',103) -- dd/mm/yyy
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
SELECT ASIN(1) as [ASIN(1)],ACOS(1) as [ACOS(1)],ATAN(1) as [ATAN(1)];

-- 2.2 Các hàm xử lý chuỗi làm việc với kiểu chuỗi
/*
 LEN(string)  Trả về số lượng ký tự trong chuỗi, tính cả ký tự trắng đầu chuỗi
 LTRIM(string) Loại bỏ khoảng trắng bên trái
 RTRIM(string)  Loại bỏ khoảng trắng bên phải
 LEFT(string,length) Cắt chuỗi theo vị trí chỉ định từ trái
 RIGHT(string,legnth) Cắt chuỗi theo vị trí chỉ định từ phải
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
VALUES(N'Nguyễn Văn Chương'),(N'Tô Ngọc Hùng')
SELECT TenNV,
CHARINDEX(' ',TenNV) AS 'CHARINDEX',
LEN(TenNV) AS 'LEN',
LEFT(TenNV,CHARINDEX(' ',TenNV)-1) AS N'Họ',
RIGHT(TenNV,LEN(TenNV)-CHARINDEX(' ',TenNV)) AS N'Tên'
FROM @Name1_Talbe