# Exemplos curl
Segue os comandos ```curl``` para serem utilizados como base.

Utilize a [collection Postman ](./contract/Sporting%20Event%20Race.postman_collection.json)

### Obter todos nomes cadastrados
É possível filtrar pelo inicio do nome
```curl
curl --location 'http://localhost:9111/corre-familia/atletas?start_name='
```

### Adiciona o número do atleta
Deve obter o id do atleta através da requisição acima
```curl
curl --location --request PUT 'http://localhost:9111/corre-familia/atletas' \
--header 'Content-Type: application/json' \
--data '{
    "id": "c65539e4-5b3a-4b4e-93d9-975d18920c55",
    "numero_atleta": 234521
}'
```
### Adiciona o tempo que o atleta concluiu a corrida
Pode enviar mais um elemento. O numero_atleta deve ser o que foi cadastrado acima. O operador é o usuário que está registrando o cronometro
```curl
curl --location 'http://localhost:9111/corre-familia/cronometros' \
--header 'Content-Type: application/json' \
--data '{
    "dados": [
        {
            "operador": "Carlos",
            "numero_atleta" : 234521,
            "momento_chegada": "22:10:07.378000"
        }
    ]
}'
```
### Obtém os segmentos cadastrados
```curl
curl --location 'http://localhost:9111/corre-familia/segmentos'
```
### Obtém a classificação.

É possível filtrar pelos campos da categoria

```curl
curl --location 'http://localhost:9111/corre-familia/classificacoes?sexo=Todos&faixa_etaria=16%20-%2020&categoria=Caminhada'
```