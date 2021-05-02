



ALTER TABLE DATASETFINAL ADD CONSTRAINT PK_NEWKEY PRIMARY KEY(PLAYER_ID);
--FIRST PACKAGE 
create or replace package first_package as 
procedure create_index;
cursor help_cursor is select player_id , player_attacking ,
player_skills from datasetfinal;
new_rec help_cursor%rowtype;
type t_newtype is table of help_cursor%rowtype 
index by binary_integer;
new_record t_newtype;
v_var number;
end first_package;
create or replace package body first_package as 
procedure create_index 
as
begin 
    open help_cursor;
    loop
        fetch help_cursor into new_rec;
        new_record(new_rec.player_id):= new_rec;
        exit when help_cursor%notfound;
    end loop;
      close help_cursor;
    for i in new_record.first .. new_record.last
    loop
        if(new_record.exists(i))
        then 
            v_var :=  new_record(i).player_attacking +
new_record(i).player_skills;
            update datasetfinal  
            set player_overall_score = v_var where player_id = new_record(i).player_id;
        end if;
    end loop;
end create_index;
end first_package;

--SECOND PACKAGE
create or replace package second_package as 
procedure create_physic;
cursor physic_cursor is select player_id , player_acceleration ,
player_power, player_strength from datasetfinal;
new_col physic_cursor%rowtype;
type t_physictype is table of physic_cursor%rowtype 
index by binary_integer;
physic_record t_physictype;
v_var number;
end second_package;
create or replace package body second_package as 
procedure create_physic 
as
begin 
    open physic_cursor;
    loop
        fetch physic_cursor into new_col;
        physic_record(new_col.player_id):= new_col;
        exit when physic_cursor%notfound;
    end loop;
    close physic_cursor;
    for i in physic_record.first .. physic_record.last
    loop
        if(physic_record.exists(i))
        then 
            v_var :=  physic_record(i).player_acceleration +
physic_record(i).player_power + physic_record(i).player_strength;
            update datasetfinal  
            set player_physics_overall = v_var where player_id = physic_record(i).player_id;
        end if;
    end loop;
end create_physic;
end second_package;



--INSERT PACKAGE
create or replace package insert_package as
procedure insert_procedure(new_id datasetfinal.player_id%type, new_name datasetfinal.player_name%type,
new_age datasetfinal.player_age%type, new_nation datasetfinal.player_nationality%type, new_club datasetfinal.player_club%type,
new_contract datasetfinal.player_contract%type, new_join datasetfinal.player_joined%type, new_value_salary datasetfinal.player_value%type,
new_wage datasetfinal.player_wage%type, new_attacking datasetfinal.player_attacking%type, new_skills datasetfinal.player_skills%type, 
new_acceleration datasetfinal.player_acceleration%type, new_power datasetfinal.player_power%type, new_strength datasetfinal.player_strength%type);
end insert_package;

create or replace package body insert_package as
    procedure insert_procedure(new_id datasetfinal.player_id%type, new_name datasetfinal.player_name%type,
new_age datasetfinal.player_age%type, new_nation datasetfinal.player_nationality%type, new_club datasetfinal.player_club%type,
new_contract datasetfinal.player_contract%type, new_join datasetfinal.player_joined%type, new_value_salary datasetfinal.player_value%type,
new_wage datasetfinal.player_wage%type, new_attacking datasetfinal.player_attacking%type, new_skills datasetfinal.player_skills%type, 
new_acceleration datasetfinal.player_acceleration%type, new_power datasetfinal.player_power%type, new_strength datasetfinal.player_strength%type)
    as
    v_execute varchar2(10000);
    begin 
    v_execute := 'INSERT INTO ' || 'DATASETFINAL ' || '(player_id, player_name, player_age, player_nationality,
        player_club, player_contract, player_joined, player_value, player_wage, player_attacking, player_skills,
        player_acceleration, player_power, player_strength)' || ' VALUES' || '(' || new_id ||
    ' , ' || '''' || new_name || '''' || ' , ' || new_age || ' , ' || '''' || new_nation || ''''
    || ' , ' || '''' || new_club  || '''' || ' , ' || '''' || new_contract || '''' || ' , ' || '''' || new_join ||
    '''' || ' , ' || new_value_salary || ' , ' || new_wage || ' , ' || new_attacking || ' , ' || new_skills || 
    ' , ' || new_acceleration || ' , ' || new_power || ' , ' || new_strength ||')';
execute immediate v_execute;
    end insert_procedure;
end insert_package;

--UPDATE PACKAGE
create or replace package update_package as
procedure update_procedure(new_id datasetfinal.player_id%type, new_name datasetfinal.player_name%type,
new_age datasetfinal.player_age%type, new_nation datasetfinal.player_nationality%type, new_club datasetfinal.player_club%type,
new_contract datasetfinal.player_contract%type, new_join datasetfinal.player_joined%type, new_value_salary datasetfinal.player_value%type,
new_wage datasetfinal.player_wage%type, new_attacking datasetfinal.player_attacking%type, new_skills datasetfinal.player_skills%type, 
new_acceleration datasetfinal.player_acceleration%type, new_power datasetfinal.player_power%type, new_strength datasetfinal.player_strength%type);
end update_package;
create or replace package body update_package as
    procedure update_procedure(new_id datasetfinal.player_id%type, new_name datasetfinal.player_name%type,
new_age datasetfinal.player_age%type, new_nation datasetfinal.player_nationality%type, new_club datasetfinal.player_club%type,
new_contract datasetfinal.player_contract%type, new_join datasetfinal.player_joined%type, new_value_salary datasetfinal.player_value%type,
new_wage datasetfinal.player_wage%type, new_attacking datasetfinal.player_attacking%type, new_skills datasetfinal.player_skills%type, 
new_acceleration datasetfinal.player_acceleration%type, new_power datasetfinal.player_power%type, new_strength datasetfinal.player_strength%type) 
    as
    v_string_store varchar(10000);
    begin 
    v_string_store := 'UPDATE ' || 'DATASETFINAL ' || 'SET ' || 'player_name' || ' = ' || '''' || new_name || '''' || ' , '
    || 'player_age' || ' = ' || new_age || ' , ' ||  'player_nationality' || ' = '  || '''' || new_nation || '''' || ' , ' ||
    'player_club' || ' = ' || '''' || new_club || '''' || ' , ' || 'player_contract' || ' = ' ||  '''' || new_contract || '''' ||  ' , ' ||
    'player_joined'  ||  ' = ' ||  '''' || new_join || '''' || ' , ' ||  'player_value' || ' = ' || new_value_salary  || ' , ' ||
    'player_wage'  || ' = ' || new_wage  || ' , ' || 'player_attacking' || ' = ' ||  new_attacking || ' , ' || 
    'player_skills'  || ' = ' ||  new_skills || ' , ' || 'player_acceleration'  || ' = ' || new_acceleration || ' , ' ||
    'player_power'  || ' = '  || new_power || ' , ' ||  'player_strength'   || ' = ' || new_strength || ' WHERE ' || 'player_id' || ' = ' || new_id;
    execute immediate v_string_store;
    end update_procedure;
end update_package;

--DELETE PACKAGE


create or replace package delete_package
as
procedure delete_procedure(p_del_id datasetfinal.player_id%type);
end delete_package;
create or replace package body delete_package as
procedure delete_procedure(p_del_id datasetfinal.player_id%type) 
is
v_new_st varchar(10000);
begin 
    v_new_st := 'DELETE ' || 'FROM' || ' DATASETFINAL ' || 'WHERE' || ' player_id ' || ' = ' || p_del_id;
    execute immediate v_new_st;
end delete_procedure;
end delete_package;


--NEW SOLVE
create or replace package new_solve as
cursor change_value 
is select player_id, player_value
from datasetfinal
where player_value  like '%,%';
cursor change_wage 
is select player_id , player_wage 
from datasetfinal 
where player_wage like '%,%';
procedure change_procedure;
end new_solve;
create or replace package body new_solve as
procedure change_procedure is
begin
for temp_cursor in change_value loop
update datasetfinal set datasetfinal.player_value = temp_cursor.player_value * 1000000
where datasetfinal.player_id = temp_cursor.player_id;
end loop;
for temp_cursor in change_wage loop
update datasetfinal set datasetfinal.player_wage = temp_cursor.player_wage *  1000000
where datasetfinal.player_id = temp_cursor.player_id;
end loop;
end change_procedure;
end new_solve;

begin
new_solve.change_procedure;
end;

--RECOMMENDATION PROCEDURE 
CREATE TABLE RECOMMENDATION_TABLE AS SELECT * FROM DATASETFINAL;
DELETE FROM RECOMMENDATION_TABLE;

create or replace procedure recommendation_proc
is
new_var number;
count_var number := 0;
cursor new_recommend is select * from datasetfinal 
order by  (player_overall_score + player_physics_overall) desc;
begin
    delete from recommendation_table;
    for i in new_recommend loop 
       insert into recommendation_table (player_id, player_name, player_age, player_nationality,player_club, player_contract, player_joined, player_value, player_wage, player_attacking, player_skills,player_acceleration, player_power, player_strength,
       player_overall_score, player_physics_overall)
    values(i.player_id,i.player_name, i.player_age, i.player_nationality,
        i.player_club, i.player_contract, i.player_joined, i.player_value, i.player_wage, i.player_attacking, i.player_skills,
        i.player_acceleration, i.player_power, i.player_strength,i.player_overall_score, i.player_physics_overall);
    count_var := count_var + 1;
    exit when count_var > 9;
    end loop;
end;


---------TRIGGERS---------
--FOR RECOMMENDATION TRIGGER 
create or replace trigger for_recommend
after insert or update or delete on datasetfinal 
declare 
    v_var varchar2(5);
begin
    if inserting then 
    recommendation_proc;
    elsif updating then 
    recommendation_proc;
    elsif deleting then 
    recommendation_proc;
    else
        v_var := 'no';
    end if;
end;
--AFTER INSERT PLAYER
create or replace trigger after_insert_player 
after insert on datasetfinal
begin
    first_package.create_index;
    second_package.create_physic;
end;
--AFTER UPDATE PLAYER 
create or replace trigger after_update_player
after update of player_id,
player_name, player_age, 
player_nationality, player_club,
player_contract, player_joined, 
player_value, player_wage, 
player_attacking, player_skills, 
player_acceleration, player_power, 
player_strength on datasetfinal
begin
    first_package.create_index;
    second_package.create_physic;
end;
