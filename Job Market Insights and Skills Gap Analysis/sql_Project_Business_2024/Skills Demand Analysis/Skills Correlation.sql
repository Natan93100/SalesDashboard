WITH SkillCombinations AS (
    -- Get all possible pairs of skills for each job
    SELECT 
        js1.skill_id AS skill_id_1,
        js2.skill_id AS skill_id_2,
        COUNT(DISTINCT js1.job_id) AS jobs_with_both_skills
    FROM job_skills js1
    JOIN job_skills js2 
        ON js1.job_id = js2.job_id
        AND js1.skill_id < js2.skill_id  -- To avoid duplicates and self-joins
    GROUP BY js1.skill_id, js2.skill_id
),
SkillTotals AS (
    -- Get the total number of jobs where each skill appears
    SELECT 
        skill_id, 
        COUNT(DISTINCT job_id) AS total_jobs
    FROM job_skills
    GROUP BY skill_id
),
SkillCorrelation AS (
    -- Calculate the correlation coefficient for each skill pair
    SELECT 
        sc.skill_id_1,
        sc.skill_id_2,
        sc.jobs_with_both_skills,
        st1.total_jobs AS total_jobs_skill_1,
        st2.total_jobs AS total_jobs_skill_2,
        ROUND( 
            (CAST(sc.jobs_with_both_skills AS DECIMAL) / 
            LEAST(st1.total_jobs, st2.total_jobs)) * 100, 2) AS correlation_percentage
    FROM SkillCombinations sc
    JOIN SkillTotals st1 
        ON sc.skill_id_1 = st1.skill_id
    JOIN SkillTotals st2 
        ON sc.skill_id_2 = st2.skill_id
    WHERE sc.jobs_with_both_skills > 0
    ORDER BY correlation_percentage DESC
)
-- Final output: top skill correlations
SELECT 
    s1.skill_name AS skill_1,
    s2.skill_name AS skill_2,
    sc.correlation_percentage
FROM SkillCorrelation sc
JOIN skills s1 ON sc.skill_id_1 = s1.skill_id
JOIN skills s2 ON sc.skill_id_2 = s2.skill_id
ORDER BY sc.correlation_percentage DESC
LIMIT 10;
