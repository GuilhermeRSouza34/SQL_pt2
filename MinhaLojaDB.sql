-- Criar o banco de dados
CREATE DATABASE MinhaLojaDB;
USE MinhaLojaDB;

-- Tabela Produto
CREATE TABLE Produto (
    ProdutoID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT,
    Preco DECIMAL(10, 2) NOT NULL
);

-- Tabela Cliente
CREATE TABLE Cliente (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL
);

-- Tabela NotaFiscal
CREATE TABLE NotaFiscal (
    NotaFiscalID INT PRIMARY KEY,
    ClienteID INT,
    DataCompra DATE NOT NULL,
    ValorTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

-- Tabela ItemNotaFiscal para representar os itens na nota fiscal
CREATE TABLE ItemNotaFiscal (
    ItemID INT PRIMARY KEY,
    NotaFiscalID INT,
    ProdutoID INT,
    Quantidade INT NOT NULL,
    PrecoUnitario DECIMAL(10, 2) NOT NULL,
    ValorTotalItem DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (NotaFiscalID) REFERENCES NotaFiscal(NotaFiscalID),
    FOREIGN KEY (ProdutoID) REFERENCES Produto(ProdutoID)
);

-- Inserções de Exemplo
INSERT INTO Produto (ProdutoID, Nome, Descricao, Preco) VALUES (1, 'Laptop', 'Laptop de última geração', 1200.00);
INSERT INTO Produto (ProdutoID, Nome, Descricao, Preco) VALUES (2, 'Smartphone', 'Smartphone avançado', 800.00);

INSERT INTO Cliente (ClienteID, Nome, Email) VALUES (1, 'João Silva', 'joao@email.com');
INSERT INTO Cliente (ClienteID, Nome, Email) VALUES (2, 'Maria Oliveira', 'maria@email.com');

INSERT INTO NotaFiscal (NotaFiscalID, ClienteID, DataCompra, ValorTotal) VALUES (101, 1, '2023-10-25', 1200.00);
INSERT INTO NotaFiscal (NotaFiscalID, ClienteID, DataCompra, ValorTotal) VALUES (102, 2, '2023-10-26', 800.00);

-- Inserir itens nas notas fiscais
INSERT INTO ItemNotaFiscal (ItemID, NotaFiscalID, ProdutoID, Quantidade, PrecoUnitario, ValorTotalItem) VALUES (1, 101, 1, 2, 1200.00, 2400.00);
INSERT INTO ItemNotaFiscal (ItemID, NotaFiscalID, ProdutoID, Quantidade, PrecoUnitario, ValorTotalItem) VALUES (2, 102, 2, 1, 800.00, 800.00);

-- Exemplos de Consultas
-- Selecionar todos os produtos
SELECT * FROM Produto;

-- Selecionar todos os clientes
SELECT * FROM Cliente;

-- Selecionar todas as notas fiscais com detalhes do cliente
SELECT NotaFiscal.NotaFiscalID, Cliente.Nome AS NomeCliente, NotaFiscal.DataCompra, NotaFiscal.ValorTotal
FROM NotaFiscal
JOIN Cliente ON NotaFiscal.ClienteID = Cliente.ClienteID;

-- Selecionar todos os itens de uma nota fiscal específica
SELECT ItemNotaFiscal.ItemID, Produto.Nome AS NomeProduto, ItemNotaFiscal.Quantidade, ItemNotaFiscal.PrecoUnitario, ItemNotaFiscal.ValorTotalItem
FROM ItemNotaFiscal
JOIN Produto ON ItemNotaFiscal.ProdutoID = Produto.ProdutoID
WHERE ItemNotaFiscal.NotaFiscalID = 101;