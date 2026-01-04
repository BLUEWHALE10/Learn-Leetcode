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
* **AI** = Accent Insensitive (ไม่สนวรรณยุกต์ ก่า=ก้า)

**MSSQL (SQL Server)**
```sql
CREATE DATABASE database_name
COLLATE THAI_CI_AS;

```
**MySQL**
```mysq
CREATE DATABASE database_name
CHARACTER SET utf8mb4
COLLATE utf8mb4_thai_520_w2;
```



