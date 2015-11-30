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
    When I send a GET request to "/test"
    Then the response should be:
      """
      Hello world!
      """
    And the status should be "200"

  Scenario: Register a mock, send an OPTIONS request
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
    When I send an OPTIONS request to "/test"
    Then the status should be "200"

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
    When I send a GET request to "/test"
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
    When I send a GET request to "/test"
    Then the response should be:
      """
      Hello world!
      """
    And the header "X-Test" should be "test"

  Scenario: Register a POST method mock without specifying methods
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
    When I send a POST request to "/test" with the following:
      """
      """
    Then the response should be:
      """
      Hello world!
      """
    And the status should be "200"

  Scenario: Register a POST method mock
    Given I send a POST request to "/_mocks" with the following:
      """json
      {
        "request": {
          "method": "POST",
          "path": "test"
        },
        "response": {
          "body": "Hello world!"
        }
      }
      """
    When I send a POST request to "/test" with the following:
      """
      """
    Then the response should be:
      """
      Hello world!
      """
    And the status should be "200"

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
    When I send a GET request to "/_last_request"
    Then the response should be:
      """json
      {
        "CONTENT_LENGTH": "0",
        "HTTPS": "off",
        "HTTP_COOKIE": "",
        "HTTP_HOST": "example.org",
        "PATH_INFO": "/test",
        "QUERY_STRING": "",
        "REMOTE_ADDR": "127.0.0.1",
        "REQUEST_METHOD": "GET",
        "SCRIPT_NAME": "",
        "SERVER_NAME": "example.org",
        "SERVER_PORT": "80"
      }
      """
