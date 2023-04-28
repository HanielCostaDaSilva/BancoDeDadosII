/*Questão 1*/

CREATE OR REPLACE FUNCTION ModificarEstoque (codigo INTEGER, quantidadeInserir INTEGER) 
RETURNS void as $$
    Begin
    
        update produto set quantest = quantidadeInserir where codprod= codigo;
        
        if (select quantest from produto where  codprod= codigo ) > 30 then 
            update produto 
                set status = 'Estoque dentro do esperado' 
                where codprod = codigo; 
        else 
            update produto 
            set status = 'Estoque fora do limite minimo' 
            where codprod = codigo; 
        end if; 
End; 
$$ LANGUAGE 'plpgsql';

select * from produto; 
        update produto set status = null where codprod = 10;  
        select ModificarEstoque(10,35); 

select * from produto; 


/*Questão 2*/
create or replace function getSumSalario()  
       returns numeric as $$  
    Declare 
        salcomp numeric; 
        v record; 
    Begin 
        Salcomp = 0; 
        for v in (select salariofixo from vendedor where salariofixo is not null)   loop
            salcomp = salcomp + v.salariofixo; 
        end loop; 
        return salcomp; 
    end; 
    $$ LANGUAGE 'plpgsql'; 

select * from vendedor;

/*Questão 2.1*/
create or replace function getSumSalario2()
    returns numeric as $$
	Declare
		somaSalario numeric;
	Begin
    	SELECT SUM(salariofixo) INTO somaSalario  FROM vendedor;
		return somaSalario;
		
end;
$$ LANGUAGE 'plpgsql';

select getSumsalario2(); 


/*3. Crie uma tabela Fornecedor. Em seguida,  faça uma função que permita a inserção de registros nesta tabela */

create Table if not exists Fornecedor (

cod integer Not Null primary key,
nome varchar(30),
CNPJ varchar(15) ,
email varchar(15)
);


create or replace function insertFornedor( 
    codigo integer, 
    nome varchar(30),
    Cnpj varchar(15), 
    email varchar(15))
    returns void as $$
    
    Begin

    insert into Fornecedor values(codigo, nome, CNPJ, email);

    end;
    $$LANGUAGE 'plpgsql';

select insertFornedor(1,'Abatedouro Silva','123451234512345','Naruto@gmail');
select insertFornedor(3,'Desmatamento Legal','478951234512345','Jair@gmail');
select insertFornedor(100,'NHK','0000000000000','?????@gmail');

select * from fornecedor;

/* Desenvolva uma função armazenada (showFornecedor) que mostre, via mensagem,  todos os fornecedores cadastrados. Apresente seus códigos, nomes e emails. */


create or replace function showFornecedor() returns void as $$ 
    Declare
    f_cursor Cursor for select * from fornecedor;
	cod text;
	nome text;
	email text;
	inform text;

    Begin
        for forn in f_cursor loop
			raise notice '----------------';
			cod  = concat('código: ',forn.cod);
            nome = concat('Nome Fantasia: ',forn.nome);
            email = concat('Email: ',forn.email);
            inform= cod||'===='||nome||'====='||email;
			
			raise notice '%',inform;
        
		end loop;
    end;
    $$LANGUAGE 'plpgsql';
	
select showFornecedor();