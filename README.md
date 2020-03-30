# Desafio TruckPad

Passos necessários para executar a aplicação:

* Versão do Ruby 2.6.5

* Versão do Rails 5.2.4.2

* Dependências

  - Sqlite (banco de dados para o Active Record)
  - Geocoder (API de Geolocalização)
  - Faker (Usado para popular o banco de dados)

* Instruções para deploy

  - git clone https://github.com/celsofilho82/desafio-truckpad-api.git
  - cd desafio-truckpad-api
  - bundle install
  - rails dev:setup
  - rails s
  - API disponível no endereço http://localhost:3000/api/v1/drivers

# Detalhes do Desafio

Em um terminal chegam para carga e descarga cerca de mil caminhões por dia, nem todos os caminhões saem
do terminal carregados para voltar a seu lugar de origem. Muitos dos nossos amigos caminhoneiros são
motoristas autônomos e alguns deles tem seu próprio veiculo.

+ Precisamos criar uma api para para cadastrar os motoristas que chegam nesse terminal e saber
mais informações sobre eles. Precisamos saber nome, idade, sexo, se possui veiculo, tipo da CNH,
se está carregado, tipo do veiculo que está dirigindo.
+ Precisamos saber a origem e destino de cada caminhoneiro. Será necessário pegar a latitude e
longitude de cada origem e destino.
+ Precisamos de um método para consultar todos os motoristas que não tem carga para voltar ao seu
destino de origem.
+ Precisamos saber quantos caminhões passam carregados pelo terminal durante o dia, semana e
mês.
+ Precisamos saber quantos caminhoneiros tem veiculo próprio.
+ Mostrar uma lista de origem e destino agrupado por cada um dos tipos.
+ Será necessário atualizar os registros dos caminhoneiros.
+ Criar testes unitários para validar o funcionamento dos serviços criados. Utilize o framework de
testes de sua preferência.

# Detahes da implementação

| Descrição | URL |
|---|---|
| URL Base | http://localhost:3000/api/v1/ |

## Recursos disponíveis
| Recursos | URL | Descrição |
|---|---|---|
| `DRIVERS` | http://localhost:3000/api/v1/drivers | Retorna informações de um ou mais motoristas |
| `TRIPS` | http://localhost:3000/api/v1/trips | Retorna detalhes sobre o trajeto dos motoristas |
| `LOCATIONS` | http://localhost:3000/api/v1/locations | Retorna detalhes de geolocalizão dos destinos cadastrados |


## Métodos
Requisições para a API devem seguir os padrões:
| Método | Descrição |
|---|---|
| `GET` | Retorna informações de um ou mais motoristas. |
| `POST` | Utilizado para cadastrar um novo motorista. |
| `PATCH` | Atualiza total ou parcial os dados de cadastro de um motorista. |
| `DELETE` | Remove o registro de um motorista. |


## Respostas

| Código | Descrição |
|---|---|
| `200` | Requisição executada com sucesso (success).|
| `203` | Registro criado com sucesso (success).|
| `404` | Registro pesquisado não encontrado (Not found).|
| `422` | Não foi possível processar as instruções presentes. (Unprocessable Entity).|

# Acessando os recursos

| Recurso | URL |
|---|---|
| `DRIVERS` | http://localhost:3000/api/v1/drivers |


### [GET] [http://localhost:3000/api/v1/drivers]

+ Request (application/json)

+ Response 200 (application/json) - Retorna informações sobre os motoristas cadastrados

        [
            {
          "id": 1,
          "name": "Hwa Gleichner",
          "gender": "f",
          "has_truck": true,
          "cnh_type": "C",
          "birthdate": "1982-08-18",
          "truck": {
              "id": 4,
              "description": "Carreta Simples"
          },
          "trips": [
              {
                  "id": 1,
                  "truck_loaded": true,
                  "has_load_back": false,
                  "driver_id": 1,
                  "truck_id": 4,
                  "origin": {
                      "id": 10,
                      "city": "Carapicuíba",
                      "state": "São Paulo",
                      "latitude": -23.5234673,
                      "longitude": -46.8406808
                  },
                  "destination": {
                      "id": 7,
                      "city": "Diadema",
                      "state": "São Paulo",
                      "latitude": -23.681347,
                      "longitude": -46.62052
                  }
          ]


### [POST] [http://localhost:3000/api/v1/drivers]


+ Attributes (object)

    + **name**: Nome do motorista (string, **required**)
    + **gender**: Sexo do motorista (string, **required**)
    + **birthdate**: Data de nascimento formato {yyyy-mm-dd} (string, **required**)
    + **has_truck**: Se possui veiculo próprio {true || false} (boolean, **required**)
    + **cnh_type**: O tipo da CNH do motorista (string, **required**)
    + truck_id: Caso tenha um veiculo próprio, informe o tipo segundo a tabela abaixo: (integer, optional)
        | Tipos de caminhão | Código |
        |---|---|
        | `Caminhão 3/4 ` | 1 |
        | `Caminhão Toco ` | 2 |
        | `Caminhão Truck ` | 3 |
        | `Carreta Simples  ` | 4 |
        | `Carreta Eixo Extendido ` | 5 |

+ Request (application/json)

    + Body

          {
              "name": "Celso Ribeiro",
              "gender": "m",
              "has_truck": true,
              "cnh_type": "C",
              "birthdate": "1982-10-02",
              "truck_id": 5
          }

+ Response 203 (application/json) - Todos os dados do motorista cadastrado.

    + Body
      
           
                {
                    "id": 36,
                    "name": "Celso Ribeiro",
                    "gender": "m",
                    "has_truck": true,
                    "cnh_type": "C",
                    "birthdate": "1982-10-02",
                    "truck": {
                      "id": 5,
                      "description": "Carreta Eixo Extendido"
                    },
                    "trips": []
                }
           

### [GET] [http://localhost:3000/api/v1/drivers/{codigo}]

+ Parameters
    + codigo (required, number, `36`) ... Código do motorista

+ Request (application/json)

+ Response 200 (application/json) - Todos os dados do motorista solicitado.

    + Body

          {
              "id": 36,
              "name": "Celso Ribeiro",
              "gender": "m",
              "has_truck": true,
              "cnh_type": "C",
              "birthdate": "1982-10-02",
              "truck": {
                  "id": 5,
                  "description": "Carreta Eixo Extendido"
              },
              "trips": []
          }

+ Response 404 (application/json) - Motorista não encontrado.

    + Body

            {
              "status": 404,
              "error": "Not Found",
              "exception": "Couldn't find Driver with 'id'=37"
            }


### [PATCH] [http://localhost:3000/api/v1/drivers/{codigo}]

+ Parameters
    + codigo (required, number, `36`) ... Código do motorista

+ Request (application/json)

    + Body
    
              {
                "truck_id": 2
              }

+ Response 200 (application/json) - Todos os dados do motorista atualizado.

    + Body

              {
                  "id": 36,
                  "name": "Celso Ribeiro",
                  "gender": "m",
                  "has_truck": true,
                  "cnh_type": "C",
                  "birthdate": "1982-10-02",
                  "truck": {
                    "id": 2,
                    "description": "Caminhão Toco"
                  },
                  "trips": []                
              }

+ Response 404 (application/json) - Motorista não encontrado.

    + Body

            {
              "status": 404,
              "error": "Not Found",
              "exception": "Couldn't find Driver with 'id'=37"
            }

### [DELETE] [http://localhost:3000/api/v1/drivers/{codigo}]

+ Request (application/json)

+ Parameters
    + codigo (required, number, `36`) ... Código do motorista

+ Request (application/json)


+ Response 200 (application/json) - Excluido com sucesso o retorno é um objeto vazio.

    + Body

            {}

+ Response 404 (application/json) - Motorista não encontrado.

    + Body

            {
              "status": 404,
              "error": "Not Found",
              "exception": "Couldn't find Driver with 'id'=37"
            }
            
### Consultas adicionais

### [GET] [http://localhost:3000/api/v1/drivers?has_load_back={option}]

+ Parameters
    + has_load_back = boolean (required, `true` || `false`) ... Consultar todos os motoristas que tem ou não carga para voltar ao seu destino de origem.

+ Request (application/json) - Ex: http://localhost:3000/api/v1/drivers?has_load_back=false

+ Response 200 (application/json) - Retorna todos os motoristas que não tem carga para voltar a sua origem

     + Body
        
      [
        {
            "id": 3,
            "name": "Terrence Reinger",
            "gender": "f",
            "has_truck": false,
            "cnh_type": "C",
            "birthdate": "1977-05-26",
            "trips": [
                {
                    "id": 3,
                    "truck_loaded": true,
                    "has_load_back": false,
                    "driver_id": 3,
                    "truck_id": 5,
                    "origin": {
                        "id": 12,
                        "city": "Araras",
                        "state": "São Paulo",
                        "latitude": -22.3569477,
                        "longitude": -47.3838889
                    },
                    "destination": {
                        "id": 8,
                        "city": "Jundiaí",
                        "state": "São Paulo",
                        "latitude": -23.1887866,
                        "longitude": -46.8845122
                    }
                }
            ]
          }
         }
      ]

### [GET] [http://localhost:3000/api/v1/drivers?has_truck={option}]

+ Parameters
    + has_truck = boolean (required, `true` || `false`) ... Consultar todos os motoristas que tem ou não veiculo próprio.

+ Request (application/json) - Ex: http://localhost:3000/api/v1/drivers?has_truck=false

+ Response 200 (application/json) - Retorna todos os motoristas que não tem veiculo próprio.

     + Body
        
           [
              {
                "id": 2,
                "name": "Elias Beahan",
                "gender": "f",
                "has_truck": false,
                "cnh_type": "C",
                "birthdate": "1970-10-01"
              }
           ]


| Recurso | URL |
|---|---|
| `TRIPS` | http://localhost:3000/api/v1/trips |
     
### [GET] [http://localhost:3000/api/v1/drivers]

+ Request (application/json)

+ Response 200 (application/json) - Retorna detalhes de todos os trajetos disponíveis.

     + Body
          
            [
                {
                  "id": 1,
                  "truck_loaded": true,
                  "has_load_back": false,
                  "driver_id": 1,
                  "truck_id": 4,
                  "origin": {
                      "id": 10,
                      "city": "Carapicuíba",
                      "state": "São Paulo",
                      "latitude": -23.5234673,
                      "longitude": -46.8406808
                  },
                  "destination": {
                      "id": 7,
                      "city": "Diadema",
                      "state": "São Paulo",
                      "latitude": -23.681347,
                      "longitude": -46.62052
                  }
                }
            ]

### [GET] [http://localhost:3000/api/v1/trips/{codigo}]

+ Parameters
    + codigo (required, number, `15`) ... Código do trajeto.

+ Request (application/json)

+ Response 200 (application/json) - Retorna informações sobre um trajeto em especifico.

    + Body
    
            {
               "id": 15,
                "truck_loaded": true,
                "has_load_back": false,
                "driver_id": 15,
                "truck_id": 4,
                "origin": {
                    "id": 6,
                    "city": "Santos",
                    "state": "São Paulo",
                    "latitude": -23.960833,
                    "longitude": -46.333889
                },
                "destination": {
                    "id": 4,
                    "city": "Sorocaba",
                    "state": "São Paulo",
                    "latitude": -23.501667,
                    "longitude": -47.458056
                }
            }

### Consultas adicionais

### [GET] [http://localhost:3000/api/v1/trips?truck_loaded={options}&period={options}]

+ Parameters
    + truck_loaded = boolean(required, `true` || `false`) ... Retorna os motoristas que tem ou não os veiculos carregados.
    + period = date(required, `yyy-mm-dd:yyy-mm-dd`) ... Caminhões que passam pelo terminal durante o dia, semana e mês.
    
+ Request (application/json) - Ex: http://localhost:3000/api/v1/trips?period=2020-03-30:2020-03-31&truck_loaded=true

+ Response 200 (application/json) - Retorna os caminhões passam carregados ou não pelo terminal durante o dia, semana e mês
     
     + Body
        
            [
                {
                    "id": 1,
                    "truck_loaded": true,
                    "has_load_back": false,
                    "driver_id": 1,
                    "truck_id": 4,
                    "created_at": "2020-03-30 00:00:00",
                    "origin": {
                        "id": 10,
                        "city": "Carapicuíba",
                        "state": "São Paulo",
                        "latitude": -23.5234673,
                        "longitude": -46.8406808
                    },
                    "destination": {
                        "id": 7,
                        "city": "Diadema",
                        "state": "São Paulo",
                        "latitude": -23.681347,
                        "longitude": -46.62052
                    }
                }
            ]

### [GET] [http://localhost:3000/api/v1/trips?list={options}]

+ Parameters
    + list = boolean (required, `origin` || `destination`) ... Lista de origem e destino agrupado por cada um dos tipos.

+ Request (application/json) - Ex: http://localhost:3000/api/v1/trips?list=origin

+ Response 200 (application/json) - Retorna lista de origem e destino agrupado.

     + Body
        
            [
              {
                "id": 10,
                "city": "Carapicuíba",
                "state": "São Paulo",
                "latitude": -23.5234673,
                "longitude": -46.8406808
              }
            ]


| Recurso | URL |
|---|---|
| `LOCATIONS` | http://localhost:3000/api/v1/locations |
     
### [GET] [http://localhost:3000/api/v1/locations]

+ Request (application/json)

+ Response 200 (application/json) - Retorna detalhes de geolocalizão dos destinos cadastrados.

     + Body

            [
                {
                    "id": 1,
                    "city": "Guarulhos",
                    "state": "São Paulo",
                    "latitude": -23.4430602,
                    "longitude": -46.524459,
                    "created_at": "2020-03-29T20:37:44.723Z",
                    "updated_at": "2020-03-29T20:37:44.723Z"
                }
            ]
            
            
### [GET] [http://localhost:3000/api/v1/locations/{codigo}]

+ Parameters
    + codigo (required, number, `11`) ... Código da localidade.

+ Request (application/json)

+ Response 200 (application/json) - Retorna detalhes de geolocalizão de um destinos em especifico.

    + Body
 
            {
                "id": 11,
                "city": "Taubaté",
                "state": "São Paulo",
                "latitude": -23.031448,
                "longitude": -45.5612792,
                "created_at": "2020-03-29T20:37:52.001Z",
                "updated_at": "2020-03-29T20:37:52.001Z"
            }
