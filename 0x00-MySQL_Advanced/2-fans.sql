-- Ranks country origins of bands, ordered by the number of (non-unique) fans
-- Expects table structure and data from metal_bands.sql
-- Output columns: origin and nb_fans

SELECT origin, SUM(fans) AS nb_fans
FROM metal_bands
GROUP BY origin
ORDER BY nb_fans DESC;
