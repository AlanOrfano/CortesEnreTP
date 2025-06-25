WITH MaximosDiarios AS (
    SELECT 
        CAST(fecha_hora AS DATE) AS Dia,
        city_name,
        MAX(Temperatura) AS TempMaxima
    FROM [ClimaTP].[dbo].[Clima]
    GROUP BY CAST(fecha_hora AS DATE), city_name
)

SELECT TOP 10 *
FROM MaximosDiarios
ORDER BY TempMaxima DESC;