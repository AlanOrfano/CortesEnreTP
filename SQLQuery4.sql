
--1. top 10 localidades con corte
SELECT TOP 10 Localidad, COUNT(*) AS CantidadCortes
FROM [CortesEnreTp].[dbo].[cortes_enre]
GROUP BY Localidad
ORDER BY CantidadCortes DESC;

--2. top 15 de 6 meses de cortes por usuarios
	--Explicación:
--Agrupamos por Localidad, Prestadora, Severidad y TipoCorte para tener un detalle muy claro de dónde, quién y qué tipo de corte impacta más.

--Sumamos la cantidad de usuarios afectados por grupo (usando TRY_CAST para evitar errores con datos inválidos).

--Ordenamos para mostrar primero los casos con más usuarios afectados y más cortes.

--Qué hace: Resumen con detalle por prestadora, severidad, localidad y tipo de corte. Permite tener un informe profesional y detallado para toma de decisiones.
SELECT top 15
    Localidad,
    Prestadora, 
    Severidad, 
    TipoCorte,
    COUNT(*) AS CantidadCortes, 
    SUM(TRY_CAST(UsuariosAfectados AS INT)) AS TotalUsuariosAfectados
FROM [CortesEnreTp].[dbo].[cortes_enre]
WHERE TRY_CAST(UsuariosAfectados AS INT) IS NOT NULL
GROUP BY 
    Localidad,
    Prestadora, 
    Severidad,
    TipoCorte
ORDER BY 
    TotalUsuariosAfectados DESC,
    CantidadCortes DESC;

	
	--3. Cortes por mes
	--Qué hace: Muestra la cantidad de cortes y usuarios afectados agrupados por mes. Útil para detectar patrones estacionales o meses con mayor impacto.
SELECT 
    FORMAT(TRY_CAST(FechaInicio AS DATETIME), 'yyyy-MM') AS Mes,
    COUNT(*) AS Cortes,
    SUM(UsuariosAfectados) AS UsuariosAfectados
FROM [CortesEnreTp].[dbo].[cortes_enre]
WHERE TRY_CAST(FechaInicio AS DATETIME) IS NOT NULL
GROUP BY FORMAT(TRY_CAST(FechaInicio AS DATETIME), 'yyyy-MM')
ORDER BY Mes;
 
 