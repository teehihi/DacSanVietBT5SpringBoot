# BaiTap5 Spring Boot Project

## 📌 Giới thiệu

Dự án Spring Boot quản lý người dùng, danh mục, video với phân quyền Admin/User.  
Sử dụng **JSP + Spring MVC + Spring Security + JPA Hibernate**.

---

## 📂 Cấu trúc thư mục

```plaintext
src/main/java/LapTrinhWeb.SpringBoot/
 ├── Config/
 ├── Controller/
 ├── Entity/
 ├── Model/
 ├── Repository/
 ├── Service/
 └── BaiTap5SpringBootApplication.java

src/main/resources/
 ├── META-INF/resources/WEB-INF/views/
 │   ├── admin/categories (add.jsp, list.jsp,…)
 │   ├── auth (login.jsp, register.jsp)
 │   ├── user (home.jsp, profile.jsp)
 │   ├── common (header.jsp, footer.jsp)
 ├── static/
 ├── templates/
 └── application.properties
```

---

## 🚀 Hướng dẫn sử dụng

### Cài đặt và chạy dự án
1. Clone project từ GitHub
```bash
git clone https://github.com/teehihi/DacSanVietBT5SpringBoot.git
cd DacSanVietBT5SpringBoot
```
2. Cấu hình database trong ```src/main/resources/application.properties```

```bash
server.port=8089

spring.datasource.driverClassName=com.microsoft.sqlserver.jdbc.SQLServerDriver
spring.datasource.url=jdbc:sqlserver://{yourDbServer}; databaseName=QuanLySVSpringDB;trustServerCertificate=true;encrypt=true;
spring.datasource.username=YourDbUsername
spring.datasource.password=YourDbPassword

spring.jpa.show-sql=true
```
⚠ Hãy đảm bảo đã tạo DB QuanLySVSpringDB trong SQL Server trước khi chạy.

3. Chạy dự án

```bash
mvn spring-boot:run
```
Sau đó truy cập trình duyệt:
```
http://localhost:8080
```
Quy trình trên sẽ cực kỳ đơn giản nếu dùng SpringToolSuite: 
- Bật Boot Dashboard
- Chuột phải vào project trong bảng controll bên trong mục local
- Chọn (Re)start sau đó click đúp vào tên project tại chỗ đó 
---

## 🔐 Cấu hình tài khoản Admin

## Cách 1: Đăng ký tài khoản và cập nhật qua Database

1. **Đăng ký tài khoản mới** qua trang `/register`
2. **Kết nối đến SQL Server** và chạy câu lệnh sau:

```sql
UPDATE users 
SET admin = 1 
WHERE username = 'ten_username_cua_ban';
```

Ví dụ:
```sql
UPDATE users 
SET admin = 1 
WHERE username = 'admin';
```

## Cách 2: Sử dụng trang quản lý User (nếu bạn đã là admin)

1. Đăng nhập với tài khoản admin
2. Vào trang `/admin/users`
3. Click "Sửa" trên user cần cấp quyền admin
4. Chọn "Admin" trong dropdown "Quyền Admin"
5. Lưu lại

## Cách 3: Tạo user admin trực tiếp trong Database

Chạy câu lệnh SQL sau để tạo user admin mới:

```sql
INSERT INTO users (username, password, fullname, email, phone, admin, active, images)
VALUES (
    'admin', 
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', -- password: admin123
    'Administrator',
    'admin@example.com',
    '0123456789',
    1, -- admin = true
    1, -- active = true
    NULL
);
```

**Lưu ý:** Password đã được mã hóa bằng BCrypt. Mật khẩu gốc là: `admin123`

## Cách 4: Sử dụng Spring Boot CommandLineRunner (Tự động tạo admin khi khởi động)

Đã có sẵn trong code, bạn có thể uncomment phần tạo admin tự động trong file `BaiTap5SpringBootApplication.java` hoặc tạo một class riêng.

## Kiểm tra quyền Admin

Sau khi cấu hình, đăng nhập lại và kiểm tra:
- User có quyền admin sẽ thấy badge "Admin" màu đỏ trong trang quản lý User
- User admin có thể truy cập tất cả các trang `/admin/**`
- User thường cũng có thể truy cập nhưng có thể bị giới hạn một số chức năng

## Lưu ý quan trọng

- **Password được mã hóa:** Tất cả password đều được mã hóa bằng BCrypt trước khi lưu vào database
- **Active status:** User phải có `active = 1` mới có thể đăng nhập
- **Security:** Đảm bảo chỉ có user admin mới có thể chỉnh sửa quyền của user khác


---

## 🌍 Giao diện trang chủ

![Trang chủ](https://files.catbox.moe/otbqpi.png)

---

## 🧑‍💻 Tác giả

**Nguyễn Nhật Thiên (TEE)**  
📧 GitHub: https://github.com/teehihi  
🔗 Linktree: https://linktr.ee/nkqt.tee

---