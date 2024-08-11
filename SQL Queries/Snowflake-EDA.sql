SELECT * FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA LIMIT 100;

-------=======================================================================================================================================================
---// Hipóteses para a Análise Exploratória de Dados (EDA):

-- OBS: Levando em consideração o LOS
---- LOS: LOS (Length of Stay) refere-se à duração da internação de um paciente em um hospital ou outra instituição de saúde. 
---       Esse termo é amplamente utilizado na área da saúde para medir o tempo, geralmente em dias, que um paciente permanece internado desde a admissão até a alta.
---       O LOS é um indicador importante para a gestão hospitalar, pois pode refletir a eficiência dos cuidados prestados e ajudar a identificar possíveis áreas de melhoria, como otimização de recursos e custos. 
---       Por exemplo, um LOS mais curto pode indicar que os pacientes estão recebendo cuidados eficazes e sendo liberados mais rapidamente, enquanto um LOS prolongado pode sugerir complicações ou necessidade de monitoramento adicional.


--1. Análise Univariada
--2. A duração da internação dos pacientes (LOS) muda de acordo com o código do tipo de hospital (HOSPITAL_TYPE_CODE)?
--3. A duração da internação dos pacientes (LOS) muda de acordo com o código da cidade do hospital (CITY_CODE_HOSPITAL)?
--4. A duração da internação dos pacientes (LOS) muda de acordo com o código da região do hospital (HOSPITAL_REGION_CODE)?
--5. Qual o impacto do DEPARTAMENTO de admissão na duração da internação (LOS)?
--6. Como a combinação de DEPARTAMENTO e código da região do hospital (HOSPITAL_REGION_CODE) afeta a duração da internação (LOS)?
--7. Mais QUARTOS EXTRAS DISPONÍVEIS NO HOSPITAL afetam a duração da internação dos pacientes (LOS)?
--8. O TIPO DE ADMISSÃO influencia a duração da internação (LOS)?
--9. A GRAVIDADE DA DOENÇA afeta a duração da internação (LOS)?
--10. A IDADE impacta a duração da internação (LOS)?
--11. O DEPÓSITO DE ADMISSÃO tem relação com a duração da internação (LOS)?
--12. Pacientes com doenças mais graves recebem mais visitantes?
--13. Existe diferença na duração da internação (LOS) para diferentes TIPOS DE ALA e CÓDIGO DE FACILIDADE DE ALA em cada DEPARTAMENTO?
--14. A CLASSIFICAÇÃO DO LEITO (BED_GRADE) influencia a duração da internação dos pacientes (LOS)?
--15. Pacientes mais jovens recebem mais visitantes que os pacientes mais velhos?
--16. Quais tipos de doença e admissão são mais comuns entre pacientes com menos de 30 anos e em qual departamento a maioria deles é admitida?
--17. Pacientes com menos de 40 anos pagam um DEPÓSITO DE ADMISSÃO maior quando são internados?

-------=======================================================================================================================================================

-- // 1. Análise Univariada //

-- Quantidade e distribuição única de códigos de hospital
SELECT HOSPITAL_CODE, COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Quantidade e distribuição única de códigos de tipo de hospital
SELECT HOSPITAL_TYPE_CODE, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Quantidade e distribuição única de códigos de cidade do hospital
SELECT CITY_CODE_HOSPITAL, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,
        COUNT(DISTINCT HOSPITAL_TYPE_CODE) AS CNT_HOSPITAL_TYPE_CODE,
        COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Quantidade e distribuição única de códigos de região do hospital
SELECT HOSPITAL_REGION_CODE, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,
        COUNT(DISTINCT HOSPITAL_TYPE_CODE) AS CNT_HOSPITAL_TYPE_CODE,
        COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Quantidade e distribuição única de departamentos
SELECT DEPARTMENT, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,
        COUNT(DISTINCT HOSPITAL_TYPE_CODE) AS CNT_HOSPITAL_TYPE_CODE,
        COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Quantidade e distribuição única de classificação de leitos
SELECT BED_GRADE, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,
        COUNT(DISTINCT HOSPITAL_TYPE_CODE) AS CNT_HOSPITAL_TYPE_CODE,
        COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Quantidade e distribuição única de tipos de admissão
SELECT TYPE_OF_ADMISSION, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,
        COUNT(DISTINCT HOSPITAL_TYPE_CODE) AS CNT_HOSPITAL_TYPE_CODE,
        COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Quantidade e distribuição única de gravidade da doença
SELECT SEVERITY_OF_ILLNESS, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,
        COUNT(DISTINCT HOSPITAL_TYPE_CODE) AS CNT_HOSPITAL_TYPE_CODE,
        COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

-- Quantidade e distribuição única de faixas etárias
SELECT AGE, COUNT(DISTINCT HOSPITAL_CODE) AS CNT_HOSPITAL_CODE,
        COUNT(DISTINCT HOSPITAL_TYPE_CODE) AS CNT_HOSPITAL_TYPE_CODE,
        COUNT(*) AS CNT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
GROUP BY 1
ORDER BY 2 DESC;

----========================================================================

-- // 2/3/4. A duração da internação dos pacientes (LOS) muda de acordo com o código do tipo de hospital (HOSPITAL_TYPE_CODE) / código da cidade do hospital (CITY_CODE_HOSPITAL) / código da região do hospital (HOSPITAL_REGION_CODE)? //

SELECT HOSPITAL_TYPE_CODE, 
        MIN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

SELECT CITY_CODE_HOSPITAL, 
        MIN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

SELECT HOSPITAL_REGION_CODE, 
        MIN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

----========================================================================

-- // 5. Qual o impacto do DEPARTAMENTO de admissão na duração da internação (LOS)? //

SELECT DEPARTMENT, 
        MIN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

----========================================================================

-- // 6. Como a combinação de DEPARTAMENTO e código da região do hospital (HOSPITAL_REGION_CODE) afeta a duração da internação (LOS)? //

SELECT DEPARTMENT,HOSPITAL_REGION_CODE, 
        MIN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1,2;

----========================================================================

-- // 7. Mais QUARTOS EXTRAS DISPONÍVEIS NO HOSPITAL afetam a duração da internação dos pacientes (LOS)? // (Insight)

SELECT AVAILABLE_EXTRA_ROOMS_IN_HOSPITAL,
        MIN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

----========================================================================

-- // 8. O TIPO DE ADMISSÃO influencia a duração da internação (LOS)? //

SELECT TYPE_OF_ADMISSION,
        MIN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

----========================================================================

-- // 9. A GRAVIDADE DA DOENÇA afeta a duração da internação (LOS)? //

SELECT SEVERITY_OF_ILLNESS,
        MIN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

----========================================================================

-- // 10. A IDADE impacta a duração da internação (LOS)? //

SELECT AGE,
        MIN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

----========================================================================

-- // 11. O DEPÓSITO DE ADMISSÃO tem relação com a duração da internação (LOS)? //

SELECT DISTINCT ADMISSION_DEPOSIT FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA; --- Ranges from 1800 to 11000

WITH BASE AS (

    SELECT ADMISSION_DEPOSIT,
            CASE WHEN ADMISSION_DEPOSIT <= 3000 THEN '1. Less than 3K'
                 WHEN ADMISSION_DEPOSIT > 7000 THEN '3. Greater than 7K'   
            ELSE '2. Between 3K to 7K' END AS DEPOSIT_BUCKET,
            ADMISSION_DATE,
            DISCHARGE_DATE,
            CASE_ID
    FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
)

-- SELECT * FROM BASE;

SELECT DEPOSIT_BUCKET,
        MIN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MEDIAN_LOS,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES
FROM BASE
GROUP BY 1
ORDER BY 1;

----========================================================================

-- // 12. Pacientes com doenças mais graves recebem mais visitantes? // (Insight)

SELECT SEVERITY_OF_ILLNESS,
        MIN(VISITORS_WITH_PATIENT) AS MIN_VISITORS,
        MAX(VISITORS_WITH_PATIENT) AS MAX_VISITORS,
        AVG(VISITORS_WITH_PATIENT) AS AVG_VISITORS,
        MEDIAN(VISITORS_WITH_PATIENT) AS MEDIAN_VISITORS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

----========================================================================

-- // 13. Existe diferença na duração da internação (LOS) para diferentes TIPOS DE ALA e CÓDIGO DE FACILIDADE DE ALA em cada DEPARTAMENTO? //

SELECT DEPARTMENT,WARD_TYPE,WARD_FACILITY_CODE,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES,
        MIN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1,2,3
ORDER BY 1,2,3;

SELECT DEPARTMENT,SEVERITY_OF_ILLNESS,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES,
        MIN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1,2
ORDER BY 1,2;

----========================================================================

-- // 14. A CLASSIFICAÇÃO DO LEITO (BED_GRADE) influencia a duração da internação dos pacientes (LOS)? //

SELECT BED_GRADE,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES,
        MIN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

SELECT SEVERITY_OF_ILLNESS,BED_GRADE,
        COUNT(DISTINCT CASE_ID) AS CNT_CASES,
        MIN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MIN_LOS,
        MAX(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MAX_LOS,
        AVG(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS AVG_LOS,
        MEDIAN(DATEDIFF(day,ADMISSION_DATE,DISCHARGE_DATE)) AS MEDIAN_LOS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1,2
ORDER BY 1,2;

----========================================================================

-- // 15. Pacientes mais jovens recebem mais visitantes que os pacientes mais velhos? // (Insight)

SELECT AGE,
        MIN(VISITORS_WITH_PATIENT) AS MIN_VISITORS,
        MAX(VISITORS_WITH_PATIENT) AS MAX_VISITORS,
        AVG(VISITORS_WITH_PATIENT) AS AVG_VISITORS,
        MEDIAN(VISITORS_WITH_PATIENT) AS MEDIAN_VISITORS
FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA 
GROUP BY 1;

----========================================================================

-- // 16. Quais tipos de doença e admissão são mais comuns entre pacientes com menos de 30 anos e em qual departamento a maioria deles é admitida? // (Insight)

WITH BASE AS (

    SELECT * 
    FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
    WHERE AGE IN ('0-10','20-Nov','21-30')

),

ILLNESS_N_ADMISSION AS (

    SELECT TYPE_OF_ADMISSION, SEVERITY_OF_ILLNESS,
            COUNT(DISTINCT CASE_ID) AS CNT_CASES
    FROM BASE 
    GROUP BY 1,2
    ORDER BY 1,2
),

DEPARTMENT AS (

    SELECT DEPARTMENT, COUNT(DISTINCT CASE_ID) AS CNT_CASES
    FROM BASE 
    GROUP BY 1

)

-- SELECT * FROM BASE; -- 43,417 cases

-- SELECT * FROM ILLNESS_N_ADMISSION;

SELECT * FROM DEPARTMENT;

----========================================================================

-- // 17. Pacientes com menos de 40 anos pagam um DEPÓSITO DE ADMISSÃO maior quando são internados? //

WITH BASE AS (

    SELECT *,
            CASE WHEN AGE IN ('0-10','20-Nov','21-30','31-40') THEN 1 ELSE 0 END AS BELOW_40_IND            
    FROM HEALTHDB.HEALTHSCHEMA.HEALTH_DATA
)

SELECT BELOW_40_IND,
        MIN(ADMISSION_DEPOSIT) AS MIN_DEP,
        MAX(ADMISSION_DEPOSIT) AS MAX_DEP,
        AVG(ADMISSION_DEPOSIT) AS AVG_DEP
FROM BASE 
GROUP BY 1;

