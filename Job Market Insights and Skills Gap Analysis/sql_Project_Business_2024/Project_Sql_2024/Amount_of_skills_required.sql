/* Based On Data_Analysis_Stats which stipulated 
 everything about Data Analysts rolls in the industry, we wanted to know how many are skills required for each
 of the top 10 jobs */


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
),
Rolls_And_Skillls AS (
    SELECT 
        data_analysts_stats.job_id,
        salary_year_avg,
        job_title,
        name as Company_Name,
        skills as Skill_required,
        dense_rank() OVER (ORDER BY salary_year_avg DESC) AS rank
    FROM
        Data_Analysts_Stats
    INNER JOIN 
        skills_job_dim on Data_Analysts_Stats.job_id  =skills_job_dim.job_id
    INNER JOIN 
        skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
        )








SELECT
    job_id,job_title, count(Skill_required) as Amount_of_skills_required
FROM
    Rolls_And_Skillls
WHERE
rank <= 10
GROUP BY
job_id, job_title
ORDER BY
Amount_of_skills_required desc;