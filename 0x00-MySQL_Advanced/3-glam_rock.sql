-- Lists all bands with Glam rock as their main style, ranked by their longevity
-- Calculates lifespan using the difference between 2022 and the year the band was formed
-- If the band is split, the lifespan calculation stops at the split year

SELECT band_name, 
       CASE 
           WHEN split IS NULL THEN 2022 - formed
           ELSE split - formed
       END AS lifespan
FROM metal_bands
WHERE main_style = 'Glam rock'
ORDER BY lifespan DESC;
