Feature: Access Token API

  Scenario: Create Access Token
    Given url baseUrl
    And path "auth"
    And header Content-Type = ContentType
    And header Accept = AcceptVar
    And request accesTokenRequestPayload
    When method post
    Then status 200
    * match $.token == "#present"
