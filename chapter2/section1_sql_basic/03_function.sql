/*
제 3절 함수

1. 내장 함수 개요

내장 함수 : 각 벤더에서 제공하는 데이터베이스를 설치하면 기본적으로 제공되는 함수.
함수는 입력되는 값이 아무리 많아도 출력은 하나만 되는 M:1 관계이다.

  1) 단일행 함수(Single-Row Function) : 함수 입력 값이 단일행, 단일행 내에 있는 하나의 값 또는 여러 값이 인수로 표현 
    - 문자형 함수 : 문자를 입력하면 문자나 숫자값을 반환한다.
    - 숫자형 함수 : 숫자를 입력하면 숫자 값을 반환한다.
    - 날짜형 함수 : DATE 타입의 값을 연산한다.
    - 변환형 함수 : 문자, 숫자, 날짜형 값의 데이터 타입을 변환한다.
    - NULL 관련 함수 : NULL을 처리하기 위한 함수 
   
    * 단일행 함수의 중요한 특징
      - SELECT, WHERE, ORDER BY 절에 사용 가능하다.
      - 각 행들에 대해 개별적으로 작용해 데이터 값들을 조작하고, 각각의 행에 대한 조작 결과를 리턴한다.
      - 여러 인자(Arguments)를 입력해도 단 하나의 결과만 리턴한다.
      - 함수의 인자로 상수,변수,표현식이 사용 가능하고, 하나의 인수를 가지는 경우도 있지만 여러개의 인수를 가질 수도 있다.
      - 특별한 경우가 아니면 함수의 인자로 함수를 사용하는 함수의 중첩이 가능하다.
      
  2) 다중행 함수(Multi-Row Function) : 함수 입력 값이 다중행 
    - 집계 함수(Aggregate Function)
    - 그룹 함수(Group Function)
    - 윈도우 함수(Window Function)
    
2. 문자형 함수

문자형 함수 : 문자 데이터를 매개 변수로 받아들여서 문자나 숫자 값의 결과를 돌려주는 함수.
  - LOWER(문자열) : 문자열의 알파벳 문자를 소문자로 바꾸어 준다.
  - UPPER(문자열) : 문자열의 알파벳 문자를 대문자로 바꾸어 준다.
  - ASCII(문자) : 문자나 숫자를 ASCII 코드 번호로 바꾸어 준다.
  - CHR(ASCII번호) : ASCII 코드 번호를 문자나 숫자로 바꾸어 준다.
  - CONCAT(문자열1, 문자열2) : 문자열1과 문자열2를 연결한다. 합성연산자 (||)와 동일하다.
  - SUBSTR(문자열, m[, n]) : 문자열 중 m의 위치에서 n개의 문자 길이에 해당하는 문자를 돌려준다. n이 생략되면 마지막 문자까지이다.
  - LENGTH(문자열) : 문자열의 개수를 숫자값으로 돌려준다.
  - LTRIM(문자열 [,지정문자]) : 문자열의 첫 문자부터 확인해서 지정 문자가 나타나면 해당 문자를 제거한다(지정 문자가 생략되면 공백 값이 디폴트).
  - RTRIM(문자열 [,지정문자]) : 문자열의 마지막 문자부터 확인해서 지정 문자가 나타나는 동안 해당 문자를 제거한다(지정 문자가 생략되면 공백 값이 디폴트).
  - TRIM([leading|trailing|both] 지정문자 FROM 문자열) : 문자열에서 머리말, 꼬리말 또는 양쪽에 있는 지정문자를 제거한다(leading|trailing|both가 생략되면 both가 디폴트).
*/

SELECT LOWER('SQL Expert') FROM dual; -- sql expert
SELECT UPPER('SQL Expert') FROM dual; -- SQL EXPERT
SELECT ASCII('A') FROM dual; -- 65
SELECT CHR(65) FROM dual; -- A
SELECT CONCAT('RDBMS', ' SQL') FROM dual; -- RDBMS SQL
SELECT 'RDBMS' || ' SQL' FROM dual; -- RDBMS SQL
SELECT SUBSTR('SQL Expert', 5, 3) FROM dual; -- Exp, 띄어쓰기 포함해서 5번째(sql은 1부터 셈)~ 3글자
SELECT LENGTH('SQL Expert') FROM dual; -- 10
SELECT LTRIM('xxxYYZZxYZ', 'x') FROM dual; -- YYZZxYZ
SELECT RTRIM('XXYYzzYYzz', 'z') FROM dual; -- XXYYzzYY
SELECT TRIM('x' FROM 'xxYYZZxYZxx') FROM dual; -- YYZZxYZ

-- [예제] 'SQL Expert'라는 문자형 데이터의 길이를 구하는 문자형 함수를 사용한다.
SELECT
    LENGTH('SQL Expert')
FROM
    dual;

/*
Oracle은 SELECT절과 FROM절을 SELECT문장의 필수 절로 지정했으므로, 사용자 테이블이 필요 없는 문장에도 필수적으로 dual이라는 테이블을 FROM절에 지정한다.
dual테이블의 특성
  - 사용자 sys가 소유하며 모든 사용자가 액세스 가능한 테이블이다.
  - SELECT ~ FROM ~ 의 형식을 갖추기 위한 일종의 dummy 테이블이다.
  - dummy라는 문자열 유형의 칼럼에 'X'라는 값이 들어있는 행 1건을 포함하고 있다.
*/

-- [예제] Oracle
DESC dual;

/* [실행 결과]
이름    널? 유형          
----- -- ----------- 
DUMMY    VARCHAR2(1)
*/

SELECT
    *
FROM
    dual;
    
/* [실행 결과]
D
-
X
*/

-- [예제] 선수 테이블에서 CONCAT 문자형 함수를 이용해 축구선수란 문구를 추가한다.
SELECT 
    CONCAT(player_name, ' 축구선수') AS 선수명 -- SELECT player_name || ' 축구선수' 와 같음 
FROM
    player;

-- [예제] 경기장의 지역번호와 전화번호를 합친 번호의 길이를 구하시오.
SELECT
    stadium_id,
    ddd || ')' || tel AS tel, --- ddd : 지역번호, tel : 전화번호 
    LENGTH(ddd || '-' || tel) AS t_len
FROM
    stadium;
    
/*
3. 숫자형 함수

숫자형 함수 : 숫자 데이터를 입력받아 처리하고 숫자를 리턴하는 함수
  - ABS(숫자) : 숫자의 절댓값을 돌려준다.
  - SIGN(숫자) : 숫자가 양수인지, 음수인지 0인지를 구별한다.
  - MOD(숫자1, 숫자2) : 숫자1을 숫자2로 나누어 나머지 값을 리턴한다. % 연산자로 대체 가능
  - CEIL(숫자) : 숫자보다 크거나 같은 최소 정수를 리턴한다.
  - FLOOR(숫자) : 숫자보다 작거나 같은 최대 정수를 리턴한다.
  - ROUND(숫자 [, m]) : 숫자를 소수점 m자리까지 반올림해 리턴한다. m이 생략되면 디폴트 값은 0
  - TRUNC(숫자 [, m]) : 숫자를 소수 m자리에서 잘라서 버린다. m이 생략되면 디폴트 값은 0
  - SIN, COS, TAN, ... : 숫자의 삼각함수 값을 리턴한다.
  - EXP(숫자) : 숫자의 지수값을 리턴한다. 즉 e의 숫자 제곱 값을 리턴한다.
  - POWER(숫자1, 숫자2) : 숫자의 거듭제곱 값을 리턴한다. 즉 숫자1의 숫자2 제곱 값을 리턴
  - SQRT(숫자) : 숫자의 제곱근 값을 리턴한다.
  - LOG(숫자1, 숫자2) : 숫자1을 밑수로 하는 숫자2의 로그값을 리턴한다.
  - LN(숫자) : 숫자의 자연로그값을 리턴한다.
*/

SELECT ABS(-15) FROM dual; -- 15
SELECT SIGN(-20) FROM dual; -- -1
SELECT SIGN(0) FROM dual; -- 0
SELECT SIGN(20) FROM dual; -- 1
SELECT MOD(7, 3) FROM dual; -- 1, 7%3이랑 같음
SELECT CEIL(38.123) FROM dual; -- 39
SELECT CEIL(-38.123) FROM dual; -- -38
SELECT FLOOR(38.123) FROM dual; -- 38
SELECT FLOOR(-38.123) FROM dual; -- -39
SELECT ROUND(38.5235, 3) FROM dual; -- 38.524
SELECT ROUND(38.5235, 1) FROM dual; -- 38.5
SELECT ROUND(38.5235, 0) FROM dual; -- 39
SELECT TRUNC(38.5235, 3) FROM dual; -- 38.523
SELECT TRUNC(38.5235, 1) FROM dual; -- 38.5
SELECT TRUNC(38.5235, 0) FROM dual; -- 38
SELECT SIN(0) FROM dual; -- 0
SELECT COS(0) FROM dual; -- 1
SELECT TAN(0) FROM dual; -- 0
SELECT EXP(2) FROM dual; -- 7.3890560989306502272304274605750078132
SELECT POWER(2, 3) FROM dual; -- 8
SELECT SQRT(4) FROM dual; -- 2
SELECT LOG(10, 100) FROM dual; -- 2
SELECT LN(7.3890561) FROM dual; -- 2.000000...

-- [예제] 반올림 및 내림해 소수점 이하 한 자리까지 출력한다.
SELECT
    ename,
    ROUND(sal / 12, 1) AS sal_round,
    TRUNC(sal / 12, 1) AS sal_trunc
FROM
    emp;
    
-- [예제] 반올림 및 올림해 정수 기준으로 출력한다.
SELECT
    ename,
    ROUND(sal / 12) AS sal_round,
    CEIL(sal/ 12) AS sal_ceil
FROM
    emp;
    
/*
4. 날짜형 함수

날짜형 함수는 DATE 타입의 값을 연산하는 함수다.

- SYSDATE : 현재 날짜와 시각을 출력한다.
- EXTRACT('YEAR'|'MONTH'|'DAY' from d) : 날짜 데이터에서 연월일 데이터를 출력할 수 있다.
- TO_NUMBER(TO_CHAR(d,'YYYY')) : 날짜 데이터에서 연 데이터를 출력할 수 있다.
- TO_NUMBER(TO_CHAR(d,'MM')) : 날짜 데이터에서 월 데이터를 출력할 수 있다.
- TO_NUMBER(TO_CHAR(d,'DD')) : 날짜 데이터에서 일 데이터를 출력할 수 있다.

데이터베이스는 날짜를 저장할 때 내부적으로 세기, 연, 월, 일, 시, 분, 초와 같은 숫자형식으로 변환해 저장.
데이터베이스는 날짜를 숫자로 저장하기 때문에 덧셈, 뺄셈 같은 산술 연산자로도 계산이 가능하다. 즉 날짜에 숫자 상수를 더하거나 뺼 수 있다.

- 날짜 + 날짜 : 날짜, 숫자만큼의 날수를 날짜에 더한다.
- 날짜 - 숫자 : 날짜, 숫자만큼의 날수를 날짜에서 뺀다.
- 날짜1 + 날짜2 : 날짜수, 다른 하나의 날짜에서 하나의 날짜를 빼면 일수가 나온다.
- 날자 + 숫자/24 : 날짜, 시간을 날짜에 더한다.
*/

-- [예제] 데이터베이스에서 사용하는 현재의 날짜 데이터를 확인한다.
SELECT
   SYSDATE
FROM
    dual;
    
-- [예제] 사원(emp) 테이블의 입사일자에서 년, 월, 일 데이터를 각각 출력한다.
SELECT 
    ename AS 사원명,
    hiredate AS 입사일자,
    EXTRACT(YEAR FROM hiredate) AS 입사년도, -- TO_NUMBER(TO_CHAR(hiredate, 'YYYY'))랑 같음. TO_NUMBER 안쓰면 01(문자형)으로 출력 
    EXTRACT(MONTH FROM hiredate) AS 입사월,
    EXTRACT(DAY FROM hiredate) AS 입사일
FROM
    emp;
    
/*
5. 변환형 함수

변환형 함수는 특정 데이터 타입을 다양한 형식으로 출력하고 싶을 경우에 사용된다.
  1) 명시적(Explict)데이터 유형 변환 : 데이터 변환형 함수를 사용해 데이터 유형을 변환하도록 명시해 주는 경우
    - TO_NUMBER(문자열) : 숫자로 변환 가능한 문자열을 숫자로 변환한다.
    - TO_CHAR(숫자|날짜 [, FORMAT]) : 숫자나 날짜를 주어진 FORMAT 형태인 문자열 타입으로 변환한다.
    - TO_DATE(문자열 [, FORMAT]) : 문자열을 주어진 FORMAT 형태인 날짜 타입으로 변환한다.
  2) 암시적(Implict)데이터 유형 변환 : 데이터베이스가 자동으로 데이터 유형을 변환해 계산하는 경우
  자동으로 데이터베이스가 알아서 계산하지 않는 경우가 있어 에러를 발생할 수 있음.
*/

-- [예제] 날짜를 정해진 문자 형태로 변형한다.
SELECT
    TO_CHAR(SYSDATE, 'YYYY/MM/DD') AS 날짜,
    TO_CHAR(SYSDATE, 'YYYY. MON, DAY') AS 문자형
FROM
    dual;
    
/* [실행 결과]
날짜         문자형                         
---------- ----------------------------
2022/04/17 2022. 4월 , 일요일 
*/
 
-- [예제] 금액을 달러와 원화로 표시한다. 두 번째 컬럼의 L999에서 L은 로컬 화폐 단위를 의미한다.
SELECT
    TO_CHAR(123456789 / 1200, '$999,999,999.99') AS 환율반영달러,
    TO_CHAR(123456789, 'L999,999,999') AS 원화
FROM
    dual;
    
-- [예제] 팀(TEAM) 테이블의 ZIP코드1과 ZIP코드2를 숫자로 변환한 후 두 항목을 더한 숫자를 출력한다.
SELECT
    team_id AS 팀ID,
    TO_NUMBER(zip_code1, '999') + TO_NUMBER(zip_code2, '999') AS 우편번호합
FROM
    team;

/*
6. CASE 표현

CASE 표현은 IF-THEN-ELSE 논리와 유사한 방식으로 표현식을 작성.

일반 프로그램의 IF-THEN-ELSE 로직
IF sal > 2000 -- sal이 2000 보다 클 때 
    THEN REVISED_SALARY = sal
    ELSE REVISED_SALARY = 2000
END IF

위와 같은 기능을 하는 CASE 표현
SELECT
    ename,
    CASE
        WHEN SAL > 2000 THEN sal
        ELSE 2000
    END AS revised_salary
FROM
    emp;
    
CASE 표현을 하는 방법
  - CASE SIMPLE_CASE_EXPRESSION 조건 pr SEARCHED_CASE_EXPRESSION 조건 [ELSE 디폴트값] END
  : SIMPLE_CASE_EXPRESSION/SEARCHED_CASE_EXPRESSION 조건이 맞으면 조건 내의 THEN절을 수행, 
  조건이 맞지 않으면 ELSE 절을 수행
  
  1) SIMPLE_CASE_EXPRESSION: CASE 다음 바로 조건에 사용되는 컬럼이나 표현식.
  2) SEARCHED_CASE_EXPRESSION : CASE 다음 WHEN절에서 여러 조건절을 사용 가능
  
  - DECODE(표현식, 기준값1, 값1[, 기준값2, 값2, ..., 디폴트값])
  : 표현식 값이 기준값1이면 값1을 출력하고, 기준값2이면 값2를 출력한다. 기준값이 없으면 디폴트 값을 출력한다.
*/

-- [예제] 부서 정보에서 부서 위치를 미국의 동부, 중부, 서부로 구분하라.
SELECT
    loc,
    CASE loc -- SIMPLE_CASE_EXPRESSION
        WHEN 'NEW YORK' THEN 'EAST'
        WHEN 'BOSTON' THEN 'EAST'
        WHEN 'CHICAGO' THEN 'CENTER'
        WHEN 'DALLAS' THEN 'CENTER'
        ELSE 'ETC'
    END AS area
FROM
    dept;
    
-- [예제] 사원 정보에서 급여가 3000 이상이면 상등급으로, 1000 이상이면 중등급으로, 1000 미만이면 하등급으로 분류하라.
SELECT
    ename,
    CASE -- SEARCHED_CASE_EXPRESSION
        WHEN sal >= 3000 THEN 'HIGH'
        WHEN sal >= 1000 THEN 'MID'
        ELSE 'LOW'
    END AS salary_grade
FROM
    emp;

-- CASE 표현은 함수의 성질을 갖고 있으므로 다른 함수처럼 중첩해 사용할 수 있다.
-- [예제] 사원 정보에서 급여가 2000 이상이면 보너스를 1000으로, 1000 이상이면 500으로, 1000미만이면 0으로 계산한다.
SELECT
    ename,
    sal,
    CASE
        WHEN sal >= 2000 THEN 1000
        ELSE (CASE
                WHEN sal >= 1000 THEN 500
                ELSE 0
            END)
        END AS bonus
FROM
    emp;

/*
7. NULL 관련 함수

1) NVL/ISNULL 함수

NULL의 특성
 - 널 값은 아직 정의되지 않은 값으로 0 또는 공백과 다르다. 0은 숫자고, 공백은 문자이다.
 - 테이블을 생성할 때 NOT NULL 또는 PRIMARY KEY로 정의되지 않은 모든 데이터 유형은 NULL 값을 포함할 수 있다.
 - NULL 값을 포함하는 연산의 경우 결과 값도 NULL이다.
 - 결과 값을 NULL이 아닌 다른 값을 얻고자 할 때 NVL 함수를 사용한다.
 
NULL관련 함수의 종류
 - NVL(표현식1, 표현식2) : 표현식1의 결과 값이 NULL이면 표현식2의 값을 출력한다. 
 - NULLIF(표현식1, 표현식2) : 표현식1이 표현식2와 같으면 NULL을, 같지 않으면 표현식1을 리턴한다.
 - COALESCE(표현식1, 표현식2, ...) : 임의의 개수 표현식에서 NULL이 아닌 최초의 표현식을 나타낸다.
   모든 표현식이 NULL이면 NULL을 리턴한다.
*/

-- [예제] 선수 테이블에서 성남 일화천마(K08) 소속 선수의 이름과 포지션을 출력하는데, 포지션이 없는 경우는 '없음'으로 표시한다.
SELECT
    player_name AS 선수명,
    position AS 포지션,
    NVL(position, '없음') AS nl포지션
FROM
    player
WHERE
    team_id = 'K08';

-- [예제] NVL함수를 사용한 문장은 벤더 공통적으로 CASE 문장으로 표현할 수 있다.
SELECT
   player_name AS 선수명,
   position AS 포지션,
   CASE
       WHEN position IS NULL THEN '없음'
       ELSE position
    END AS nl포지션
FROM
    player
WHERE
    team_id = 'K08';
    
-- [예제] 급여와 커미션을 포함한 연봉을 계산하면서 NVL 함수의 필요성을 알아본다.
SELECT
    ename AS 사원명,
    sal AS 월급,
    comm AS 커미션,
    (sal * 12) + comm AS 연봉a, -- 커미션이 null 이면 연봉a가 null이 됨.
    (sal * 12) + NVL(comm, 0) AS 연봉b
FROM
    emp;

/*
2) NULL과 공집합
*/

-- 일반적인 NVL 함수 사용 
-- (1) 정상적으로 매니저 정보를 갖고 있는 SCOTT의 매니저를 출력한다.
SELECT
    mgr
FROM
    emp
WHERE
    ename = 'SCOTT';
-- 'SCOTT'의 관리자는 7566 사번을 가진 jones다.

-- (2) 매니저에 NULL이 들어있는 KING의 매니저를 출력한다.
SELECT 
    mgr
FROM
    emp
WHERE
    ename = 'KING';
-- 'KING'은 emp 테이블에서 사장이므로 mgr 필드에 NULL이 입력돼있다.

-- (3) 매니저가 NULL인 경우 빈칸이 아닌 9999로 출력하기 위해 NVL 함수를 사용한다.
SELECT
    NVL(mgr, 9999) AS mgr
FROM
    emp
WHERE
    ename = 'KING';

-- 공집합의 NVL 함수 사용
-- 조건에 맞는 데이터가 한 건도 없는 경우를 공집합이라고 하고, WHERE 1 = 2; 와 같은 조건이 공집합을 발생시키는 쿼리다.
-- (1) 공집합을 발생시키기 위해 사원 테이블에 존재하지 않는 'JSC'라는 이름으로 데이터를 검색한다.
SELECT
    mgr
FROM
    emp
WHERE ename = 'JSC';

-- (2) NVL 함수를 이용해 공집합을 9999로 바꾸고자 시도한다.
SELECT 
    NVL(mgr, 9999) AS mgr
FROM
    emp
WHERE
    ename = 'JSC'; -- 인수의 값이 공집합인 경우는 NVL 함수를 사용해도 공집합이 출력된다.

-- (3) 적절한 집계함수를 찾아서 NVL 함수 대신 적용한다.
SELECT
    MAX(mgr) AS mgr
FROM
    emp
WHERE
    ename = 'JSC'; -- 다른 함수와 달리 집계함수와 scalar subquery의 경우는 결과가 공집합인 경우에도 null을 출력
    
-- (4) 집계함수를 인수로 한 NVL 함수를 이용해서 공집합인 경우에도 9999로 출력하게 한다.
SELECT
    NVL(MAX(mgr), 9999) AS mgr
FROM
    emp
WHERE
    ename = 'JSC';

-- NULLIF : 특정 값을 NULL로 대체하는 경우에 유용하게 사용할 수 있다.
-- [예제] 사원 테이블에서 mgr과 7698이 같으면 NULL을 표시하고, 같지 않으면 mgr을 표시한다.
SELECT 
    ename,
    empno,
    mgr,
    NULLIF(mgr, 7698) AS nuif
FROM
    emp;

-- NULLIF 함수를 CASE 문장으로 표현할 수 있다.
SELECT 
    ename,
    empno,
    mgr,
    CASE
        WHEN mgr = 7698 THEN NULL
        ELSE mgr
    END AS nuif
FROM
    emp;

-- 기타 NULL 관련 함수(COALESCE) : 인수중에서 NULL이 아닌 최초의 인수를 나타낸다. 모든 인수가 NULL이면 NULL을 리턴
-- [예제] 사원 테이블에서 커미션을 1차 선택값으로, 급여를 2차 선택값으로 선택하되, 두 칼럼 모두 NULL인 경우에는 NULL로 표시한다.
SELECT
    ename,
    comm,
    sal,
    COALESCE(comm, sal) AS coal
FROM
    emp;

-- COALESCE 함수는 두 개의 중첩된 CASE 문장으로 표현할 수 있다.
SELECT
    ename,
    comm,
    sal,
    CASE
        WHEN comm IS NOT NULL THEN comm
        ELSE (CASE
                WHEN sal IS NOT NULL THEN sal
                ELSE NULL
            END)
        END AS coal
FROM
    emp;
            

 



