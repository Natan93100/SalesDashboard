-- Identify Inconsistencies
SELECT 
    skill_id, 
    skills 
FROM 
    public.skills_dim 
ORDER BY 
    skills;


-- Create a Normalization Mapping
CREATE TEMP TABLE skill_mapping AS 
SELECT 
    LOWER(skills) AS original_skill, 
    CASE 


-- These are the main ones, However 94 More Skills are present
        WHEN LOWER(skills) LIKE '%sql%' THEN 'SQL'
        WHEN LOWER(skills) LIKE '%python%' THEN 'Python'  
        WHEN LOWER(skills) LIKE '%excel%' THEN 'Excel'
        ELSE skills
    END AS normalized_skill
FROM 
    public.skills_dim;


-- Identify duplicates, if there are any.
SELECT 
    skills, 
    COUNT(*) AS count 
FROM 
    public.skills_dim 
GROUP BY 
    skills 
HAVING 
    COUNT(*) > 1;


-- Finds the id's needed for reassigning 
SELECT 
    MIN(skill_id)
FROM 
    public.skills_dim 
WHERE
    skills IN ('powerbi', 'mongodb', 'firebase', 'ruby', 'sqlserver', 'asp.netcore', 'sas')
GROUP BY 
    skills;

SELECT 
    MAX(skill_id)
FROM 
    public.skills_dim 
WHERE
    skills IN ('powerbi', 'mongodb', 'firebase', 'ruby', 'sqlserver', 'asp.netcore', 'sas')
GROUP BY 
    skills;


-- Reassigns all references of old_skill_id to new_skill_id As part of deleting duplicates
UPDATE 
    public.skills_job_dim 
SET 
    skill_id = 30
WHERE 
    skill_id = 144;

UPDATE 
    public.skills_job_dim 
SET 
    skill_id = 7
WHERE 
    skill_id = 186;

UPDATE 
    public.skills_job_dim 
SET 
    skill_id = 203
WHERE 
    skill_id = 205;

UPDATE 
    public.skills_job_dim 
SET 
    skill_id = 164
WHERE 
    skill_id = 166;

UPDATE 
    public.skills_job_dim 
SET 
    skill_id = 71
WHERE 
    skill_id = 72;

UPDATE 
    public.skills_job_dim 
SET 
    skill_id = 66
WHERE 
    skill_id = 82;

UPDATE 
    public.skills_job_dim 
SET 
    skill_id = 18
WHERE 
    skill_id = 62;


-- Remove duplicates by keeping the lowest skill_id
DELETE FROM 
    public.skills_dim 
WHERE 
    skill_id NOT IN (
        SELECT 
            MIN(skill_id) 
        FROM 
            public.skills_dim 
        GROUP BY 
            skills
    );


-- Sanity Check
SELECT 
     skills 
FROM 
    public.skills_dim 
ORDER BY 
    skills;

