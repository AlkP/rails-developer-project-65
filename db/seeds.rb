%w[test@ya.ru testN@ya.ru].each do |email|
  User.find_or_create_by(email: email) do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end
end
