describe Person do

  before(:each) { @person = Person.new(name: 'John Q Public',
                                        address: '123 Anystreet',
                                        city: 'Somewhere',
                                        state: 'CA',
                                        zip: '12345',
                                        tel: "(123) 456-7890",
                                        email: 'user@example.com') }

  subject { @person }
  it { should have_many(:categories)}

  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zip) }
  it { should respond_to(:tel) }
  it { should respond_to(:email) }
  it { should respond_to(:skill_list) }
  it { should respond_to(:interest_list) }

  it "#name returns a string" do
    expect(@person.name).to match 'John Q Public'
  end

end