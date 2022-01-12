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
SET @Max_Luong = (SELECT MAX(LuongNV) FROM nhanvien)
-- SELECT @Max_Luong
PRINT @Max_Luong
PRINT N'Nhân viên có lương lớn nhất là: ' + CONVERT(NVARCHAR(12),@Max_Luong)

-- 1.4 Biến Bảng 
DECLARE @NhanVien_Table TABLE (MaNV NVARCHAR(9),TenNV NVARCHAR(20))
--Chèn dữ liệu vào biến bảng
-- Insert rows into table 'TableName' in schema '[dbo]'
INSERT INTO @NhanVien_Table
SELECT MaNhanVien,TenNV 
FROM nhanvien
WHERE DiaChi LIKE '%HCM'

SELECT * FROM @NhanVien_Table
-- Nếu muốn truy cập đến từng cột chỉ định của biến bảng
SELECT TenNV FROM @NhanVien_Table

-- 1.5  CHÈN DỮ LIỆU VÀO BIẾN BẢNG
DECLARE @NhanVien_Table1 TABLE (MaNV int,TenNV NVARCHAR(20))
-- Chèn dữ liệu vào biến bảng
INSERT INTO @NhanVien_Table1 VALUES(1,N'Nguyễn Văn Chương')
SELECT * FROM @NhanVien_Table1