require 'rails_helper'

RSpec.describe 'Events API', type: :request do
  let!(:user) { create(:user) }
  let!(:events) { create_list(:event, 20, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { events.first.id }

  describe 'GET /events' do
    before { get '/events' }

    it 'returns events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:user_id/events' do
    before { get "/users/#{user_id}/events" }

    context 'when user exists' do
      it 'returns all events' do
        expect(json.size).to eq(20)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET /events/:id' do
    before { get "/events/#{id}" }

    context 'when the record exists' do
      it 'returns the event' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exists' do
      let(:id) { 0 }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /users/:user_id/events' do
    let(:valid_attributes) {
      {
        name: 'Super Awesome Event',
        date: Date.today,
        description: 'This event is gonna be legendary!'
      }
    }

    context 'when the request attributes are valid' do
      before { post "/users/#{user_id}/events", params: valid_attributes }

      it 'creates an event' do
        expect(json['name']).to eq('Super Awesome Event')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/users/#{user_id}/events", params: { name: 'FooBar' } }

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Date can't be blank/)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /events/:id' do
    let(:valid_attributes) { { name: 'Saucy' } }

    context 'when the record exists' do
      before { put "/events/#{id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /events/:id' do
    before { delete "/events/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
