require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'success create User' do
    visit 'users/new'

    fill_in 'Email', with: 'my_best_email@email.ru'
    fill_in 'Password', with: 'MyPassword'
    fill_in 'Password confirmation', with: 'MyPassword'
    click_on I18n.t('users.new.submit')

    assert_selector 'h1', text: I18n.t('bulletins.index.title')
  end
end
