# require 'rails_helper'

RSpec.describe 'Search Recipes', type: :feature, js: true do
  before do
    # Set up test data
    @recipe1 = Recipe.create(name: 'Chicken Curry', instructions: 'Cook chicken curry', cooking_time: 30)
    @recipe2 = Recipe.create(name: 'Spaghetti Bolognese', instructions: 'Cook spaghetti bolognese', cooking_time: 45)
    @recipe3 = Recipe.create(name: 'Vegan Salad', instructions: 'Prepare vegan salad', cooking_time: 15)

    @recipe1.ingredients.create(name: 'Chicken')
    @recipe2.ingredients.create(name: 'Spaghetti')
    @recipe2.ingredients.create(name: 'Tomato Sauce')
    @recipe3.ingredients.create(name: 'Lettuce')
  end

  it 'allows users to search for recipes' do
    visit '/'
    
    # Search with cuisine and ingredient
    fill_in 'Cuisine', with: 'Curry'
    fill_in 'Ingredient', with: 'Chicken'
    click_button 'Search'

    expect(page).to have_content('Matching Recipes')
    expect(page).to have_content('Chicken Curry')
    expect(page).to have_content('Cooking time: 30 min')
    expect(page).to have_content('Cook chicken curry')
    expect(page).to have_content('Ingredients: Chicken')

    # Search with cuisine only
    fill_in 'Cuisine', with: 'Vegan'
    click_button 'Search'

    expect(page).to have_content('Matching Recipes')
    expect(page).to have_content('Vegan Salad')
    expect(page).to have_content('Cooking time: 15 min')
    expect(page).to have_content('Prepare vegan salad')
    expect(page).to have_content('Ingredients: Lettuce')

    # Search with ingredient only
    fill_in 'Ingredient', with: 'Tomato Sauce'
    click_button 'Search'

    expect(page).to have_content('Matching Recipes')
    expect(page).to have_content('Spaghetti Bolognese')
    expect(page).to have_content('Cooking time: 45 min')
    expect(page).to have_content('Cook spaghetti bolognese')
    expect(page).to have_content('Ingredients: Spaghetti, Tomato Sauce')

    # Search with no cuisine or ingredient
    click_button 'Search'

    expect(page).to have_content('Matching Recipes')
    expect(page).to have_content('Chicken Curry')
    expect(page).to have_content('Spaghetti Bolognese')
    expect(page).to have_content('Vegan Salad')

    # Search with no matching recipes
    fill_in 'Cuisine', with: 'Pizza'
    fill_in 'Ingredient', with: 'Mushrooms'
    click_button 'Search'

    expect(page).to have_content('No recipes found.')
  end
end
