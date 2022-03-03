create table plant (
	plant_id int primary key AUTO_INCREMENT,
    plant_name varchar(50),
    zone varchar(50),
    season varchar(50)
);
    
create table seeds (
	seed_id int primary key auto_increment,
	expiration_date date,
	quantity int,
	reorder bool,
	plant_id int,
	foreign key (plant_id) references plant(plant_id)
);
    
create table garden_bed (
	space_number int primary key auto_increment,
	date_planted date,
	doing_well bool,
	plant_id int,
	foreign key (plant_id) references plant(plant_id)
);
    
select plant.plant_name, seeds.*, garden_bed.*
    from seeds
    inner join plant on plant.plant_id = seeds.plant_id
    inner join garden_bed on garden_bed.plant_id = seeds.plant_id
;
    
select seeds.*, garden_bed.*, plant.plant_name
    from seeds
    inner join plant on plant.plant_id = seeds.plant_id
    left join garden_bed on garden_bed.plant_id = seeds.plant_id
;
    
select seeds.*, garden_bed.*, plant.plant_name
    from seeds
    inner join plant on plant.plant_id = seeds.plant_id
    right join garden_bed on garden_bed.plant_id = seeds.plant_id
; 

select seeds.*, garden_bed.*, plant.plant_name
    from seeds
    inner join plant on plant.plant_id = seeds.plant_id
    left join garden_bed on garden_bed.plant_id = seeds.plant_id
    
union

select seeds.*, garden_bed.*, plant.plant_name
    from seeds
    inner join plant on plant.plant_id = seeds.plant_id
    right join garden_bed on garden_bed.plant_id = seeds.plant_id
; 

insert into seeds (expiration_date, quantity, reorder, plant_id)
	values ("08/05/2020", 100, 0, (select plant_id from plant where plant_name = "Hosta"))
;