# 📘 SQL Lecture & Cheat Sheet
> สรุปคำสั่ง SQL พื้นฐานถึงระดับสูง สำหรับ MSSQL และ MySQL


> **Note:** Syntax ส่วนใหญ่ใช้ร่วมกันได้ แต่จุดที่ต่างกันจะระบุไว้ชัดเจนครับ

## 📑 Table of Contents
1. [Variable & Data Types](#1-variable--data-types)
2. [Database Management](#2-database-management)
3. [Table Management (DDL)](#3-table-management-ddl)
4. [Data Manipulation (DML)](#4-data-manipulation-dml)
5. [Advanced & Joins](#5-advanced--joins)

---

## 1. Variable & Data Types

### 🔤 String (ตัวอักษร)

| Data Type | กำหนดขนาด | ข้อมูลตัวอย่าง | พื้นที่ที่ใช้ (ประมาณ) | รองรับภาษาไทย (MSSQL) |
| :--- | :--- | :--- | :--- | :--- |
| **CHAR(n)** | Fix | "A" | จองเต็มเสมอ (n bytes) | อาจเพี้ยน |
| **VARCHAR(n)** | Variable | "A" | ตามจริง + overhead | อาจเพี้ยน |
| **NVARCHAR(n)**| Variable | "A" | ตามจริง x2 + overhead | **ชัวร์ 100% (แนะนำ)** |

> **MySQL Note:** ใน MySQL แนะนำให้ใช้ `VARCHAR` คู่กับ Collation `utf8mb4` ก็เพียงพอสำหรับภาษาไทย

### 🔢 Numeric (ตัวเลข)
- **BIT**: ค่า 0 หรือ 1 (เหมาะสำหรับ True/False)
- **INT**: จำนวนเต็ม (Integer)
- **DECIMAL(p,s)**: ทศนิยมแม่นยำสูง เช่น `DECIMAL(10,2)` เก็บเงินหรือบัญชี
- **FLOAT**: ทศนิยมวิทยาศาสตร์

### 📅 Date & Time
- **DATE**: `2050-07-16` (เก็บแต่วันที่)
- **TIME**: `06:24:30.123` (เก็บแต่เวลา)
- **DATETIME**: `2050-07-16 06:24:30.123` (เก็บทั้งคู่)

---

## 2. Database Management

### Create Database with Collation
การเลือก Collation (ชุดภาษา):
* **CI** = Case Insensitive (ตัวใหญ่/เล็ก เหมือนกัน a=A)
* **CS** = Case Sensitive (ตัวใหญ่/เล็ก ต่างกัน)
* **AI** = Accent Insensitive (ไม่สนวรรณยุกต์ ก่า=ก้า)
* **AS** = Accent Sensitive (สนวรรณยุกต์)

**MSSQL (SQL Server)**
```sql
CREATE DATABASE database_name
COLLATE THAI_CI_AS;

```
**MySQL**
```sql
CREATE DATABASE database_name
CHARACTER SET utf8mb4
COLLATE utf8mb4_thai_520_w2;
```

**Drop & Rename**
```sql
-- ลบฐานข้อมูล
DROP DATABASE database_name;

-- เปลี่ยนชื่อฐานข้อมูล (MSSQL)
ALTER DATABASE database_name
MODIFY NAME = new_name;
```

## 3. Table Management (DDL)
**Create Table**
```sql
CREATE TABLE Table_name (
    Column1 DataType,
    Column2 DataType,
    ID INT PRIMARY KEY -- สร้าง Primary Key แบบย่อ
);
```

**Alter Table (แก้ไขโครงสร้างตาราง)**
ระวัง: Syntax ของ MSSQL และ MySQL จะต่างกันเล็กน้อยในส่วนนี้

```sql
-- 3.1 เพิ่มคอลัมน์ใหม่ (Add)
ALTER TABLE Table_name
ADD column_name datatype;

-- 3.2 ลบคอลัมน์ทิ้ง (Drop) **ไม่ต้องใส่ datatype
ALTER TABLE Table_name
DROP COLUMN column_name;

-- 3.3 แก้ไขประเภทข้อมูล (Alter/Modify)
-- MSSQL ใช้:
ALTER TABLE Table_name
ALTER COLUMN column_name new_datatype;

-- MySQL ใช้:
ALTER TABLE Table_name
MODIFY COLUMN column_name new_datatype;
```

**Rename (เปลี่ยนชื่อ)**
```sql
-- MSSQL: เปลี่ยนชื่อคอลัมน์
EXEC sp_rename 'table_name.old_column', 'new_column', 'COLUMN';

-- MSSQL: เปลี่ยนชื่อตาราง
EXEC sp_rename 'old_table', 'new_table';
```

## 4. Data Manipulation (DML)
**Basic CRUD OperationsBasic CRUD Operations**
```sql
-- INSERT (เพิ่มข้อมูล)
INSERT INTO table_name (col1, col2) VALUES ('Val1', 'Val2');

-- SELECT (ดึงข้อมูล)
SELECT * FROM table_name WHERE Condition;

-- UPDATE (แก้ไขข้อมูล *ต้องมี WHERE)
UPDATE table_name SET col1 = 'NewVal' WHERE Condition;

-- DELETE (ลบข้อมูล *ต้องมี WHERE)
DELETE FROM table_name WHERE Condition;-- INSERT (เพิ่มข้อมูล)
INSERT INTO table_name (col1, col2) VALUES ('Val1', 'Val2');

-- SELECT (ดึงข้อมูล)
SELECT * FROM table_name WHERE Condition;

-- UPDATE (แก้ไขข้อมูล *ต้องมี WHERE)
UPDATE table_name SET col1 = 'NewVal' WHERE Condition;

-- DELETE (ลบข้อมูล *ต้องมี WHERE)
DELETE FROM table_name WHERE Condition;
```

**Filtering & Sorting**
```sql
-- WHERE Conditions
SELECT * FROM Users 
WHERE Role IN ('Admin','User')  -- เลือกหลายค่า
AND Email IS NULL               -- ค่าว่าง
AND Name LIKE 'S%';             -- ขึ้นต้นด้วย S

-- ORDER BY (เรียงลำดับ)
SELECT * FROM Users ORDER BY Age ASC, Name DESC;
-- ASC = น้อยไปมาก, DESC = มากไปน้อย

-- LIMIT / TOP (จำกัดจำนวนแถว)
SELECT TOP 5 * FROM Users;      -- MSSQL
SELECT * FROM Users LIMIT 5;    -- MySQL
```

**Aggregate Functions (การคำนวณรวม)Aggregate Functions (การคำนวณรวม)**
```sql
SELECT MIN(Score) FROM Results;    -- ค่าน้อยสุด
SELECT MAX(Score) FROM Results;    -- ค่ามากสุด
SELECT AVG(Score) FROM Results;    -- ค่าเฉลี่ย
SELECT SUM(Score) FROM Results;    -- ผลรวม
SELECT COUNT(*) FROM Results;      -- นับจำนวนแถว
```

## 5. Advanced & Joins

**🔑 Keys & Constraints**

ตัวอย่างการสร้างตารางแบบมี Compound Key (Primary Key คู่)
```sql
CREATE TABLE StudentSTPB (
    StudentName VARCHAR(100) NOT NULL,
    StudentLastName VARCHAR(100) NOT NULL,
    Telephone VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NULL,
    
    -- Compound Key: ชื่อและนามสกุล ห้ามซ้ำกันในระบบ
    CONSTRAINT PK_Student PRIMARY KEY (StudentName, StudentLastName)
);
```
🔗 Standard Joins
- **INNER JOIN**: เอาข้อมูลที่ id ตรงกัน ทั้ง 2 ตาราง

- **LEFT JOIN**: ยึดตาราง ซ้าย เป็นหลัก (ถ้าขวาไม่มีข้อมูลจะเป็น NULL)

- **RIGHT JOIN**: ยึดตาราง ขวา เป็นหลัก

- **FULL JOIN**: เอามา ทั้งหมด ไม่ว่าจะตรงกันหรือไม่

```sql
SELECT A.Name, B.OrderDate
FROM Customers A
INNER JOIN Orders B ON A.ID = B.CustomerID;
```

**🔄 Self Join (การจอยตารางกับตัวเอง)**

ใช้เมื่อข้อมูลมีความสัมพันธ์กันเองในตารางเดียว เช่น พนักงานกับหัวหน้า (ซึ่งหัวหน้าก็เป็นพนักงานคนหนึ่งในตารางเดียวกัน)

Concept: ต้องตั้งชื่อเล่น (Alias) ให้ตารางเดียวกันเป็น 2 ชื่อ (เช่น E แทนลูกน้อง, M แทนหัวหน้า)
```sql
SELECT 
    E.EmployeeName AS Employee,  -- ชื่อพนักงาน (จากตาราง E)
    M.EmployeeName AS Manager    -- ชื่อหัวหน้า (จากตาราง M)
FROM Employees E                 -- ตั้ง E เป็นตัวแทนตารางพนักงาน (มุมมองลูกน้อง)
LEFT JOIN Employees M            -- Join กับตารางเดิม แต่ตั้งชื่อ M (มุมมองหัวหน้า)
ON E.ManagerID = M.EmployeeID;   -- เชื่อมโยง: ManagerID ของลูกน้อง คือ EmployeeID ของหัวหน้า
```

**📦 Group By & Having**


ใช้จัดกลุ่มข้อมูล และกรองผลลัพธ์ หลังจาก การจัดกลุ่ม
```sql
SELECT Dept, COUNT(*) 
FROM Employees 
GROUP BY Dept           -- จัดกลุ่มตามแผนก
HAVING COUNT(*) > 5;    -- (Filter) กรองเฉพาะกลุ่มที่มีพนักงานเกิน 5 คน
```