require 'rails_helper'

require './spec/support/crud_helper'

RSpec.configure do |c|
  c.include CrudHelper
end

RSpec.describe Api::ShoppingCartsController, type: :request do

  before (:all) do
    create_default_data

    @category = Category.first
    @subcategory = Subcategory.first
  end

  let(:valid_attributes) {
    {
      name: 'Ball',
      description: '',
      price: 10.0,
      discount: 0.0,
      stock: 100,
      category_id: @category.id,
      subcategory_id: @subcategory.id
    }
  }

  let(:invalid_attributes) {
    {
      name: 'Ball',
      description: '',
      price: -10,
      discount: -10,
      stock: 0,
      category_id: @category.id,
      subcategory_id: @subcategory.id
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Product.create! valid_attributes
      get api_products_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      product = Product.create! valid_attributes
      get api_product_url(product), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Product" do
        expect {
          post api_products_url,
               params: { product: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Product, :count).by(1)
      end

      it "renders a JSON response with the new product" do
        post api_products_url,
             params: { product: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Product" do
        expect {
          post api_products_url,
               params: { product: invalid_attributes }, as: :json
        }.to change(Product, :count).by(0)
      end

      it "renders a JSON response with errors for the new product" do
        post api_products_url,
             params: { product: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: 'Ball',
          description: '',
          price: 15.0,
          discount: 0.0,
          stock: 100,
          category_id: @category.id,
          subcategory_id: @subcategory.id
        }        
      }

      it "updates the requested product" do
        product = Product.create! valid_attributes
        patch api_product_url(product),
              params: { product: new_attributes }, headers: valid_headers, as: :json
        product.reload
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the product" do
        product = Product.create! valid_attributes
        patch api_product_url(product),
              params: { product: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the product" do
        product = Product.create! valid_attributes
        patch api_product_url(product),
              params: { product: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested product" do
      product = Product.create! valid_attributes
      expect {
        delete api_product_url(product), headers: valid_headers, as: :json
      }.to change(Product, :count).by(-1)
    end
  end
end
