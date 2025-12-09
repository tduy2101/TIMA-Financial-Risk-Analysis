# Task 9: Predictive Analysis (Phân tích Dự báo)

## 📖 Tổng quan
Trong task này, chúng ta chuyển từ việc phân tích quá khứ (Descriptive/Diagnostic) sang dự báo tương lai (Predictive). Mục tiêu là xây dựng các mô hình học máy (Machine Learning) cơ bản để dự đoán các chỉ số tài chính quan trọng dựa trên dữ liệu lịch sử.

Các mô hình này giúp trả lời các câu hỏi:
* *Với mức lương X, khách hàng này có thể vay bao nhiêu tiền?*
* *Xu hướng giải ngân trong tháng tới sẽ tăng hay giảm?*
* *Các yếu tố nào (Tuổi, Lương) ảnh hưởng mạnh nhất đến Điểm tín dụng?*

## 🤖 Các mô hình đã xây dựng
Notebook `TIMA_Forecasting.ipynb` triển khai 3 bài toán dự báo chính:

### 1. Dự báo Số tiền vay (Loan Amount Prediction)
* **Loại bài toán:** Hồi quy tuyến tính đơn biến (Simple Linear Regression).
* **Biến đầu vào (Feature):** `Salary` (Thu nhập).
* **Biến mục tiêu (Target):** `SoTienDKVayBanDau` (Số tiền đăng ký vay).
* **Mục đích:** Ước tính hạn mức vay tiềm năng cho khách hàng mới dựa trên thu nhập khai báo.
* **Đánh giá:** Sử dụng chỉ số MSE và R-squared để đo lường độ chính xác.

### 2. Dự báo Lãi suất & Điểm tín dụng (Multivariate Regression)
* **Loại bài toán:** Hồi quy đa biến (Multiple Linear Regression).
* **Mô hình A:** `TS_CREDIT_SCORE_V2` -> Dự báo `LaiSuat`.
    * *Giả thuyết:* Điểm tín dụng càng cao, lãi suất càng thấp (nghịch biến).
* **Mô hình B:** `Salary` + `Age` -> Dự báo `TS_CREDIT_SCORE_V2`.
    * *Mục đích:* Xác định xem thu nhập và độ tuổi có phải là yếu tố chính cấu thành nên điểm tín dụng nội bộ hay không.

### 3. Dự báo Xu hướng Giải ngân (Time Series Forecasting)
* **Loại bài toán:** Chuỗi thời gian (Time Series).
* **Mô hình:** **ARIMA** (AutoRegressive Integrated Moving Average).
* **Dữ liệu:** Tổng tiền giải ngân theo tháng (`TienGiaiNgan` resampled by Month).
* **Mục đích:** Dự báo nhu cầu vốn trong 3-6 tháng tới để lập kế hoạch dòng tiền (Cash flow planning).

## 🛠 Thư viện & Công cụ
* **Scikit-learn (`sklearn`):**
    * `LinearRegression`: Thuật toán hồi quy.
    * `train_test_split`: Chia tập dữ liệu Train (80%) / Test (20%).
    * `mean_squared_error`, `r2_score`: Đánh giá hiệu suất mô hình.
* **Statsmodels:**
    * `ARIMA`: Mô hình dự báo chuỗi thời gian.
* **Matplotlib/Seaborn:** Vẽ biểu đồ đường hồi quy (Regression Line) và so sánh Thực tế vs Dự báo (Actual vs Predicted).

## 🚀 Hướng dẫn chạy code
1.  Đảm bảo file dữ liệu sạch `Tima_CRM_Handled_Python.csv` đã có trong thư mục `Data`.
2.  Cài đặt thư viện (nếu chưa có): `pip install scikit-learn statsmodels`.
3.  Mở file `TIMA_Forecasting.ipynb` và chạy lần lượt các cell.
4.  Quan sát các biểu đồ dự báo xu hướng ở cuối notebook.

## 💡 Kết quả sơ bộ (Model Insights)
* **Mối quan hệ Lương - Tiền vay:** [Nhận xét kết quả R2, VD: R2 thấp cho thấy chỉ dựa vào Lương là chưa đủ để dự báo chính xác số tiền vay].
* **Xu hướng thời gian:** [Nhận xét từ biểu đồ ARIMA, VD: Xu hướng giải ngân có tính mùa vụ, thường tăng cao vào cuối năm].

---
**Author:**  Hoàng Thái Duy
**Project:** TIMA Financial Analysis
