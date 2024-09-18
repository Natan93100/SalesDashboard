WITH new_table AS (
    SELECT
        AREA_NAME,
        premis_desc,
        ROW_NUMBER() OVER (PARTITION BY AREA_NAME, premis_desc ORDER BY AREA_NAME) AS rank
    FROM crime_data
    ORDER BY AREA_NAME
),
new_table_2 AS (
    SELECT AREA_NAME, MAX(rank) AS max_rank
    FROM new_table
    GROUP BY AREA_NAME
)
SELECT new_table.AREA_NAME, new_table.premis_desc 
FROM new_table
INNER JOIN new_table_2 
    ON new_table.AREA_NAME = new_table_2.AREA_NAME 
    AND new_table.rank = new_table_2.max_rank;
