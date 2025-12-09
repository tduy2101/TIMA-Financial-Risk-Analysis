# Task 8: Diagnostic Analytics (Phân tích Chẩn đoán)

## 📖 Tổng quan
Nếu Task 7 trả lời câu hỏi "Cái gì đã xảy ra?", thì Task 8 tập trung trả lời câu hỏi **"Tại sao nó lại xảy ra?"**.

Trong task này, chúng ta sử dụng các kỹ thuật thống kê (Statistical Analysis) để kiểm định các giả thuyết nghiệp vụ, tìm kiếm mối tương quan giữa các biến số và xác định các nguyên nhân tiềm ẩn dẫn đến rủi ro hoặc cơ hội kinh doanh.

## 🔬 Các giả thuyết & Kiểm định (Hypotheses Testing)
Notebook `TIMA_Diagnosis.ipynb` thực hiện các kiểm định sau:

### 1. Phân tích Tương quan (Correlation Analysis)
Sử dụng hệ số tương quan Pearson (r) để đo lường mối quan hệ tuyến tính:
* **Thu nhập (Salary) vs Số tiền vay:** Kiểm tra xem người có thu nhập cao có xu hướng vay nhiều hơn không?
    * *Kết quả sơ bộ:* Tương quan rất yếu (r ~ 0.04), cho thấy số tiền vay không phụ thuộc nhiều vào lương khai báo.
* **Số tiền vay vs Lãi suất:** Kiểm tra xem vay nhiều có được ưu đãi lãi suất thấp hơn không?
* **Điểm tín dụng vs Lãi suất:** Kiểm tra xem điểm tín dụng cao có giúp giảm lãi suất vay không?

### 2. So sánh nhóm (Comparative Analysis & T-test)
* **Giới tính vs Số tiền vay:**
    * Sử dụng **T-test** để kiểm định xem có sự khác biệt có ý nghĩa thống kê về số tiền vay trung bình giữa Nam và Nữ hay không.
    * *P-value:* Dùng để kết luận chấp nhận hay bác bỏ giả thuyết H0 (Không có sự khác biệt).
* **Nợ xấu vs Điểm tín dụng:**
    * So sánh điểm tín dụng trung bình của nhóm khách hàng "Good" (trả đúng hạn) và "Bad" (Nợ xấu).

### 3. Phân tích đa biến (Multivariate Analysis)
* **Correlation Heatmap:** Trực quan hóa mối tương quan tổng thể giữa tất cả các biến định lượng (Lương, Tuổi, Tiền vay, Điểm tín dụng, Lãi suất...).

## 🛠 Kỹ thuật & Thư viện sử dụng
* **Scipy Stats (`scipy.stats`):** Thực hiện các kiểm định thống kê như `ttest_ind` (Independent T-test), `pearsonr`.
* **Pandas (`corr`):** Tính toán ma trận tương quan.
* **Seaborn (`heatmap`, `boxplot`):** Trực quan hóa ma trận tương quan và phân phối dữ liệu so sánh.

## 🚀 Hướng dẫn chạy code
1.  Đảm bảo file dữ liệu sạch `Tima_CRM_Handled_Python.csv` đã có trong thư mục `Data`.
2.  Mở file `TIMA_Diagnosis.ipynb`.
3.  Chạy các cell để xem các hệ số tương quan (r), giá trị P-value và biểu đồ.

## 💡 Key Insights (Kết quả chẩn đoán)
* **Về thu nhập:** Thu nhập khai báo không phải là yếu tố quyết định chính đến hạn mức được vay (Correlation thấp).
* **Về giới tính:** [Kết luận dựa trên T-test, ví dụ: Không có sự khác biệt đáng kể về hành vi vay giữa Nam và Nữ].
* **Về rủi ro:** Điểm tín dụng (Credit Score) có sự phân hóa rõ rệt giữa nhóm khách hàng tốt và xấu, khẳng định giá trị của hệ thống chấm điểm nội bộ.

---
**Author:**  Hoàng Thái Duy
**Project:** TIMA Financial Analysis