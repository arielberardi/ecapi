require 'rails_helper'
require './spec/support/crud_helper'

RSpec.configure do |c|
  c.include CrudHelper
end

RSpec.describe Api::ShoppingCartsController, type: :request do

  before (:all) do
    create_default_data


    @product = Product.first
    @user = User.first
  end

  before (:each) do
    ShoppingCart.all.each do |s| s.destroy end
  end

  let(:valid_attributes) {
    {
      user_id: @user.id,
      product_id: @product.id,
      quantity: 1
    }    
  }

  let(:invalid_attributes) {
    {
      user_id: @user.id,
      product_id: @product.id,
      quantity: -1
    }    
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # ShoppingCartsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      ShoppingCart.create! valid_attributes
      get api_shopping_carts_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      shopping_cart = ShoppingCart.create! valid_attributes
      get api_shopping_cart_url(shopping_cart), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ShoppingCart" do
        expect {
          post api_shopping_carts_url,
               params: { shopping_cart: valid_attributes }, headers: valid_headers, as: :json
        }.to change(ShoppingCart, :count).by(1)
      end

      it "renders a JSON response with the new shopping_cart" do
        post api_shopping_carts_url,
             params: { shopping_cart: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ShoppingCart" do
        expect {
          post api_shopping_carts_url,
               params: { shopping_cart: invalid_attributes }, as: :json
        }.to change(ShoppingCart, :count).by(0)
      end

      it "renders a JSON response with errors for the new shopping_cart" do
        post api_shopping_carts_url,
             params: { shopping_cart: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          user_id: @user.id,
          product_id: @product.id,
          quantity: 5
        }    
      }

      it "updates the requested shopping_cart" do
        shopping_cart = ShoppingCart.create! valid_attributes
        patch api_shopping_cart_url(shopping_cart),
              params: { shopping_cart: new_attributes }, headers: valid_headers, as: :json
        shopping_cart.reload
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the shopping_cart" do
        shopping_cart = ShoppingCart.create! valid_attributes
        patch api_shopping_cart_url(shopping_cart),
              params: { shopping_cart: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the shopping_cart" do
        shopping_cart = ShoppingCart.create! valid_attributes
        patch api_shopping_cart_url(shopping_cart),
              params: { shopping_cart: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested shopping_cart" do
      shopping_cart = ShoppingCart.create! valid_attributes
      expect {
        delete api_shopping_cart_url(shopping_cart), headers: valid_headers, as: :json
      }.to change(ShoppingCart, :count).by(-1)
    end
  end
end
