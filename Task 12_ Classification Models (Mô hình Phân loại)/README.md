# Task 12: Classification Models (Mô hình Phân loại)

## 📖 Tổng quan
Trong Task 12, chúng ta tập trung vào việc xây dựng và chuẩn hóa các mô hình phân loại (Classification) để giải quyết các bài toán "Có/Không" (Binary Classification) trong quản trị rủi ro tín dụng.

Notebook này được thiết kế theo hướng **"Function-based"** (dựa trên hàm), cho phép huấn luyện và đánh giá nhanh chóng nhiều mô hình khác nhau với cùng một quy trình xử lý dữ liệu chuẩn.

## 🧠 Các bài toán phân loại đã giải quyết
Notebook `TIMA_ClassificationModels.ipynb` giải quyết 2 bài toán cốt lõi:

### 1. Phân loại Khách hàng có Lịch sử Nợ xấu (History of Bad Debt)
* **Biến mục tiêu:** `HasBadDebt` (1: Có, 0: Không).
* **Ý nghĩa:** Xác định các đặc điểm (Features) chung của nhóm khách hàng từng có nợ xấu để cảnh báo sớm.
* **Kết quả:** Đạt độ chính xác (Accuracy) ~93% và chỉ số ROC-AUC ~0.91.

### 2. Phân loại Khách hàng Trả chậm (Late Payment Prediction)
* **Biến mục tiêu:** `HasLatePayment` (1: Có, 0: Không).
* **Ý nghĩa:** Dự báo khả năng khách hàng sẽ thanh toán không đúng hạn (dù chưa đến mức nợ xấu) để bộ phận thu hồi nợ (Collection) có kế hoạch nhắc nợ phù hợp.
* **Kết quả:** Đạt độ chính xác ~90% và ROC-AUC ~0.94.

## 🛠 Phương pháp kỹ thuật (Methodology)

### 1. Automated Pipeline
Sử dụng `sklearn.pipeline` để đóng gói quy trình xử lý:
* **Dữ liệu số (Numerical):** Imputation (Median) -> Scaling (StandardScaler).
* **Dữ liệu phân loại (Categorical):** Imputation (Most Frequent) -> Encoding (OneHotEncoder).

### 2. Mô hình & Tối ưu
* **Thuật toán:** `RandomForestClassifier`.
* **Cấu hình:** `n_estimators=100`, `class_weight='balanced'` (để xử lý chênh lệch mẫu).
* **Chiến lược chia dữ liệu:** `Stratified Split` (đảm bảo tỷ lệ nợ xấu ở tập Train và Test là tương đồng).

### 3. Phân tích Phân khúc (Segmentation Analysis)
Trước khi modeling, dữ liệu được phân nhóm để tìm Insight:
* **Salary Group:** Thu nhập Thấp (<5M) - Trung bình - Cao (>20M).
* **Credit Score Group:** Điểm Thấp (<500) - Trung bình - Cao (>700).
* *Insight:* Tỷ lệ nợ xấu có xu hướng giảm dần khi nhóm thu nhập và điểm tín dụng tăng lên.

## 🚀 Hướng dẫn sử dụng
1.  Đảm bảo file `Tima_CRM_Handled.csv` đã có trong thư mục.
2.  Chạy notebook `TIMA_ClassificationModels.ipynb`.
3.  Hàm `build_and_evaluate_binary_classifier` sẽ tự động in ra báo cáo đánh giá (Precision, Recall, F1-Score) cho từng bài toán.

---
**Author:**  Hoàng Thái Duy
**Project:** TIMA Financial Analysis
