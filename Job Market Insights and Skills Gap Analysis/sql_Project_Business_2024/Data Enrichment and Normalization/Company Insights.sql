/* Enhance the company_dim table by enriching it with 
additional attributes like company size, industry, or other relevant data */


CREATE TEMP TABLE company_enrichment AS 
SELECT 
    company_id, 
    company_size, 
    industry 
FROM 
    external_company_data;

ALTER TABLE public.company_dim 
ADD COLUMN company_size VARCHAR(50), 
ADD COLUMN industry VARCHAR(50);

UPDATE 
    public.company_dim 
SET 
    company_size = company_enrichment.company_size, 
    industry = company_enrichment.industry 
FROM 
    company_enrichment 
WHERE 
    public.company_dim.company_id = company_enrichment.company_id;

UPDATE 
    public.company_dim 
SET 
    company_size = 'Unknown' 
WHERE 
    company_size IS NULL;

UPDATE 
    public.company_dim 
SET 
    industry = 'Other' 
WHERE 
    industry IS NULL;

-- Sanity Check

SELECT 
    * 
FROM 
    public.company_dim 
ORDER BY 
    company_size;
