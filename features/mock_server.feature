Feature: Mock Server

  Scenario: Register a mock
    Given I send a POST request to "/_mocks" with the following:
      """json
      {
        "request": {
          "path": "test"
        },
        "response": {
          "body": "Hello world!"
        }
      }
      """
    And I send a GET request to "/test"
    Then the response should be:
      """
      Hello world!
      """
    And the status should be "200"

  Scenario: Register a mock with status code
    Given I send a POST request to "/_mocks" with the following:
      """json
      {
        "request": {
          "path": "test"
        },
        "response": {
          "status": 404,
          "body": "Not Found"
        }
      }
      """
    And I send a GET request to "/test"
    Then the response should be:
      """
      Not Found
      """
    And the status should be "404"

  Scenario: Register a mock with headers
    Given I send a POST request to "/_mocks" with the following:
      """json
      {
        "request": {
          "path": "test"
        },
        "response": {
          "headers": {
            "X-Test": "test"
          },
          "body": "Hello world!"
        }
      }
      """
    And I send a GET request to "/test"
    Then the response should be:
      """
      Hello world!
      """
    And the header "X-Test" should be "test"
