# healthcare-analytics-project
Healthcare Analytics project using Excel, SQL, and Power BI to analyze patients data, appointments, billing, doctor performance, and prescriptions.
🏥 Healthcare Analytics Dashboard

📌 Project Overview
An end-to-end Healthcare Analytics project built using Excel, SQL, and Power BI to analyze patient records, appointments, billing, doctor performance, and prescriptions across a hospital network.
The project demonstrates the complete data analytics workflow, from data cleaning and SQL analysis to interactive dashboard development in Power BI.

🎯 Business Objectives

- Analyze hospital revenue and billing trends
- Track appointment volume, status, and cancellation patterns
- Evaluate doctor performance and workload distribution
- Analyze patient demographics and visit behavior
- Identify top-performing departments by revenue and patient volume
- Monitor prescription trends across departments
- Generate actionable insights to support hospital operations

🛠️ Tools & Technologies

- Excel – Data cleaning and preprocessing
- SQL – Data analysis, joins, subqueries, aggregations, window functions, and ranking queries
- Power BI – Data modeling, DAX, KPIs, and interactive visualization

📂 Dataset
The project contains six related datasets:

- `patients.csv` – Patient demographics, contact info, blood type, and insurance details
- `doctors.csv` – Doctor details, specialization, department, and experience
- `departments.csv` – Department names and floor information
- `appointment.csv` – Appointment records with date, time, and status
- `billing.csv` – Billing amount, payment status, payment mode, and insurance provider
- `prescriptions.csv` – Prescribed medicines, dosage, and duration per appointment

📊 Dashboard
The Power BI dashboard is organized across 5 pages:

- Executive Dashboard – hospital-wide KPIs, revenue, and appointment status overview
- Patients Analytics – patient demographics by gender, age, city, and blood type
- Doctor & Department Performance – doctor workload, experience distribution, and cancellation rates
- Billing & Revenue – revenue trends by department, payment mode, and insurance provider
- Business Insights – key takeaways from across the hospital's operations

📄 Dashboard Overview & Business Insights For a complete view of all dashboard pages(Executive Dashboard,Patients Analytics ,	Doctor & Department Performance,Billing & Revenue,Business Insights)
[📄 View Dashboard Overview](./dashboard_view.pdf)



🧮 SQL Analysis
SQL was used to perform:

- Data aggregation and filtering
- Joins across patients, doctors, departments, appointments, billing, and prescriptions
- Subqueries for above-average revenue and appointment comparisons
- Window functions (running total, LAG) ordered by billing date
- Ranking queries (DENSE_RANK) for doctors, departments, and patients by revenue
- Business KPI queries combining multiple tables for executive-level summaries

The complete SQL queries are available in:
`healthcare_questions.sql`

🔍 Key Insights

. Female patients represent (54.72%) of all patients, followed by Male (45.28%) .
.The ENT department has the highest appointment cancellation rate (22.86%).
. The overall appointment cancellation rate is 19.59%, meaning about 1 in 5 appointments are cancelled.
. UPI is the most used payment method and contributes 40.52% of the total revenue.
. The hospital earned the highest revenue in 2024, with around ₹48M.
. Pending payments are around 58% of the total revenue, showing that many payments are still waiting to be collected.

📁 Project Files

- `patients.csv`
- `doctors.csv`
- `departments.csv`
- `appointment.csv`
- `billing.csv`
- `prescriptions.csv`
- `healthcare sql`
- `Healthcare.pbix`
- `dashboard view`



👤 Author
Ayush Kukreti
Data Analytics Portfolio | SQL | Power BI | Excel
