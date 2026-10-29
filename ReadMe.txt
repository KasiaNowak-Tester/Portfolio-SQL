
# SQL Quality Assurance & Data Verification Sandbox

## 📌 Project Overview
This repository contains a comprehensive collection of relational database queries and data aggregation scripts designed for **Data Quality Assurance (Data QA)**, reporting verification, and backend testing. The scripts simulate real-world QA scenarios where data integrity, structural validation, and migration correctness need to be verified against business requirements.

The queries are structured to demonstrate clean coding standards, precise filtering, and relational database management logic using systems like **Microsoft SQL Server (MS SSMS)** and **MySQL**.

---

## ⚡ Core Database Testing Competencies

The scripts in this repository validate proficiency in the following backend QA areas:

*   **Data Completeness & Integrity:** Utilizing multi-table relations via complex joins (`INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL JOIN`, and `SELF JOIN`) to verify that no orphaned records exist across environments.
*   **Business Reporting Verification:** Implementing advanced data aggregation using `GROUP BY` and conditioning logic (`HAVING`, `WHERE`) to reconcile application UI values with database realities.
*   **Set Theory Operations:** Executing advanced dataset combining and exclusion checks utilizing `UNION`, `INTERSECT`, and `EXCEPT` clauses.
*   **Deep-Data Assertions:** Writing optimized nested subqueries (`SUBQUERIES`) to fetch conditional testing boundaries and handle lookups.
*   **Database State Manipulation (DML/DDL):** Executing safe data modification and environment cleanups using `INSERT INTO`, `UPDATE SET`, `DELETE`, `TRUNCATE`, and safety constraints like `DROP IF EXISTS`.

---

## 📂 Repository Structure & Test Categories

The repository is organized sequentially to reflect advanced data manipulation workflows:

*   `01-02_basic_data_retrieval/` - Functional smoke testing queries verifying core tables and basic filtering criteria (`SELECT`, `WHERE`).
*   `03-04_data_state_manipulation/` - Verifying data creation, modification, and purge workflows while maintaining relational integrity (`INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`).
*   `05_data_aggregation_reporting/` - Testing analytical outputs, summary metrics, and business intelligence logic (`GROUP BY`, `COUNT`, `SUM`).
*   `06-08_relational_integrity_joins/` - Advanced end-to-end data tracing across interconnected schemas using relational joins and set operations.
*   `09_nested_subqueries/` - Executing deep data lookups and validation checks using sophisticated subquery blocks.

---

## 💻 Toolset & Tools Used
*   **Management Engines:** Microsoft SQL Server Management Studio (SSMS) / phpMyAdmin
*   **Local Staging:** XAMPP (Localhost environment configuration)
*   **Environment Interaction:** Command-line interfaces (CMD) for database migrations and raw dump imports

---

### 👤 Contact & Project Maintenance
*   **GitHub Portfolio:** [github.com/KasiaNowak-Tester](https://github.com/KasiaNowak-Tester)
*   **Role Focus:** QA Engineer | Backend Testing & Data Verification Specialist

------------------------------------
Tools: XAMPP(localhost) / phpmyadmin
LIST OF KEY WORDS  SQL:
SELECT
INSERT INTO
UPDATE SET
DELETE
TRUNCATE
DROP
IF EXISTS
GROUP BY
INNER LEFT RIGHT FULL SELF JOIN
CONCAT
UCASE
STRING FUNCTIONS
UNION
INTERSECT
EXCEPT
SUBQUERIES SELECT
------------------------------------
		
		



