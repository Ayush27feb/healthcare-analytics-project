-------------------------------------------------------
--Healthcare Analytics — SQL Analysis
-- -----------------------------------------------------
--  Create DataBase
ANS create database healhhcare;
----------------------------------------------------------
create tables in healthcare
ANS CREATE TABLE Appointment (
    appointment_id VARCHAR(10) PRIMARY KEY,
    patient_id VARCHAR(10),
    doctor_id VARCHAR(10),
    department_id VARCHAR(10),
    appointment_date DATE,
    appointment_time TIME,
    status VARCHAR(20),
    reason_for_visit VARCHAR(100));
CREATE TABLE Patients (
    patient_id VARCHAR(10) PRIMARY KEY,
    patient_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    contact_number VARCHAR(20),
    email VARCHAR(100),
    city VARCHAR(50),
    blood_type VARCHAR(3),
    registration_date DATE,
    insurance_provider VARCHAR(50)
); 
CREATE TABLE doctors (
    doctor_id VARCHAR(10) PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialization VARCHAR(100),
    department_id VARCHAR(10),
    experience_years INT,
    contact_number VARCHAR(20),
    email VARCHAR(100),
    joining_date DATE
);
CREATE TABLE departments (
    department_id VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(100),
    floor_number INT
);
CREATE TABLE billing (
    billing_id VARCHAR(10) PRIMARY KEY,
    patient_id VARCHAR(10),
    appointment_id VARCHAR(10),
    amount DECIMAL(10,2),
    payment_status VARCHAR(30),
    payment_mode VARCHAR(30),
    insurance_provider VARCHAR(70),
    billing_date DATE
);
CREATE TABLE prescriptions (
    prescription_id VARCHAR(10) PRIMARY KEY,
    appointment_id VARCHAR(10),
    patient_id VARCHAR(10),
    doctor_id VARCHAR(10),
    medicine_name VARCHAR(100),
    dosage VARCHAR(50),
    duration_days INT,
    prescribed_date DATE
);


Q1. Find the total hospital revenue.

ANS
SELECT SUM(amount) AS total_hospital_revenue
FROM billing
WHERE payment_status = 'Paid';
---------------------------------
Q2. Find the total revenue by payment mode.
 select payment_status,round(sum(amount),2) as total_revenue
 from billing
 group by payment_status;
---------------------------------
Q3. Find the doctor who treated the highest number of unique patients.
select dr.doctor_id,dr.doctor_name ,count(distinct p.patient_id) as Unique_patients
 from doctors dr inner join appointment a on dr.doctor_id=a.doctor_id
inner join patients p on a.patient_id=p.patient_id
where a.Status="Completed"
group by dr.doctor_id,dr.doctor_name
limit 1;
---------------------------------
Q4. Which department generated the highest revenue?
select d.department_name ,sum(b.amount) as Total_Revenue
FROM BILLING B  INNER JOIN APPOINTMENT A ON A.Appointment_ID=B.Appointment_ID
INNER JOIN DOCTORS DR ON A.Doctor_ID =DR.Doctor_ID
INNER JOIN DEPARTMENTS D ON D.Department_id=DR.Department_id
WHERE B.payment_status="PAID"
GROUP BY d.department_name
ORDER BY Total_Revenue DESC
LIMIT 1;
---------------------------------

Q5. Which doctor generated the highest revenue?
SELECT D.Doctor_id,D.Doctor_Name,SUM(B.AMOUNT) AS  HIGHEST_REVENUE FROM DOCTORS D
INNER JOIN APPOINTMENT A
ON D.DOCTOR_ID=A.DOCTOR_ID
INNER JOIN BILLING B ON A.appointment_id=B.appointment_id
WHERE B.payment_status="PAID"
GROUP BY D.DOCTOR_ID, D.DOCTOR_NAME
ORDER BY HIGhEST_REVENUE DESC
LIMIT 1;

---------------------------------

Q6. Top 10 patients by total billing amount.

select p.patient_id,patient_name,sum(b.amount) as Total_Billing_amount from patients p
 inner join billing b on p.patient_id =b.patient_id
where b.payment_status="paid"
group by p.patient_id,patient_name
order by Total_Billing_amount desc
limit 10;
---------------------------------

Q7. Average billing amount by department.

select d.department_name ,avg(b.amount) as Average_billing_amount
FROM BILLING B  INNER JOIN APPOINTMENT A ON A.Appointment_ID=B.Appointment_ID
INNER JOIN DOCTORS DR ON A.Doctor_ID =DR.Doctor_ID
INNER JOIN DEPARTMENTS D ON D.Department_id=DR.Department_id
WHERE B.payment_status="PAID"
GROUP BY d.department_name
ORDER BY Average_billing_amount DESC;
---------------------------------

Q8. Find the busiest department.
SELECT
    d.department_name,
    COUNT(a.appointment_id) AS total_appointments
FROM departments d
INNER JOIN doctors dr
    ON d.department_id = dr.department_id
INNER JOIN appointment a
    ON dr.doctor_id = a.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.department_id, d.department_name
ORDER BY total_appointments DESC
LIMIT 1;
---------------------------------

Q9. Which doctor handled the highest number of completed appointments?

SELECT
    d.doctor_name,
    COUNT(a.appointment_id) AS completed_appointments
FROM doctors d
INNER JOIN appointment a
    ON d.doctor_id = a.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.doctor_id, d.doctor_name
ORDER BY completed_appointments DESC
LIMIT 1;

---------------------------------

Q10. Find doctors with no appointments.

select d.Doctor_ID,d.Doctor_Name from doctors d 
left join appointment a on d.doctor_id=a.doctor_id
where a.Appointment_ID IS NULL;
---------------------------------

Q11. Find patients who visited more than 5 times..
SELECT
    p.Patient_ID,
    p.Patient_Name,
    COUNT(a.Appointment_ID) AS Total_Visits
FROM Patients p
INNER JOIN Appointment a
    ON p.Patient_ID = a.Patient_ID
    where a.Status="Completed"
GROUP BY
    p.Patient_ID,
    p.Patient_Name
HAVING COUNT(a.Appointment_ID) > 5
ORDER BY Total_Visits DESC;
---------------------------------

Q12. Find appointments without billing records.
SELECT a.appointment_id,a.patient_id,a.doctor_id,a.appointment_date
FROM appointment a
LEFT JOIN billing b
    ON a.appointment_id = b.appointment_id
WHERE b.appointment_id IS NULL;
---------------------------------
Q13 Find doctors who treated patients from the highest number of different cities.
SELECT
    dr.doctor_id,dr.doctor_name,
    COUNT(DISTINCT p.city) AS Different_cities
FROM doctors dr
INNER JOIN appointment a
    ON dr.doctor_id = a.doctor_id
INNER JOIN patients p
    ON a.patient_id = p.patient_id
WHERE a.status = 'Completed'
GROUP BY
    dr.doctor_id,dr.doctor_name
ORDER BY different_cities DESC
LIMIT 1;
---------------------------------
Q14. Find patients who visited at least 3 different departments.

SELECT
    p.Patient_ID,
    p.Patient_Name,
    COUNT(DISTINCT d.Department_ID) AS Different_Departments
FROM Patients p
INNER JOIN Appointment a
    ON p.Patient_ID = a.Patient_ID
INNER JOIN Doctors dr
    ON a.Doctor_ID = dr.Doctor_ID
INNER JOIN Departments d
    ON dr.Department_ID = d.Department_ID
WHERE a.Status = 'Completed'
GROUP BY
    p.Patient_ID,
    p.Patient_Name
HAVING COUNT(DISTINCT d.Department_ID) >= 3;

---------------------------------
Q15. Find all patients whose names start with 'A'.
SELECT
    patient_id,
    patient_name
FROM patients
WHERE patient_name LIKE 'A%';
---------------------------------

Q16. Revenue by payment mode.
SELECT payment_mode,SUM(amount) AS total_revenue
FROM billing
WHERE payment_status = 'PAID'
GROUP BY payment_mode
ORDER BY total_revenue DESC;
---------------------------------

Q17. Revenue by insurance provider.
SELECT insurance_provider,SUM(amount) AS total_revenue
FROM billing
WHERE payment_status = 'PAID' AND payment_mode ="Insurance"
GROUP BY insurance_provider
ORDER BY total_revenue DESC;
---------------------------------
Q18. Which department handled the highest number of senior citizens (Age > 60)?
SELECT
    d.department_name,
    COUNT(distinct p.patient_id) AS senior_citizen_count
FROM patients p
INNER JOIN appointment a
    ON p.patient_id = a.patient_id
INNER JOIN doctors dr
    ON a.doctor_id = dr.doctor_id
INNER JOIN departments d
    ON dr.department_id = d.department_id
WHERE p.age > 60
GROUP BY d.department_name
ORDER BY senior_citizen_count DESC;
---------------------------------

Q19. Average patient age by department visited.
SELECT d.department_name,
       ROUND(AVG(p.age), 0) AS Average_Patient_Age
FROM Patients p
JOIN Appointment a
    ON p.Patient_ID = a.Patient_ID
JOIN Doctors dr
    ON a.Doctor_ID = dr.Doctor_ID
JOIN Departments d
    ON dr.Department_ID = d.Department_ID
GROUP BY d.department_name;
---------------------------------
Q20. Find the top 5 cities that generated the highest revenue.

SELECT
    p.City,
    ROUND(SUM(b.Amount), 2) AS Total_Revenue
FROM Patients p
INNER JOIN Billing b
    ON p.Patient_ID = b.Patient_ID
WHERE b.Payment_Status = 'Paid'
GROUP BY
    p.City
ORDER BY
    Total_Revenue DESC
LIMIT 5;
---------------------------------
Q21. Gender distribution of patients.
SELECT gender,
       COUNT(patient_id) AS Patient_Count
FROM patients
GROUP BY gender
ORDER BY Patient_Count DESC;
---------------------------------

Q22. Blood group distribution.
SELECT Blood_Type,
       COUNT(patient_id) AS Patient_BLOOD_Count
FROM patients
GROUP BY Blood_Type
ORDER BY Patient_BLOOD_Count DESC;
---------------------------------
Q23. Top prescribed medicines.
 SELECT medicine_name,COUNT(medicine_name) AS Top_prescribed_medicines FROM prescriptions
GROUP BY medicine_name
ORDER BY Top_prescribed_medicines DESC
LIMIT 1;
---------------------------------

Q24. Most prescribing doctors.
SELECT DR.DOCTOR_ID,
       DR.DOCTOR_NAME,
       COUNT(P.MEDICINE_NAME) AS PRESCRIBING_MEDICINE
FROM DOCTORS DR
INNER JOIN PRESCRIPTIONS P
    ON DR.DOCTOR_ID = P.DOCTOR_ID
GROUP BY DR.DOCTOR_ID, DR.DOCTOR_NAME
ORDER BY PRESCRIBING_MEDICINE DESC
LIMIT 5;
---------------------------------

Q25. Average prescription duration by medicine.
SELECT
    Medicine_Name,
    ROUND(AVG(Duration_Days), 0) AS Average_Prescription_Duration
FROM Prescriptions GROUP BY Medicine_Name;
---------------------------------
Q26. Patients who visited multiple departments.
SELECT p.patient_id,
       p.patient_name,
       COUNT(DISTINCT d.department_name) AS Visit_Multiple_Departments
FROM patients p
INNER JOIN appointment a
    ON p.patient_id = a.patient_id
INNER JOIN doctors dr
    ON a.doctor_id = dr.doctor_id
INNER JOIN departments d
    ON dr.department_id = d.department_id
GROUP BY p.patient_id, p.patient_name
HAVING COUNT(DISTINCT d.department_name) > 1;
---------------------------------
Q27. Patients who consulted multiple doctors.
SELECT
    p.patient_id,
    p.patient_name,
    COUNT(DISTINCT dr.doctor_id) AS Total_Doctors
FROM patients p
INNER JOIN appointment a
    ON p.patient_id = a.patient_id
INNER JOIN doctors dr
    ON a.doctor_id = dr.doctor_id
GROUP BY
    p.patient_id,
    p.patient_name
HAVING COUNT(DISTINCT dr.doctor_id) > 1;
---------------------------------

Q28. Repeat patients (more than one appointment)
SELECT
    p.patient_id,
    p.patient_name,
    COUNT(DISTINCT a.Appointment_ID) AS repeat_patients
FROM patients p
INNER JOIN appointment a
    ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id,
    p.patient_name
HAVING COUNT(DISTINCT a.Appointment_ID) > 1;
---------------------------------

Q29. Find patients spending above average.
SELECT
    p.Patient_ID,
    p.Patient_Name,
    SUM(b.Amount) AS Total_Spending
FROM Patients p
INNER JOIN Billing b
    ON p.Patient_ID = b.Patient_ID
WHERE b.Payment_Status = 'Paid'
GROUP BY p.Patient_ID, p.Patient_Name
HAVING SUM(b.Amount) >
(
    SELECT AVG(Total_Spending)
    FROM
    (
        SELECT SUM(Amount) AS Total_Spending
        FROM Billing
        WHERE Payment_Status = 'Paid'
        GROUP BY Patient_ID
    ) t
);
---------------------------------

Q30. Find doctors handling above-average appointments.
SELECT
    dr.Doctor_ID,
    dr.Doctor_Name,
    COUNT(a.Appointment_ID) AS Total_Appointments
FROM Doctors dr
INNER JOIN Appointment a
    ON dr.Doctor_ID = a.Doctor_ID
GROUP BY
    dr.Doctor_ID,
    dr.Doctor_Name
HAVING COUNT(a.Appointment_ID) >
(
    SELECT AVG(Appointment_Count)
    FROM
    (
        SELECT COUNT(Appointment_ID) AS Appointment_Count
        FROM Appointment
        GROUP BY Doctor_ID
    ) t
);
---------------------------------

Q31. Find departments with above-average revenue.
SELECT
    d.Department_ID,
    d.Department_Name,
    SUM(b.Amount) AS Total_Revenue
FROM Departments d
INNER JOIN Doctors dr
    ON d.Department_ID = dr.Department_ID
INNER JOIN Appointment a
    ON dr.Doctor_ID = a.Doctor_ID
INNER JOIN Billing b
    ON a.Appointment_ID = b.Appointment_ID
WHERE b.Payment_Status = 'Paid'
GROUP BY
    d.Department_ID,
    d.Department_Name
HAVING SUM(b.Amount) >
(
    SELECT AVG(Department_Revenue)
    FROM
    (
        SELECT SUM(b.Amount) AS Department_Revenue
        FROM Departments d
        INNER JOIN Doctors dr
            ON d.Department_ID = dr.Department_ID
        INNER JOIN Appointment a
            ON dr.Doctor_ID = a.Doctor_ID
        INNER JOIN Billing b
            ON a.Appointment_ID = b.Appointment_ID
        WHERE b.Payment_Status = 'Paid'
        GROUP BY d.Department_ID
    ) t
);
---------------------------------

Q32. Find the top 5 patients who spent the highest amount on a single visit.
SELECT
    p.patient_id,
    p.patient_name,
    a.appointment_id,
    SUM(b.amount) AS total_amount
FROM patients p
INNER JOIN appointment a
    ON p.patient_id = a.patient_id
INNER JOIN billing b
    ON a.appointment_id = b.appointment_id
WHERE a.status = 'Completed'
  AND b.payment_status = 'PAID'
GROUP BY
    p.patient_id,
    p.patient_name,
    a.appointment_id
ORDER BY total_amount DESC
LIMIT 5;
---------------------------------

Q33.Find patients who visited at least 3 different departments.
SELECT P.PATIENT_ID,P.PATIENT_NAME ,COUNT(DISTINCT d.department_id) AS DIFFERENT_DEPARTMENTS
FROM PATIENTS P INNER JOIN APPOINTMENT A ON P.PATIENT_ID=A.PATIENT_ID
INNER JOIN DOCTORS DR ON A.DOCTOR_ID=DR.DOCTOR_ID
INNER JOIN DEPARTMENTS D ON DR.DEPARTMENT_ID=D.DEPARTMENT_ID
WHERE a.status = 'Completed'
GROUP BY  P.PATIENT_ID,P.PATIENT_NAME
HAVING COUNT(DISTINCT d.department_id) >=3;
---------------------------------
Q34. Patients registered but never visited.
SELECT
    p.patient_id,
    p.patient_name
FROM patients p
LEFT JOIN appointment a
    ON p.patient_id = a.patient_id
    AND a.status = 'Completed'
WHERE a.patient_id IS NULL;
---------------------------------
Q35. Top 5 Doctors with highest cancellation .
SELECT
    dr.doctor_id,
    dr.doctor_name,
    COUNT(a.appointment_id) AS total_cancellations
FROM doctors dr
INNER JOIN appointment a
    ON dr.doctor_id = a.doctor_id
WHERE a.status = 'Cancelled'
GROUP BY dr.doctor_id, dr.doctor_name
ORDER BY total_cancellations DESC
LIMIT 5;
---------------------------------
Q36.top 5  Doctors with highest no-show .
SELECT
    dr.doctor_id,
    dr.doctor_name,
    COUNT(a.appointment_id) AS total_no_show
FROM doctors dr
INNER JOIN appointment a
    ON dr.doctor_id = a.doctor_id
WHERE a.status = 'No-show'
GROUP BY dr.doctor_id, dr.doctor_name
ORDER BY total_no_show DESC
LIMIT 5;
---------------------------------
Q37. Average revenue per appointment.
SELECT
    ROUND(AVG(b.amount),2) AS average_revenue_per_appointment
FROM appointment a
JOIN billing b
    ON a.appointment_id = b.appointment_id
WHERE a.status = 'Completed'
  AND b.payment_status = 'PAID';
---------------------------------
Q38. Average revenue per doctor.
SELECT
    dr.doctor_id,
    dr.doctor_name,
    ROUND(AVG(b.amount), 2) AS avg_revenue
FROM doctors dr
INNER JOIN appointment a
    ON dr.doctor_id = a.doctor_id
INNER JOIN billing b
    ON a.appointment_id = b.appointment_id
WHERE b.payment_status = 'PAID'
  AND a.status = 'Completed'
GROUP BY dr.doctor_id, dr.doctor_name;
---------------------------------
Q39. Latest appointment for every patient.
SELECT
    p.patient_id,
    p.patient_name,
    a.appointment_id,
    a.appointment_date,
    a.status
FROM patients p
INNER JOIN appointment a
    ON p.patient_id = a.patient_id
WHERE a.appointment_date =

(
    SELECT MAX(a2.appointment_date)
    FROM appointment a2
    WHERE a2.patient_id = a.patient_id
);
---------------------------------
Q40. Rank doctors by appointment count.
select dr.doctor_id,dr.doctor_name,count(a.appointment_id) as Total_appointment,dense_rank() over(ORDER BY COUNT(a.appointment_id) DESC) as ranking
from doctors dr inner join appointment a
on dr.doctor_id=a.doctor_id
WHERE a.status = 'Completed'
group by dr.doctor_id,dr.doctor_name;
---------------------------------
Q41. Rank departments by revenue.
select d.department_id,d.department_name,round(sum(b.amount),2) as Revenue,dense_rank()over(order by sum(b.amount) desc) as Ranking
from billing b inner join appointment a on b.appointment_id=a.appointment_id
inner join doctors dr on a.Doctor_ID=dr.Doctor_ID
inner join departments d on dr.department_id=d.department_id
where b.payment_status="Paid"
group by  d.department_id,d.department_name;
---------------------------------
Q42. DENSE_RANK patients by billing amount.
select p.patient_id,p.patient_name,round(sum(b.amount),2) as revenue,dense_rank()over(order by sum(b.amount)desc) as ranking
from patients p inner join billing b on p.patient_id=b.patient_id
where b.payment_status="paid"
group by p.patient_id,p.patient_name;
---------------------------------
Q43. Running total of revenue.
SELECT
    billing_date,
    amount,
    SUM(amount) OVER (
        ORDER BY billing_date
    ) AS running_total_revenue
FROM billing
WHERE payment_status = 'PAID'
ORDER BY billing_date;
---------------------------------
Q44.Compare each patient's bill with the previous patient's bill using LAG().
SELECT
    Billing_ID,
    Patient_ID,
    Amount,
    LAG(Amount) OVER (ORDER BY Billing_ID) AS Previous_Bill_Amount
FROM Billing;
---------------------------------
Q45. Which blood group has the highest number of registered patients?
select  distinct blood_type,count(patient_id) as Highest_patients
from patients
group by  blood_type
order by Highest_patients desc
limit 1;
---------------------------------
Q46. Department-wise prescription count.
select d.Department_name,count(prescription_id) as Prescription_count  from prescriptions p inner join doctors dr on p.doctor_id=dr.doctor_id
inner join departments d on dr.department_id=d.department_id
group by d.Department_name;
---------------------------------
Q47. Payment status analysis.
SELECT
    Payment_Status,
    COUNT(Billing_ID) AS Total_Transactions,
    ROUND(SUM(Amount), 2) AS Total_Amount
FROM Billing
GROUP BY Payment_Status
ORDER BY Total_Transactions DESC;
--------------------------------

Q48. Which city has the highest number of registered patients?
SELECT
    City,
    COUNT(Patient_ID) AS Total_Patients
FROM Patients
GROUP BY City
ORDER BY Total_Patients DESC
LIMIT 1;
---------------------------------
Q49. Top 3 insurance providers by revenue
SELECT insurance_provider,round(sum(amount),2) as revenue from billing
where payment_status="Paid"
group by insurance_provider
order by revenue desc
limit 3;
---------------------------------
Q50. Executive KPI query combining total patients, doctors, appointments, revenue, and average bill.
SELECT
    COUNT(DISTINCT p.Patient_ID) AS Total_Patients,
    COUNT(DISTINCT dr.Doctor_ID) AS Total_Doctors,
    COUNT(DISTINCT a.Appointment_ID) AS Total_Appointments,
    ROUND(SUM(b.Amount), 2) AS Total_Revenue,
    ROUND(AVG(b.Amount), 2) AS Average_Bill
FROM Appointment a
INNER JOIN Doctors dr
    ON a.Doctor_ID = dr.Doctor_ID
INNER JOIN Billing b
    ON a.Appointment_ID = b.Appointment_ID
INNER JOIN Patients p
    ON a.Patient_ID = p.Patient_ID
WHERE b.Payment_Status = 'Paid'
AND a.status="Completed";

---------------------------------