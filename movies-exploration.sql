SELECT * 
 FROM [Movies].[dbo].[movies$]

-- Highest Rated 

SELECT * 
FROM [Movies].[dbo].[movies$]
WHERE score IS NOT NULL 
ORDER BY score DESC

-- Highest Grossing 

SELECT * 
FROM [Movies].dbo.movies$
WHERE gross IS NOT NULL
ORDER BY gross DESC


-- No. of Movies by Genre

SELECT COUNT(genre) AS total_per_genre, genre
FROM Movies.dbo.movies$
GROUP BY genre
ORDER BY total_per_genre DESC

-- Unique Leads 

SELECT DISTINCT(star) AS unique_lead_star
FROM Movies.dbo.movies$
WHERE star IS NOT NULL

-- Averages Per Top 3 Grossing Genres

SELECT genre, AVG(CAST(score AS numeric)), AVG(CAST(gross AS numeric))
FROM Movies.dbo.movies$
WHERE genre = 'Comedy' OR genre = 'Action' OR genre = 'Drama'
GROUP BY genre


-- Movies That Didn't Turn a Profit 

CREATE VIEW no_profit 
	AS
SELECT name, rating, score, released, budget, gross, (budget - gross) AS loss
FROM Movies.dbo.movies$
WHERE budget > gross

SELECT * FROM no_profit

-- Average runtime by genre 

SELECT genre, AVG(CAST(runtime AS int)) AS avg_runtime_minutes
FROM 
Movies.dbo.movies$
GROUP BY genre

-- No. of Movies from each Director / Avg Score and Box Office from each Director

SELECT COUNT(name) AS num_of_movies, director
FROM Movies.dbo.movies$
GROUP BY director

SELECT ROUND(AVG(score), 2), ROUND(AVG(gross), 2), director 
FROM Movies.dbo.movies$
GROUP BY director 

-- Total Movies per Country / Movie Revenue by Country

SELECT COUNT(name) AS total_films, SUM(gross) AS box_office, country 
FROM Movies.dbo.movies$
WHERE gross IS NOT NULL AND country IS NOT NULL
GROUP BY country
ORDER BY total_films DESC, box_office DESC


-- Using Temp Table to find 10 highest grossing 

SELECT name, genre, year, gross 
INTO #TopGrossing
FROM 
Movies.dbo.movies$ 
WHERE gross IS NOT NULL
ORDER BY gross

SELECT TOP (10) *
FROM #TopGrossing
ORDER BY gross DESC


-- Using Temp Table to find 10 highest rated

SELECT name, genre, year, score 
INTO #TopRated
FROM
Movies.dbo.movies$
WHERE score IS NOT NULL
ORDER BY score DESC

SELECT TOP (10) * 
FROM #TopRated
ORDER BY score DESC
