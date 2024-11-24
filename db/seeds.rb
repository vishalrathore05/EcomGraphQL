# Create Users
5.times do
    first_name = Faker::Name.first_name
    User.create!(
      first_name: first_name, 
      last_name: Faker::Name.last_name, 
      email: "#{first_name.downcase}@test.com",
      password: 'password'
    )
  end
  
  # Create Blogs
  20.times do
    Blog.create!(
      title: Faker::Book.title, 
      description: Faker::Lorem.paragraphs(number: 3).join("\n"), # Join paragraphs into a single string
      user: User.find(User.ids.sample) # Randomly associate a User
    )
  end


# Create Categories
puts "Seeding categories..."
5.times do
  Category.create!(
    name: Faker::Commerce.unique.department(max: 1) # e.g., "Electronics", "Clothing"
  )
end

# Create Products
puts "Seeding products..."
20.times do
  Product.create!(
    name: Faker::Commerce.product_name,        # e.g., "Ergonomic Chair"
    description: Faker::Lorem.sentence(word_count: 10), # e.g., "This chair is very comfortable..."
    price: Faker::Commerce.price(range: 10..500), # e.g., 299.99
    category: Category.all.sample              # Randomly assign a category
  )
end

# Create Orders
puts "Seeding orders..."
30.times do
  Order.create!(
    user: User.all.sample,                    # Randomly assign a user
    product: Product.all.sample,              # Randomly assign a product
    quantity: rand(1..5)                      # Random quantity between 1 and 5
  )
end



# User.create!(
#   first_name: "test_user",
#   last_name: "user_test",
#   email: "test@email.com",
#   password: 'password'
# )