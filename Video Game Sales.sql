SELECT * FROM video_game_sales LIMIT 10;

SELECT * FROM video_game_sales
WHERE name IS NULL OR year IS NULL;

DELETE FROM video_game_sales
WHERE name IS NULL OR year IS NULL;

SELECT name, platform, year_, genre, publisher, na_sales, eu_sales, jp_sales, other_sales, global_sales,
       COUNT(*) AS row_count
FROM video_game_sales
GROUP BY name, platform, year_, genre, publisher, na_sales, eu_sales, jp_sales, other_sales, global_sales
HAVING COUNT(*) > 1;

WITH ranked_games AS (
  SELECT *,
         ROW_NUMBER() OVER (
           PARTITION BY name, platform, year_, genre, publisher, na_sales, eu_sales, jp_sales, other_sales, global_sales
           ORDER BY name
         ) AS row_num
  FROM video_game_sales
)
DELETE FROM video_game_sales
WHERE name IN (
  SELECT name FROM ranked_games WHERE row_num > 1
);

DELETE vgs
FROM video_game_sales vgs
JOIN duplicates_to_delete dup
ON vgs.name = dup.name
   AND vgs.platform = dup.platform
   AND vgs.year_ = dup.year
   AND vgs.genre = dup.genre
   AND vgs.publisher = dup.publisher
   AND vgs.na_sales = dup.na_sales
   AND vgs.eu_sales = dup.eu_sales
   AND vgs.jp_sales = dup.jp_sales
   AND vgs.other_sales = dup.other_sales
   AND vgs.global_sales = dup.global_sales;
   
   SELECT name, global_sales
FROM video_game_sales
ORDER BY global_sales DESC
LIMIT 10;

SELECT Platform, SUM(Global_sales) AS Total_sales
FROM video_game_sales
GROUP BY Platform
ORDER BY Total_sales DESC;

SELECT * FROM video_game_sales;