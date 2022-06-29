create table Planetas(
	IdPlaneta int not null,
	Nome varchar(50) not null,
	Rotacao float not null,
	Orbita float not null,
	Diametro float not null,
	Clima varchar(50) not null,
	Populacao int not null,
)
go -- Indica o final de uma instrução e o inicio de outra
alter table Planetas add constraint PK_PLANETAS primary key (IdPlaneta); -- Adiciona uma regra na tabela Planetas com o nome de PK_PLANETAS, informando que é uma regra do tipo primary key (chave primária) na coluna IdPlaneta
go
create table Naves(
	IdNave int not null,
	Nome varchar(100) not null,
	Modelo varchar(150) not null,
	Passageiros int not null,
	Carga float not null,
	Classe varchar(100) not null,
)
go
alter table Naves add constraint PK_NAVES primary key (IdNave);
go
create table Pilotos(
	IdPiloto int not null,
	Nome varchar(200) not null,
	AnoNascimento varchar(10) not null,
	IdPlaneta int not null,
)
go
alter table Pilotos add constraint PK_PILOTOS primary key (IdPiloto);
go
alter table Pilotos add constraint FK_Pilotos_Planetas foreign key(IdPlaneta) References Planetas(IdPlaneta)

create table PilotosNaves(
	IdPiloto int not null,
	IdNave int not null,
	FlagAutorizado bit not null,
)
go
alter table PilotosNaves add constraint PK_PilotosNaves primary key (IdPiloto, IdNave);
go
alter table PilotosNaves add constraint FK_PilotosNaves_Pilotos foreign key(IdPiloto) references Pilotos (IdPiloto)
go
alter table PilotosNaves add constraint FK_PilotosNaves_Naves foreign key(IdNave)
references Naves(IdNave)
go
alter table PilotosNaves add constraint DF_PilotosNaves_FlagAutorizado default (1) for FlagAutorizado -- Se for omitido o valor para a coluna FlagAutorizado, por padrão, ele será 1 (o piloto está permitido), e o for indica para qual coluna será, no caso, a FlagAutorizado.
go
create table HistoricoViagens(
	IdNave int not null,
	IdPiloto int not null,
	DtSaida datetime not null,
	DtChegada datetime null
)
go

alter table HistoricoViagens add constraint FK_HistoricoViagens_PilotosNaves foreign key(IdPiloto, IdNave)
references PilotosNaves(IdPiloto, IdNave)
go
alter table HistoricoViagens check constraint FK_HistoricoViagens_PilotosNaves -- Checa se os registros estão garantidos (opcional)

select * from Pilotos
select * from Planetas
select * from Naves
select * from PilotosNaves
select * from HistoricoViagens

select * from Pilotos where Nome = 'Darth Vader'

select * from Pilotos where ltrim(Nome) = ltrim(' Darth Vader') -- ltrim remove os espaços a esquerda 
select * from Pilotos where rtrim(Nome) = rtrim('Darth Vader ') -- ltrim remove os espaços a direita 

select * from Pilotos where Nome like 'Dart%' -- Procure a string que comece com Dart e termine com qualquer coisa
select * from Pilotos where Nome like '%Vader' -- Procure a string que comece com qualquer coisa e termine com Vader

select t1.*,
	t2.Nome,
	t3.Nome
from HistoricoViagens t1
inner join Pilotos t2
on t1.IdPiloto = t2.IdPiloto
inner join Naves t3
on t1.IdNave = t3.IdNave