SELECT TOP (100) *
FROM [dbo].[Tima_CRM_Handled]

EXEC sp_rename N'dbo.Tima_CRM_Handled.[Số_tiền_đăng_ký_vay_ban_đầu]', 'SoTienDangKy', 'COLUMN';
EXEC sp_rename N'dbo.Tima_CRM_Handled.[Tiền_giải_ngân]', 'TienGiaiNgan', 'COLUMN';
EXEC sp_rename N'dbo.Tima_CRM_Handled.[Tiền_gốc_còn_lại]', 'TienGocConLai', 'COLUMN';
EXEC sp_rename N'dbo.Tima_CRM_Handled.[Trạng_thái]', 'TrangThai', 'COLUMN';
EXEC sp_rename N'dbo.Tima_CRM_Handled.[Số_điện_thoại_khách_hàng]', '', 'COLUMN';

DELETE FROM Tima_CRM_Handled
WHERE TienGiaiNgan > SoTienDangKy;

--1. Truy vấn về số tiền vay ban đầu và giải ngân
--Tính tổng số tiền đăng ký vay ban đầu (SoTienDKVayBanDau) theo từng loại sản phẩm tín dụng (ProductCreditName) và so sánh với tổng tiền giải ngân (TienGiaiNgan).
SELECT ProductCreditName,
	SUM(SoTienDangKy) AS TONG_VAY
FROM Tima_CRM_Handled
GROUP BY ProductCreditName
ORDER BY TONG_VAY DESC

--- Hiển thị danh sách các khoản vay có tỷ lệ giải ngân thấp hơn 50% (SoTienGiaiNgan / SoTienDKVayBanDau < 0.5) và phân tích theo thành phố (CityName).
SELECT 
    CityName, 
    ROUND(AVG(TienGiaiNgan * 100.0 / SoTienDangKy), 2) AS [TỈ LỆ GIẢI NGÂN (%)]
FROM 
    Tima_CRM_Handled
WHERE 
    SoTienDangKy > 0 AND
    (TienGiaiNgan * 1.0 / SoTienDangKy) < 0.5
GROUP BY 
    CityName
ORDER BY 
    [TỈ LỆ GIẢI NGÂN (%)] DESC;

--- Tính mức chênh lệch giữa số tiền đăng ký vay ban đầu và số tiền còn lại (SoTienConLai) cho mỗi khách hàng, và phân loại theo độ tuổi khách hàng (Age = Thời gian đã sống).
SELECT 
    FullName,
    SoTienDangKy,
    TienGocConLai,
    (SoTienDangKy - TienGocConLai) AS ChenhLechTien,
	CustomerAge,
    CASE
        WHEN CustomerAge < 25 THEN 'Dưới 25'
        WHEN CustomerAge BETWEEN 25 AND 34 THEN '25-34'
        WHEN CustomerAge BETWEEN 35 AND 44 THEN '35-44'
        WHEN CustomerAge BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS DoTuoi
FROM 
    Tima_CRM_Handled
WHERE 
    SoTienDangKy IS NOT NULL AND TienGocConLai IS NOT NULL;

--- Phân tích các khoản vay có mức giải ngân cao nhất so với số tiền vay ban đầu, theo từng quận (DistrictName) và giới tính (Gender).
SELECT STT,
    DistrictName,
    Gender,
    FullName,
    SoTienDangKy,
    TienGiaiNgan,
    ROUND(TienGiaiNgan * 100.0 / SoTienDangKy, 2) AS TyLeGiaiNgan
FROM 
    Tima_CRM_Handled
WHERE 
    SoTienDangKy > 0
    AND TienGiaiNgan IS NOT NULL
    AND Gender IS NOT NULL
    AND DistrictName IS NOT NULL
ORDER BY 
    ROUND(TienGiaiNgan * 1.0 / SoTienDangKy, 2) DESC;

SELECT *
FROM Tima_CRM_Handled
WHERE TienGiaiNgan > SoTienDangKy;


--- Tính tỷ lệ hoàn thành giải ngân (Số tiền giải ngân/Số tiền đăng ký vay) cho các khoản vay và xác định các yếu tố ảnh hưởng (ví dụ: nghề nghiệp, thành phố).

SELECT 
    JobName,
    CityName,
    COUNT(*) AS SoKhoanVay,
    ROUND(AVG(TienGiaiNgan * 100.0 / SoTienDangKy), 2) AS TyLeGiaiNganTB
FROM 
    Tima_CRM_Handled
WHERE 
    SoTienDangKy > 0 AND TienGiaiNgan IS NOT NULL
GROUP BY 
    JobName, CityName
ORDER BY 
    TyLeGiaiNganTB DESC;

--2. Truy vấn theo trạng thái và thông tin vay

--- Xác định tỷ lệ phần trăm các khoản vay đã trả hết (Trạng thái) theo các vùng địa lý khác nhau (CityName, DistrictName).
SELECT 
    CityName,
    COUNT(*) AS TongSoKhoanVay,
    SUM(CASE 
            WHEN LTRIM(RTRIM(TrangThai)) LIKE N'Kết thúc%' THEN 1 
            ELSE 0 
        END) AS SoKhoanDaTraHet,
    ROUND(
        100.0 * SUM(CASE 
                        WHEN LTRIM(RTRIM(TrangThai)) LIKE N'Kết thúc%' THEN 1 
                        ELSE 0 
                   END) / COUNT(*), 
        2
    ) AS TiLeDaTraHet_PhanTram
FROM 
    Tima_CRM_Handled
GROUP BY 
    CityName
ORDER BY 
    TiLeDaTraHet_PhanTram DESC;


--- Phân tích trạng thái khoản vay của khách hàng theo nhóm thu nhập (Salary) và loại công việc (JobName).
SELECT 
    JobName,
    CASE 
        WHEN Salary < 5000000 THEN N'Dưới 5 triệu'
        WHEN Salary BETWEEN 5000000 AND 10000000 THEN N'5-10 triệu'
        WHEN Salary BETWEEN 10000000 AND 20000000 THEN N'10-20 triệu'
        ELSE N'Trên 20 triệu'
    END AS NhomLuong,
    TrangThai,
    COUNT(*) AS SoLuong
FROM 
    Tima_CRM_Handled
WHERE 
    Salary IS NOT NULL AND JobName IS NOT NULL
GROUP BY 
    JobName, 
    CASE 
        WHEN Salary < 5000000 THEN N'Dưới 5 triệu'
        WHEN Salary BETWEEN 5000000 AND 10000000 THEN N'5-10 triệu'
        WHEN Salary BETWEEN 10000000 AND 20000000 THEN '10-20 triệu'
        ELSE N'Trên 20 triệu'
    END,
    TrangThai
ORDER BY 
    NhomLuong, JobName, TrangThai;

--- Tính tỷ lệ khoản vay quá hạn (Trạng thái = 'Quá hạn') theo các sản phẩm tín dụng và các yếu tố ảnh hưởng.
SELECT 
    ProductCreditName,
    CityName,
    JobName,
    COUNT(*) AS TongSoKhoanVay,
    SUM(CASE WHEN TrangThai = N'Nợ Xấu' THEN 1 ELSE 0 END) AS SoKhoanQuaHan,
    ROUND(
        100.0 * SUM(CASE WHEN TrangThai = N'Nợ Xấu' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS TiLeQuaHan_PhanTram
FROM 
    Tima_CRM_Handled
WHERE 
    ProductCreditName IS NOT NULL AND TrangThai IS NOT NULL
GROUP BY 
    ProductCreditName, CityName, JobName
ORDER BY 
    TiLeQuaHan_PhanTram DESC;

--Hiển thị các khoản vay có trạng thái 'Chưa giải ngân' và mối liên hệ với mức lương, số tiền vay
SELECT 
    FullName,
    Salary,
    SoTienDangKy AS SoTienDKVayBanDau,
    JobName,
    CityName,
    DistrictName
FROM 
    Tima_CRM_Handled
WHERE 
    TrangThai = N'Đang vay'
ORDER BY 
    Salary DESC, SoTienDangKy DESC;

--- Phân tích các khoản vay có trạng thái 'Đang vay' và tình hình trả nợ qua các tháng (InterestPaymentType).
SELECT 
    YEAR(ToDate) AS Nam,
    MONTH(ToDate) AS Thang,
    InterestPaymentType,
    COUNT(*) AS SoKhoanDangVay
FROM 
    Tima_CRM_Handled
WHERE 
    TrangThai = N'Đang vay'
GROUP BY 
    YEAR(ToDate), MONTH(ToDate), InterestPaymentType
ORDER BY 
    Nam, Thang;

--3. Truy vấn theo điểm tín dụng
--- Phân tích sự phân bố điểm tín dụng (TS_CREDIT_SCORE_V2) của khách hàng và so sánh theo nhóm thu nhập (Salary).
SELECT 
    CASE 
        WHEN Salary < 5000000 THEN N'<5 triệu'
        WHEN Salary BETWEEN 5000000 AND 10000000 THEN N'5-10 triệu'
        ELSE N'>10 triệu' 
    END AS NhomThuNhap,
    AVG(TS_CREDIT_SCORE_V2) AS DiemTrungBinh,
    COUNT(*) AS SoKH
FROM Tima_CRM_Handled
WHERE TS_CREDIT_SCORE_V2 IS NOT NULL
GROUP BY 
    CASE 
        WHEN Salary < 5000000 THEN N'<5 triệu'
        WHEN Salary BETWEEN 5000000 AND 10000000 THEN N'5-10 triệu'
        ELSE N'>10 triệu' 
    END

--- Hiển thị các khách hàng có điểm tín dụng (TS_CREDIT_SCORE_V2) dưới 500 và phân tích xu hướng quá hạn của họ.
SELECT 
    YEAR(application_date) AS Nam,
    MONTH(application_date) AS Thang,
    COUNT(*) AS SoKH_TinDungThap,
    SUM(CASE WHEN HasLatePayment = 1 THEN 1 ELSE 0 END) AS SoKH_QuaHan
FROM Tima_CRM_Handled
WHERE TS_CREDIT_SCORE_V2 < 500
GROUP BY YEAR(application_date), MONTH(application_date)
ORDER BY Nam, Thang

--- Xác định các yếu tố ảnh hưởng đến điểm tín dụng của khách hàng (Gender, CityName, Salary) qua một mô hình phân tích đa biến. (PYTHON)

--- Tính tỷ lệ các khách hàng có điểm tín dụng dưới 600 và so sánh với tỷ lệ nợ xấu (HasBadDebt).
SELECT 
    ROUND(SUM(CASE WHEN TS_CREDIT_SCORE_V2 < 600 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Tyle_DiemTD_Thap,
    ROUND(SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Tyle_NoXau
FROM Tima_CRM_Handled
WHERE TS_CREDIT_SCORE_V2 IS NOT NULL;

--- Hiển thị phân bố điểm tín dụng (TS_CREDIT_SCORE_V2) và phân tích theo trạng thái khoản vay (Trạng thái) và sản phẩm tín dụng.
SELECT 
    TrangThai,
    ProductCreditName,
    COUNT(*) AS SoKH,
    AVG(TS_CREDIT_SCORE_V2) AS Diem_Tin_Dung_TB,
    MIN(TS_CREDIT_SCORE_V2) AS Diem_Min,
    MAX(TS_CREDIT_SCORE_V2) AS Diem_Max
FROM Tima_CRM_Handled
WHERE TS_CREDIT_SCORE_V2 IS NOT NULL
GROUP BY TrangThai, ProductCreditName
ORDER BY TrangThai, ProductCreditName;

--4. Truy vấn theo thông tin khách hàng
--- Phân tích độ tuổi trung bình của khách hàng vay tiền theo thành phố (CityName) và khu vực (DistrictName).
SELECT 
    CityName, 
    DistrictName,
    COUNT(*) AS So_Khach_Hang,
    AVG(CustomerAge) AS Do_Tuoi_TB,
    MIN(CustomerAge) AS Tuoi_Nho_Nhat,
    MAX(CustomerAge) AS Tuoi_Lon_Nhat
FROM Tima_CRM_Handled
WHERE CustomerAge IS NOT NULL
GROUP BY CityName, DistrictName
ORDER BY CityName, DistrictName;

--- Hiển thị danh sách các khách hàng có số điện thoại trùng lặp và phân tích ảnh hưởng của họ đến các khoản vay đã giải ngân.
-- Danh sách số điện thoại bị trùng
WITH DuplicatedPhones AS (
SELECT SDT
FROM Tima_CRM_Handled
WHERE SDT IS NOT NULL
GROUP BY SDT
HAVING COUNT(*) > 1
)

-- Thống kê ảnh hưởng đến giải ngân
SELECT 
h.SDT,
COUNT(DISTINCT h.CardNumber) AS So_Khach_Hang,
SUM(h.TienGiaiNgan) AS Tong_Giai_Ngan
FROM Tima_CRM_Handled h
JOIN DuplicatedPhones d ON h.SDT = d.SDT
GROUP BY h.SDT
ORDER BY Tong_Giai_Ngan DESC;

--- Tính số lượng khách hàng theo từng nhóm giới tính (Gender) và phân tích theo tỷ lệ nợ xấu (HasBadDebt).
SELECT 
    Gender,
    COUNT(*) AS So_Khach_Hang,
    SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) AS So_KH_No_Xau,
    ROUND(SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_No_Xau
FROM Tima_CRM_Handled
WHERE Gender IS NOT NULL
GROUP BY Gender;

--- Phân tích mức độ ảnh hưởng của độ tuổi khách hàng (Thời gian đã sống) đến quyết định vay tiền, xác định các nhóm khách hàng có nguy cơ nợ xấu cao.
SELECT 
    CASE 
        WHEN CustomerAge < 25 THEN N'Dưới 25'
        WHEN CustomerAge BETWEEN 25 AND 35 THEN N'25-35'
        WHEN CustomerAge BETWEEN 36 AND 50 THEN N'36-50'
        ELSE N'Trên 50' 
    END AS Nhom_Tuoi,
    COUNT(*) AS So_Khach_Hang,
    SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) AS So_KH_No_Xau,
    ROUND(SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_No_Xau
FROM Tima_CRM_Handled
WHERE CustomerAge IS NOT NULL
GROUP BY 
    CASE 
        WHEN CustomerAge < 25 THEN N'Dưới 25'
        WHEN CustomerAge BETWEEN 25 AND 35 THEN N'25-35'
        WHEN CustomerAge BETWEEN 36 AND 50 THEN N'36-50'
        ELSE N'Trên 50' 
    END
ORDER BY Ti_Le_No_Xau DESC;

--- Hiển thị các khách hàng có thông tin địa chỉ trùng lặp (Street, WardName) và phân tích mức độ rủi ro của họ.
-- Các địa chỉ trùng
WITH DuplicatedAddresses AS (
    SELECT Street, WardName
    FROM Tima_CRM_Handled
    WHERE Street IS NOT NULL AND WardName IS NOT NULL
    GROUP BY Street, WardName
    HAVING COUNT(*) > 1
)

-- Phân tích rủi ro tại các địa chỉ này
SELECT 
    h.Street,
    h.WardName,
    COUNT(*) AS So_Khach_Hang,
    SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) AS So_KH_No_Xau,
    ROUND(SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_No_Xau
FROM Tima_CRM_Handled h
JOIN DuplicatedAddresses d ON h.Street = d.Street AND h.WardName = d.WardName
GROUP BY h.Street, h.WardName
ORDER BY Ti_Le_No_Xau DESC;

--5. Truy vấn theo địa chỉ
--- Phân tích các khách hàng sống tại các quận có tỷ lệ nợ xấu cao, và so sánh với các yếu tố như thu nhập, nghề nghiệp.
SELECT 
    T.DistrictName,
    COUNT(*) AS So_Khach_Hang,
    ROUND(SUM(CASE WHEN T.HasBadDebt = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_No_Xau,
    ROUND(AVG(Salary), 0) AS Thu_Nhap_TB,
    TopJobs.Nghe_Nghiep_Tieu_Bieu
FROM Tima_CRM_Handled T
CROSS APPLY (
    SELECT STRING_AGG(JobName, ', ') AS Nghe_Nghiep_Tieu_Bieu
    FROM (
        SELECT TOP 3 JobName
        FROM Tima_CRM_Handled
        WHERE DistrictName = T.DistrictName AND JobName IS NOT NULL
        GROUP BY JobName
        ORDER BY COUNT(*) DESC
    ) AS TopJobList
) AS TopJobs
WHERE T.DistrictName IS NOT NULL
GROUP BY T.DistrictName, TopJobs.Nghe_Nghiep_Tieu_Bieu
HAVING COUNT(*) > 20
ORDER BY Ti_Le_No_Xau DESC;




--- Tính số lượng khách hàng sống tại thành phố A và phân tích tỷ lệ giải ngân thành công trong từng khu vực quận.
SELECT 
    DistrictName,
    COUNT(*) AS So_Khach_Hang,
    SUM(CASE WHEN TrangThai = N'Kết thúc' THEN 1 ELSE 0 END) AS So_KH_Giai_Ngan,
    ROUND(SUM(CASE WHEN TrangThai = N'Kết thúc' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_Giai_Ngan
FROM Tima_CRM_Handled
WHERE CityName = N'Hà Nội'
GROUP BY DistrictName
ORDER BY Ti_Le_Giai_Ngan DESC;

--- Hiển thị danh sách khách hàng sống ở các phường có tên giống nhau và phân tích tỷ lệ trả nợ đúng hạn.
-- Tìm các tên phường trùng lặp giữa các quận/thành phố khác nhau
WITH DuplicatedWards AS (
    SELECT WardName
    FROM Tima_CRM_Handled
    WHERE WardName IS NOT NULL
    GROUP BY WardName
    HAVING COUNT(DISTINCT DistrictName + CityName) > 1
)

-- Phân tích tỷ lệ trả nợ đúng hạn ở các phường này
SELECT 
    WardName,
    COUNT(*) AS So_Khach_Hang,
    SUM(CASE WHEN HasLatePayment = 0 THEN 1 ELSE 0 END) AS So_KH_Tra_Dung_Han,
    ROUND(SUM(CASE WHEN HasLatePayment = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_Tra_Dung_Han
FROM Tima_CRM_Handled
WHERE WardName IN (SELECT WardName FROM DuplicatedWards)
GROUP BY WardName
ORDER BY Ti_Le_Tra_Dung_Han ASC;

--- Phân tích mức độ phân bố của các khách hàng tại các khu vực khác nhau và xu hướng vay vốn của họ.
SELECT 
    CityName,
    DistrictName,
    COUNT(*) AS So_Khach_Hang,
    SUM(CASE WHEN TrangThai = N'Kết thúc' THEN 1 ELSE 0 END) AS So_Giai_Ngan,
    ROUND(SUM(CASE WHEN TrangThai = N'Kết thúc' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_Vay_Thanh_Cong
FROM Tima_CRM_Handled
WHERE CityName IS NOT NULL AND DistrictName IS NOT NULL
GROUP BY CityName, DistrictName
ORDER BY CityName, Ti_Le_Vay_Thanh_Cong DESC;


--- Phân tích mối quan hệ giữa thành phố khách hàng sinh sống và khả năng thanh toán nợ (HasLatePayment).
SELECT 
    CityName,
    COUNT(*) AS So_Khach_Hang,
    SUM(CASE WHEN HasLatePayment = 1 THEN 1 ELSE 0 END) AS So_KH_Tra_Cham,
    ROUND(SUM(CASE WHEN HasLatePayment = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_Tra_Chan
FROM Tima_CRM_Handled
WHERE CityName IS NOT NULL
GROUP BY CityName
ORDER BY Ti_Le_Tra_Chan DESC;

--6. Truy vấn về công việc và thu nhập
--- Hiển thị tỷ lệ các khách hàng có lương dưới 10 triệu VND và tỷ lệ họ có nợ xấu (HasBadDebt).
SELECT 
    COUNT(*) AS So_Khach_Hang_Luong_Duoi_10tr,
    ROUND(SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_No_Xau
FROM Tima_CRM_Handled
WHERE Salary < 10000000;

--- Phân tích mối quan hệ giữa nghề nghiệp (JobName) và tỷ lệ quá hạn thanh toán nợ (LongestOverdue).
SELECT 
    JobName,
    COUNT(*) AS So_Khach_Hang,
    ROUND(AVG(CAST(LongestOverdue AS FLOAT)), 2) AS Ngay_Qua_Han_TB
FROM Tima_CRM_Handled
WHERE JobName IS NOT NULL AND LongestOverdue IS NOT NULL
GROUP BY JobName
ORDER BY Ngay_Qua_Han_TB DESC;

--- Tính tổng số tiền vay theo nhóm ngành nghề (JobName) và mức thu nhập (Salary).
SELECT 
    JobName,
    CASE 
        WHEN Salary < 5000000 THEN N'Dưới 5 triệu'
        WHEN Salary BETWEEN 5000000 AND 10000000 THEN N'5 - 10 triệu'
        WHEN Salary BETWEEN 10000001 AND 15000000 THEN N'10 - 15 triệu'
        ELSE N'Trên 15 triệu'
    END AS Nhom_Thu_Nhap,
    SUM(SoTienDangKy) AS Tong_Tien_Vay
FROM Tima_CRM_Handled
WHERE JobName IS NOT NULL AND Salary IS NOT NULL
GROUP BY JobName, 
    CASE 
        WHEN Salary < 5000000 THEN N'Dưới 5 triệu'
        WHEN Salary BETWEEN 5000000 AND 10000000 THEN N'5 - 10 triệu'
        WHEN Salary BETWEEN 10000001 AND 15000000 THEN N'10 - 15 triệu'
        ELSE N'Trên 15 triệu'
    END
ORDER BY Tong_Tien_Vay DESC;

--- Phân tích ảnh hưởng của loại công ty (NameCompany, CityCompany) đến khả năng trả nợ của khách hàng.
SELECT 
    NameCompany,
    CityCompany,
    COUNT(*) AS So_Khach_Hang,
    ROUND(SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_No_Xau
FROM Tima_CRM_Handled
WHERE NameCompany IS NOT NULL AND CityCompany IS NOT NULL
GROUP BY NameCompany, CityCompany
HAVING COUNT(*) >= 10
ORDER BY Ti_Le_No_Xau DESC;

--- Xác định các nhóm thu nhập có nguy cơ nợ xấu cao và phân tích thông tin về công ty nơi khách hàng làm việc.
SELECT 
    CASE 
        WHEN Salary < 5000000 THEN N'Dưới 5 triệu'
        WHEN Salary BETWEEN 5000000 AND 10000000 THEN N'5 - 10 triệu'
        WHEN Salary BETWEEN 10000001 AND 15000000 THEN N'10 - 15 triệu'
        ELSE N'Trên 15 triệu'
    END AS Nhom_Thu_Nhap,
    COUNT(*) AS So_Khach_Hang,
    ROUND(SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_No_Xau,
    MAX(NameCompany) AS Cong_Ty_Tieu_Bieu
FROM Tima_CRM_Handled
WHERE Salary IS NOT NULL AND NameCompany IS NOT NULL
GROUP BY 
    CASE 
        WHEN Salary < 5000000 THEN N'Dưới 5 triệu'
        WHEN Salary BETWEEN 5000000 AND 10000000 THEN N'5 - 10 triệu'
        WHEN Salary BETWEEN 10000001 AND 15000000 THEN N'10 - 15 triệu'
        ELSE N'Trên 15 triệu'
    END
ORDER BY Ti_Le_No_Xau DESC;

--7. Truy vấn về thông tin gia đình
--- Phân tích ảnh hưởng của người thân trong gia đình (RelativeFamilyName) đến quyết định vay tiền và tình hình nợ xấu.
SELECT 
    RelativeFamilyName,
    COUNT(*) AS So_Khach_Hang,
    ROUND(SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_No_Xau
FROM Tima_CRM_Handled
WHERE RelativeFamilyName IS NOT NULL
GROUP BY RelativeFamilyName
HAVING COUNT(*) >= 10
ORDER BY Ti_Le_No_Xau DESC;

--- Hiển thị các khách hàng có người thân vay tiền tại công ty và xác định mối liên hệ giữa việc vay của họ và quá hạn thanh toán.
SELECT 
    KH1.CardNumber AS CustomerID,
    KH1.FullName AS KhachHang,
    KH1.HasBadDebt AS NoXau_KhachHang,
    KH1.LongestOverdue AS Ngay_QuaHan_KhachHang,
    
    KH1.FullNameFamily AS TenNguoiThan,
    KH2.CardNumber AS CustomerID_NguoiThan,
    KH2.HasBadDebt AS NoXau_NguoiThan,
    KH2.LongestOverdue AS Ngay_QuaHan_NguoiThan
FROM Tima_CRM_Handled KH1
JOIN Tima_CRM_Handled KH2
    ON KH1.FullNameFamily = KH2.FullName
WHERE KH1.FullNameFamily IS NOT NULL;


--- Xác định các nhóm khách hàng có người thân là giám đốc và phân tích tỷ lệ nợ xấu và thanh toán đúng hạn.
SELECT 
    COUNT(*) AS So_Khach_Hang,
    ROUND(SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_No_Xau,
    ROUND(SUM(CASE WHEN HasBadDebt = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_Thanh_Toan_Dung_Han
FROM Tima_CRM_Handled
WHERE JobName LIKE N'%Giám đốc%';

--- Phân tích tác động của người thân (FullNameFamily) đến mức độ tín nhiệm khi vay tiền.
SELECT 
    FullNameFamily,
    COUNT(*) AS So_Khach_Hang,
    ROUND(AVG(TS_CREDIT_SCORE_V2), 2) AS Diem_Tin_Dung_TB,
    ROUND(SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_No_Xau
FROM Tima_CRM_Handled
WHERE FullNameFamily IS NOT NULL AND TS_CREDIT_SCORE_V2 IS NOT NULL
GROUP BY FullNameFamily
HAVING COUNT(*) >= 5
ORDER BY Diem_Tin_Dung_TB DESC;

--- Hiển thị các khách hàng có người thân sống tại cùng khu vực (CityNameHouseHold) và tỷ lệ họ thanh toán đúng hạn.
SELECT 
    CityNameHouseHold,
    COUNT(*) AS So_Khach_Hang,
    ROUND(SUM(CASE WHEN HasBadDebt = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Ti_Le_Thanh_Toan_Dung_Han
FROM Tima_CRM_Handled
WHERE CityNameHouseHold IS NOT NULL
GROUP BY CityNameHouseHold
HAVING COUNT(*) >= 10
ORDER BY Ti_Le_Thanh_Toan_Dung_Han DESC;

--7. Truy vấn về sản phẩm tín dụng
--- Phân tích các khoản vay theo từng loại sản phẩm tín dụng (ProductCreditName) và tính tỷ lệ hoàn trả đúng hạn.
SELECT 
    ProductCreditName,
    COUNT(*) AS TongKhoanVay,
    SUM(CASE WHEN HasBadDebt = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS TiLeTraDungHan
FROM Tima_CRM_Handled
GROUP BY ProductCreditName
ORDER BY TiLeTraDungHan DESC;

--- Hiển thị tỷ lệ các khoản vay có sản phẩm tín dụng ‘Vay tiêu dùng’ và tỷ lệ nợ xấu so với các sản phẩm khác.
SELECT 
    CASE 
        WHEN ProductCreditName = N'Vay%' THEN N'Vay tiêu dùng'
        ELSE N'Khác'
    END AS NhomSanPham,
    COUNT(*) AS SoLuong,
    SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS TiLeNoXau
FROM Tima_CRM_Handled
GROUP BY 
    CASE 
        WHEN ProductCreditName = N'Vay%' THEN N'Vay tiêu dùng'
        ELSE N'Khác'
    END;

SELECT DISTINCT ProductCreditName
FROM Tima_CRM_Handled

--- Tính tổng số tiền vay cho mỗi loại sản phẩm tín dụng (ProductCreditName) và so sánh với tỷ lệ giải ngân.
SELECT 
    ProductCreditName,
    SUM(SoTienDangKy) AS TongTienVay,
    SUM(TienGiaiNgan) * 1.0 / SUM(SoTienDangKy) AS TiLeGiaiNgan
FROM Tima_CRM_Handled
GROUP BY ProductCreditName
ORDER BY TongTienVay DESC;

--- Xác định các sản phẩm tín dụng có tỷ lệ quá hạn thanh toán cao nhất và phân tích mối liên hệ với điểm tín dụng (TS_CREDIT_SCORE_V2).
SELECT 
    ProductCreditName,
    AVG(TS_CREDIT_SCORE_V2) AS DiemTinDungTB,
    AVG(LongestOverdue) AS NgayQuaHanTB,
    COUNT(*) AS SoLuongKhoanVay
FROM Tima_CRM_Handled
WHERE LongestOverdue IS NOT NULL
GROUP BY ProductCreditName
ORDER BY NgayQuaHanTB DESC;

--- Phân tích các khách hàng vay ‘Vay mua nhà’ và tình trạng nợ xấu của họ theo từng thành phố và khu vực.
SELECT 
    CityName,
    DistrictName,
    COUNT(*) AS SoLuongKH,
    SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS TiLeNoXau
FROM Tima_CRM_Handled
WHERE ProductCreditName = N'Cầm cố xe máy'
GROUP BY CityName, DistrictName
ORDER BY TiLeNoXau DESC;

--9. Truy vấn về lịch sử vay và quá hạn
--- Phân tích các khoản vay có quá hạn (LongestOverdue) từ 3 đến 6 tháng và các yếu tố ảnh hưởng đến sự quá hạn này (Salary, CityName).
SELECT 
    CardNumber,
    Salary,
    CityName,
    LongestOverdue
FROM Tima_CRM_Handled
WHERE LongestOverdue BETWEEN 3 AND 6;

--- Tính tỷ lệ quá hạn của các khách hàng đã từng vay nhiều lần (NumberOfLoans) so với lần vay đầu tiên.
SELECT 
    CASE 
        WHEN NumberOfLoans > 1 THEN N'Đã vay nhiều lần'
        ELSE N'Lần vay đầu tiên'
    END AS NhomKhachHang,
    COUNT(*) AS SoLuong,
    SUM(CASE WHEN HasLatePayment = 1 THEN 1 ELSE 0 END)*1.0 / COUNT(*) AS TiLeQuaHan
FROM Tima_CRM_Handled
GROUP BY 
    CASE 
        WHEN NumberOfLoans > 1 THEN N'Đã vay nhiều lần'
        ELSE N'Lần vay đầu tiên'
    END;

--- Hiển thị các khoản vay có quá hạn từ 6 tháng trở lên và phân tích các yếu tố như sản phẩm tín dụng, địa chỉ công ty.
SELECT 
    CardNumber,
    ProductCreditName,
    NameCompany,
    CityCompany,
    LongestOverdue
FROM Tima_CRM_Handled
WHERE LongestOverdue >= 6;

--- Xác định các khách hàng có số lần quá hạn cao nhất và phân tích theo độ tuổi, nghề nghiệp và thu nhập.
SELECT TOP 10 
    CardNumber,
    CustomerAge,
    JobName,
    Salary,
    SUM(CASE WHEN HasLatePayment = 1 THEN 1 ELSE 0 END) AS LatePaymentCount
FROM Tima_CRM_Handled
GROUP BY 
    CardNumber,
    CustomerAge,
    JobName,
    Salary
ORDER BY LatePaymentCount DESC;

--- Phân tích tình trạng quá hạn của các khoản vay và tìm kiếm các mối liên hệ với số tiền vay ban đầu và trạng thái khoản vay.
SELECT 
    HasLatePayment,
    TrangThai, -- nếu có cột này
    AVG(SoTienDangKy) AS AvgLoanAmount,
    AVG(LongestOverdue) AS AvgOverdueMonth
FROM Tima_CRM_Handled
GROUP BY HasLatePayment, TrangThai;

--10. Truy vấn về nợ xấu và thanh toán
--- Hiển thị các khoản vay có nợ xấu (HasBadDebt = True) và phân tích theo sản phẩm tín dụng và thành phố.
SELECT 
    ProductCreditName,
    CityName,
    COUNT(*) AS TotalBadDebt
FROM Tima_CRM_Handled
WHERE HasBadDebt = 1
GROUP BY ProductCreditName, CityName
ORDER BY TotalBadDebt DESC;

--- Tính tỷ lệ các khoản vay không có nợ xấu và phân tích các yếu tố ảnh hưởng như mức lương và thời gian vay.
SELECT 
    Salary,
    LoanDuration,
    COUNT(*) AS TotalNoBadDebt,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM Tima_CRM_Handled), 2) AS PercentNoBadDebt
FROM Tima_CRM_Handled
WHERE HasBadDebt = 0
GROUP BY Salary, LoanDuration
ORDER BY TotalNoBadDebt DESC;

--- Phân tích các khoản vay có thanh toán chậm (HasLatePayment) theo nhóm khách hàng và các đặc điểm như giới tính, nghề nghiệp.
SELECT 
    Gender,
    JobName,
    COUNT(*) AS LatePaymentCount
FROM Tima_CRM_Handled
WHERE HasLatePayment = 1
GROUP BY Gender, JobName
ORDER BY LatePaymentCount DESC;

--- Hiển thị các khoản vay có nợ xấu và tỷ lệ quá hạn thanh toán, phân tích mối quan hệ với các yếu tố địa lý và thu nhập.
SELECT 
    CityName,
    Salary,
    COUNT(*) AS TotalBadDebt,
    SUM(CASE WHEN HasLatePayment = 1 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS LatePaymentRate
FROM Tima_CRM_Handled
WHERE HasBadDebt = 1
GROUP BY CityName, Salary
ORDER BY TotalBadDebt DESC;

--- Tính tỷ lệ khách hàng có nợ xấu sau 1 năm vay và phân tích theo các nhóm độ tuổi và nghề nghiệp.
SELECT 
    CustomerAge,
    JobName,
    COUNT(*) AS TotalLoans,
    SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) AS BadDebtCount,
    ROUND(100.0 * SUM(CASE WHEN HasBadDebt = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS BadDebtRate
FROM Tima_CRM_Handled
WHERE DATEDIFF(MONTH, FromDate, GETDATE()) >= 12
GROUP BY CustomerAge, JobName
ORDER BY BadDebtRate DESC;



--==============================================================================================================================
