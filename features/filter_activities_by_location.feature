Feature: Filter activities by location
  In order to find something in a specific location
  As an adventurer
  I want to filter activities by location

  Scenario: when there is three activities in different locations
    Given there is an event called "Role de Barco na Baía de Guanabara" in "Marina da Glória"
    And there is an event called "Gastronomia no Jardim" in "Jardim Botânico"
    And there is an event called "Aula de Dança na Praça" in "Praça São Salvador"
    And I go to "the homepage"
    And I select "Laranjeiras" as the neighborhood filter
    When I press "Buscar Parada"
    Then the 1st event found should be "Aula de Dança na Praça"
    And the 2nd event found should be "Role de Barco na Baía de Guanabara"
    And the 3rd event found should be "Gastronomia no Jardim"
