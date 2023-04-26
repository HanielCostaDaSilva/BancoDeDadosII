	truncate testa_bloco;
	DO $$
		Declare 
			cont int :=0;
	Begin
	  while cont<=12 loop
			if  mod(cont,3)=0 then
				   Insert into testa_bloco values(cont, concat('esse é o registro: ', cont) );
			End if;
			cont:= cont+ 1;
	   End loop; 
	End$$;

	select * from testa_bloco;
	
	


/*Questão 4*/

select * from produto;

alter table produto add column quantidade int;

alter table produto add column status text;



update produto
set quantidade = 5 
where codprod in (1,3,4,6);

update produto
set quantidade = 35 
where codprod in (7,9);

Do $$ 
	Declare 
       prodCursor Cursor for select * from produto;
 Begin
   for vprod in prodCursor Loop
      if vprod.quantidade > 30 then
         update produto
         set status = 'Estoque dentro do esperado'
         where produto.codprod = vprod.codProd;
      else update produto
             set status = 'Estoque fora do limite mínimo'
         where produto.codprod = vprod.codProd;
		end if;
   end loop;
 End$$;
 
select * from produto;

/*Questão 5 Implemente um bloco anônimo que mostre, via mensagem, todos os vendedores cadastrados.*/

select * from vendedor;


Do $$
	Declare 
		cursorVend Cursor for select codVend, nome, salarioFixo from vendedor;
	
	Begin

		for vInfo in cursorVend loop
			raise notice '%',concat('Id: ',vInfo.codVend, ' Nome: ',vInfo.nome, ' salario: ', vInfo.salariofixo);
		end loop;

End $$
