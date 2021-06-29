-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PizzaConmigo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PizzaConmigo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PizzaConmigo` DEFAULT CHARACTER SET utf8 ;
USE `PizzaConmigo` ;

-- -----------------------------------------------------
-- Table `PizzaConmigo`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PizzaConmigo`.`cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `apellido` VARCHAR(60) NOT NULL,
  `dni` INT NOT NULL,
  `telefono` INT NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = INNODB;


-- -----------------------------------------------------
-- Table `PizzaConmigo`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PizzaConmigo`.`pais` (
  `idPais` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idPais`))
ENGINE = INNODB;


-- -----------------------------------------------------
-- Table `PizzaConmigo`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PizzaConmigo`.`provincia` (
  `idProvincia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `fk_pais` INT NOT NULL,
  PRIMARY KEY (`idProvincia`),
  INDEX `fk_provincia_pais1_idx` (`fk_pais` ASC),
  CONSTRAINT `fk_provincia_pais1`
    FOREIGN KEY (`fk_pais`)
    REFERENCES `PizzaConmigo`.`pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- Table `PizzaConmigo`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PizzaConmigo`.`localidad` (
  `idLocalidad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `cp` INT NOT NULL,
  `fk_provincia` INT NOT NULL,
  PRIMARY KEY (`idLocalidad`),
  INDEX `fk_localidad_provincia1_idx` (`fk_provincia` ASC),
  CONSTRAINT `fk_localidad_provincia1`
    FOREIGN KEY (`fk_provincia`)
    REFERENCES `PizzaConmigo`.`provincia` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- Table `PizzaConmigo`.`domiclio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PizzaConmigo`.`domiclio` (
  `idDomiclio` INT NOT NULL AUTO_INCREMENT,
  `numero` INT NOT NULL,
  `calle` VARCHAR(60) NOT NULL,
  `fk_cliente` INT NOT NULL,
  `fk_localidad` INT NOT NULL,
  PRIMARY KEY (`idDomiclio`),
  INDEX `fk_domiclio_cliente_idx` (`fk_cliente` ASC),
  INDEX `fk_domiclio_localidad1_idx` (`fk_localidad` ASC),
  CONSTRAINT `fk_domiclio_cliente`
    FOREIGN KEY (`fk_cliente`)
    REFERENCES `PizzaConmigo`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_domiclio_localidad1`
    FOREIGN KEY (`fk_localidad`)
    REFERENCES `PizzaConmigo`.`localidad` (`idLocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- Table `PizzaConmigo`.`tamanioPizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PizzaConmigo`.`tamanioPizza` (
  `idTamanioPizza` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTamanioPizza`))
ENGINE = INNODB;


-- -----------------------------------------------------
-- Table `PizzaConmigo`.`tipoDePizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PizzaConmigo`.`tipoDePizza` (
  `idTipoDePizza` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoDePizza`))
ENGINE = INNODB;


-- -----------------------------------------------------
-- Table `PizzaConmigo`.`facturaPedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PizzaConmigo`.`facturaPedido` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `precioTotal` FLOAT NOT NULL,
  PRIMARY KEY (`idFactura`))
ENGINE = INNODB;


-- -----------------------------------------------------
-- Table `PizzaConmigo`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PizzaConmigo`.`pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `fechaPedido` VARCHAR(45) NOT NULL,
  `horaPedido` VARCHAR(45) NOT NULL,
  `horaEntrega` VARCHAR(45) NOT NULL,
  `demoraEstimadaMin` INT NOT NULL,
  `observaciones` TEXT(300) NULL,
  `fk_cliente` INT NOT NULL,
  `facturaPedido_idFactura` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_pedido_cliente1_idx` (`fk_cliente` ASC),
  INDEX `fk_pedido_facturaPedido1_idx` (`facturaPedido_idFactura` ASC),
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`fk_cliente`)
    REFERENCES `PizzaConmigo`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_facturaPedido1`
    FOREIGN KEY (`facturaPedido_idFactura`)
    REFERENCES `PizzaConmigo`.`facturaPedido` (`idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- Table `PizzaConmigo`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PizzaConmigo`.`pizza` (
  `idPizza` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `descripcion` TEXT(200) NULL,
  `fk_tamanioPizza` INT NOT NULL,
  `fk_tipoDePizza` INT NOT NULL,
  `fk_pedido` INT NOT NULL,
  PRIMARY KEY (`idPizza`),
  INDEX `fk_pizza_tamanioPizza1_idx` (`fk_tamanioPizza` ASC),
  INDEX `fk_pizza_tipoDePizza1_idx` (`fk_tipoDePizza` ASC),
  INDEX `fk_pizza_pedido1_idx` (`fk_pedido` ASC),
  CONSTRAINT `fk_pizza_tamanioPizza1`
    FOREIGN KEY (`fk_tamanioPizza`)
    REFERENCES `PizzaConmigo`.`tamanioPizza` (`idTamanioPizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizza_tipoDePizza1`
    FOREIGN KEY (`fk_tipoDePizza`)
    REFERENCES `PizzaConmigo`.`tipoDePizza` (`idTipoDePizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizza_pedido1`
    FOREIGN KEY (`fk_pedido`)
    REFERENCES `PizzaConmigo`.`pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- Table `PizzaConmigo`.`estadoPedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PizzaConmigo`.`estadoPedido` (
  `idEstadoPedido` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `horaDesde` VARCHAR(10) NOT NULL,
  `horaHasta` VARCHAR(10) NULL,
  `fk_pedido` INT NOT NULL,
  PRIMARY KEY (`idEstadoPedido`),
  INDEX `fk_estadoPedido_pedido1_idx` (`fk_pedido` ASC),
  CONSTRAINT `fk_estadoPedido_pedido1`
    FOREIGN KEY (`fk_pedido`)
    REFERENCES `PizzaConmigo`.`pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


-- -----------------------------------------------------
-- Table `PizzaConmigo`.`precioUnitario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PizzaConmigo`.`precioUnitario` (
  `idPrecio` INT NOT NULL AUTO_INCREMENT,
  `precio` FLOAT NOT NULL,
  `fechaDesde` VARCHAR(45) NOT NULL,
  `fechaHasta` VARCHAR(45) NULL,
  `fk_pizza` INT NOT NULL,
  PRIMARY KEY (`idPrecio`),
  INDEX `fk_precioUnitario_pizza1_idx` (`fk_pizza` ASC),
  CONSTRAINT `fk_precioUnitario_pizza1`
    FOREIGN KEY (`fk_pizza`)
    REFERENCES `PizzaConmigo`.`pizza` (`idPizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;