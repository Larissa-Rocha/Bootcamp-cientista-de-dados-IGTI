import json
from datetime import datetime
from dateutil.relativedelta import relativedelta
import mysql.connector

import requests

response = requests.get("https://api-coleta-dados.herokuapp.com/api/pessoas")

print(response.status_code) 

print(response.content) 

dados = json.loads(response.content) 

for pessoa in dados:
    print(pessoa)

mydb = mysql.connector.connect(
    host='localhost',
    user='root',
    password='',
    database='db_desafio'
)

mycursor = mydb.cursor()

# Insercao dos Estados
for pessoa in dados:
    sigla_uf = pessoa['estado']

    query = "INSERT INTO TB_ESTADO (sigla) SELECT * FROM (SELECT '%s') AS tmp " % sigla_uf
    query += "WHERE NOT EXISTS (SELECT sigla FROM TB_ESTADO WHERE sigla = '%s') LIMIT 1;" % sigla_uf

    mycursor.execute(query)

    mydb.commit()

print(mycursor.rowcount, "registro(s) inserido(s).")

# Insercao das Cidades
for pessoa in dados:
    cidade = pessoa['cidade']

    query = "INSERT INTO TB_CIDADE (nome,id_estado) (SELECT * FROM (SELECT '{}', (SELECT id FROM TB_ESTADO " \
            "WHERE SIGLA = '{}')) AS tmp ".format(cidade, pessoa['estado'])
    query += "WHERE NOT EXISTS (SELECT nome FROM TB_CIDADE WHERE nome = '{}') LIMIT 1);".format(cidade)

    mycursor.execute(query)

    mydb.commit()

print(mycursor.rowcount, "registro(s) inserido(s).")

# Insercao das cores
for pessoa in dados:
    cor = pessoa['cor']

    query = "INSERT INTO TB_COR (cor) SELECT * FROM (SELECT '{}') AS tmp ".format(cor)
    query += "WHERE NOT EXISTS (SELECT cor FROM TB_COR WHERE cor = '{}') LIMIT 1;".format(cor)

    mycursor.execute(query)

    mydb.commit()

print(mycursor.rowcount, "registro(s) inserido(s).")

# Insercao dos tipos sanguineos
for pessoa in dados:
    tipo_sanguineo = pessoa['tipo_sanguineo']

    query = "INSERT INTO TB_TIPOSANGUINEO (tipo) SELECT * FROM (SELECT '{}') AS tmp ".format(tipo_sanguineo)
    query += "WHERE NOT EXISTS (SELECT tipo FROM TB_TIPOSANGUINEO WHERE tipo = '{}') LIMIT 1;".format(tipo_sanguineo)

    mycursor.execute(query)

    mydb.commit()

print(mycursor.rowcount, "registro(s) inserido(s).")

for pessoa in dados:
    if pessoa['idade'] is None:
        idade = relativedelta(datetime.now(), datetime.strptime(pessoa['data_nasc'], "%d/%m/%Y"))
        pessoa['idade'] = idade.years

    if len(pessoa['data_nasc']) < 10:
        diff_date = datetime.now() - relativedelta(years=pessoa['idade'])
        ano_nasc = diff_date.year
        if datetime.strptime(pessoa['data_nasc'] + '/' + str(datetime.now().year), "%d/%m/%Y") > datetime.now():
            ano_nasc = ano_nasc - 1
        pessoa['data_nasc'] = pessoa['data_nasc'] + '/' + str(ano_nasc)

    query = "INSERT INTO TB_PESSOA (nome,idade,data_nasc,sexo,signo,altura,peso,id_cidade,id_cor,id_tiposanguineo) " \
            "VALUES " \
            "('{}','{}',str_to_date('{}','%d/%m/%Y'),'{}','{}','{}','{}', (SELECT id FROM TB_CIDADE " \
            "WHERE nome = '{}'), (SELECT id FROM TB_COR WHERE cor = '{}'), (SELECT id FROM TB_TIPOSANGUINEO WHERE " \
            "tipo = '{}')); ".format(pessoa['nome'], pessoa['idade'], pessoa['data_nasc'], pessoa['sexo'][0:1],
                                     pessoa['signo'], pessoa['altura'].replace(',', '.'), pessoa['peso'],
                                     pessoa['cidade'],
                                     pessoa['cor'], pessoa['tipo_sanguineo'])

    mycursor.execute(query)

    mydb.commit()

print(mycursor.rowcount, "registro(s) inserido(s).")