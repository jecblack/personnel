describe Category do

  before(:each) { @category = Category.new(name: 'Local Officer') }

  subject { @category }

  it { should respond_to(:name) }
  it { should have_many(:people)}


  it "#name returns a string" do
    expect(@category.name).to match 'Local Officer'
  end

end