# Task 10: Prescriptive Analytics (Phân tích Đề xuất)

## 📖 Tổng quan
Đây là bước cuối cùng và quan trọng nhất trong chuỗi giá trị dữ liệu (Data Value Chain). Sau khi đã biết "Chuyện gì sẽ xảy ra?" (Predictive), Task 10 trả lời câu hỏi **"Chúng ta nên làm gì?"** (Prescriptive).

Notebook này không chỉ dừng lại ở việc dự báo rủi ro, mà còn xây dựng một **Hệ thống hỗ trợ ra quyết định (Decision Support System)** giúp tối ưu hóa quy trình phê duyệt vay và tối đa hóa lợi nhuận cho TIMA.

## 🧠 Giải pháp Đề xuất (Prescriptive Model)
Thay vì chỉ trả về kết quả 0/1 (Nợ xấu/Không), hệ thống phân loại hồ sơ thành 3 luồng xử lý:

### 1. Phân luồng Tự động (Segmentation Strategy)
* **🟢 Luồng Xanh (Auto-Approval):**
    * *Đặc điểm:* Xác suất vỡ nợ (PD) cực thấp (< 5%).
    * *Hành động:* Duyệt vay tự động, giảm thiểu thủ tục, ưu đãi lãi suất thấp để thu hút khách hàng tốt.
* **🟡 Luồng Vàng (Manual Review):**
    * *Đặc điểm:* Xác suất vỡ nợ trung bình (5% - 20%) hoặc hồ sơ thiếu thông tin.
    * *Hành động:* Chuyển qua bộ phận thẩm định thủ công (Underwriting team), yêu cầu bổ sung giấy tờ.
* **🔴 Luồng Đỏ (Auto-Rejection):**
    * *Đặc điểm:* Xác suất vỡ nợ cao (> 20%).
    * *Hành động:* Từ chối vay ngay lập tức để ngăn chặn mất vốn.

### 2. Mô phỏng Tác động Kinh doanh (Business Impact Simulation)
Để chứng minh hiệu quả, chúng tôi đã chạy mô phỏng trên tập dữ liệu kiểm thử (Test set) với giả định:
* *Lãi suất cho vay:* 20%/năm.
* *Tỷ lệ mất vốn khi vỡ nợ:* 100% nợ gốc.
* *Chi phí thẩm định thủ công:* 50,000 VNĐ/hồ sơ.

**Kết quả mô phỏng:**
* Áp dụng mô hình đề xuất giúp **tăng lợi nhuận kỳ vọng thêm X VNĐ** so với quy trình cũ.
* Giảm thiểu **Y%** nợ xấu tiềm tàng.

## 🛠 Kỹ thuật & Công nghệ
* **Machine Learning:** `Logistic Regression` (được chọn vì tính minh bạch, dễ giải thích).
* **Pipeline Engineering:** `Sklearn Pipeline` (xử lý `OneHotEncoder`, `StandardScaler`, `SimpleImputer` tự động).
* **Decision Logic:** Code Python mô phỏng luồng ra quyết định kinh doanh.

## 🚀 Hướng dẫn chạy
1.  Đảm bảo file dữ liệu `Tima_CRM_Handled.csv` có trong thư mục.
2.  Chạy notebook `TIMA_PrescriptiveAnalytics.ipynb`.
3.  Xem kết quả tại phần **5.2 Đánh giá Mô hình Đề xuất** để thấy con số lợi nhuận thực tế.

---
**Author:**  Hoàng Thái Duy
**Project:** TIMA Financial Analysis