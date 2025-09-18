create database Tahsin
GO 
use Tahsin
GO
create table department
(
dept_name char(20),
building varchar(10),
budget int,
constraint d_pk primary key (dept_name)
)
GO
create table course
(
course_id char(8) primary key,
title varchar(250),
department_name char(20),  
credits decimal(3,2), 
constraint c_fk foreign key (department_name)
references [dbo].[department] ([dept_name])
)
GO
create table prereq
(
course_id char(8) foreign key references [dbo].[course],
prereq_id char(8) constraint pre_fk2
foreign key references [dbo].[course] ([course_id]),
primary key (course_id,prereq_id)
)
GO
create table classroom
(
building char(10),
room_number smallint,
capacity tinyint,
constraint cls_pk primary key (building,room_number)
)
GO
create table section
(
course_id char(8) foreign key references course,
sec_id nchar(1),
semester nvarchar(10),
year smallint,
building char(10) not null,
room_number smallint not null,
time_slot_id varchar(1),
foreign key (building,room_number) references [dbo].[classroom],
primary key (course_id,sec_id,semester,year)
)
GO
create table instructor
(
id char(5),
name varchar(20),
dept_name char(20),
salary decimal(8,2),
primary key (id),
foreign key (dept_name) references department (dept_name)
)
GO
create table student
(
id char(5),
name varchar(20),
dept_name char(20),
tot_cred smallint,
primary key (id),
foreign key (dept_name) references department (dept_name)
)
GO
create table time_slot
(
time_slot_id varchar(1),
day varchar(10),
start_time time,
end_time time,
primary key (time_slot_id, day, start_time)
)
GO
create table teaches
(
id char(5),
course_id char(8),
sec_id nchar(1),
semester nvarchar(10),
year smallint,
primary key (id, course_id, sec_id, semester, year),
foreign key (id) references instructor (id),
foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
)
GO
create table takes
(
id char(5),
course_id char(8),
sec_id nchar(1),
semester nvarchar(10),
year smallint,
grade char(2),
primary key (id, course_id, sec_id, semester, year),
foreign key (id) references student (id),
foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
);
GO
create table advisor
(
s_id char(5),
i_id char(5),
primary key (s_id),
foreign key (s_id) references student (id),
foreign key (i_id) references instructor (id)
)
GO

--INSTRUCTOR TABLE VALUES
insert into [dbo].[instructor] values
('22222','Einstein','Physics','95000'),
('12121','Wu','Finance','90000'),
('32343','El Said','History','60000'),
('45565','Katz','Comp. Sci.','75000'),
('98345','Kim','Elec. Eng.','80000'),
('76766','Crick','Biology','72000'),
('10101','Srinivasan','Comp Sci.','65000'),
('58583','Califieri','History','62000'),
('83821','Brandt','Comp Sci','92000'),
('15151','Mozart','Music','40000'),
('33456','Gold','Physics','87000'),
('76543','Singh','Finance','80000')
select * from [dbo].[instructor]

--DEPARTMENT TABLE VALUES
insert into [dbo].[department] values
('Biology','Watson','90000'),
('Comp. Sci.','Taylor','100000'),
('Elec. Eng.','Taylor','85000'),
('Finance','Painter','120000'),
('History','Painter','50000'),
('Music','Packard','80000'),
('Physics','Watson','70000')
select * from [dbo].[department]


--Formula For Descending
order by budget desc

--Formula for Average value
select avg(budget) as Avg_value
from department
where building ='Painter'

--Formula for Counting
select count(*) as Total_countValue
from department

--Formula
select dept_name from [dbo].[department] where dept_name = 'History'


insert into [dbo].[course] values
('BIO-101','Intro to Biology','Biology','4'),
('BIO-301','Genetics','Biology','4'),
('BIO-399','Computational Biology','Biology','3'),
('CS-101','Intro to Computer Science','Comp. Sci.','4'),
('CS-190','Game Design','Comp. Sci.','4'),
('CS-315','Robotics','Comp. Sci.','3'),
('CS-319','Image Processing','Comp. Sci.','3'),
('CS-347','Database System Concepts','Comp. Sci.','3'),
('EE-181','Intro to Digital Systems','Elec. Eng.','3'),
('FIN-201','Investment Banking','Finance','3'),
('HIS-351','World History','History','3'),
('MU-199','Music Video Production','Music','3'),
('PHY-101','Physical Principles','Physics','4')
select * from [dbo].[course]

insert into [dbo].[prereq] values
('BIO-301','BIO-101'),
('BIO-399','BIO-101'),
('CS-190','CS-101'),
('CS-315','CS-101'),
('CS-319','CS-101'),
('CS-347','CS-101'),
('EE-181','PHY-101')

--section
insert into [dbo].[section] values
('BIO-101','1','Summer','2017','Painter','514','B'),
('BIO-301','1','Summer','2018','Painter','514','A'),
('CS-101','1','Fall','2017','Packard','101','H'),
('CS-101','1','Spring','2018','Packard','101','F'),
('CS-190','1','Spring','2017','Taylor','3128','E'),
('CS-190','2','Spring','2017','Taylor','3128','A'),
('CS-315','1','Spring','2018','Watson','120','D'),
('CS-319','1','Spring','2018','Watson','100','B'),
('CS-319','2','Spring','2018','Taylor','3128','C'),
('CS-347','1','Fall','2017','Taylor','3128','A'),
('EE-181','1','Spring','2017','Taylor','3128','C'),
('FIN-201','1','Spring','2018','Packard','101','B'),
('HIS-351','1','Spring','2018','Painter','514','C'),
('MU-199','1','Spring','2018','Packard','101','D'),
('PHY-101','1','Fall','2017','Watson','100','A')

select * from [dbo].[section]

--Classromm
insert into [dbo].[classroom] values
('Packard','101','50'),
('Painter','514','10'),
('Taylor','3128','70'),
('Watson','100','30'),
('Watson','120','50')
select * from [dbo].[classroom]