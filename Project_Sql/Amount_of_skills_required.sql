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


SELECT *
FROM 