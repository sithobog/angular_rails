require 'spec_helper.rb'

feature "Viewing a product", js: true do
  scenario "check all product's action" do
    product = FactoryGirl.attributes_for(:product)
    visit '/'
    #check create
    click_on 'New'

    fill_in "name", with: product[:name]
    fill_in "description", with: product[:description]
    fill_in "price", with: product[:price]
    
    within '.well' do
      find('.btn.btn-primary').click
    end
    expect(page).to have_content("IPen")

    #check show
    click_on "IPen"
    expect(page).to have_content("This is very useful thing")

    #check edit
    click_on "Edit"

    fill_in "name", with: "IPen edited"
    fill_in "description", with: "Not so useful"
    fill_in "price", with: 10

    within '.well' do
      find('.btn.btn-primary').click
    end

    #check index
    expect(page).to have_content("IPen edited")
    expect(page).to have_no_content("Not so useful")

     within '.well' do
      find('.btn.btn-danger').click
    end

    expect(page).to have_content("No products in catalog")

  end
end