@MarvelApi @campache
Feature: API caracteres de Marvel

  Background:
    * configure ssl = true
    * def usuario = 'campache'
    * def baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + usuario + '/api/characters'
    * def characterId = 25

  @id:1 @GetAllCaracterts
  Scenario: T-API-MarvelApi-Listar todos los caractares de Marvel
    Given url baseUrl
    When method GET
    * print response
    Then status 200
    And match response == '#[]'

  @id:2 @PostCharacter
  Scenario: T-API-MarvelApi-Crear nuevo caracter de Marvel
    Given url baseUrl
    * def characterRequest = read('classpath:./data/PostCharacter.json')
    And request characterRequest
    When method POST
    * print response
    Then status 201
    And def schemaValidate = read('classpath:../data/CharacterSchema.json')
    And match response contains schemaValidate
    And match response.name == characterRequest.name

  @id:3 @GetChararacterById
  Scenario: T-API-MarvelApi-Consultar caracter de Marvel por ID
    * print 'Charactar Id: ' + characterId
    Given url baseUrl + '/' + characterId
    When method GET
    * print response
    Then status 200
    And def schemaValidate = read('classpath:../data/CharacterSchema.json')
    And match response contains schemaValidate
    And match response.id == characterId

  @id:4 @PutChararacterById
  Scenario: T-API-MarvelApi-Actualizar caracter de Marvel por ID
    * print 'Charactar Id: ' + characterId
    Given url baseUrl + '/' + characterId
    * def characterRequest = read('classpath:./data/PutCharacter.json')
    And request characterRequest
    When method PUT
    * print response
    Then status 200
    And match response.name == characterRequest.name

  @id:4 @DeleteChararacterById
  Scenario: T-API-MarvelApi-Eliminar caracter de Marvel por ID
    * print 'Charactar Id: ' + characterId
    Given url baseUrl + '/' + characterId
    When method DELETE
    * print response
    Then status 204