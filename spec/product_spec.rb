require 'rails_helper'

describe 'Validations' do
  it 'exists' do
    @category = Category.new(:name => 'newCategory')
    @newProduct = Product.new(:name => 'fail', :price=> 100, :quantity => 3, :category => @category) 
    @newProduct.save!
    expect(@newProduct.id).to be_present
  end

  it 'has a name' do
    @category = Category.new(:name => 'newCategory')
    @newProduct = Product.new(:name => nil, :price=> 100, :quantity => 3, :category => @category) 
    @newProduct.valid?
    expect(@newProduct.errors.full_messages).to include("Name can't be blank") 
  end

  it 'has a price' do
    @category = Category.new(:name => 'newCategory')
    @newProduct = Product.new(:name => 'fail', :price=> nil, :quantity => 3, :category => @category) 
    @newProduct.valid?
    expect(@newProduct.errors.full_messages).to include("Price can't be blank") 
  end

  it 'has a quantity' do
    @category = Category.new(:name => 'newCategory')
    @newProduct = Product.new(:name => nil, :price=> 100, :quantity => nil, :category => @category) 
    @newProduct.valid?
    expect(@newProduct.errors.full_messages).to include("Quantity can't be blank") 
  end

  it 'has a category' do
    @newProduct = Product.new(:name => nil, :price=> 100, :quantity => 3, :category => nil) 
    @newProduct.valid?
    expect(@newProduct.errors.full_messages).to include("Category can't be blank") 
  end
  # validation tests/examples here
end


