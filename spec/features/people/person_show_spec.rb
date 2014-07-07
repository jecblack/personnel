include Warden::Test::Helpers
Warden.test_mode!

# Feature: People listing page
#   As an administrator
#   I want to visit the people index page
#   So I can see all personnel
feature 'Person index page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Administrator views all personnel
  #   Given I am signed in
  #   When I visit the people index page
  #   Then I see a list of personnel
  scenario 'admin sees personnel list' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    person = FactoryGirl.create(:person, :name => ' A. Person')
    visit people_path()
    expect(page).to have_content 'Personnel'
    expect(page).to have_content person.name
  end
  
  scenario 'admin sees individual person' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    person = FactoryGirl.create(:person)
    visit person_path(person)
    expect(page).to have_content person.name
    expect(page).to have_content person.email
    expect(page).to have_content person.address
    expect(page).to have_content person.city
    expect(page).to have_content person.zip
    expect(page).to have_content person.state
    expect(page).to have_content person.tel                
  end
  

  # Scenario: User cannot see another user's profile
  #   Given I am signed in
  #   When I visit another user's profile
  #   Then I see an 'access denied' message
  scenario "must be a logged-in admin tp access personnel" do
    Capybara.current_session.driver.header 'Referer', root_path
    visit people_path()
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
  

end
