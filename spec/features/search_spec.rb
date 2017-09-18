require 'spec_helper.rb'

feature "looking up recipes", js: true do
  scenario "search recipes" do
    visit '/'
    fill_in "keywords" ,with: "Baked"
    click_on "Search"

    expect(page).to have_content("Baked Potato")
    expect(page).to have_content("Baked Brussel Sprouts")
  end
end
