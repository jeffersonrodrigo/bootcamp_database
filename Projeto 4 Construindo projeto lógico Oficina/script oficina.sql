create database IF NOT EXISTS oficina;
use oficina;
-- alter table <tabela_origem> add constraint <nome_restrição> foreign key (<campo_tabela_origem>) references <tabela_destino> (<campo_tabela_destino>);
-- Criar tabela Clientes
create table clientes(
	idClientes int auto_increment primary key
);
alter table clientes add constraint fk_veiculo foreign key (idClientes) references veiculo(idVeiculo);

-- Criar tabela Pessoa Fisica
create table pessoaFisica(
	idPessoaFisica int primary key auto_increment,
    Nome varchar(45) not null,
    CPF char(11) not null,
    Endereço varchar(45),
    Telefone varchar(11)
);
alter table pessoaFisica add constraint unique_cpf_pessoaFisica unique (CPF);
alter table pessoaFisica add constraint fk_idclientes_pf foreign key (idPessoaFisica) references clientes(idClientes),
add constraint fk_veiculo_pf foreign key (idPessoaFisica) references veiculo(idVeiculo); -- nome das FK não podem se duplicar, entao juntar sempre as tabelas

-- Criar Tabela Pessoa juridica
create table pessoaJuridica(
	idPessoaJuridica int primary key auto_increment,
    RazaoSocial Varchar(45) not null,
    CNPJ varchar(15) not null,
    Endereço varchar(45),
    Telefone varchar(11),
    constraint unique_cnpj_pessoaJuridica unique (CNPJ)
);
alter table pessoaJuridica add constraint fk_idclientes_pj foreign key (idPessoaJuridica) references clientes(idClientes),
add constraint fk_veiculo_pj foreign key (idPessoaJuridica) references veiculo(idVeiculo);

-- Criar tabela Veiculo
create table veiculo(
	idVeiculo int primary key auto_increment,
    PlacaVeiculo char(7) not null,
    constraint placa_id_veiculo unique (idVeiculo, PlacaVeiculo)
);
alter table veiculo add constraint fk_equi_mecanicos foreign key (idVeiculo) references equipeMecanico(idEquipeMecanico),
add constraint fk_conserto foreign key (idVeiculo) references conserto(idConserto),
add constraint fk_revisao foreign key (idVeiculo) references revisao(idRevisao);

-- Criar tabela Conserto
create table conserto(
	idConserto int primary key auto_increment,
    Descrição varchar(45) not null
);

-- Criar tabela Revisão
create table revisao(
	idRevisao int primary key auto_increment,
    Descrição varchar(45) not null
);

-- Criar tabela Mecanico
create table mecanico(
	idMecanico int primary key auto_increment,
    NomeMecanico varchar(45) not null,
    Telefone char(11) not null,
    Especialidade varchar(45)
);

-- Criar tabela Equipe Mecanico
create table equipeMecanico(
	idEquipeMecanico int primary key auto_increment
);
alter table equipeMecanico add constraint fk_mecanico foreign key (idEquipeMecanico) references mecanico(idMecanico);
alter table equipeMecanico add constraint fk_ordem_servico foreign key (idEquipeMecanico) references ordemServico(idOrdemServico);

-- Criar tabela Ordem de Serviço
create table ordemServico(
	idOrdemServico int primary key auto_increment,
    DataEmissao date,
    ValorServico decimal(5,2) not null,
    ValorPeca decimal(5,2) not null,
    ValorTotal decimal(5,2) not null,
    Status enum('A fazer', 'Fazendo', 'Concluido', 'Cancelado'),
    DataConclusao date
);

-- Criar tabela Tabela Referencia
create table tabelaReferencia(
	idTabelaReferencia int primary key auto_increment,
    constraint fk_os_tab_ref foreign key (idTabelaReferencia) references ordemServico(idOrdemServico)
);

-- Criar tabela Autorização Cliente
create table autorizacaoCliente(
	idAutorizacaoCliente int primary key auto_increment,
	Autorizado boolean,
    constraint fk_aut_cliente foreign key (idAutorizacaoCliente) references clientes(idClientes),
    constraint fk_aut_veiculo foreign key (idAutorizacaoCliente) references veiculo(idVeiculo),
    constraint fk_aut_OS foreign key (idAutorizacaoCliente) references ordemServico(idOrdemServico)
);

-- Criar tabela Peças
create table pecas(
	idPecas int primary key auto_increment,
    Descrição varchar(45),
    Valor decimal(5,2)
);

-- Criar tabela OSPeças
create table oSPecas(
	idOSPecas int primary key auto_increment,
    constraint fk_pecas foreign key (idOSPecas) references pecas(idPecas),
    constraint fk_os_pecas foreign key (idOSPecas) references ordemServico(idOrdemServico)
);

-- Criar tabela Serviços
create table servicos(
	idServicos int primary key auto_increment,
    Descrição varchar(45),
    Valor decimal(5,2)
);

-- Criar tabela OSServiços
create table oSServicos(
	idOSServicos int primary key auto_increment,
    constraint fk_servicos foreign key (idOSServicos) references servicos(idServicos),
    constraint fk_os_servicos foreign key (idOSServicos) references ordemServico(idOrdemServico)
);
