-- Na modelagem do Banco de Dados abaixo, foram aplicadas as Formas Normais (FNs) conforme solicitado --
-- O Banco esta modelado até a 3FN, apresentando também as propriedades de ACID (atomicidade, consistência, isolamento e durabilidade)--


------Criação do Banco ------
create database RedeSocial;

------ Usando o Banco ------
use RedeSocial;

-----Criação das Tabelas-----
create table Sexo(
id_sexo int not null identity(0,1) primary key,
genero varchar(20)
);

create table Conta(
id_tipoconta int not null identity(0,1) primary key,
nome varchar(20),
descricao varchar(50)
);

create table Tipo_grupo(
id_tipogrupo int not null identity (0,1) primary key,
tipo_gp varchar(30));

create table Usuario (
id int not null identity (0,1) primary key,
email varchar(100) not null, 
senha varchar(30) not null,
nome varchar(100) not null,
dt_nascimento date not null,
sexo int,
dt_cadastro datetime default (getdate()),
interesses varchar(200),
tipo_conta int,
foto image,
foreign key (sexo) references Sexo(id_sexo),
foreign key (tipo_conta) references Conta (id_tipoconta));


create table Grupo (
grupo_id int identity(0,1) not null primary key,
grupo_nome varchar (100),
criador_grupo int not null,
dt_criacao datetime default (getdate()),
gp_tipo int not null,
icone image,  
foreign key (gp_tipo) references Tipo_grupo(id_tipogrupo),
foreign key (criador_grupo) references Usuario(id),
);

create table Postagem (
post_id int not null identity(0,1) primary key,
post_descricao varchar(100),
dt_post datetime default (getdate()),
anexo varchar(100),
id_user int,
foreign key (id_user) references usuario(id));

create table Comentarios (
coment_id int not null identity(0,1) primary key,
descricao_coment varchar(500),
dt_coment datetime default (getdate()),
id_user int not null,
id_post int not null,
foreign key (id_user) references Usuario (id),
foreign key (id_post) references Postagem (post_id)
);

create table Curtidas (
curtida_id int not null identity(0,1) primary key,
dt_curtida datetime default (getdate()),
id_post int not null,
id_user int not null,
foreign key (id_post) references Postagem (post_id),
foreign key (id_user) references Usuario (id)
);

Create table Usuario_premium (
id_user int not null,
nome_cartao varchar(100),
numero_cartao int not null primary key,
senha_cartao varchar(30) not null,
foreign key (id_user) references Usuario(id)
);


create table Gp_membros (
id_grupo int not null,
id_user int not null,
foreign key (id_grupo) references Grupo(grupo_id),
foreign key (id_user) references Usuario(id),
constraint pk_gmembros primary key (id_grupo,id_user)
);

create table Imagem (
Codigo Int Identity(1,1) Not Null Primary Key,
NomedoArquivo Varchar(100) Not Null,
Arquivo Varbinary(Max)
);

-----Inserção de valores nas devidas tabelas-----

insert into sexo values ('Feminino');
insert into sexo values ('Masculino');
insert into sexo values ('Indefinido');

insert into Conta values ('Normal', 'Para todos os usuários');
insert into Conta values ('Premium', 'Somente para usuário premium');

insert into Tipo_grupo values ('Publico');
insert into Tipo_grupo values ('Privado');

insert into Usuario values ('giovannah.oliveira@hotmail.com', '123456', 'Giovanna', '19980810', '0', default, 'Python ', '0', null);
insert into Usuario values ('victor.neu@hotmail.com', '101010','Victor', '19960520', '1', default, 'Java, PHP e C# ', '0', null );
insert into Usuario values ('aldoh.oliveira@outlook.com', '987654', 'Aldo', '19930210', '1', default, 'PHP e C# ', '1', null );
insert into Usuario values ('wah.oliveira@hotmail.com', '555555', 'Walisson','19890119', '1', default, 'Java e PHP', '1',null );
insert into Usuario values ('biankinha123@hotmail.com', '212101', 'Bianca', '19960605', '0', default, 'JavaScript e C', '0', null);
insert into Usuario values ('luan123@hotmail.com', '101010', 'Luan', '19960808', '1', default, null, '0', null);

insert into grupo values ('ProjetoBD', '2', default, '0', null);
insert into grupo values ('ProjetoLPOO', '4', default, '1' , null );
insert into grupo values ('Me ajuda, Prof!', '5', default, '0', null);
insert into grupo values ('Bonde do programa', '3', default, '1', null);
insert into grupo values ('Cloud Computing', '3', default, '1', null);
insert into grupo values ('Portugol para iniciantes', '3', default, '1', null);
insert into grupo values ('C# para iniciantes', '3', default, '1', null);
insert into grupo values ('Java para iniciantes', '3', default, '0', null);

insert into postagem values ('Anexo projeto 1', default, null, 2);
insert into postagem values ('Insert SQL', default, null, 3);
insert into postagem values ('Exercícios', default, null, 3);
insert into postagem values ('Aula 2 LPOO', default,null, 3);

insert into comentarios values ('Legal!!!', default, '4', '0' );
insert into comentarios values ('Não entendi nada.', default, '5', '3' );
insert into comentarios values ('Explica de novo, por favor?', default, '1', '3' );
insert into comentarios values ('Consegui fazer', default, '5', '3' );
insert into comentarios values ('Entenderam agora?', default, '3', '3' );

insert into curtidas values (default, 3,4);
insert into curtidas values (default, 2,1);
insert into curtidas values (default, 2,3);
insert into curtidas values (default, 1,2);

insert into usuario_premium values (3, 'ELO', '123456789', '252476');
insert into usuario_premium values (4, 'Visa', '987654321', '1010');
insert into usuario_premium values (3, 'Visa', '101010101', '2020');
insert into usuario_premium values (4, 'Hipercard', '111222333', '122125');
insert into usuario_premium values (3, 'Hipercard', '555555555', '1212');

insert into gp_membros values (1,2);
insert into gp_membros values (1,3);
insert into gp_membros values (2,2);
insert into gp_membros values (3,1);
insert into gp_membros values (3,5);

INSERT INTO Imagem(NomedoArquivo, Arquivo) SELECT 'Gato_Preto.jpeg', * FROM OPENROWSET(BULK N'C:\Temp\Gato_Preto.jpeg',
SINGLE_BLOB
) load;

INSERT INTO Imagem(NomedoArquivo, Arquivo) SELECT 'Lobo_Branco.jpeg', * FROM OPENROWSET(BULK N'C:\Temp\Lobo_Branco.jpeg',
SINGLE_BLOB
) load;

INSERT INTO Imagem(NomedoArquivo, Arquivo) SELECT 'Tigre_Azul.jfif', * FROM OPENROWSET(BULK N'C:\Temp\Tigre_Azul.jfif',
SINGLE_BLOB
) load;

-----Consultas dentro das tabelas----


-----Seleção de todos com usuários-----
select * from usuario;

-----Seleção do email do usuário com o id = 4-----
select u.email from usuario as u where id = 4;

-----Seleção da descrição dos comentários e a postagem aos quais estão relacionados do usuário de nome 'Bianca' (Inner Join)-----
select c.descricao_coment, p.post_descricao 
from comentarios as c join postagem as p on id_post = post_id inner join usuario on c.id_user = id 
where nome = 'Bianca'; 

-----Seleção do nome de cada usuário e os grupos aos quais eles estão ou não vinculados (Left Join)-----
select u.nome, g.grupo_nome from usuario as u left join grupo as g on criador_grupo = id;

-----Seleção de todas as postagens e os comentários existentes ou não vinculados a ela (Right Join)-----
select c.descricao_coment, p.post_descricao from comentarios as c right join postagem as p on id_post = post_id; 

-----Seleção do nome, da data de nascimento e dos interesses de todos os usuários, ordenados pelo nome-----
select u.nome, u.dt_nascimento, u.interesses from usuario as u order by nome;

-----Seleções com AVG, Count, Sum, Group by e Having-----
select AVG(coment_id) as 'Média' from comentarios;
select count(curtida_id) from curtidas;
select sum(id_user) from gp_membros where id_grupo = 2;
select tipo_conta,count(id) as 'Quantidade de pessoas' from usuario group by tipo_conta;
select gp_tipo, count(grupo_id) from grupo group by gp_tipo having count(grupo_id) > 4;

-----Seleção de todas as imagens-----

select * from Imagem

-----Alteração de campos nas colunas das tabelas-----

update Comentarios set descricao_coment = 'Jesus me ajuda' where id_post = 2;
update Postagem set id_user = 1 where post_id = 3;
update Usuario set nome = 'Victor' where nome = 'Breno';

-----Remoção de linhas dentro das tabelas----

delete from Usuario where id = 5;
delete from Grupo where grupo_id = 1;
delete from Comentarios where descricao_coment = 'Entenderam agora?';
delete from Imagem where Codigo = 1;

-----Criação das View-------

-----Criação de uma view que mostre o nome e email de todos os usuarios-----
create view vwUsuario as
select nome, email from Usuario;

-----Criação de uma view que mostre todos os usuarios do sexo masculino-----
create view vwUserSexoM as
select u.nome, s.genero from Usuario as u join Sexo s on genero = 'Masculino';

----Criação de uma view que mostre a quatidade de usuarios premium-----
create view vwUserPremium as 
select id_user from Usuario_premium;


------Criação das Triggers------

create trigger tg_alteracoesDelete  on Usuario_premium after delete as
begin 
declare @id int
select @id = id_user from Usuario_premium;
insert into User_Delete (quando, id_user, comando) values (getdate(), @id, 'Delete'); 
end

create trigger tg_Usuario_Update on Usuario for update as
begin
declare @Nome varchar
declare @Email varchar
select @Nome = nome from Usuario;
select @Email = email from Usuario;
insert into Update_User (data, nome, email, comando) values (GETDATE(), @Nome, @Email, 'update');
end

create trigger tg_Comentarios_insert on Comentarios for insert as
begin
declare @User_id int
declare @Coment_descricao varchar
select @User_id = id_user from Comentarios;
select @Coment_descricao = descricao_coment from Comentarios;
insert into Insert_Coment (data, id, comentario, comando) values (GETDATE(), @User_id, @Coment_descricao, 'insert');
end

------ Criação das Procedure ------

------ procedure para convidar usuarios para grupos----
create procedure Convite (@id_grupo int, @id_membro int, @id_user int) as
begin 
insert into Gp_membros values (@id_grupo, @id_membro, @id_user)
end;

------ procedure para procura de parceiros (sexos usuarios) -----
create procedure Procurar_Parceiros (@sexo varchar(20)) as
begin
select * from usuario join sexo on id_sexo = sexo where genero = @sexo
end;

------ procedure para consultar postagens ------
create procedure Consultar_Postagens (@post_id int) as
begin
select * from Postagem where post_id = @post_id
end;

--------- Criação dos Indices ----------

-- Indice criado com a pretenção de informar o login (email e senha) dos usuários ao invés do cadastro todo --
Create index Log_in on Usuario (email,senha);

-- Indice criado com a pretenção de 
Create index HistoricoGrupo_Tipo on Grupo (dt_criacao,gp_tipo);

-- Indice criado com objetivo de criar relatorios de anexos no banco --
Create index Anexos on Postagem (dt_post,anexo);