DROP TABLE employee CASCADE CONSTRAINTS;
CREATE TABLE employee (
  fname    varchar2(15) not null, 
  minit    varchar2(1),
  lname    varchar2(15) not null,
  ssn      char(9),
  bdate    date,
  address  varchar2(50),
  sex      char,
  salary   number(10,2),
  superssn char(9),
  dno      number(4),
  primary key (ssn),
  foreign key (superssn) references employee(ssn)
--  foreign key (dno) references department(dnumber)
);

DROP TABLE department CASCADE CONSTRAINTS;
CREATE TABLE department (
  dname        varchar2(25) not null,
  dnumber      number(4),
  mgrssn       char(9) not null, 
  mgrstartdate date,
  primary key (dnumber),
  unique (dname),
  foreign key (mgrssn) references employee(ssn)
);

ALTER TABLE employee ADD (
  foreign key (dno) references department(dnumber)
);

DROP TABLE dept_locations CASCADE CONSTRAINTS;
CREATE TABLE dept_locations (
  dnumber   number(4),
  dlocation varchar2(15), 
  primary key (dnumber,dlocation),
  foreign key (dnumber) references department(dnumber)
);

DROP TABLE project CASCADE CONSTRAINTS;
CREATE TABLE project (
  pname      varchar2(25) not null,
  pnumber    number(4),
  plocation  varchar2(15),
  dnum       number(4) not null,
  primary key (pnumber),
  unique (pname),
  foreign key (dnum) references department(dnumber)
);

DROP TABLE works_on CASCADE CONSTRAINTS;
CREATE TABLE works_on (
  essn   char(9),
  pno    number(4),
  hours  number(4,1),
  primary key (essn,pno),
  foreign key (essn) references employee(ssn),
  foreign key (pno) references project(pnumber)
);

DROP TABLE dependent CASCADE CONSTRAINTS;
CREATE TABLE dependent (
  essn           char(9),
  dependent_name varchar2(15),
  sex            char,
  bdate          date,
  relationship   varchar2(8),
  primary key (essn,dependent_name),
  foreign key (essn) references employee(ssn)
);
