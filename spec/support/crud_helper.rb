module CrudHelper
  
  def create_default_data
    User.all.each do |s| s.destroy end
    Product.all.each do |s| s.destroy end
    Category.all.each do |s| s.destroy end
    Subcategory.all.each do |s| s.destroy end
    ShoppingCart.all.each do |s| s.destroy end

    @user = User.create(
      first_name: 'Ariel', last_name: 'Berardi', born_date: 25.years.ago, address: 'Street 1234',
      email: 'ariel.berardi@gmail.com', password: '123456', password_confirmation: '123456')
    #@user.save!

    @category = Category.create(name: 'Electronics')
    #@category.save!
    
    @subcategory = Subcategory.create(name: 'Gamming', category: @category)
    #@subcategory.save!

    @product = Product.create(name: 'Headphones', category: @category, 
      subcategory: @subcategory, price: 10.0, discount: 0, stock: 100)
    #@product.save!

    @shopping_cart = ShoppingCart.create(user: @user, product: @product, quantity: 2)
  end

end 