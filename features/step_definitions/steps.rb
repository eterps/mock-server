Given(/^I send a POST request to "([^"]*)" with the following:$/) do |path, data|
  post path, data
end

Given(/^I send a GET request to "([^"]*)"$/) do |path|
  get path
end

Given(/^I send an OPTIONS request to "([^"]*)"$/) do |path|
  options path
end

Then(/^the response should be:$/) do |expected_response|
  expect(last_response.body).to eq(expected_response)
end

Then(/^the status should be "([^"]*)"$/) do |status_code|
  expect(last_response.status).to eq(status_code.to_i)
end

Then(/^the header "([^"]*)" should be "([^"]*)"$/) do |header, value|
  expect(last_response.headers[header]).to eq(value)
end
