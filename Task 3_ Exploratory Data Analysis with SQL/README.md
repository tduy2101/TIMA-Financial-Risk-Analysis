# Task 3: Exploratory Data Analysis with SQL

## 📝 Mô tả nhiệm vụ
Sử dụng **SQL (T-SQL)** để truy vấn dữ liệu sâu, trả lời các câu hỏi nghiệp vụ (Business Questions) và kiểm chứng các giả thuyết đã đặt ra ở Task 1.

## 🔍 Nội dung phân tích
1.  **Phân tích hiệu quả giải ngân:**
    * [cite_start]So sánh tỷ lệ *Giải ngân* vs *Đăng ký vay* theo từng Sản phẩm và Thành phố. [cite: 183, 184]
    * Xác định các điểm nóng (Hotspots) có tỷ lệ giải ngân thấp.

2.  **Phân tích rủi ro & Nợ xấu:**
    * [cite_start]Truy vấn danh sách khách hàng có nợ xấu (`HasBadDebt`) theo Phân khúc thu nhập và Nghề nghiệp. [cite: 213, 214]
    * [cite_start]Phân tích xu hướng *Quá hạn (Overdue)* theo thời gian (30 ngày, 90 ngày). [cite: 231]

3.  **Phân tích hồ sơ khách hàng (Customer Profiling):**
    * [cite_start]Phân tích đa chiều: *Độ tuổi - Giới tính - Khu vực địa lý*. [cite: 201, 203]
    * [cite_start]Đánh giá mối liên hệ giữa *Điểm tín dụng (Credit Score)* và *Hành vi trả nợ*. [cite: 198]

## 💡 Key SQL Techniques
* **Aggregation:** `GROUP BY`, `SUM`, `AVG`, `COUNT`.
* **Window Functions:** Xếp hạng và phân nhóm dữ liệu.
* **CTE (Common Table Expressions):** Tạo bảng tạm để xử lý các logic phức tạp.
* **Data Validation Logic:** Lọc sạch các dữ liệu phi logic (VD: Tiền giải ngân > Tiền đăng ký) ngay trong câu lệnh.

## 💻 File đính kèm
* `TIMA_QUERY.sql`: File chứa toàn bộ script truy vấn.
