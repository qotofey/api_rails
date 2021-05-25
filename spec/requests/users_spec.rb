require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/v1/users', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { attributes_for(:user) }
  let(:invalid_attributes) { { login: nil } }
  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) do
    {}
  end

  describe 'GET /v1/index' do
    let!(:users) { create_list(:user, 5) }

    it 'renders a successful response' do
      get v1_users_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /v1/show' do
    let(:user) { create(:user) }

    it 'renders a successful response' do
      get v1_user_url(user), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /v1/create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect do
          post v1_users_url,
               params: { user: valid_attributes }, headers: valid_headers, as: :json
        end.to change(User, :count).by(1)
      end

      it 'renders a JSON response with the new user' do
        post v1_users_url,
             params: { user: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect do
          post v1_users_url,
               params: { user: invalid_attributes }, as: :json
        end.to change(User, :count).by(0)
      end

      it 'renders a JSON response with errors for the new user' do
        post v1_users_url,
             params: { user: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /v1/update' do
    let(:user) { create(:user) }

    context 'with valid parameters' do
      let(:new_attributes) do
        { confirmed: false }
      end

      it 'updates the requested user' do
        patch v1_user_url(user),
              params: { user: new_attributes }, headers: valid_headers, as: :json
        user.reload
        skip('Add assertions for updated state')
      end

      it 'renders a JSON response with the user' do
        patch v1_user_url(user),
              params: { user: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      let(:user) { create(:user) }

      it 'renders a JSON response with errors for the user' do
        patch v1_user_url(user),
              params: { user: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /v1/destroy' do
    let!(:user) { create(:user) }

    it 'hides the requested user' do
      expect do
        delete v1_user_url(user), headers: valid_headers, as: :json
      end.to change(User.live, :count).by(-1)
    end

    it 'not destroys the requested user' do
      expect do
        delete v1_user_url(user), headers: valid_headers, as: :json
      end.to change(User, :count).by(0)
    end
  end
end
