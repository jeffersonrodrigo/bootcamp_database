select -- seleciona/mostra o q vc quer
	regiao as 'Região', --  Usando um "alias"(apelido) para ficar mais correto o nome 
    sum(populacao) as Total -- função de somar/agregadora
from estados -- pegando dos estados 
group by regiao -- agrupando por região
order by Total desc; -- ordenando de forma decrescete pelo Total