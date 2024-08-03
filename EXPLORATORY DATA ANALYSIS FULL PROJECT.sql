-- EXPLORATORY DATA ANALYSIS FULL PROJECT

SELECT*
from layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
from layoffs_staging2;

SELECT*
from layoffs_staging2
WHERE percentage_laid_off =1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
from layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(date), MAX(date)
from layoffs_staging2;

SELECT industry, SUM(total_laid_off)
from layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
from layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT Date, SUM(total_laid_off)
from layoffs_staging2
GROUP BY date
ORDER BY 1 DESC;

SELECT YEAR(Date), SUM(total_laid_off)
from layoffs_staging2
GROUP BY YEAR(Date)
ORDER BY 1 DESC;

SELECT Stage, SUM(total_laid_off)
from layoffs_staging2
GROUP BY Stage
ORDER BY 2 DESC;

SELECT company, AVG(percentage_laid_off)
from layoffs_staging2
GROUP BY company
ORDER BY 2 DESC; 

SELECT SUBSTRING(date ,1,7)  AS MONTH, sum(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(date ,1,7) IS NOT NULL
GROUP BY MONTH
ORDER BY 1 ASC;

-- ROLLING TOTAL

WITH ROLLING_TOTAL AS
(
SELECT SUBSTRING(date ,1,7)  AS MONTH, sum(total_laid_off) AS Total_off
FROM layoffs_staging2
WHERE SUBSTRING(date ,1,7) IS NOT NULL
GROUP BY MONTH
ORDER BY 1 ASC
)
SELECT Month, Total_off
, sum(total_off) OVER(ORDER BY Month) AS rolling_total
FROM ROLLING_TOTAL;

SELECT company, SUM(total_laid_off)
from layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company, YEAR(date), SUM(total_laid_off)
from layoffs_staging2
GROUP BY company,YEAR (date) 
ORDER BY 3 DESC;

-- RANKING 

WITH COMPANY_YEAR (Company, Years, total_laid_off) AS
(
SELECT company, YEAR(date), SUM(total_laid_off)
from layoffs_staging2
GROUP BY company,YEAR (date)
)
SELECT*
FROM COMPANY_YEAR;

WITH COMPANY_YEAR(company, years,  total_laid_off) AS
(
SELECT company, YEAR(date), SUM(total_laid_off)
from layoffs_staging2
GROUP BY company,YEAR (date)
), Company_Years_Ranking AS
(SELECT *, DENSE_RANK () OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM COMPANY_YEAR
WHERE years IS NOT NULL
)
SELECT*
FROM Company_Years_Ranking
WHERE Ranking <=5;

SELECT*
from layoffs_staging2;



