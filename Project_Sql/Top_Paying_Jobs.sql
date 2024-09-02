SELECT count(job_id)
from job_postings_fact
where job_title_short = 'Data Analyst' and extract(year from job_posted_date) = 2023 and job_no_degree_mention = 'true'


SELECT count(job_id)
from job_postings_fact
where job_title_short = 'Data Analyst' and extract(year from job_posted_date) = 2023