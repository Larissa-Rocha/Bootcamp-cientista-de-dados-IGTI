import json
import pymongo

client = pymongo.MongoClient('localhost', 27017)

db = client.igti

collection = db.video_game_sales

def readJson():
    filename = 'videogame_sales_mongo.json'

    with open(filename, 'r', encoding='utf8') as f:
        return json.load(f)


data = readJson()

collection.insert_many(data)

#Qual jogo possui a maior venda global (“Global_Sales”) para a plataforma PS2?
for documents in collection.find({"Platform": "PS2"}).sort("Global_Sales", -1).limit(1):
  print(documents['Name'])

#Qual a posição no Rank global (“Rank”) está o segundo jogo mais vendido na Europa? Ordenar pelo atributo "EU_Sales"
for documents in collection.find({}).sort("EU_Sales", -1).limit(2):
  print(documents['Rank'])

#Qual o nome do jogo que possui a menor venda global (“Global_Sales”) no ano de 2010?
for documents in collection.find({"Year": 2010}).sort("Global_Sales", 1).limit(1):
  print(documents['Name'])

#Qual a plataforma (“Platform”) do jogo mais vendido considerando as vendas globais ("Global_Sales ") no ano de 2008?
for documents in collection.find({"Year": 2008}).sort("Global_Sales", -1).limit(1):
  print(documents['Platform'])

#Qual o nome do jogo que é exibido ao executar o comando para retornar o primeiro documento da coleção onde a condição seja a plataforma (“Platform”) igual a PS4?
print(collection.find_one({"Platform": "PS4"})['Name'])

#Quantos documentos existem na base de dados referentes à plataforma (“Platform”) “X360”?
print(collection.count_documents({"Platform": "X360"}))

#Qual a plataforma (“Platform”) do jogo mais vendido no Japão ("JP_Sales") no ano de 2015?
for documents in collection.find({"Year": 2015}).sort("JP_Sales", -1).limit(1):
  print(documents['Platform'])

#Em que posição do “Rank” o jogo “The Witcher 3: Wild Hunt” está considerando a plataforma “XOne”?
for documents in collection.find({"Platform": "XOne","Name": "The Witcher 3: Wild Hunt"}):
  print(documents['Rank'])

#Quantos documentos são retornados ao executar uma consulta em que o atributo “Global_Sales” seja maior ou igual a 2?
print(collection.count_documents({"Global_Sales":{"$gte":2}}))