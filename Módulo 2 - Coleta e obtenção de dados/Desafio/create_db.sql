CREATE SCHEMA IF NOT EXISTS `db_desafio` DEFAULT CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS `db_desafio`.`tb_cor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `db_desafio`.`tb_estado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sigla` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `db_desafio`.`tb_tiposanguineo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `db_desafio`.`tb_cidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cidade_estado` (`id_estado` ASC),
  CONSTRAINT `fk_cidade_estado`
    FOREIGN KEY (`id_estado`)
    REFERENCES `db_desafio`.`tb_estado` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `db_desafio`.`tb_pessoa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `idade` INT,
  `data_nasc` DATETIME,
  `sexo` CHAR(1),
  `signo` VARCHAR(45),
  `altura` FLOAT,
  `peso` FLOAT,
  `id_cidade` INT,
  `id_cor` INT,
  `id_tiposanguineo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pessoa_cidade` (`id_cidade` ASC),
  INDEX `fk_pessoa_cor` (`id_cor` ASC),
  INDEX `fk_pessoa_tiposanguineo` (`id_tiposanguineo` ASC),
  CONSTRAINT `fk_pessoa_cidade`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `db_desafio`.`tb_cidade` (`id`),
    CONSTRAINT `fk_pessoa_cor`
    FOREIGN KEY (`id_cor`)
    REFERENCES `db_desafio`.`tb_cor` (`id`),
    CONSTRAINT `fk_pessoa_tiposanguineo`
    FOREIGN KEY (`id_tiposanguineo`)
    REFERENCES `db_desafio`.`tb_tiposanguineo` (`id`)
    )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;