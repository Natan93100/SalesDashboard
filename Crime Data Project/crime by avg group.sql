SELECT 
    crm_cd AS crime_code, 
    CAST(AVG(vict_age) AS INTEGER) AS victim_age
FROM crime_data
WHERE
    vict_age IS NOT NULL 
    AND vict_age <> 0 
    AND crm_cd IS NOT NULL
GROUP BY crm_cd;
