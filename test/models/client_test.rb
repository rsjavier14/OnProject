require 'test_helper'

class ClientTest < ActiveSupport::TestCase

  test "Should not save a client without data" do
    client = Client.new()
    assert_not client.valid?, "The client was not valid. Errors: #{client.errors.to_a.to_sentence}"
  end

  test "Should not save a client without name" do
    client = Client.new(last_name: "last_name", ruc: 2345234, email: "email@gmail.com", adress: "adress", phone:"phone")
    assert_not client.valid?, "Cannot save a client without name. Errors: #{client.errors.to_a.to_sentence}"
  end

  test "Should not save a client invalid name" do
    client = Client.new(name: "name54", last_name: "last_name", ruc: 2345234, email: "email@gmail.com", adress: "adress", phone:"phone")
    assert_not client.valid?, "Cannot save a client invalid name. Errors: #{client.errors.to_a.to_sentence}"
  end

  test "Should not save a client without ruc" do
    client = Client.new(name: "name", last_name: "last_name", email: "email@gmail.com", adress: "adress", phone: "phone")
    assert_not client.valid?, "Cannot save a client without ruc. Errors: #{client.errors.to_a.to_sentence}"
  end

  test "Should not save a client with existing ruc" do
    client = Client.new(name: "name", last_name: "last_name", ruc: 2345234, email: "email@gmail.com", adress: "adress", phone: "phone")
    assert_not client.valid?, "Cannot save a client. Errors: #{client.errors.to_a.to_sentence}"
  end

  test "Should not save a client with existing email" do
    client = Client.new(name: "name", last_name: "last_name", ruc: 2345234, email: "email@gmail.com", adress: "adress", phone: "phone")
    assert_not client.valid?, "Cannot save a client. Errors: #{client.errors.to_a.to_sentence}"
  end

  test "Should not save a client with invalid ruc" do
    client = Client.new(name: "name", last_name: "last_name", ruc: "2345234a", email: "email@gmail.com", adress: "adress", phone: "phone")
    assert_not client.valid?, "Cannot save a client with invalid ruc. Errors: #{client.errors.to_a.to_sentence}"
  end

  test "Should not save a client with invalid email" do
    client = Client.new(name: "name", last_name: "last_name", ruc: 2345234, email: "email.gmail.com", adress: "adress", phone: "phone")
    assert_not client.valid?, "Cannot save a client with invalid email. Errors: #{client.errors.to_a.to_sentence}"
  end

end