/*
제 1절 관계형 데이터베이스 개요

1. 데이터베이스

넓은 의미의 데이터 베이스 : 일상적인 정보를 모아놓은 것 자체를 의미.
일반적인 데이터베이스 : 특정 기업이나 조직, 개인이 필요에 따라 데이터를 일정한 형태로 저장해놓은 것.

DBMS(Database Management System) : 데이터베이스 관리 시스탬
RDBMS(Relational Database Management System) : 관계형 데이터베이스 관리 시스템

2. SQL 

SQL(Structured Query Language) : 관계형 데이터베이스에서 데이터 정의, 데이터 조작, 데이터를 제어하기 위해 사용하는 언어.
  - SQL 문장들의 종류
    1) 데이터 조작어(DML, Data Manipulation Language)
      - SELECT : 데이터베이스에 들어있는 데이터를 조회하거나 검색하기 위한 명령어.
      - INSERT, UPDATE, DELETE : 데이터베이스의 테이블에 들어있는 데이터에 변형을 가하는 종류의 명령어들
        ex) 테이블에 새로운 행 집어넣기, 기존 데이터 수정하기, 원하지 않는 데이터를 삭제
    2) 데이터 정의어(DDL, Data Definition Language)
      - CREATE, ALTER, DROP, RENAME : 테이블과 같은 데이터 구조를 정의하는데 사용됨.
      - 구조를 생성, 변경, 삭제하거나 이름을 바꾸는 데이터 구조와 관련된 명렁어.
    3) 데이터 제어어(DCL, Data Control Language)
      - GRANT, REVOKE : 데이터베이스에 접근하고 객체들을 사용하도록 권한을 주고 회수하는 명령어
    4) 트랜잭션 제어어(TCL, Transaction Control Language)
      - COMMIT, ROLLBACK : 논리적인 작업단위를 묶어서 DML에 의해 조작된 결과를 작업단위(트랜잭션)별로 제어하는 명령어
*/

