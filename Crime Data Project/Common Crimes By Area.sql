WITH crime_counts AS (
    SELECT 
        area,
        crm_cd_desc,
        COUNT(crm_cd) AS crime_count
    FROM 
        crime_data
    GROUP BY 
        area, crm_cd_desc
),

ranked_crimes AS (
    SELECT 
        area,
        crm_cd_desc,
        crime_count,
        ROW_NUMBER() OVER (PARTITION BY area ORDER BY crime_count DESC) AS rank
    FROM 
        crime_counts
)

SELECT 
    area,
    crm_cd_desc Crime_Type,
    crime_count 
FROM 
    ranked_crimes
WHERE 
    rank <= 3
ORDER BY 
    area ASC, rank ASC;
