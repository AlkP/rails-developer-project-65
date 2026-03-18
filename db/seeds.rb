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
    title: 'Toyota Camry 2020 for Sale',
    description: 'Excellent condition, single owner, all-wheel drive, climate control, heated seats. Mileage 50,000 km.',
    category: categories[0],
    user: users[0]
  },
  {
    title: '2-Bedroom Apartment for Rent',
    description: 'Downtown apartment, renovated, furnished, appliances. Long-term lease.',
    category: categories[1],
    user: users[0]
  },
  {
    title: 'Ruby on Rails Developer Needed',
    description: 'Seeking experienced developer for interesting projects. Remote work, flexible schedule.',
    category: categories[2],
    user: users[1]
  },
  {
    title: 'Computer and Laptop Repair',
    description: 'Professional repairs of any complexity. On-site service available. Warranty on all work.',
    category: categories[3],
    user: users[1]
  },
  {
    title: 'iPhone 13 Pro Max for Sale',
    description: 'Perfect condition, full package, box, charger. Receipt included.',
    category: categories[4],
    user: users[2]
  },
  {
    title: 'Men\'s Winter Jacket',
    description: 'New jacket, size L, black color. Never worn, tags attached.',
    category: categories[0],
    user: users[2]
  },
  {
    title: 'Sectional Sofa',
    description: 'Sectional sofa, good condition, microfiber upholstery, beige color.',
    category: categories[1],
    user: users[0]
  },
  {
    title: 'Mountain Bike',
    description: 'Mountain bike, 21 speeds, disc brakes, suspension. Excellent condition.',
    category: categories[2],
    user: users[1]
  },
  {
    title: 'Husky Puppies',
    description: 'Adorable husky puppies with papers, vaccinated, ready for new home.',
    category: categories[3],
    user: users[2]
  },
  {
    title: 'Baby Stroller',
    description: 'Convertible stroller, good condition, rain cover, mosquito net included.',
    category: categories[4],
    user: users[0]
  },
  {
    title: 'Toyota Camry 2020 for Sale',
    description: 'Excellent condition, single owner, all-wheel drive, climate control, heated seats. Mileage 50,000 km.',
    category: categories[0],
    user: users[0]
  },
  {
    title: '2-Bedroom Apartment for Rent',
    description: 'Downtown apartment, renovated, furnished, appliances. Long-term lease.',
    category: categories[1],
    user: users[0]
  },
  {
    title: 'Ruby on Rails Developer Needed',
    description: 'Seeking experienced developer for interesting projects. Remote work, flexible schedule.',
    category: categories[2],
    user: users[1]
  },
  {
    title: 'Computer and Laptop Repair',
    description: 'Professional repairs of any complexity. On-site service available. Warranty on all work.',
    category: categories[3],
    user: users[1]
  },
  {
    title: 'iPhone 13 Pro Max for Sale',
    description: 'Perfect condition, full package, box, charger. Receipt included.',
    category: categories[4],
    user: users[2]
  },
  {
    title: 'Men\'s Winter Jacket',
    description: 'New jacket, size L, black color. Never worn, tags attached.',
    category: categories[0],
    user: users[2]
  },
  {
    title: 'Sectional Sofa',
    description: 'Sectional sofa, good condition, microfiber upholstery, beige color.',
    category: categories[1],
    user: users[0]
  },
  {
    title: 'Mountain Bike',
    description: 'Mountain bike, 21 speeds, disc brakes, suspension. Excellent condition.',
    category: categories[2],
    user: users[1]
  },
  {
    title: 'Husky Puppies',
    description: 'Adorable husky puppies with papers, vaccinated, ready for new home.',
    category: categories[3],
    user: users[2]
  },
  {
    title: 'Baby Stroller',
    description: 'Convertible stroller, good condition, rain cover, mosquito net included.',
    category: categories[4],
    user: users[0]
  },
]

bulletins_data.each do |data|
  bulletin = Bulletin.create!(
    title: data[:title],
    description: data[:description],
    category: data[:category],
    user: data[:user],
    state: :published,
  )

  filename = "test#{rand(6)}.jpg"
  bulletin.image.attach(io: File.open(Rails.root.join("test/fixtures/files/#{filename}")), filename: filename)
end

Bulletin.all.each_with_index do |bulletin, index|
  bulletin.update_columns(created_at: index.days.ago)
end
