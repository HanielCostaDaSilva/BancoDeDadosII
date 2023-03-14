CREATE TABLE Filme (
   	CodFILME   	Serial  NOT NULL,
   	Titulo      Varchar(25),
   	Ano         integer,
   	Duracao   	integer,
   	CodCATEG   	integer,
   	CodEst     	integer);

CREATE TABLE Artista (
   	CodART  	Serial  NOT NULL,
   	NomeART	    Varchar(25),
   	Cidade      Varchar(20),
   	Pais        Varchar(20),
   	DataNasc   	Date);

CREATE TABLE Estudio (
   	CodEst 	    serial  NOT NULL,
   	NomeEst	    Varchar(25));

CREATE TABLE Categoria (
   	CodCATEG   	serial  NOT NULL,
   	DescCATEG   VARCHAR(25));

CREATE TABLE Personagem (
   	CodART 	    integer  NOT NULL,
   	CodFILME    integer  NOT NULL,
   	NomePers    VARCHAR(25),
   	Cache       numeric(15,2));

ALTER TABLE Filme ADD CONSTRAINT PKFilme PRIMARY KEY(CodFILME);
ALTER TABLE Artista ADD CONSTRAINT PKArtista PRIMARY KEY(CodART);
ALTER TABLE Estudio ADD CONSTRAINT PKEst PRIMARY KEY(CodEst);
ALTER TABLE Categoria ADD CONSTRAINT PKCategoria PRIMARY KEY(CodCATEG);
ALTER TABLE Personagem ADD CONSTRAINT PKPersonagem PRIMARY KEY(CodART,CodFILME);
ALTER TABLE Filme ADD CONSTRAINT FKFilme1Categ FOREIGN KEY(CodCATEG) REFERENCES Categoria;
ALTER TABLE Filme ADD CONSTRAINT FKFilme2Estud FOREIGN KEY(CodEst) REFERENCES Estudio;
ALTER TABLE Personagem ADD CONSTRAINT FKPersonagem2Artis FOREIGN KEY(CodART) REFERENCES Artista;
ALTER TABLE Personagem ADD CONSTRAINT FKPersonagem1Filme FOREIGN KEY(CodFILME) REFERENCES Filme;

/*Insertions*/

/*Categoria*/
insert into categoria values(default,'Aventura');
insert into categoria values(default,'Romance');
insert into categoria values(default,'Comédia');
insert into categoria values(default,'Ação');
insert into categoria values(default,'Suspense');
insert into categoria values(default,'Drama');

/*Estudio*/
insert into estudio values(default,'Paramount');
insert into estudio values(default,'Disney');
insert into estudio values(default,'Universal');

/*Artista*/
insert into artista values(default,'Cameron Diaz',null,'USA','15/07/75');
insert into artista values(default,'Julia Roberts',null,'USA','20/08/67');
insert into artista values(default,'Brad Pitt',null,null,'05/03/70');
insert into artista values(default,'Joaquin Phoenix',null,null,'06/04/72');
insert into artista values(default,'Bradley Cooper',null,'USA','06/06/77');
insert into artista values(default,'Tom Cruise',null,'USA','10/09/64');
insert into artista values(default,'Rodrigo Santoro','Rio de Janeiro','Brasil','12/10/78');

/*Filme*/
insert into filme values(default,'Encontro Explosivo',2010,134,4,1);
insert into filme values(default,'O Besouro Verde',2010,155,1,1);
insert into filme values(default,'Comer, Rezar, Amar',2010,177,2,1);
insert into filme values(default,'Coringa',2019,122,6,1);
insert into filme values(default,'Era uma vez em Hollywood',2020,119,4,2);
insert into filme values(default,'Nasce uma estrela',2018,100,6,1);

/*Personagem*/
insert into personagem values(1,1,'Natalie',10000);
insert into personagem values(1,2,'Tom',10000);
insert into personagem values(3,2,'Ana',6000);
insert into personagem values(5,3,'John',10000);
insert into personagem values(4,4,'John',12000);
insert into personagem values(6,5,'Tom',11000);

/*Checks*/
select * from Estudio;
select * from Categoria;
select * from Filme;
select * from artista;
select * from Personagem;

/*Insertions de minha autoria:*/

insert into categoria values(default,  'Sci-fi');
insert into categoria values(default,  'Animação');
insert into categoria values(default,  'Comédia Romântica');
select * from Categoria;


insert into estudio values(default,'Mediapro');
insert into estudio values(default,'Sony pictures');
insert into estudio values(default,'Paris Filmes');
select * from Estudio;

insert into artista values(default,'Owen Wilson', 'Dalas','USA','18/11/1968');
insert into artista values(default,'Dwayne Johnson', 'Califórnia','USA',' 02/05/1972');
insert into artista values(default,'Emily Blunt', 'Londres','Inglaterra',' 23/02/1983');
select * from artista;

insert into filme values(default, 'Meia-Noite em Paris', 2011, 94 ,2 ,4);
insert into filme values(default, 'Jumanji Bem-vindo Selva',2018, 119, 4 ,5);
insert into filme values(default, 'Jungle Cruise',2021, 127, 1 ,2);
select * from Filme;

insert into personagem values(8 , 7,'Gil Pender', 9000);
insert into personagem values(9 ,8, 'Smolder Bravestone', 20000);
insert into personagem values(10 , 9, 'Lily Houghton', 15000);
select * from Personagem;

/*Tarefa 2*/

/*1. Faça um select geral nas cinco tabelas e observe seus relacionamentos.*/

select * from Estudio;
select * from Categoria;
select * from Filme;
select * from artista;
select * from Personagem;

/*2. Em seguida, realize a seguinte inserção e consulta: */

insert into filme values(default,'Elvis',2022,120,null,3);
select * from filme;


/*3. Verifique quais os títulos dos filmes que possuem duração maior que 120 min?*/

SELECT titulo 
from filme
where duracao>120;

/*4. Na tabela ARTISTA, quais artistas possuem cidade nula*/

Select * 
from Artista
where cidade is null;


/*4. atualize as cidades nulas encontradas para três artistas.*/

Update Artista
set cidade = 'Cajazeiras'
where codArt in(
    select codArt
    from Artista
    where cidade is null
    Limit 3
);

select * from Artista;


/*5. Qual a descrição da categoria do filme ‘Coringa’?*/

select fil.codfilme, fil.titulo, cat.DescCATEG 
from Filme fil inner join Categoria cat on cat.codcateg= fil.codcateg
where fil.titulo='Coringa';


/*6. Mostre os títulos de filmes, com seus nomes de estúdios e nomes de suas categorias.*/

select fil.titulo, est.nomeest, cat.DescCATEG
from filme fil inner join Estudio est on fil.codEst = est.codEst  
inner join Categoria cat on fil.CodCATEG= cat.CodCATEG;


/*7. Qual o nome dos artistas que fizeram o filme ‘Encontro Explosivo’?*/

select art.NomeArt, pers.NomePers, fil.titulo
from filme fil  join personagem pers on pers.CodFILME = fil.CodFILME 
 join artista art on pers.CODART= art.CODART
where fil.titulo ='Encontro Explosivo';


/*8. 	Selecione os artistas que têm o nome iniciando com a letra ‘B’ e participaram de filmes da categoria ‘Aventura’.    */

select art.NomeArt, fil.titulo
from artista art 
 join personagem pers on art.CODART= pers.CODART
 join filme fil  on pers.CodFILME = fil.CodFILME 
 join categoria cat on fil.CodCateg= cat.CodCateg
where cat.DescCateg ='Aventura' and art.NomeArt like 'B%';


/*9. Apresente quantos filmes existem por categoria*/

select cat.DescCateg, count(*) as Quantidade
from categoria cat inner join filme fil on fil.codcateg = cat.codcateg
group by cat.desccateg;

/*10.  Explique o que o seguinte comando faz e mostra*/
select a.nomeart, p.nomepers
from artista a left outer join personagem p on a.codart = p.codart;

/*Esta busca irá mostrar todos os nomes de artistas e seus respectivos personagens, incluindo os que não possuen personagens. */


/*11.  O que a seguinte consulta retorna? Explique.*/
Select f.titulo as Filme, c.desccateg as Categoria
From filme f right join categoria c on f.codcateg = c.codcateg
Where c.codcateg is null;

/*Esta consulta não apressenta nenhum retorno. Pois não existe filme sem ligação com categoria.*/