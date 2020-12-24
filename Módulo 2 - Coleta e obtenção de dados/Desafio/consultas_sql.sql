#Quantas pessoas possuem idade maior ou igual a 50 anos?
 SELECT
	count(*)
FROM
	TB_PESSOA
WHERE
	IDADE >= 50;

#Qual a média de idade das pessoas que moram em Mato Grosso?
 SELECT
	avg(idade)
FROM
	TB_PESSOA PES
INNER JOIN TB_CIDADE CID ON
	CID.ID = PES.ID_CIDADE
INNER JOIN TB_ESTADO EST ON
	EST.ID = CID.ID_ESTADO
WHERE
	EST.SIGLA = 'MT';

#Quantas pessoas nasceram nos anos de 1968 a 1978 (incluindo 1968 e 1978)?
 SELECT
	COUNT(*)
FROM
	TB_PESSOA PES
WHERE
	YEAR (PES.DATA_NASC) BETWEEN 1968 AND 1978;

#Ao executar o seguinte comando (abaixo) SQL no banco de dados criado, qual é o valor retornado?
 SELECT
	count(*)
FROM
	tb_pessoa
INNER JOIN tb_tiposanguineo ON
	tb_pessoa.id_tiposanguineo = tb_tiposanguineo.id
INNER JOIN tb_cidade ON
	tb_pessoa.id_cidade = tb_cidade.id
INNER JOIN tb_estado ON
	tb_cidade.id_estado = tb_estado.id
WHERE
	tb_tiposanguineo.tipo LIKE "AB-"
	AND (tb_estado.sigla LIKE "AP"
	OR tb_estado.sigla LIKE "PE");

#Qual o nome da pessoa mais velha na base de dados?
 SELECT
	*
FROM
	TB_PESSOA PES
ORDER BY
	PES.IDADE DESC
LIMIT 1;

#Qual o nome da pessoa mais nova da base de dados?
 SELECT
	*
FROM
	TB_PESSOA PES
ORDER BY
	PES.IDADE ASC
LIMIT 1;