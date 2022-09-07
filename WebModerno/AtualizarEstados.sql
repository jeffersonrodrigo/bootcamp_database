update estados 
set nome = 'Maranhão'
where sigla = 'MA'; -- se não colocar algo que identifique especificadamente onde se quer alterar acabaria alterando todo o banco de dados

select nome from estados where sigla = 'MA';

update estados
set nome= 'Paraná', populacao = 11.32
where sigla = 'PR';