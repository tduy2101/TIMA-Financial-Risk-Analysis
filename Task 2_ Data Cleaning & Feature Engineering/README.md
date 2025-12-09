# Task 2: Data Cleaning & Feature Engineering

## 📝 Mô tả nhiệm vụ
Sử dụng **Python** để xử lý bộ dữ liệu thô (Raw CRM Data) chứa nhiều nhiễu, giá trị thiếu và định dạng không đồng nhất, chuẩn bị sẵn sàng cho việc phân tích và modeling.

## 🔧 Kỹ thuật áp dụng
1.  **Data Cleaning:**
    * [cite_start]**Xử lý Missing Values:** Impute giá trị thiếu bằng Median (cho biến số) và Mode (cho biến phân loại). [cite: 3, 5]
    * [cite_start]**Regex Cleaning:** Chuẩn hóa cột *Salary* (loại bỏ ký tự lạ, đưa về dạng số) và *Số điện thoại*. [cite: 23, 89]
    * [cite_start]**Deduplication:** Loại bỏ các bản ghi trùng lặp dựa trên LoanID và thông tin khách hàng. [cite: 6, 8]

2.  [cite_start]**Feature Engineering (Tạo biến mới):** [cite: 45, 47]
    * `CustomerAge`: Tính tuổi từ ngày sinh.
    * `LoanDuration`: Tính kỳ hạn vay (Ngày kết thúc - Ngày bắt đầu).
    * `IncomeBin`, `AgeGroup`: Phân nhóm thu nhập và độ tuổi.

3.  **Outlier Detection:**
    * [cite_start]Sử dụng phương pháp **IQR (Interquartile Range)** để phát hiện và xử lý các giá trị điểm tín dụng bất thường. [cite: 63]

4.  **Standardization:**
    * [cite_start]Chuẩn hóa dữ liệu (Scaling) sử dụng `StandardScaler` cho các mô hình học máy. [cite: 68]

## 💻 File đính kèm
* `handle_raw_data.ipynb`: Notebook chứa toàn bộ code xử lý.
* `Tima_CRM_Cleaned.csv`: Dữ liệu đầu ra đã làm sạch.

