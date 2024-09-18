WITH new_table AS (
    SELECT    
        row_number() OVER (PARTITION BY vict_age, vict_sex, vict_descent ORDER BY crm_cd) AS rank,
        crm_cd,
        vict_age, 
        vict_sex, 
        vict_descent,
        crm_cd_desc
    FROM 
        crime_data
    WHERE
        vict_age IS NOT NULL 
        AND vict_age <> 0 
        AND vict_age <> -1 
        AND vict_age <> -2
        AND vict_sex IS NOT NULL
        AND vict_descent IS NOT NULL
        AND area IS NOT NULL
),

ranked_table AS (
    SELECT
        crm_cd,
        vict_age,
        vict_sex,
        vict_descent,
        crm_cd_desc,
        rank,
        ROW_NUMBER() OVER (PARTITION BY crm_cd ORDER BY rank DESC) AS row_num
    FROM 
        new_table
)

SELECT
    crm_cd_desc Crime_Name, 
    vict_age Age, 
    vict_sex Sex, 
    vict_descent Race,
    rank number_of_cases
FROM 
    ranked_table
WHERE 
    row_num = 1;
