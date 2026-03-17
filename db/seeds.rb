%w[test@ya.ru testN@ya.ru testHg@ya.ru].each do |email|
  User.find_or_create_by(email: email) do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end
end

%w[Транспорт Недвижимость Работа Услуги Животные].each do |name|
  Category.find_or_create_by(name: name)
end

users = User.all
categories = Category.all

bulletins_data = [
  {
    title: 'Продам Toyota Camry 2020',
    description: 'Автомобиль в отличном состоянии, один владелец, полный привод, климат-контроль, подогрев сидений. Пробег 50000 км.',
    category: categories[0],
    user: users[0]
  },
  {
    title: 'Сдам 2-комнатную квартиру',
    description: 'Квартира в центре, свежий ремонт, мебель, бытовая техника. Сдается на длительный срок.',
    category: categories[1],
    user: users[0]
  },
  {
    title: 'Требуется Ruby on Rails разработчик',
    description: 'Ищем опытного разработчика для работы над интересными проектами. Удаленная работа, гибкий график.',
    category: categories[2],
    user: users[1]
  },
  {
    title: 'Ремонт компьютеров и ноутбуков',
    description: 'Профессиональный ремонт любой сложности. Выезд на дом. Гарантия на все виды работ.',
    category: categories[3],
    user: users[1]
  },
  {
    title: 'Продам iPhone 13 Pro Max',
    description: 'Телефон в идеальном состоянии, комплект полный, коробка, зарядка. Есть чек.',
    category: categories[4],
    user: users[2]
  },
  {
    title: 'Куртка зимняя мужская',
    description: 'Новая куртка, размер L, цвет черный. Не носилась, бирки сохранены.',
    category: categories[0],
    user: users[2]
  },
  {
    title: 'Диван угловой',
    description: 'Угловой диван, состояние хорошее, обивка микрофибра, цвет бежевый.',
    category: categories[1],
    user: users[0]
  },
  {
    title: 'Велосипед горный',
    description: 'Горный велосипед, 21 скорость, дисковые тормоза, амортизация. Отличное состояние.',
    category: categories[2],
    user: users[1]
  },
  {
    title: 'Щенки хаски',
    description: 'Очаровательные щенки хаски с документами, привиты, готовы к переезду в новый дом.',
    category: categories[3],
    user: users[2]
  },
  {
    title: 'Детская коляска',
    description: 'Коляска трансформер, состояние хорошее, есть дождевик, москитная сетка.',
    category: categories[4],
    user: users[0]
  },
  {
    title: 'Продам Toyota Camry 2020',
    description: 'Автомобиль в отличном состоянии, один владелец, полный привод, климат-контроль, подогрев сидений. Пробег 50000 км.',
    category: categories[0],
    user: users[0]
  },
  {
    title: 'Сдам 2-комнатную квартиру',
    description: 'Квартира в центре, свежий ремонт, мебель, бытовая техника. Сдается на длительный срок.',
    category: categories[1],
    user: users[0]
  },
  {
    title: 'Требуется Ruby on Rails разработчик',
    description: 'Ищем опытного разработчика для работы над интересными проектами. Удаленная работа, гибкий график.',
    category: categories[2],
    user: users[1]
  },
  {
    title: 'Ремонт компьютеров и ноутбуков',
    description: 'Профессиональный ремонт любой сложности. Выезд на дом. Гарантия на все виды работ.',
    category: categories[3],
    user: users[1]
  },
  {
    title: 'Продам iPhone 13 Pro Max',
    description: 'Телефон в идеальном состоянии, комплект полный, коробка, зарядка. Есть чек.',
    category: categories[4],
    user: users[2]
  },
  {
    title: 'Куртка зимняя мужская',
    description: 'Новая куртка, размер L, цвет черный. Не носилась, бирки сохранены.',
    category: categories[0],
    user: users[2]
  },
  {
    title: 'Диван угловой',
    description: 'Угловой диван, состояние хорошее, обивка микрофибра, цвет бежевый.',
    category: categories[1],
    user: users[0]
  },
  {
    title: 'Велосипед горный',
    description: 'Горный велосипед, 21 скорость, дисковые тормоза, амортизация. Отличное состояние.',
    category: categories[2],
    user: users[1]
  },
  {
    title: 'Щенки хаски',
    description: 'Очаровательные щенки хаски с документами, привиты, готовы к переезду в новый дом.',
    category: categories[3],
    user: users[2]
  },
  {
    title: 'Детская коляска',
    description: 'Коляска трансформер, состояние хорошее, есть дождевик, москитная сетка.',
    category: categories[4],
    user: users[0]
  },
]

bulletins_data.each do |data|
  bulletin = Bulletin.create!(
    title: data[:title],
    description: data[:description],
    category: data[:category],
    user: data[:user]
  )

  bulletin.image.attach(io: File.open(Rails.root.join('test/fixtures/files/test.jpg')), filename: 'test.jpg') if File.exist?('test/fixtures/files/test.jpg')
end

Bulletin.all.each_with_index do |bulletin, index|
  bulletin.update_columns(created_at: index.days.ago)
end
