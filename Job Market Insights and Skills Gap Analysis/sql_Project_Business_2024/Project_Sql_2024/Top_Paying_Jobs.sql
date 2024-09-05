-- A query whcich finds the most lucrative rolls in Data Analysis.
-- We also wanted to know The Locatin, Source ans also whether it allowed working remote.
-- The best ten rows roslls are shown.




WITH Data_Analysts_Stats AS (
    SELECT 
        job_id, 
        salary_year_avg,
        job_title,
        Name,
        job_country,
        job_via
    FROM
        job_postings_fact
    LEFT JOIN 
        company_dim 
    ON 
        job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL 
        AND job_work_from_home = 'true'
)

SELECT
    Name AS Company_Name,
    job_title,
    job_id,
    salary_year_avg,
    job_country,
    job_via,
    ROW_NUMBER() OVER (ORDER BY salary_year_avg DESC) AS rank
FROM
    Data_Analysts_Stats
ORDER BY 
    rank
LIMIT 10;
