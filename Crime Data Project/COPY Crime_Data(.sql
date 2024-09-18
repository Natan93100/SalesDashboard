COPY Crime_Data(
    DR_NO,
    Date_Rptd,
    DATE_OCC,
    TIME_OCC,
    AREA,
    AREA_NAME,
    Rpt_Dist_No,
    Part_1_2,
    Crm_Cd,
    Crm_Cd_Desc,
    Mocodes,
    Vict_Age,
    Vict_Sex,
    Vict_Descent,
    Premis_Cd,
    Premis_Desc,
    Weapon_Used_Cd,
    Weapon_Desc,
    Status,
    Status_Desc,
    Crm_Cd_1,
    Crm_Cd_2,
    Crm_Cd_3,
    Crm_Cd_4,
    LOCATION,
    Cross_Street,
    LAT,
    LON
)
FROM '/Users/nathans/Desktop/Crime Data Project/Crime_Data_from_2020_to_Present.csv' 
DELIMITER ',' 
CSV HEADER;

\copy crime_data FROM '/Users/nathans/Desktop/Crime Data Project/Crime_Data_from_2020_to_Present.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
