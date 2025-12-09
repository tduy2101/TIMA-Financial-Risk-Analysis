# Task 6: Data Visualization & Exploratory Data Analysis (EDA)

## 📖 Tổng quan
Trong bước này, chúng ta sử dụng các kỹ thuật trực quan hóa dữ liệu (Visualization) để khám phá các mẫu hình (patterns), xu hướng (trends) và các điểm bất thường (outliers) trong bộ dữ liệu TIMA CRM sau khi đã được làm sạch.

Mục tiêu là trả lời các câu hỏi nghiệp vụ thông qua hình ảnh trực quan, giúp các bên liên quan (Stakeholders) dễ dàng nắm bắt insight.

## 📊 Các loại biểu đồ đã thực hiện
Notebook `TIMA_Visualization.ipynb` bao gồm các phân tích sau:

1.  **Phân phối dữ liệu (Distribution):**
    * **Histogram & KDE:** Xem phân phối của *Số tiền đăng ký*, *Tiền giải ngân*, *Lương*.
    * **Boxplot:** Phát hiện các giá trị ngoại lai (Outliers) trong các biến tài chính.

2.  **Mối quan hệ biến số (Relationships):**
    * **Scatter Plot:** Tương quan giữa *Số tiền đăng ký* và *Tiền giải ngân* (phân nhóm theo Nợ xấu).
    * **Heatmap:** Ma trận tương quan (Correlation Matrix) giữa các biến định lượng.
    * **Pairplot:** Quan hệ tổng quan giữa nhiều biến cùng lúc.

3.  **So sánh nhóm (Categorical Comparison):**
    * **Countplot:** Tần suất hồ sơ theo *Giới tính*, *Khu vực*.
    * **Violin Plot:** So sánh phân phối *Thu nhập (Salary)* giữa các nhóm giới tính.

4.  **Phân tích nâng cao:**
    * **Bubble Chart (Plotly):** Biểu đồ bong bóng tương tác 3 chiều (Vay, Giải ngân, Lương).
    * **Time Series Analysis:** Xu hướng giải ngân theo thời gian (Tháng/Năm).

## 🛠 Thư viện sử dụng
* **Pandas & NumPy:** Xử lý và tổng hợp dữ liệu.
* **Matplotlib:** Thư viện vẽ biểu đồ nền tảng.
* **Seaborn:** Vẽ biểu đồ thống kê đẹp và trực quan.
* **Plotly Express:** Vẽ biểu đồ tương tác (Interactive charts).

## 🚀 Hướng dẫn chạy
1.  Đảm bảo file dữ liệu sạch `Tima_CRM_Handled_Python.csv` đã có trong thư mục `Data`.
2.  Mở file `TIMA_Visualization.ipynb` bằng Jupyter Notebook hoặc Google Colab.
3.  Cập nhật đường dẫn file (nếu cần thiết) tại cell đọc dữ liệu.
4.  Chạy lần lượt các cell để xuất biểu đồ.

---
**Author:**  Hoàng Thái Duy
**Project:** TIMA Financial Analysis
