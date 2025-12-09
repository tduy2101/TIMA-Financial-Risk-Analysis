# Task 11: Predictive Modeling & Optimization (Xây dựng & Tối ưu Mô hình)

## 📖 Tổng quan
Trong Task 11, chúng ta tập trung xây dựng các mô hình Học máy (Machine Learning) để giải quyết các bài toán nghiệp vụ cốt lõi của TIMA: Quản trị rủi ro và Tối ưu hóa kinh doanh.

Notebook này triển khai quy trình khép kín từ Tiền xử lý dữ liệu, Feature Engineering, Huấn luyện mô hình đến Đánh giá hiệu quả.

## 🤖 Các mô hình đã xây dựng
Notebook `TIMA_Predictation.ipynb` bao gồm 4 mô hình chính:

### 1. Dự báo Trạng thái Khoản vay (Loan Status Prediction)
* **Mục tiêu:** Dự đoán xem một khoản vay sẽ được trả **"Đúng hạn"** hay **"Trễ hạn"**.
* **Thuật toán:** `RandomForestClassifier`.
* **Biến mục tiêu:** `Loan_Status` (được tạo từ `TrangThai`).
* **Kỹ thuật:** Sử dụng `class_weight='balanced'` để xử lý chênh lệch số lượng mẫu.

### 2. Phân tầng Rủi ro Khách hàng (Risk Level Segmentation)
* **Mục tiêu:** Phân loại khách hàng vào 3 nhóm rủi ro: **Cao - Trung bình - Thấp**.
* **Feature Engineering:** Tạo biến `Risk_Level` dựa trên logic kết hợp giữa *Điểm tín dụng (Credit Score)* và *Lịch sử nợ xấu (HasBadDebt)*.
* **Thuật toán:** `RandomForestClassifier` (Multi-class).
* **Ứng dụng:** Giúp bộ phận thẩm định áp dụng chính sách duyệt vay khác nhau cho từng nhóm.

### 3. Dự báo Khả năng Nợ xấu (Bad Debt Prediction)
* **Mục tiêu:** Phát hiện sớm các khách hàng có nguy cơ bùng nợ (`HasBadDebt = 1`).
* **Thuật toán:** `LogisticRegression`.
* **Đặc điểm:** Đây là mô hình quan trọng nhất trong quản trị rủi ro tín dụng.
* **Metric đánh giá:** Tập trung vào **Recall** (để không bỏ sót khách hàng rủi ro) và **ROC-AUC**.

### 4. Gợi ý Sản phẩm Tín dụng (Product Recommendation)
* **Mục tiêu:** Dự đoán sản phẩm vay phù hợp nhất (`ProductCreditName`) dựa trên profile khách hàng (Tuổi, Lương, Nghề nghiệp...).
* **Thuật toán:** `RandomForestClassifier`.
* **Ứng dụng:** Hỗ trợ nhân viên sales tư vấn đúng sản phẩm, tăng tỷ lệ chốt sale (Conversion Rate).

## 🛠 Kỹ thuật & Công nghệ
* **Pipeline:** Sử dụng `sklearn.pipeline.Pipeline` và `ColumnTransformer` để tự động hóa quy trình xử lý dữ liệu (Chuẩn hóa `StandardScaler` cho biến số, Mã hóa `OneHotEncoder` cho biến phân loại).
* **Imputation:** Xử lý dữ liệu thiếu bằng Trung vị (Median) cho Lương và 0 cho Quá hạn.
* **Evaluation Metrics:**
    * `Classification Report`: Xem chi tiết Precision, Recall, F1-Score.
    * `ROC-AUC`: Đánh giá khả năng phân loại của mô hình.

## 🚀 Hướng dẫn chạy code
1.  Đảm bảo file dữ liệu đã xử lý `Tima_CRM_Handled.csv` nằm trong cùng thư mục.
2.  Cài đặt các thư viện cần thiết: `pandas`, `numpy`, `scikit-learn`, `matplotlib`, `seaborn`.
3.  Chạy toàn bộ notebook `TIMA_Predictation.ipynb`.
4.  Kết quả đánh giá (Report) sẽ được in ra ở cuối mỗi phần mô hình.

---
**Author:**  Hoàng Thái Duy
**Project:** TIMA Financial Analysis
