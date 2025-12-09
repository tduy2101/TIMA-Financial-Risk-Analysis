# TIMA Financial Data Analysis Project 📊🚀

## 📖 Giới thiệu (Introduction)
Dự án phân tích dữ liệu toàn diện cho **TIMA** - Sàn kết nối tài chính P2P Lending lớn nhất Việt Nam.
Dự án áp dụng quy trình phân tích dữ liệu từ đầu đến cuối (**End-to-End Data Analysis**), từ việc làm sạch dữ liệu thô, trực quan hóa insight đến xây dựng các mô hình Học máy (Machine Learning) để dự báo rủi ro tín dụng và đề xuất chiến lược kinh doanh.

* **Vai trò:** Data Analyst / Data Scientist
* **Công cụ:** Python (Pandas, Scikit-learn), SQL, Power BI.
* **Kết quả:** Báo cáo chiến lược & Hệ thống mô hình hỗ trợ ra quyết định (Decision Support System).

---

## 🎯 Mục tiêu Dự án (Objectives)
1.  **Business Intelligence:** Đánh giá hiệu suất kinh doanh, tỷ lệ giải ngân và chân dung khách hàng.
2.  **Risk Management:** Phân tích các yếu tố ảnh hưởng đến nợ xấu (NPL) và xây dựng hệ thống cảnh báo sớm.
3.  **Predictive Modeling:** Dự báo khả năng vỡ nợ (Default Probability) và đề xuất hạn mức tín dụng tối ưu.
4.  **Strategic Recommendation:** Đưa ra các giải pháp phân luồng phê duyệt hồ sơ tự động để tối đa hóa lợi nhuận.

---

## 🗂 Cấu trúc Dự án (Project Structure)

### 📂 1. Data Understanding & Preparation
* **Task 1 - Overview:** Tìm hiểu nghiệp vụ P2P, xác định KPIs (Ticket Size, Approval Rate, NPL Ratio) và Data Dictionary.
* **Task 2 - Data Cleaning (Python):**
    * Xử lý dữ liệu thô (Raw CRM Data).
    * Kỹ thuật: Regex (xử lý SĐT, Lương), Imputation (điền giá trị thiếu), Deduplication.
    * Feature Engineering: Tạo biến `CustomerAge`, `LoanDuration`, `IncomeBin`.

### 📂 2. Exploratory Data Analysis (EDA)
* **Task 3 - SQL Analysis:** Truy vấn dữ liệu để trả lời các câu hỏi nghiệp vụ (Ad-hoc Analysis).
* **Task 6 & 7 - Descriptive Analytics:**
    * Phân tích phân phối (Distribution) của Khoản vay và Thu nhập.
    * Trực quan hóa mối tương quan (Correlation) giữa Điểm tín dụng và Lãi suất.
* **Task 8 - Diagnostic Analytics:** Kiểm định giả thuyết (Hypothesis Testing) về mối quan hệ giữa Giới tính/Khu vực và Rủi ro nợ xấu.

### 📂 3. Data Visualization (Power BI)
* **Dashboarding:** Xây dựng báo cáo tương tác trên Power BI (`TIMA_PJ.pbix`).
* **Key Visuals:**
    * Tổng quan hiệu suất kinh doanh (Overview).
    * Phân tích rủi ro tín dụng (Risk Analysis).
    * Phân tích hành vi khách hàng (Customer Profile).

### 📂 4. Predictive & Prescriptive Modeling
* **Task 9 - Forecasting:** Dự báo xu hướng giải ngân (Time Series) và Số tiền vay tiềm năng (Regression).
* **Task 11 & 12 - Classification Models:**
    * Xây dựng mô hình **Random Forest** & **Logistic Regression** để phân loại Nợ xấu.
    * Kỹ thuật: `SMOTE`/`Class_weight` xử lý mất cân bằng dữ liệu.
    * Kết quả: ROC-AUC > 0.9, Accuracy > 90%.
* **Task 10 - Prescriptive Analytics:**
    * Xây dựng hệ thống phân luồng phê duyệt: **Xanh (Duyệt ngay)** - **Vàng (Thẩm định)** - **Đỏ (Từ chối)**.
    * Mô phỏng tác động kinh doanh (Business Impact Simulation): Chứng minh lợi nhuận tăng thêm khi áp dụng mô hình.

---

## 🛠 Công nghệ & Thư viện (Tech Stack)
* **Ngôn ngữ:** Python 3.x, SQL.
* **Libraries:**
    * *Data Manipulation:* Pandas, NumPy.
    * *Visualization:* Matplotlib, Seaborn, Plotly.
    * *Machine Learning:* Scikit-learn, Statsmodels.
* **BI Tool:** Microsoft Power BI.

---

## 💡 Key Insights & Kết luận
1.  **Credit Score:** Là chỉ số dự báo rủi ro quan trọng nhất. Khách hàng có điểm tín dụng thấp (<500) có tỷ lệ nợ xấu cao vượt trội.
2.  **Sản phẩm:** "Vay theo đăng ký xe máy" là sản phẩm chủ lực nhưng cần chính sách kiểm soát chặt chẽ hơn ở các tỉnh thành có tỷ lệ nợ xấu cao.
3.  **Tối ưu quy trình:** Việc áp dụng mô hình phân loại tự động giúp giảm 30% thời gian thẩm định thủ công và giảm thiểu rủi ro nợ xấu đáng kể.

---

## 📬 Liên hệ (Contact)
* **Author:** Hoàng Thái Duy
* **Email:** hoangthaiduy210104@gmail.com

*Dự án này là minh chứng cho khả năng kết hợp giữa tư duy kinh doanh (Business Mindset) và kỹ năng kỹ thuật (Technical Skills) để giải quyết các vấn đề thực tế.*
