--������ ���� ���¸� �״�� ����ϰ��� �Ѵ�
--���ʿ� �ѹ� �����ϱ�
alter session set "_ORACLE_SECRIPT" = TRUE;

--���̵� ����
CREATE USER busan IDENTIFIED BY dbdb;

--����� ��й�ȣ ����
ALTER USER busan IDENtiFIED BY dbdb;

--����� �����ϱ�
Drop User busan;

--������ ����ڿ��� ���� �ο��ϱ�
--���ӱ���, �����ڱ��� ��� �ο�
GRANT CONNECT, RESOURCE,DBA TO busan;

--���� ȸ���ϱ�
REVOKE DBA FROM busan;
