-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 25-Maio-2021 às 20:38
-- Versão do servidor: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Banco de dados: `livraria`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `autores`
--

CREATE TABLE IF NOT EXISTS `autores` (
  `idaut` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `nascimento` date DEFAULT NULL,
  PRIMARY KEY (`idaut`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `editoras`
--

CREATE TABLE IF NOT EXISTS `editoras` (
  `idedit` int(11) NOT NULL AUTO_INCREMENT,
  `editora` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idedit`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Extraindo dados da tabela `editoras`
--

INSERT INTO `editoras` (`idedit`, `editora`) VALUES
(2, 'McGrowHill 2'),
(4, 'São Paulo'),
(8, 'Editus'),
(10, 'Atenas Rio'),
(12, 'Itabuna');

-- --------------------------------------------------------

--
-- Estrutura da tabela `livros`
--

CREATE TABLE IF NOT EXISTS `livros` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) DEFAULT NULL,
  `edicao` int(11) DEFAULT NULL,
  `publicacao` int(11) DEFAULT NULL,
  `descricao` varchar(500) DEFAULT NULL,
  `ideditora` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=42 ;

--
-- Extraindo dados da tabela `livros`
--

INSERT INTO `livros` (`id`, `titulo`, `edicao`, `publicacao`, `descricao`, `ideditora`) VALUES
(28, 'Máquina de Turing', 2000, 2002, 'Teoria da computação', 2),
(30, 'Logica I', 2021, 2019, 'Logica de predicados', 4),
(34, 'Programação Web', 2018, 2020, '  Programação web com python, sql, html, css', 4),
(35, 'Engenharia de software', 2021, 2020, 'Teste de software com grafo fluxo de dados', 8),
(39, 'Programação Web', 2021, 2019, 'Programação Web', 4),
(41, 'Engenharia de software', 2021, 2019, 'Engenharia de software', 12);

-- --------------------------------------------------------

--
-- Estrutura da tabela `livro_autor`
--

CREATE TABLE IF NOT EXISTS `livro_autor` (
  `livro_id` int(11) DEFAULT NULL,
  `autor_id` int(11) DEFAULT NULL,
  KEY `fk_autor_livro` (`autor_id`),
  KEY `fk_livro_autor` (`livro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `publicacao`
--

CREATE TABLE IF NOT EXISTS `publicacao` (
  `idpub` int(11) NOT NULL AUTO_INCREMENT,
  `livro_id` int(11) DEFAULT NULL,
  `editora_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`idpub`),
  KEY `fk_editora` (`editora_id`),
  KEY `fk_livro` (`livro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `iduser` int(11) NOT NULL,
  `usuario` varchar(15) DEFAULT NULL,
  `senha` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `livro_autor`
--
ALTER TABLE `livro_autor`
  ADD CONSTRAINT `fk_autor_livro` FOREIGN KEY (`autor_id`) REFERENCES `autores` (`idaut`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_livro_autor` FOREIGN KEY (`livro_id`) REFERENCES `livros` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
