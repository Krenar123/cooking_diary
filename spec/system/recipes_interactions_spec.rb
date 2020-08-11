require 'rails_helper'

RSpec.describe "RecipesInteractions" do
  before do
    driven_by(:rack_test)

    visit root_path
  end

  describe 'Creating a recipe' do
    before do
      click_on 'New Recipe'
    end

    context 'when clicking button New Recipe' do
      it 'should have button cancel' do
        expect(page).to have_content('Cancel')
      end

      it 'should have button Create Recipe' do
        expect(page).to have_button('Create Recipe')
      end

      it 'should have a button for deleting nested fields' do
        expect(page).to have_selector('i.fa-times')
      end

      it 'should have a button for adding nested fields' do
        expect(page).to have_content('Add')
      end
    end

    context 'when submiting the form without instructions and ingridients' do
      it 'creates and shows created recipe without instructions and ingridients' do
          title = 'Recipe'
          description = 'This is description testing'

          within('form') do
            fill_in 'Title', with: title
            fill_in 'Description', with: description
            
            click_on 'Create Recipe'
          end

          expect(page).to have_content(title)
          expect(page).to have_content(description)
      end
    end

    context 'when submiting the form with instructions and ingridients' do
      it 'creates and shows created recipe with instructions and ingridients' do
        title = 'Recipe'
        description = 'This is description testing'
        instruction_info = 'Instruction info test'
        ing_name = 'Sugar'

        within('form') do
          fill_in 'Title', with: title
          fill_in 'Description', with: description
          fill_in 'recipe_instructions_attributes_0_order',
                  with: 1
          fill_in 'recipe_instructions_attributes_0_instruction_info',
                  with: instruction_info
          fill_in 'recipe_ingridients_attributes_0_name',
                  with: ing_name

          click_on 'Create Recipe'
        end

        expect(page).to have_content(title)
        expect(page).to have_content(description)
        expect(page).to have_content(instruction_info)
        expect(page).to have_content(ing_name)
      end
    end
  end
end
