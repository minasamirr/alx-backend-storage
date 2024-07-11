-- Select band names and calculate their lifespan
-- Lifespan is calculated based on the diff between the formed and split years
-- If a band hasn't split, the current year (2022) is used
-- Only bands with "Glam rock" as their main style are considered
-- Results are ordered by lifespan in descending order
SELECT band_name, (IFNULL(split, '2020') - formed) AS lifespan
    FROM metal_bands
    WHERE FIND_IN_SET('Glam rock', IFNULL(style, "")) > 0
    ORDER BY lifespan DESC;
