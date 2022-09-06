select * from estados;

select Sigla, nome as 'Nome do Estado' from estados; 

select Sigla, nome as 'Nome do Estado' from estados
where regiao = 'Sul'; -- busca dentro da tabela estados a sigla e o nome apenas dos estados onde a região é a Sul

select Sigla, nome as 'Nome do Estado' from estados
where regiao = 'Centro-Oeste';

select nome, regiao from estados
where populacao >= 10 -- buscar nome do estado e a regiao apenas dos estados que tem a população acima dos 10 milhoes
order by populacao desc -- ordenar por população de forma decrescente