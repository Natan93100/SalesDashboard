
-- Target: Allow users to perform advanced searches across job postings, 
-- companies, and skills using multiple filters and conditions 

SELECT 
    jp.job_id,
    jp.job_title,
    jp.job_location,
    jp.salary_year_avg,
    c.name AS company_name,
    STRING_AGG(s.skills, ', ') AS required_skills
FROM 
    public.job_postings_fact jp
JOIN 
    public.company_dim c ON jp.company_id = c.company_id
JOIN 
    public.skills_job_dim sj ON jp.job_id = sj.job_id
JOIN 
    public.skills_dim s ON sj.skill_id = s.skill_id
WHERE 
    jp.job_title ILIKE '%Data Analyst%'  -- Relevant For Me       
    AND jp.salary_year_avg BETWEEN 70000 AND 120000 -- Salary range filter
    AND s.skills IN ('Python', 'SQL') -- Skills filter
GROUP BY 
    jp.job_id, jp.job_title, jp.job_location, jp.salary_year_avg, c.name
ORDER BY 
    jp.job_posted_date DESC  -- Order by most recent job postings
Limit 1000;