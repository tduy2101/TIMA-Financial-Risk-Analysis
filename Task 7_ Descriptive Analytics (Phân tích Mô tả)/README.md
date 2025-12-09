# Task 7: Descriptive Analytics (Phân tích Mô tả)

## 📖 Tổng quan
Trong bước này, chúng ta sử dụng các kỹ thuật thống kê mô tả (Descriptive Statistics) để tóm tắt các đặc điểm chính của bộ dữ liệu TIMA. Mục tiêu là hiểu rõ "Dữ liệu đang nói gì" thông qua các con số trung bình, độ lệch chuẩn, phân phối và mối tương quan cơ bản.

## 📊 Các nội dung phân tích chính
Notebook `TIMA_DescriptiveAnalytics.ipynb` thực hiện 25 yêu cầu phân tích theo tài liệu dự án, chia làm các nhóm sau:

### 1. Thống kê xu hướng trung tâm & Phân tán
* **Trung bình (Mean):** Tính số tiền vay trung bình, Tuổi trung bình, Thời gian sống trung bình tại địa phương.
* **Tổng (Sum):** Tổng số tiền đã giải ngân, Tổng lãi suất theo từng khu vực.
* **Độ lệch chuẩn (Std):** Đánh giá mức độ biến động của Lãi suất.
* **Phân vị & Min/Max:** Tìm Top 5 khoản vay cao nhất và Top 5 lãi suất thấp nhất.

### 2. Phân tích phân phối (Distribution)
* **Histogram:**
    * Phân phối *Thu nhập (Salary)*: Xem mức thu nhập phổ biến của khách hàng.
    * Phân phối *Điểm tín dụng (Credit Score)*: Đánh giá chất lượng tệp khách hàng.
* **Bar Chart:** Tần suất khách hàng theo *Giới tính*, *Nhóm tuổi (Age Group)*.

### 3. Phân tích theo nhóm (Segmentation)
* **Theo Địa lý:** Số lượng hồ sơ và Tổng khoản vay theo *Thành phố (City)* và *Phường/Xã (Ward)*.
* **Theo Nghề nghiệp:** So sánh số tiền vay trung bình giữa các nhóm ngành nghề (Giáo viên, Công nhân, Kinh doanh...).
* **Theo Hình thức cư trú:** Phân loại khách hàng dựa trên thời gian sinh sống tại địa phương.

### 4. Phân tích tương quan (Correlation)
* **Scatter Plot:** Mối quan hệ giữa *Thu nhập* và *Điểm tín dụng*.
* **Heatmap:** Ma trận tương quan giữa *Lãi suất* và *Điểm tín dụng*.
* **Logic Rủi ro:** Đếm số lượng và tỷ lệ khách hàng có *Nợ xấu (Bad Debt)*.

## 🛠 Kỹ thuật & Thư viện sử dụng
* **Pandas:** Sử dụng linh hoạt `groupby()`, `pivot_table`, `value_counts()`, `describe()`, `nlargest/nsmallest`.
* **Data Transformation:** Xử lý dữ liệu dạng văn bản (VD: "Dưới 6 tháng", "1-3 năm") sang dạng số để tính toán thống kê.
* **Matplotlib & Seaborn:** Trực quan hóa các phân phối và tương quan.

## 🚀 Hướng dẫn chạy code
1.  Đảm bảo file dữ liệu sạch `Tima_CRM_Handled_Python.csv` (từ Task 2/6) đã có trong thư mục `Data`.
2.  Mở file `TIMA_DescriptiveAnalytics.ipynb`.
3.  Chạy toàn bộ cells để xem các con số thống kê và biểu đồ.

## 💡 Key Insights (Kết quả sơ bộ)
* *Đang cập nhật... (Ví dụ: Đa số khách hàng có điểm tín dụng tập trung ở mức 550-650; Nhóm khách hàng "Kinh doanh tự do" có nhu cầu vay vốn cao nhất...)*

---
**Author:**  Hoàng Thái Duy
**Project:** TIMA Financial Analysis
