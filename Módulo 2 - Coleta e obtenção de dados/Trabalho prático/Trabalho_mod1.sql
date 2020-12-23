-- Exercícios de consulta

-- Quantos registros são retornados ao executar o seguinte comando sql no banco de dados após ter povoado a tabela de estados: 
--SELECT * FROM estado WHERE NomeEstado like 'P%'
SELECT COUNT(*) FROM estado WHERE NomeEstado like 'P%';

-- Qual o total de registros da tabela ‘caracteristicasgerais’?
SELECT COUNT(*) FROM CARACTERISTICASGERAIS ;

-- Crie uma consulta sql para verificar a quantidade de imóveis cadastrados no estado de RS
SELECT COUNT(*) FROM IMOVEL IMO
INNER JOIN CIDADE CID ON CID.CODIGOCOMPLETOIBGE  = IMO.CODIGOCOMPLETOIBGE
INNER JOIN ESTADO EST ON EST.CODESTADOIBGE  = CID.CODESTADOIBGE
WHERE EST.SIGLAESTADO = 'RS';

-- Quantos estados possuem imóveis cadastrados em que o valor do *condomínio é igual a R$ 0,00?
SELECT COUNT(DISTINCT EST.NOMEESTADO) AS QTD_ESTADOS FROM IMOVEL IMO
INNER JOIN CIDADE CID ON CID.CODIGOCOMPLETOIBGE  = IMO.CODIGOCOMPLETOIBGE
INNER JOIN ESTADO EST ON EST.CODESTADOIBGE  = CID.CODESTADOIBGE
WHERE IMO.VALORCONDOMINIO  = 0 ;

-- Quantos registros foram inseridos na tabela ‘caracteristicageralimovel’? 
SELECT COUNT(*) FROM CARACTERISTICAGERALIMOVEL ;

-- Qual o número do registro do imóvel (coluna codRegistro) que possui o maior valor de condomínio? 
SELECT IMO.CODREGISTRO FROM IMOVEL IMO
ORDER BY IMO.VALORCONDOMINIO DESC
LIMIT 1;