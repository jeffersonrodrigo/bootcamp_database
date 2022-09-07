CREATE SCHEMA IF NOT EXISTS `eccommerce` DEFAULT CHARACTER SET utf8 ;
USE `eccommerce` ;

-- -----------------------------------------------------
-- Table `eccommerce`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Identificação` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `eccommerce`.`Entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Entrega` (
  `idEntrega` INT NOT NULL,
  `Código de rastreio` VARCHAR(45) NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idEntrega`),
  UNIQUE INDEX `Código de rastreio_UNIQUE` (`Código de rastreio` ASC) VISIBLE,
  INDEX `fk_Entrega_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Entrega_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `eccommerce`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `eccommerce`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Pedido` (
  `idPedido` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Status do pedido` VARCHAR(45) NULL,
  `Descrição` VARCHAR(45) NULL,
  `Frete` FLOAT NULL,
  `Entrega_idEntrega` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Entrega_idEntrega`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Pedido_Entrega1_idx` (`Entrega_idEntrega` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `eccommerce`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Entrega1`
    FOREIGN KEY (`Entrega_idEntrega`)
    REFERENCES `eccommerce`.`Entrega` (`idEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `eccommerce`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Produto` (
  `idProduto` INT NOT NULL,
  `Categoria` VARCHAR(45) NULL,
  `Descrição` VARCHAR(45) NULL,
  `Valor` VARCHAR(45) NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `eccommerce`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `Razão Social` VARCHAR(45) NULL,
  `CNPJ` CHAR(15) NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `eccommerce`.`Fornece`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Fornece` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idProduto`),
  INDEX `fk_Fornecedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Produto_Fornecedor_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `eccommerce`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `eccommerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `eccommerce`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Estoque` (
  `idEstoque` INT NOT NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `eccommerce`.`Produto no Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Produto no Estoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `eccommerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `eccommerce`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `eccommerce`.`Relação produto/pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Relação produto/pedido` (
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Quantidade` VARCHAR(45) NULL,
  PRIMARY KEY (`Produto_idProduto`, `Pedido_idPedido`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `eccommerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `eccommerce`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `eccommerce`.`Vendedores Terceiros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Vendedores Terceiros` (
  `idVendedores Terceiros` INT NOT NULL,
  `Razão Social` VARCHAR(45) NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idVendedores Terceiros`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `eccommerce`.`Produto por vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Produto por vendedor` (
  `Produto_idProduto` INT NOT NULL,
  `Vendedores Terceiros_idVendedores Terceiros` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Vendedores Terceiros_idVendedores Terceiros`),
  INDEX `fk_Produto_has_Vendedores Terceiros_Vendedores Terceiros1_idx` (`Vendedores Terceiros_idVendedores Terceiros` ASC) VISIBLE,
  INDEX `fk_Produto_has_Vendedores Terceiros_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Vendedores Terceiros_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `eccommerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Vendedores Terceiros_Vendedores Terceiros1`
    FOREIGN KEY (`Vendedores Terceiros_idVendedores Terceiros`)
    REFERENCES `eccommerce`.`Vendedores Terceiros` (`idVendedores Terceiros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `eccommerce`.`Pessoa Física`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Pessoa Física` (
  `idPessoa Física` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `CPF` VARCHAR(45) NOT NULL,
  `Endereço` VARCHAR(45) NULL,
  `Contato` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPessoa Física`, `Cliente_idCliente`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  INDEX `fk_Pessoa Física_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pessoa Física_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `eccommerce`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `eccommerce`.`Pessoa Jurídica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Pessoa Jurídica` (
  `idPessoa Jurídica` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Razão Social` VARCHAR(45) NOT NULL,
  `CNPJ` VARCHAR(45) NOT NULL,
  `Endereço` VARCHAR(45) NULL,
  `Contato` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPessoa Jurídica`, `Cliente_idCliente`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  INDEX `fk_Pessoa Jurídica_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pessoa Jurídica_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `eccommerce`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `eccommerce`.`Forma de pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Forma de pagamento` (
  `idForma de pagamento` INT NOT NULL,
  `Nome cartão` VARCHAR(45) NOT NULL,
  `Numero cartão` VARCHAR(45) NOT NULL,
  `Vencimento cartão` VARCHAR(45) NOT NULL,
  `CPF/CNPJ proprietário do cartão` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idForma de pagamento`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `eccommerce`.`Cliente tem Forma de pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eccommerce`.`Cliente tem Forma de pagamento` (
  `Cliente_idCliente` INT NOT NULL,
  `Forma de pagamento_idForma de pagamento` INT NOT NULL,
  PRIMARY KEY (`Cliente_idCliente`, `Forma de pagamento_idForma de pagamento`),
  INDEX `fk_Cliente_has_Forma de pagamento_Forma de pagamento1_idx` (`Forma de pagamento_idForma de pagamento` ASC) VISIBLE,
  INDEX `fk_Cliente_has_Forma de pagamento_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_has_Forma de pagamento_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `eccommerce`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Forma de pagamento_Forma de pagamento1`
    FOREIGN KEY (`Forma de pagamento_idForma de pagamento`)
    REFERENCES `eccommerce`.`Forma de pagamento` (`idForma de pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;