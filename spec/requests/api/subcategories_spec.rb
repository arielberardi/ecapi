require 'rails_helper'
require './spec/support/crud_helper'

RSpec.configure do |c|
  c.include CrudHelper
end

RSpec.describe Api::SubcategoriesController, type: :request do

  before (:all) do
    create_default_data

    @category = Category.first
  end

  let(:valid_attributes) {
    { 
      name: 'Monitors', 
      category_id: @category.id
    }
  }

  let(:invalid_attributes) {
    { 
      name: '', 
      category_id: @category.id
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Subcategory.create! valid_attributes
      get api_subcategories_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      subcategory = Subcategory.create! valid_attributes
      get api_subcategory_url(subcategory), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Subcategory" do
        expect {
          post api_subcategories_url,
               params: { subcategory: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Subcategory, :count).by(1)
      end

      it "renders a JSON response with the new subcategory" do
        post api_subcategories_url,
             params: { subcategory: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Subcategory" do
        expect {
          post api_subcategories_url,
               params: { subcategory: invalid_attributes }, as: :json
        }.to change(Subcategory, :count).by(0)
      end

      it "renders a JSON response with errors for the new subcategory" do
        post api_subcategories_url,
             params: { subcategory: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { 
          name: 'MouseEdited',
          category_id: @category.id
        }
      }

      it "updates the requested subcategory" do
        subcategory = Subcategory.create! valid_attributes
        patch api_subcategory_url(subcategory),
              params: { subcategory: new_attributes }, headers: valid_headers, as: :json
        subcategory.reload
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "renders a JSON response with the subcategory" do
        subcategory = Subcategory.create! valid_attributes
        patch api_subcategory_url(subcategory),
              params: { subcategory: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the subcategory" do
        subcategory = Subcategory.create! valid_attributes
        patch api_subcategory_url(subcategory),
              params: { subcategory: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested subcategory" do
      subcategory = Subcategory.create! valid_attributes
      expect {
        delete api_subcategory_url(subcategory), headers: valid_headers, as: :json
      }.to change(Subcategory, :count).by(-1)
    end
  end
end
