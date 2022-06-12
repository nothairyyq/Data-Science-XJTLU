drop table College CASCADE CONSTRAINTS;
drop table  Student CASCADE CONSTRAINTS;
drop table Apply CASCADE CONSTRAINTS;

create table College(cName VARCHAR2(20), state VARCHAR2(20), enrollment int);
create table Student(sID int, sName VARCHAR2(20), GPA real, sizeHS int);
create table Apply(sID int, cName VARCHAR2(20), major VARCHAR2(20), decision VARCHAR2(30));