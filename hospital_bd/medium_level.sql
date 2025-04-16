

/* Show unique birth years from patients and order them by ascending. */

SELECT
  DISTINCT YEAR(birth_date) AS birth_year
FROM patients
ORDER BY birth_year;

SELECT year(birth_date)
FROM patients
GROUP BY year(birth_date);

/* Show unique first names from the patients table which only occurs once in the list.
For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. 
If only 1 person is named 'Leo' then include them in the output. */

SELECT first_name from patients
group by first_name
having count(*) == 1;

SELECT first_name
FROM (
    SELECT
      first_name,
      count(first_name) AS occurrencies
    FROM patients
    GROUP BY first_name
  )
WHERE occurrencies = 1;

/* Show patient_id and first_name from patients where their first_name 
start and ends with 's' and is at least 6 characters long. */

SELECT
  patient_id,
  first_name
FROM patients
WHERE first_name LIKE 's____%s';

SELECT
  patient_id,
  first_name
FROM patients
WHERE
  first_name LIKE 's%s'
  AND len(first_name) >= 6;

SELECT
  patient_id,
  first_name
FROM patients
where
  first_name like 's%'
  and first_name like '%s'
  and len(first_name) >= 6;

/* Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.

Primary diagnosis is stored in the admissions table. */

SELECT
  patients.patient_id,
  first_name,
  last_name
FROM patients
  JOIN admissions ON admissions.patient_id = patients.patient_id
WHERE diagnosis = 'Dementia';

SELECT
  patient_id,
  first_name,
  last_name
FROM patients
WHERE patient_id IN (
    SELECT patient_id
    FROM admissions
    WHERE diagnosis = 'Dementia');

SELECT
  patient_id,
  first_name,
  last_name
FROM patients p
WHERE 'Dementia' IN (
    SELECT diagnosis
    FROM admissions
    WHERE admissions.patient_id = p.patient_id
  );


/* Display every patient's first_name.
Order the list by the length of each name and then by alphabetically. */

SELECT first_name
FROM patients
order by
  len(first_name),
  first_name;


/* Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row. */

SELECT 
  (SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
  (SELECT count(*) FROM patients WHERE gender='F') AS female_count;


SELECT 
  SUM(Gender = 'M') as male_count, 
  SUM(Gender = 'F') AS female_count
FROM patients

select 
  sum(case when gender = 'M' then 1 end) as male_count,
  sum(case when gender = 'F' then 1 end) as female_count 
from patients;