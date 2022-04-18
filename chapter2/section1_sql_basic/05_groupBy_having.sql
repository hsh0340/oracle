/*
제 5절 GROUP BY, HAVING 절

1. 집계함수

여러 행들의 그룹이 모여서 그룹당 단 하나의 결과를 돌려주는 다중행 함수 중 집계함수의 특성
 - 여러 행들의 그룹이 모여 그룹당 단 하나의 결과를 돌려주는 함수
 - GROUP BY 절은 행들을 소그룹화한다.
 - SELECT 절, HAVING 절, ORDER BY 절에 사용할 수 있다.
 
집계함수명 ([DISTINCT|ALL] 컬럼이나 표현식)
 - ALL : DEFAULT 옵션이므로 생략 가능하다.
 - DISTINCT : 같은 값을 하나의 데이터로 간주할 때 사용하는 옵션이다.

집계함수의 종류 : 주로 숫자 유형에 사용되지만, MAX, MIN, COUNT 함수는 문자, 날짜 유형에도 적용 가능하다.
 - COUNT(*) : NULL 값을 포함한 행의 수를 출력한다.
 - COUNT(표현식) : 표현식의 값이 NULL 값인 것을 제외한 행 수를 출력한다.
 - SUM([DISTINCT | ALL] 표현식) : 표현식의 NULL 값을 제외한 합계를 출력한다.
 - AVG([DISTINCT | ALL] 표현식) : 표현식의 NULL 값을 제외한 평균을 출력한다.
 - MAX([DISTINCT | ALL] 표현식) : 표현식의 최댓값을 출력한다. (문자, 날짜 데이터 타입도 사용가능)
 - MIN([DISTINCT | ALL] 표현식) : 표현식의 최솟값을 출력한다. (문자, 날짜 데이터 타입도 사용가능)
 - STDDEV([DISTINCT | ALL] 표현식) : 표현식의 표준 편차를 출력한다.
 - VARIANCE([DISTINCT | ALL] 표현식) : 표현식의 분산을 출력한다.
*/

-- 일반적으로 집계함수는 GROUP BY 절과 같이 사용하지만 테이블 전체가 하나의 그룹이 되는 경우에는 GROUP BY 절 없이 단독으로 사용 가능
SELECT
    COUNT(*) AS 전체행수, -- 전체 컬럼 
    COUNT(height) AS 키건수, -- NULL인 건은 제외 
    MAX(height) AS 최대키,
    MIN(height) AS 최소키,
    ROUND(AVG(height), 2) AS 평균키
FROM
    player;

/*
2. GROUP BY 절

GROUP BY 절은 FROM절과 WHERE 절 뒤에 오며, 데이터들을 작은 그룹으로 분류해 소그룹에 대한 항목별로 통계 정보를 얻을 때 사용됨

SELECT [DISTINCT] 컬럼명 [ALIAS명]
FROM 테이블명
[WHERE 조건식]
[GROUP BY 컬럼이나 표현식]
[HAVING 그룹조건식];

GROUP BY 절과 HAVING 절은 다음과 같은 특성을 가진다.
 - GROUP BY 절을 통해 소그룹별 기준을 정한 후, SELECT 절에 집계함수를 사용한다.
 - 집계함수의 통계 정보는 NULL 값을 가진 행을 제외하고 수행한다.
 - GROUP BY 절에서는 SELECT 절과는 달리 ALIAS 명을 사용할 수 없다.
 - 집계함수는 WHERE 절에는 올 수 없다. (집계함수를 사용할 수 있는 GROUP BY 절보다 WHERE 절이 먼저 수행된다.)
 - WHERE 절은 전체 데이터를 GROUP으로 나누기 전에 행들을 미리 제거한다.
 - HAVING 절은 GROUP BY 절의 기준 항목이나 소그룹의 집계함수를 이용한 조건을 표시할 수 있다.
 - GROUP BY 절에 의한 소그룹별로 만들어진 집계 데이터 중, HAVING 절에서 제한 조건을 두어 조건을 만족하는 내용만 출력한다.
 - HAVING 절은 일반적으로 GROUP BY 절 뒤에 위치한다.
*/

-- [예제] 케이리그 선수들의 포지션별 키는 어떻게되는가? GROUP BY절을 사용하지 않고 집계함수를 사용하면?
SELECT
    position AS 포지션,
    AVG(height) AS 평균키
FROM
    player; -- 단일 그룹의 함수가 아닙니다.
-- GROUP BY 절에서 그룹 단위를 표시해 주어야 SELECT 절에서 그룹 단위의 컬럼과 집계함수를 사용할 수 있다.

-- [예제] SELECT 절에서 사용된 포지션이라는 한글 ALIAS를 GROUP BY 절의 기준으로 사용해본다.
SELECT
    position AS 포지션,
    AVG(height) AS 평균키
FROM
    player
GROUP BY
    포지션; -- 부적합한 식별자
-- GROUP BY 절에서는 ALIAS를 사용할 수 없다.

-- [예제] 포지션별 최대키, 최소키, 평균키를 출력한다.
SELECT
    position AS 포지션,
    COUNT(*) AS 인원수, 
    COUNT(height) AS 키대상,
    MAX(height) AS 최대키,
    MIN(height) AS 최소키,
    ROUND(AVG(height), 2) AS 평균키
FROM
    player
GROUP BY
    position;

-- 3. HAVING 절
-- [예제] 케이리그 선수들의 포지션별 평균키를 구하는데, 평균키가 180cm 이상인 정보만 표시하라.
SELECT
    position AS 포지션,
    ROUND(AVG(height), 2) AS 평균키
FROM
    player
-- WHERE
    -- AVG(height) >= 180 -- 그룹함수는 허가되지 않습니다.
GROUP BY
    position
HAVING
    AVG(height) >= 180;
-- WHERE 절에는 그룹함수가 허가되지 않는다.
-- GROUP BY절과 HAVING절의 순서를 바꿔도 실행은 잘 되지만 순서를 바꾸지 말자.

-- [예제] 케이리그 선수들 중 삼성블루윙즈와 FC서울의 인원수는 얼마인가?
-- 1번 풀이
SELECT
    team_id AS 팀id,
    COUNT(*) AS 인원수
FROM
    player
WHERE 
    team_id IN('K09', 'K02')
GROUP BY
    team_id;
-- 2번 풀이  
SELECT
    team_id AS 팀id,
    COUNT(*) AS 인원수
FROM
    player
GROUP BY
    team_id
HAVING
    team_id IN('K09', 'K02');
-- 가능하면 WHERE 절에서 조건절을 적용해 GROUP BY의 계산 대상을 줄이는 것이 효율적인 자원 활용 측면에서 바람직하다.

-- [예제] 포지션별 평균 키만 출력하는데, 최대 키가 190 cm 이상인 선수를 갖고있는 포지션의 정보만 출력
SELECT
    position AS 포지션,
    ROUND(AVG(height), 2) AS 평균키
FROM
    player
GROUP BY
    position
HAVING 
    MAX(height) >= 190;

-- 4. CASE 표현을 활용한 월별 데이터 집계
-- [예제] 개별 입사정보에서 월별 데이터를 추출한다.
SELECT
    ename AS 사원명,
    deptno AS 부서번호,
    EXTRACT(MONTH FROM hiredate) AS 입사월,
    sal AS 급여
FROM
   emp;
   
-- [예제] 추출된 MONTH 데이터를 12개의 월별 컬럼으로 구분한다.
SELECT
    ename AS 사원명,
    deptno AS 부서번호,
    CASE MONTH WHEN 1 THEN SAL END AS M01,  CASE MONTH WHEN 2 THEN SAL END AS M02,
    CASE MONTH WHEN 3 THEN SAL END AS M03,  CASE MONTH WHEN 4 THEN SAL END AS M04,
    CASE MONTH WHEN 5 THEN SAL END AS M05,  CASE MONTH WHEN 6 THEN SAL END AS M06,
    CASE MONTH WHEN 7 THEN SAL END AS M07,  CASE MONTH WHEN 6 THEN SAL END AS M08,
    CASE MONTH WHEN 9 THEN SAL END AS M09,  CASE MONTH WHEN 6 THEN SAL END AS M10,
    CASE MONTH WHEN 11 THEN SAL END AS M11,  CASE MONTH WHEN 12 THEN SAL END AS M12
FROM
    (
    SELECT
        ename,
        deptno,
        EXTRACT(MONTH FROM hiredate) AS MONTH,
        sal
    FROM
        emp
    );

-- 5. 집계함수와 NULL 처리
-- [예제] 팀별 포지션별 FW, MF, DF, GK 포지션의 인원수와 팀별 전체 인원수를 구한다.
SELECT
    team_id,
    NVL(SUM(CASE position WHEN 'FW' THEN 1 END), 0) AS FW,
    NVL(SUM(CASE position WHEN 'MF' THEN 1 END), 0) AS MF,
    NVL(SUM(CASE position WHEN 'DF' THEN 1 END), 0) AS DF,
    NVL(SUM(CASE position WHEN 'GK' THEN 1 END), 0) AS GK,
    COUNT(*) AS sum
FROM
    player
GROUP BY
    team_id;

-- [예제] GROUP BY 절 없이 전체 선수들의 포지션별 평균키 및 전체 평균 키를 출력할 수 있다.
SELECT
    ROUND(AVG(CASE WHEN position = 'MF' THEN height END), 2) AS 미드필더,
    ROUND(AVG(CASE WHEN position = 'FW' THEN height END), 2) AS 포워드,
    ROUND(AVG(CASE WHEN position = 'DF' THEN height END), 2) AS 디펜더,
    ROUND(AVG(CASE WHEN position = 'GK' THEN height END), 2) AS 골키퍼,
    ROUND(AVG(height), 2) AS 전체평균키
FROM
    player;