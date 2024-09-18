
WITH New_Table AS (
    SELECT 
        weapon_desc,
        vict_descent,
        ROW_NUMBER() OVER (PARTITION BY weapon_desc, vict_descent ORDER BY weapon_desc) AS rank_count
    FROM 
        crime_data
    WHERE 
        weapon_desc IS NOT NULL 
        AND vict_descent IS NOT NULL
),
New_Table_2 AS (
    SELECT 
        weapon_desc,
        MAX(rank_count) AS max_rank_count
    FROM 
        New_Table
    GROUP BY 
        weapon_desc
)

SELECT * 
FROM
    New_Table
INNER JOIN
New_Table_2 ON New_Table.rank_count = New_Table_2.max_rank_count
AND NEW_TABLE.Weapon_Desc = New_Table_2.Weapon_Desc




