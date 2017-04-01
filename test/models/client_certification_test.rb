require 'test_helper'

class ClientCertificationTest < ActiveSupport::TestCase
  test "Should not save client certification without data" do
    clientCertification = ClientCertification.new()
    assert_not clientCertification.valid?, "The client certification was not valid. Errors: #{clientCertification.errors.to_a.to_sentence}"
  end

  test "Should not save a client certification without contract" do
    clientCertification = ClientCertification.new(state: 'Pendiente', date: Date.today, received: 'name', observation: 'Observacion')
    assert_not clientCertification.valid?, "The client certification was not valid. Errors: #{clientCertification.errors.to_a.to_sentence}"
  end

  test "Should not save a client certification without state" do
    clientCertification = ClientCertification.new(contract: Contract.first, date: Date.today, received: 'name', observation: 'Observacion')
    assert_not clientCertification.valid?, "The client certification was not valid. Errors: #{clientCertification.errors.to_a.to_sentence}"
  end

  test "Should not save a client certification without date" do
    clientCertification = ClientCertification.new(contract: Contract.first, state: 'Pendiente', received: 'name', observation: 'Observacion')
    assert_not clientCertification.valid?, "The client certification was not valid. Errors: #{clientCertification.errors.to_a.to_sentence}"
  end

  test "Should not save a client certification without received" do
    clientCertification = ClientCertification.new(contract: Contract.first, state: 'Pendiente', date: Date.today, observation: 'Observacion')
    assert_not clientCertification.valid?, "The client certification was not valid. Errors: #{clientCertification.errors.to_a.to_sentence}"
  end

  test "Should not save a client certification invalid received" do
    clientCertification = ClientCertification.new(contract: Contract.first, state: 'Pendiente', date: Date.today, received: 'Name15', observation: 'Observacion')
    assert_not clientCertification.valid?, "Cannot save a client invalid name. Errors: #{clientCertification.errors.to_a.to_sentence}"
  end
end
