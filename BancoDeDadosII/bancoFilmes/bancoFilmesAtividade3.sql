/*3. Crie uma consulta que mostre as descrições de categorias que estão na tabela Filme*/

select descCateg as "Categoria Descrição"
from categoria cat  
where cat.codcateg in (
	select fil.codCateg
	from filme fil
);

/*4. 	Qual o nome do artista cujo nome de personagem é ‘Natalie’?  */
select nomeArt 
from Artista
where codart in (
	select codArt 
	from personagem
	where nomepers like 'Natalie'
);

/*5.Existe algum artista cadastrado que não esteja na tabela Personagem? Crie uma consulta que apresente isso. */

select * 
from artista
where codArt not in (
	select codArt 
	from personagem 
);

/*R: Existe dois artistas que não possuem cadastro na lista de Personagem: Julia Roberts e Rodrigo Santoro. A consulta pode ser vista acima */

/*Correspondência utilizando o Join.*/
select * from Artista A left outer join personagem P on A.codArt=P.codArt;


/*6. Crie uma consulta que mostre os nomes dos artistas que possuem cachê acima da média.*/

select * 
from Artista A inner join Personagem P on A.codArt= P.codArt
where P.cache > (
select AVG(cache)
from Personagem
);