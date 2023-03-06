/*Obter, para todos os produtos, código, nome com o cabeçalho "Produto", quantidade em estoque com o cabeçalho "Estoque Real" e estoque mínimo com o cabeçalho "Estoque Mínimo".*/

select idproduto, nome as 'Produto', quantest as 'Estoque Real', estmin as 'Estoque Mínimo'
from produto
order by quantest desc;

/*2. Obter, para todos os produtos, o código, o nome, o preço de venda e uma coluna adicional informando um aumento de 25% sobre o preço de venda. Dê um nome a esta coluna.*/

/*3.Obter as cidades onde residem os funcionários. Elimine a repetição de linhas.*/

select distinct func.nome, city.nome
from funcionario func
join cidade city
on func.idreside = city.idcidade
order by city.nome;

/*8. Obter o nome e o salário dos funcionários homens, casados e com salário menor ou igual a R$ 3.000,00, ordenados pelo salário em ordem descendente.*/
select  nome, salario
from funcionario func
where salario<=3000.00 and estcivil='C' and sexo='M'
order by salario desc;

/*10. Obter o código e o nome dos funcionários homens, exceto aqueles cujos nomes iniciam pela letra "A", ordenados pelo nome em ordem ascendente.*/
select idfuncionario, nome
from funcionario
where sexo='M' and nome not like 'a%'
order by nome;

/*11. Obter quantos clientes fizeram pedido na empresa.*/
select count(distinct idcliente) as quantos_Pedidos 
from pedido;

/*14. Obter a data de nascimento da funcionária mais velha.*/
select nome, min(datanasc) from funcionario
where sexo='F'
order by datanasc;

/*16. Obter quantos homens e quantas mulheres funcionários nasceram em cada cidade.*/
select distinct city.nome as cidade, func.sexo, count(*)
from funcionario func
join cidade city
on func.idreside = city.idcidade
group by city.nome, func.sexo
order by city.nome;

/*18.Obter o código do cliente e a quantidade de pedidos realizados por cada um em cada ano, apenas para os anos em que foram realizados mais de 5 pedidos.*/
select idcliente, year(datapedid) as ano_pedido, count(distinct idpedido) as pedidos
from pedido
group by idcliente, ano_pedido
having pedidos>5;

/*20. Obter o código e o nome dos clientes que moram na cidade de nome "London"*/
select distinct C.idcliente, C.nome
from cliente C
join Cidade city
on C.idcidade = city.idcidade
where city.nome = 'London'
order by city.nome;