/*
제 6절 ORDER BY 절 

1. ORDER BY 정렬

ORDER BY 절은 조회한 데이터들을 다양한 목적에 맞게 특정 컬럼을 기준으로 정렬, 출력하는데 사용한다.
ORDER BY 절에 컬럼명 대신 SELECT 절에서 사용한 ALIAS명이나 컬럼 순서를 나타내는 정수도 사용 가능하다.
별도로 정렬 방식을 지정하지 않으면 기본적으로 오름차순이 적용되며 SQL 문장의 제일 마지막에 위치한다.

SELECT 컬럼명 [ALIAS명]
FROM 테이블명
[WHERE 조건식]
[GROUP BY 컬럼이나 표현식]
[HAVING 그룹 조건식]
[ORDER BY 컬럼이나 표현식 [ASC 또는 DESC]];

2가지의 정렬 방식이 있다.
 - ASC : 조회한 데이터를 오름차순으로 정렬한다(기본 값이므로 생략 가능).
 - DESC : 조회한 데이터를 내림차순으로 정렬한다.
*/

-- [예제] ORDER BY 절의 예로 선수 테이블에서 선수들의 이름, 포지션, 백넘버를 출력하는데 사람 이름을 내림차순으로 정렬해 출력
SELECT
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버
FROM
    player
ORDER BY
    player_name DESC;
    
-- [예제] ORDER BY 절의 예로 선수 테이블에서 선수들의 이름, 포지션, 백넘버를 출력하는데 선수들의 포지션을 내림차순으로 출력한다. 
-- 컬럼명이 아닌 ALIAS를 이용한다.
SELECT
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버
FROM
    player
ORDER BY
    포지션 DESC; -- NULL 값을 가장 큰 값으로 취급

/*
ORDER BY 절의 특징
 - 기본적인 정렬 순서는 오름차순이다.
 - 숫자형 데이터 타입은 오름차순으로 정렬했을 경우에 가장 작은 값부터 출력된다.
 - 날짜형 데이터 타입은 오름차순으로 정렬했을 경우 날짜 값이 가장 빠른 값이 먼저 출력된다.
 - oracle에서는 NULL을 가장 큰 값으로 간주해 오름차순으로 정렬했을 경우에는 가장 마지막에, 내림차순으로 정렬했을 경우에는 가장 먼저 위치한다.
*/

-- [예제] 한 개의 컬럼이 아닌 여러 가지 컬럼을 기준으로 정렬한다. 키가 큰 순서대로, 키가 같은 경우 백넘버 순으로 정렬한다. 키가 null인 경우는 제외한다.
SELECT
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버,
    height AS 키
FROM
    player
WHERE 
    height IS not NULL
ORDER BY
    height DESC, back_no;

-- [예제] 선수테이블에서 선수들의 이름, 포지션, 백넘버를 출력하는데
-- 선수들의 백넘버 내림차순, 백넘버가 같은경우 포지션, 포지션까지 같은 경우 선수명 순서로 출력한다.
-- back_no가 null인 경우는 제외하고, 컬럼명이나 ALIAS가 아닌 컬럼 순서를 매핑해 사용한다.
SELECT
    player_name AS 선수명,
    position AS 포지션,
    back_no 백넘버
FROM
    player
WHERE 
    back_no IS NOT NULL
ORDER BY 3 DESC, 2, 1;

-- [예제] dept 테이블 정보를 부서명, 지역, 부서번호 내림차순으로 정렬해서 출력한다.
-- case1. 컬럼명 사용 order by 절 사용
SELECT
    dname,
    loc,
    deptno
FROM
    dept
ORDER BY
    dname, loc, deptno DESC;

-- case2. 컬럼명 + alias명 사용 order by 절 사용
SELECT
    dname AS dept,
    loc AS area,
    deptno
FROM
    dept
ORDER BY
    dname, area, deptno DESC;
    
-- case3. 컬럼 순서 번호 + alias 명 사용
SELECT
    dname,
    loc AS area,
    deptno
FROM
    dept
ORDER BY 1, AREA, 3 DESC;

/*
2. SELECT 문장 실행 순서

GROUP BY 절과 ORDER BY가 같이 사용 될 때 SELECT 문장은 6개의 절로 구성되고, SELECT 문장의 수행 단계는 아래와 같다.
 1. 발췌 대상 테이블을 참조한다(FROM).
 2. 발췌 대상 데이터가 아닌 것은 제거한다(WHERE).
 3. 행들을 소그룹화한다(GROUP BY).
 4. 그루핑된 값의 조건에 맞는 것만 출력한다(HAVING).
 5. 데이터 값을 출력, 계산한다(SELECT)
 6. 데이터를 정렬한다(ORDER BY)
*/

-- [예제] SELECT 절에 없는 mgr 컬럼을 ORDER BY 절에 사용한다.
SELECT
    empno,
    ename
FROM
    emp
ORDER BY
    mgr; -- ORDER BY 절에 SELECT 절에서 정의하지 않은 컬럼을 사용해도 문제 없다.
