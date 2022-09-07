select * from cidades c inner join prefeitos p on c.id = p.cidade_id; -- traz a interseção entre as duas tabelas
select * from cidades c left join prefeitos p on c.id = p.cidade_id; -- traz além da interseção todo o lado esquerdo (no caso cidades)
select * from cidades c right join prefeitos p on c.id = p.cidade_id; -- traz além da interseção todo o lado direito (no caso prefeitos)

-- select * from cidades c full join prefeitos p on c.id = p.cidade_id; o mysql nao suporta full join

select * from cidades c left join prefeitos p on c.id = p.cidade_id
union
select * from cidades c right join prefeitos p on c.id = p.cidade_id; -- essa seria uma maneira de executar o full join 