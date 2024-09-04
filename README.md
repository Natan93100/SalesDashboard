💼 Advanced SQL Job Market Analysis Project

🎯 Project Overview

Welcome to the Advanced SQL Job Market Analysis project! This project is designed to demonstrate advanced SQL skills through the analysis of job postings, company data, skills mapping, and salary analysis. The primary goal is to provide meaningful insights into the job market by leveraging complex SQL queries and data manipulation techniques. 🌟

This project uses PostgreSQL as the database management system, and the queries are designed to be both sophisticated and efficient, showcasing an advanced understanding of SQL.

🚀 Key Features

🔍 Advanced Search and Filtering:
Implemented sophisticated filtering mechanisms to search for jobs based on multiple criteria, such as location, job title, required skills, and more.
💼 Company and Job Title Analysis:
Detailed breakdown of how companies compare across various job titles in terms of the number of job postings and average salaries.
📊 Salary Analysis:
In-depth salary comparison across companies and roles, with a focus on identifying trends and outliers.
📈 Data Aggregation and Reporting:
Aggregated data to generate reports on skills demand, salary ranges, and job market dynamics.
🛠️ Technologies Used

PostgreSQL 13+ - For all database operations.
SQL - The primary query language used for data manipulation and analysis.
GitHub - Version control and collaboration.
Markdown - For documentation and README creation.
📂 Project Structure

graphql
Copy code
├── README.md             # Project documentation
├── SQL
│   ├── create_tables.sql # SQL script to create tables
│   ├── data_insertion.sql# SQL script to insert sample data
│   ├── analysis_queries.sql # Advanced SQL queries for analysis
└── assets
    ├── images            # Directory for images used in the README
    
🔧 Database Schema

The project consists of four primary tables:

company_dim - Stores company-related information such as company_id, name, and link.
skills_dim - Contains skills data, including skill_id and skills (e.g., Python, SQL).
job_postings_fact - Fact table that stores job postings with attributes like job_id, company_id, job_title, salary, etc.
skills_job_dim - A junction table that maps skills to job postings.
SQL Table Creation
Here is the SQL script to create the tables:

sql
Copy code
CREATE TABLE public.company_dim
(
    company_id INT PRIMARY KEY,
    name TEXT,
    link TEXT,
    link_google TEXT,
    thumbnail TEXT
);

CREATE TABLE public.skills_dim
(
    skill_id INT PRIMARY KEY,
    skills TEXT,
    type TEXT
);

CREATE TABLE public.job_postings_fact
(
    job_id INT PRIMARY KEY,
    company_id INT,
    job_title_short VARCHAR(255),
    job_title TEXT,
    job_location TEXT,
    job_via TEXT,
    job_schedule_type TEXT,
    job_work_from_home BOOLEAN,
    search_location TEXT,
    job_posted_date TIMESTAMP,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country TEXT,
    salary_rate TEXT,
    salary_year_avg NUMERIC,
    salary_hour_avg NUMERIC,
    FOREIGN KEY (company_id) REFERENCES public.company_dim (company_id)
);

CREATE TABLE public.skills_job_dim
(
    job_id INT,
    skill_id INT,
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES public.job_postings_fact (job_id),
    FOREIGN KEY (skill_id) REFERENCES public.skills_dim (skill_id)
);
📊 Advanced SQL Queries

1. Advanced Search and Filtering
This query allows users to search for jobs based on location, skills, and other criteria:

sql
Copy code
SELECT 
    jp.job_title, 
    c.name AS company_name, 
    STRING_AGG(s.skills, ', ') AS required_skills, 
    jp.job_location,
    jp.salary_year_avg
FROM 
    public.job_postings_fact jp
JOIN 
    public.company_dim c ON jp.company_id = c.company_id
JOIN 
    public.skills_job_dim sj ON jp.job_id = sj.job_id
JOIN 
    public.skills_dim s ON sj.skill_id = s.skill_id
WHERE 
    jp.job_location = 'New York' 
    AND s.skills IN ('Python', 'SQL')
GROUP BY 
    jp.job_title, c.name, jp.job_location, jp.salary_year_avg
ORDER BY 
    jp.salary_year_avg DESC;
2. Company and Job Title Analysis
This query provides insights into how different companies compensate for the same job titles:

sql
Copy code
SELECT 
    c.name AS company_name,
    jp.job_title,
    AVG(jp.salary_year_avg) AS avg_salary
FROM 
    public.job_postings_fact jp
JOIN 
    public.company_dim c ON jp.company_id = c.company_id
WHERE 
    jp.job_title IN ('Data Scientist', 'Junior Data Scientist', 'Senior Data Scientist')
GROUP BY 
    c.name, jp.job_title
ORDER BY 
    avg_salary DESC;
3. Salary Distribution Analysis
This query breaks down salary distributions into ranges:

sql
Copy code
SELECT 
    CASE
        WHEN salary_year_avg < 50000 THEN 'Less than 50K'
        WHEN salary_year_avg BETWEEN 50000 AND 75000 THEN '50K-75K'
        WHEN salary_year_avg BETWEEN 75001 AND 100000 THEN '75K-100K'
        ELSE 'Above 100K'
    END AS salary_range,
    COUNT(*) AS num_jobs
FROM 
    public.job_postings_fact
GROUP BY 
    salary_range
ORDER BY 
    salary_range;
📈 Data Analysis Insights

Skill Demand Analysis: The demand for specific skills can be inferred from the frequency of their appearance in job postings.
Salary Trends: The analysis reveals how salaries vary across companies and locations, providing a competitive advantage to both job seekers and employers.
Job Market Dynamics: By comparing job titles across companies, we gain insights into how different roles are valued in the industry.
🎨 Visualizations

To better understand the data, we have also included visualizations (not included in this example but recommended for the final project). These could include bar charts, histograms, and pie charts showcasing the distribution of salaries, the demand for specific skills, and the number of job postings per company.

🧠 Challenges & Learning Points

Data Normalization: Ensured that the data model was normalized to avoid redundancy and maintain data integrity.
Optimized Queries: Employed query optimization techniques to handle large datasets efficiently.
Complex Joins: Navigated complex joins and subqueries to extract meaningful insights from the data.
Salary Data Handling: Managed inconsistencies in salary data, such as missing values and different formats (hourly vs. yearly).
💡 Future Enhancements

Real-Time Data Integration: Implementing real-time data integration to keep the job market analysis up-to-date.
Advanced Analytics: Expanding the analysis to include predictive modeling using SQL and integrating machine learning techniques.
Dashboard Creation: Developing an interactive dashboard using tools like Tableau or Power BI to visualize the SQL query results dynamically.
🤝 Contribution

We welcome contributions! Feel free to open issues, submit pull requests, or suggest new features.

📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

Thank you for checking out this project! If you found it helpful or interesting, please give it a star ⭐ on GitHub, and feel free to connect with me on LinkedIn.

