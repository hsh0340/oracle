/*
제 4절 WHERE 절

1. WHERE 조건절 개요 

WHERE 절에는 두 개 이상의 테이블에 대한 조인조건을 기술하거나 결과를 제한하기 위한 조건을 기술할 수 있다.

SELECT [DISTINCT/ALL]
    컬럼명 [ALIAS명]
FROM 테이블명
WHERE 조건식;

WHERE 절은 FROM 절 다음에 위치하며, 조건식은 아래 내용으로 구성된다.
 - 컬럼명(보통 조건식의 좌측에 위치)
 - 비교 연산자
 - 문자, 숫자, 표현식(보통 조건식의 우측에 위치)
 - 비교 컬럼명(JOIN 사용 시)
 
2. 연산자의 종류 

WHERE 절에 사용되는 연산자는 3가지 종류가 있다.
 - 비교 연산자
  • = : 같다
  • > : 보다 크다
  • >= : 보다 크거나 같다
  • < : 보다 작다
  • <= : 보다 작거나 같다.
  
 - SQL 연산자
  • BETWEEN a AND b : a 와 b 사이의 값을 갖는다.(a와 b의 값이 포함됨)
  • IN(list) : 리스트에 있는 값 중에서 어느 하나라도 일치한다.
  • LIKE '비교문자열' : 비교문자열과 형태가 일치한다.(%, _ 사용).
  • IS NULL : NULL 값을 갖는다.
  
 - 논리 연산자
  • AND : 앞에 있는 조건과 뒤에오는 조건이 동시에 참이면 결과가 참이다.
  • OR : 앞 뒤 조건중 하나라도 참이면 결과가 참이다.
  • NOT : 조건의 반대 결과를 되돌려준다.
  
 - 부정 비교 연산자
  • != : 같지 않다.
  • ^= : 같지 않다.
  • <> : 같지 않다(ISO 표준, 모든 운영체제에서 사용 가능)
  • NOT 컬럼명 = : ~와 같지 않다.
  • NOT 컬럼명 > : ~보다 크지 않다.
  
 - 부정 SQL 연산자
  • NOT BETWEEN a AND B : a 와 b 의 값 사이에 있지 않다.(a, b 값을 포함하지 않는다).
  • NOT IN(list) : list 값과 일치하지 않다.
  • IS NOT NULL : NULL 값을 갖지 않는다.
  
연산자 우선순위
 1 : 괄호()
 2 : 비교연산자, SQL 연산자
 3 : NOT 연산자
 4 : AND
 5 : OR
*/

-- 3. 비교 연산자
-- [예시] 소속팀이 삼성블루윙즈 라는 조건을 WHERE 조건절에 작성
SELECT 
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버,
    height AS 키
FROM
    player
WHERE
    --team_id = K02; -- 부적합한 식별자 : K02를 작은따옴표로 묶어야함.
    team_id = 'K02';

-- [예시] 포지션이 미드필더인 조건을 WHERE 조건절에 작성
SELECT 
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버,
    height AS 키
FROM
    player
WHERE
    position = 'MF';
    
-- [예제] 키 170 센티미터 이상인 조건을 WHERE 조건절에 작성
SELECT 
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버,
    height AS 키
FROM
    player
WHERE
    height >= 170;
    
-- 4. SQL 연산자
-- [예제] 소속팀 코드와 관련된 IN 형태의 SQL 연산자를 사용해 WHERE 절에 사용
SELECT 
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버,
    height AS 키
FROM
    player
WHERE
    team_id IN('K02', 'K07');
    
-- IN(list) 연산자
-- [예제] 사원 테이블에서 job이 manager이면서 20번 부서에 속하거나, job이 clerk 이면서 30번 부서에 속하는 
-- 사원의 정보를 IN 연산자의 다중 리스트를 이용해 출력
SELECT
    ename, job, deptno
FROM
    emp
WHERE (job, deptno) IN (('MANAGER', 20), ('CLERK', 30));

-- LIKE 연산자
-- [예제] LIKE 연산자를 WHERE 절에 적용해서 실행한다.
SELECT 
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버,
    height AS 키
FROM
    player
WHERE
    position LIKE 'MF';

-- 와일드카드 : 한 개 혹은 0개 이상의 문자를 대신해 사용하기 위한 특수문자
-- % : 0개 이상의 어떤 문자를 의미한다.
-- _ : 1개인 단일 문자를 의미한다.
-- [예제] : '장'씨 성을 가진 선수들의 정보를 조회하는 WHERE 절을 작성한다.
SELECT
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버,
    height AS 키
FROM
    player
WHERE
    player_name LIKE '장%';

-- [예제] : 세 글자 이름을 가진 선수 중 '장'씨 성을 갖고 끝 글자가 '호'인 선수들의 정보를 조회하는 WHERE 절을 작성
SELECT
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버,
    height AS 키
FROM
    player
WHERE
    player_name LIKE '장_호';

-- BETWEEN a AND b 연산자
-- [예제] 키가 170센티미터 이상 180센티미터 이하인 선수들의 정보를 BETWEEN 연산자를 사용해 WHERE절을 작성
SELECT
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버,
    height AS 키
FROM 
    player
WHERE
    height BETWEEN 170 AND 180;

-- IS NULL 연산자
-- NULL 값의 비교 연산은 IS NULL, IS NOT NULL이라는 정해진 문구를 사용해야함.
-- [예제] position 컬럼 값이 NULL인지 판단하기 위해 IS NULL을 사용한다.
SELECT
    player_name AS 선수명,
    position AS 포지션,
    team_id AS 팀id
FROM
    player
WHERE
    position IS NULL;

-- 5. 논리 연산자
-- [예제] 소속이 삼성블루윙즈인 조건과 키가 170센티미터 이상인 조건을 연결해 WHERE절을 완성
SELECT
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버,
    height AS 키
FROM
    player
WHERE
    team_id = 'K02'
    AND height >= 170;

-- [예제] 소석이 삼성블루윙즈이거나 전남드래곤즈이고, 포지션이 미드필더인 조건을 WHERE절에 완성
SELECT
    team_id AS 팀id,
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버,
    height AS 키
FROM
    player
WHERE
    team_id IN('K02', 'K07')
    AND position = 'MF';

-- [예제] 소속팀이 삼성블루윙즈거나 전남드래곤즈에 소속된 선수들이어야 하고,
-- 포지션이 미드필더 이어야 한다.
-- 키는 170센티미터 이상이고 180 센티미터 이하여야 한다.
SELECT
    team_id AS 팀id,
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버,
    height AS 키
FROM 
    player
WHERE
    (team_id = 'K02'
    OR team_id = 'K07')
    AND position = 'MF' -- 괄호가 누락하면 OR보다 AND 먼저 실행 : 잘못된 결과 나타냄.
    AND height >= 170
    AND height <= 180;

-- IN(list)와 BETWEEN a AND b 를 사용
SELECT
    team_id AS 팀id,
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버,
    height AS 키
FROM
    player
WHERE
    team_id IN('K02', 'K07')
    AND position = 'MF'
    AND height BETWEEN 170 AND 180;

-- 6. 부정 연산자
-- [예제] 삼성블루윙즈 소속인 선수들 중에서 포지션이 미드필더가 아니고, 키가 175cm 이상 185cm 이하가 아닌 선수들
SELECT
    player_name AS 선수명,
    position AS 포지션,
    back_no AS 백넘버,
    height AS 키
FROM
    player
WHERE
    team_id = 'K02'
    AND NOT position = 'MF'
    AND NOT height BETWEEN 175 AND 185;

-- [예제] 국적 컬럼이 NULL 이 아닌 선수와 국적을 표시
SELECT
    player_name AS 선수명,
    nation AS 국적
FROM
    player
WHERE
    nation IS NOT NULL;

