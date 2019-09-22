# Postgre SQL 명령어

-   \h  
    도움말

-   \!  
    일반적인 cmd의 명령어를 사용할 수 있게됨.  
    화면 cls, cd 등등이 가능해진다.

-   \l  
    데이터베이스 리스트

-   \c (DB이름)  
    데이터베이스 접속

-   \i (파일위치)  
    .sql 파일의 쿼리들 실행  
    한글이 들어간 INSERT 수행시, 다음의 절차를 따라야 한다.

    ```sql
    SET client_encoding = 'utf8';
    \i (.sql)
    SET client_encoding = 'euc-kr';
    ```

-   \d  
    테이블 리스트 보여줌

-   \d \dt  
    List tables & views, list only tables

-   \di, \dv, \ds, \dS  
    List indices, list views, list sequences, list ‘system + user’ tables & views
