/*
제 2절 SELECT 문

1. SELECT

사용자가 입력한 데이터는 언제라도 조회할 수 있다.

SELECT [ALL/DISTINCT] 
    출력 대상 컬럼명, 
    출력 대상 컬럼명, 
    ...
FROM 
    출력 대상 컬럼들이 있는 테이블명;
    
  - ALL : DEFAULT 옵션이므로 별도로 쓰지 않아도 됨. 중복된 데이터가 있어도 모두 출력한다.
  - DISTINCT : 중복된 데이터가 있을 경우 1건으로 처리해 출력한다.
*/

-- [예제] SELECT 한 다음 조회하기를 원하는 컬럼명을 콤마 구분자(,)로 구분해 나열하고, 
-- FROM 다음에 해당 컬럼이 존재하는 테이블명을 입력해 실행한다. 입력한 선수들의 데이터를 조회한다.
SELECT
    player_id,
    player_name,
    team_id,
    height,
    weight,
    back_no
FROM
    player;
    
-- ★ DISTINCT 옵션
-- [예제] 선수 테이블의 포지션 정보를 ALL과 DISTINCT 옵션으로 확인해본다.
SELECT ALL -- ALL은 생략 가능
    position
FROM
    player;
-- 모든 선수의 포지션을 출력함. (480개 행 인출)

SELECT DISTINCT
    position
FROM
    player;
-- 포지션의 종류인 4개의 행과 포지션 데이터가 아직 미정인 NULL까지 5건의 데이터만 출력되었음.

/*
★ ALIAS 부여하기
조회된 결과에 ALIAS를 부여해 컬럼 레이블을 변경할 수 있다. ALIAS는
  - 컬럼명 바로 뒤에 온다.
  - 컬럼명과 ALIAS 사이에 AS 키워드를 사용할 수 있다.(생략 가능)
  - 이중 인용부호(Double quotation)는 ALIAS가 공백, 특수문자를 포함할 경우와 대소문자 구분이 필요할 때 사용한다.
*/

-- [예제] 선수들의 정보를 컬럼 별명을 이용해 출력한다.
SELECT
    player_name AS 선수명, -- AS 뒤에 컬럼 별명 사용. 생략 가능
    position AS 위치,
    height AS 키,
    weight AS 몸무게
FROM
    player;

-- [예제] 컬럼 별명을 적용할 때 별명 중간에 공백이 들어가는 경우 " " 를 사용해야 한다.
SELECT
    player_name AS "선수 명", -- 중간에 공백이 들어가므로 큰따옴표 사용 
    position AS 포지션,
    height AS 키,
    weight AS 몸무게
FROM
    player;
    
/*
2. 산술 연산자와 합성 연산자

1) 산술 연산자
산술 연산자는 NUMBER와 DATE 자료형에 대해 적용되며, 일반적으로 수학의 사칙연산과 동일.
우선순위를 위한 괄호 적용이 가능하다.
수학에서와 같이 (), *, /, +, - 의 우선순위를 가진다.
*/

-- [예제] 선수들의 키에서 몸무게를 뺀 값을 알아본다.
SELECT
    player_name AS 선수명,
    height - weight AS "키-몸무게"
FROM
    player;
    
-- [예제] 선수들의 키와 몸무게를 이용해서 BMI 비만지수를 측정한다.
SELECT 
    player_name AS 선수명,
    ROUND (weight / ((height / 100) * (height / 100)), 2) AS BMI비만지수 
FROM
    player;

/*
2) 합성(CONCATENATION) 연산자
  - 문자와 문자를 연결하는 경우 2개의 수직 바(||)를 사용한다.
  - CONCAT(string1, string2) 함수를 사용할 수 있다.
  - 컬럼과 문자 또는 다른 컬럼과 연결한다.
  - 문자 표현식의 결과에 의해 새로운 컬럼을 생성한다.
*/

-- [예제] 다음과 같은 선수들의 출력 형태를 만들어본다.
-- 박지성 선수, 176cm, 70 kg
SELECT
    player_name || ' 선수, ' || height || ' cm, ' || weight || ' kg'
FROM
    player;