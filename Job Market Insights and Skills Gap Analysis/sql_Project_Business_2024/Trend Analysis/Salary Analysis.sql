SELECT 
    jp.job_title_short,
    COUNT(*) AS total_jobs,
    AVG(jp.salary_year_avg) AS avg_salary,
    MIN(jp.salary_year_avg) AS min_salary,
    MAX(jp.salary_year_avg) AS max_salary
FROM 
    public.job_postings_fact jp
JOIN 
    public.company_dim c ON jp.company_id = c.company_id
JOIN 
    public.skills_job_dim sj ON jp.job_id = sj.job_id
JOIN 
    public.skills_dim s ON sj.skill_id = s.skill_id
GROUP BY 
    jp.job_title_short
ORDER BY 
    avg_salary DESC;  -- Order by highest average salary


-- Comparison Across Companies
SELECT 
    c.name AS company_name,
    jp.job_title_short,
    AVG(jp.salary_year_avg) AS avg_salary
FROM 
    public.job_postings_fact jp
JOIN 
    public.company_dim c ON jp.company_id = c.company_id
WHERE 
    jp.job_title ILIKE '%Data Analyst%' 
GROUP BY 
    c.name, jp.job_title_short
HAVING
    AVG(jp.salary_year_avg) IS NOT NULL
ORDER BY 
    avg_salary DESC; 

WITH SalaryDetails AS (
    SELECT
        jp.job_id,
        jp.job_title,
        jp.job_location,
        jp.salary_year_avg,
        c.name AS company_name,
        ARRAY_AGG(s.skills) OVER (PARTITION BY jp.job_id) AS required_skills
    FROM
        public.job_postings_fact jp
    JOIN
        public.company_dim c ON jp.company_id = c.company_id
    JOIN
        public.skills_job_dim sj ON jp.job_id = sj.job_id
    JOIN
        public.skills_dim s ON sj.skill_id = s.skill_id
),
RankedSalaries AS (
    SELECT
        job_title,
        job_location,
        company_name,
        salary_year_avg,
        required_skills,
        RANK() OVER (PARTITION BY job_title, job_location ORDER BY salary_year_avg DESC) AS salary_rank
    FROM
        SalaryDetails
),
AverageSalaries AS (
    SELECT
        job_title,
        AVG(salary_year_avg) AS avg_salary,
        COUNT(*) AS num_positions
    FROM
        SalaryDetails
    GROUP BY
        job_title
)
SELECT
    RS.job_title,
    RS.job_location,
    RS.company_name,
    RS.salary_year_avg,
    RS.required_skills,
    RS.salary_rank,
    AS.avg_salary
FROM
    RankedSalaries RS
JOIN
    AverageSalaries AS ON RS.job_title = AS.job_title
WHERE
    RS.salary_rank <= 3  -- To show top 3 highest salaries per job title/location
ORDER BY
    RS.job_title,
    RS.salary_rank;


