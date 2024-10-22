/*What are the most optimal skills to learn (it's a in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrate on remote positions with specified salaries
- Why? Targets skills that offer job security and financial benefits, offering strategic insight
for career development in data analysis
*/
WITH skill_demand AS(
    SELECT 
        skills,
        COUNT(skills_job_dim.skill_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        salary_year_avg IS NOT NULL 
        AND job_work_from_home = TRUE
    GROUP BY 
        skill_id
)

WITH average_salary AS(
    SELECT
        skills,
        ROUND(AVG(salary_year_avg),0) AS avg_salary
    FROM job_postings_fact 
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        salary_year_avg IS NOT NULL 
        AND job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
    GROUP BY 
        skill_id
)