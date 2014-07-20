feature 'Person tag capabilities' do


  # Scenario: Individual person page shows skills and interests
  #   Given I am signed in
  #   When I visit the individual's detail page
  #   Then I see a list of skills and interests

  scenario 'admin sees skills and interests' do
    user = FactoryGirl.create(:user, :admin)
    signin(user.email, user.password)
    person = FactoryGirl.create(:person, name: 'Person', first_name: 'Arthur')
    visit person_path(person)
    expect(page).to have_content 'Skills'
    expect(page).to have_content 'Interests'
  end
  
  scenario 'updating skills and interests persist' do
    skills = "reading, writing, arithmetic"
    interests = "scuba-diving, sky-diving"
    user = FactoryGirl.create(:user, :admin)
    signin(user.email, user.password)
    person = FactoryGirl.create(:person, name: 'Person', first_name: 'Arthur')
    visit edit_person_path(person)
    fill_in "Skills", with: skills
    fill_in "Interests", with: interests
    click_button 'Update'
    visit person_path(person)
    expect(page).to have_content 'reading'
    expect(page).to have_content 'writing'
    expect(page).to have_content 'arithmetic'
    expect(page).to have_content 'sky-diving'
    expect(page).to have_content 'scuba-diving'
       
  end
  
  scenario 'updating skills and interests overwrites previous values' do
    skills = "reading, writing, arithmetic"
    interests = "scuba-diving, sky-diving"
    new_skills = "writing, mathematics"
    new_interests = "chess, sky-diving"
    user = FactoryGirl.create(:user, :admin)
    signin(user.email, user.password)
    person = FactoryGirl.create(:person, name: 'Person', first_name: 'Arthur',
                                skill_list: skills, interest_list: interests)
    visit person_path(person)
    expect(page).to have_content 'reading'
    expect(page).to have_content 'writing'
    expect(page).to have_content 'arithmetic'
    expect(page).to have_content 'sky-diving'
    expect(page).to have_content 'scuba-diving'
    
    visit edit_person_path(person) 
    fill_in "Skills", with: new_skills
    fill_in "Interests", with: new_interests
    click_button 'Update'
    visit person_path(person)
    expect(page).to have_content 'mathematics'
    expect(page).to have_content 'writing'
    expect(page).not_to have_content 'arithmetic'
    expect(page).to have_content 'sky-diving'
    expect(page).not_to have_content 'scuba-diving'
       
  end
  scenario 'updating skills and interests overwrites previous values' do
    skills = "reading, writing, arithmetic"
    interests = "scuba-diving, sky-diving"
    new_skills = "writing, mathematics"
    new_interests = "chess, sky-diving"
    user = FactoryGirl.create(:user, :admin)
    signin(user.email, user.password)
    person = FactoryGirl.create(:person, name: 'Person', first_name: 'Arthur',
                                skill_list: skills, interest_list: interests)
    visit person_path(person)
    expect(page).to have_content 'reading'
    expect(page).to have_content 'writing'
    expect(page).to have_content 'arithmetic'
    expect(page).to have_content 'sky-diving'
    expect(page).to have_content 'scuba-diving'
    
    visit edit_person_path(person) 
    fill_in "Skills", with: new_skills
    fill_in "Interests", with: new_interests
    click_button 'Update'
    visit person_path(person)
    expect(page).to have_content 'mathematics'
    expect(page).to have_content 'writing'
    expect(page).not_to have_content 'arithmetic'
    expect(page).to have_content 'sky-diving'
    expect(page).not_to have_content 'scuba-diving'
       
  end
  
  scenario 'tags should be displayed as clickable links' do
    skills = "reading, writing, arithmetic"
    interests = "scuba-diving, sky-diving"
    user = FactoryGirl.create(:user, :admin)
    signin(user.email, user.password)
    person = FactoryGirl.create(:person, name: 'Person', first_name: 'Arthur',
                                skill_list: skills, interest_list: interests)
    visit person_path(person)
    expect(page).to have_link 'reading'
  end
  
  scenario 'clicking on tag should display all people with that tag' do
    skills = "reading, writing, arithmetic"
    interests = "scuba-diving, sky-diving"
    user = FactoryGirl.create(:user, :admin)
    signin(user.email, user.password)
    person = FactoryGirl.create(:person, name: 'Person', first_name: 'Arthur',
                                skill_list: skills, interest_list: interests)
    visit person_path(person)
    click_link 'reading'
    expect(page).to have_content "Personnel"
  end
  
  scenario 'personnel list page should show a tag_cloud' do
    skills = "reading, writing, arithmetic"
    interests = "scuba-diving, sky-diving"
    user = FactoryGirl.create(:user, :admin)
    signin(user.email, user.password)
    person = FactoryGirl.create(:person, name: 'Person', first_name: 'Arthur',
                                skill_list: skills, interest_list: interests)
    visit people_path
    expect(page).to have_content "sky-diving"

  end
end
