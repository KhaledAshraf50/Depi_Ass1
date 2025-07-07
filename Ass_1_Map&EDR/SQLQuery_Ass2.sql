use Company;
--Create the EMPLOYEE table with all constraints
create table Employees
(
 SSN int primary Key,
 Gender varchar(1) check(Gender in('M','F')) ,
 Fname varchar(30) not null,
 Lname varchar(30) not null,
 Bdate date default getdate(),
 SuperVisor int,
 DNum int 
 constraint super_fk foreign key (SuperVisor) references Employees (SSN),
);
alter table Employees 
add constraint DNum_fk foreign key (DNum) references Departments (DNum);
--Create the DEPARTMENT table with proper relationships
create table Departments
(
DNum int primary key ,
DName varchar(50) not null,
SSN int ,
HireDate date default getdate(),
);
alter table Departments 
add constraint dept_emp_fk foreign key (SSN) references Employees (SSN);
--Create the PROJECT table
create table Projects
(
PNum int primary key,
PName varchar(50) not null,
City varchar(30) not null,
DNum int ,
constraint dept_proj_fk foreign key (DNum) references Departments (DNum)
);
alter table Projects 
alter column PName varchar(30);
--UNIQUE constraints where applicable
alter table Projects 
add constraint pname_unq unique(PName);

create table Dependents
(
DNum int ,
SSN int ,
Gender nvarchar(1) check(Gender ='M' or Gender ='F') ,
BDate date ,
constraint DNum_SSN_pk primary key (DNum,SSN), 
constraint Emp_Dependent_fk foreign key (SSN) references Employees(SSN)
); 
--FOREIGN KEY constraints with appropriate ON DELETE and ON UPDATE actions
alter table Dependents drop constraint Emp_Dependent_fk;

alter table Dependents add constraint Emp_Dependent_fk 
foreign key (SSN) references Employees(SSN)
on delete cascade on update cascade


create table Emps_Projs 
(
SSN int ,
PNum int ,
work_hours int,
constraint PNum_SSN_pk primary key (PNum,SSN), 
constraint SSN_Emps_Projs_fk foreign key (SSN) references Employees(SSN)
)
alter table Emps_Projs 
add constraint PNum_Emps_Projs_fk foreign key (PNum) references Projects(PNum)

--Insert sample data into EMPLOYEE table (at least 5 employees)
insert into Employees (SSN,Gender,Fname,Lname,Bdate,SuperVisor)
values(12554,'M','Khaled Ashraf','Khalil','08/25/2005',12554),
      (45864,'M','Mohamed Kamal','youef','07/15/2000',12554),
      (54678,'F','malak ','mohamed','01/15/2004',12554),
      (15484,'M','ali anawer','zeyad','08/15/2006',54678),
      (45846,'F','Yara mahmoud','ali','10/7/2003',15484);
      --Insert sample data into DEPARTMENT table (at least 3 departments)
insert into Departments (DNum ,DName,SSN ,HireDate)
values (1,'Cs',45864,null),
      (2,'IT',12554,'05/23/2023'),
      (3,'IS',45846,'10/13/2020');
--Update an employee's department      
      update Employees 
      set DNum = 1 
      where DNum is null;

      insert into Projects (PNum , PName , City ,DNum)
      values (100,'A','Menof',1),
             (200,'B','Seben',2)

      insert into Emps_Projs (SSN,PNum,work_hours)
      values (12554,100,12),
            (54678,200,null)

 insert into Dependents (DNum , SSN , Gender, BDate)
  values (10,45846,'M',null)

      update Employees set SuperVisor = 54678 where SuperVisor = 15484 ;
update Employees set SSN = 15478 , Fname = 'salma' , Lname = 'ahmed' , Gender = 'F'
where SSN = 15484;

--Delete a dependent record
delete from Dependents;
--Retrieve all employees working in a specific department
select DNum,count(*) as "No of employees" from Employees 
group by DNum;
--Find all employees and their project assignments with working hours
       select * from Emps_Projs
       where work_hours is not null;