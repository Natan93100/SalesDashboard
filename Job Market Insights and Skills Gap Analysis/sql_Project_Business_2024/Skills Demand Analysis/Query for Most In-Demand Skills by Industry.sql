WITH IndustrySkillCounts AS (
    SELECT
        s.skills,
        i.industry,
        COUNT(jp.job_id) AS demand_count
    FROM
        job_postings_fact jp
    JOIN
        skills_job_dim sj ON jp.job_id = sj.job_id
    JOIN
        skills_dim s ON sj.skill_id = s.skill_id
    JOIN
        industries_dim i ON jp.industry_id = i.industry_id
    GROUP BY
        s.skills, i.industry
),
TotalIndustryDemands AS (
    SELECT
        industry,
        SUM(demand_count) AS total_demand
    FROM
        IndustrySkillCounts
    GROUP BY
        industry
)
SELECT
    isc.skills,
    isc.industry,
    isc.demand_count,
    ROUND((isc.demand_count * 100.0) / tid.total_demand, 2) AS percentage_demand
FROM
    IndustrySkillCounts isc
JOIN
    TotalIndustryDemands tid ON isc.industry = tid.industry
ORDER BY
    isc.industry, isc.demand_count DESC;
