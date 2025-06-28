require 'rails_helper'
require 'secret_santa/employee'
require 'secret_santa/secret_santa'

RSpec.describe SecretSanta::SecretSanta do
  let(:alice) { SecretSanta::Employee.new('Alice', 'alice@example.com') }
  let(:bob)   { SecretSanta::Employee.new('Bob', 'bob@example.com') }
  let(:carol) { SecretSanta::Employee.new('Carol', 'carol@example.com') }

  let(:employees) { [alice, bob, carol] }

  it 'assigns each employee to exactly one different employee' do
    game = described_class.new(employees, {})
    result = game.generate_assignments

    expect(result.size).to eq(3)
    expect(result.keys).to match_array(employees)
    result.each do |giver, receiver|
      expect(giver).not_to eq(receiver)
    end
    expect(result.values.uniq.size).to eq(3)
  end
end
