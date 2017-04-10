require 'rails_helper'

RSpec.describe 'People API', type: :request do
  let!(:user) { create(:user) }
  let!(:event) { create(:event, user_id: user.id) }
  let!(:event_with_attendees) { create(:event_with_attendees, user_id: user.id, attendees_count: 5) }
  let!(:people) { create_list(:person, 10) }
  let(:event_id) { event.id }
  let(:event_with_attendees_id) { event_with_attendees.id }
  let(:id) { people.first.id }

  describe 'GET /people' do
    before { get '/people' }

    it 'returns people' do
      expect(json).not_to be_empty
      expect(json.size).to eq(15)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /events/:event_id/people' do
    before { get "/events/#{event_with_attendees_id}/people" }

    it 'returns all people belonging to a particular event' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /people/:id' do
    before { get "/people/#{id}" }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exists' do
      let(:id) { 100 }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Person/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /events/:event_id/people' do
    context 'when creating a new person' do
      let(:valid_attributes) { { first_name: 'Awesome', last_name: 'Dude', email: 'awesomedude@example.com' } }

      context 'when the request attributes are valid' do
        before { post "/events/#{event_id}/people", params: valid_attributes }

        fit 'creates a person' do
          expect(json['first_name']).to eq('Awesome')
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when the request is invalid' do
        before { post "/events/#{event_id}/people", params: { first_name: 'FooBar' } }

        it 'returns a validation failure message' do
          expect(response.body).to match(/Validation failed: Last name can't be blank/)
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
      end
    end

    context 'when using and existing person' do
      let!(:existing_person) { create(:person, first_name: 'Super', last_name: 'Man', email: 'superman@test.com') }

      context 'when the person exists' do
        before { post "/events/#{event_id}/people", params: { email: 'superman@test.com' } }

        it 'does not create a new person' do
          expect(json['id']).to eq(existing_person.id)
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when the person does not exist' do
        before { post "/events/#{event_id}/people", params: { email: 'notsuperman@test.com' } }

        it 'returns a validation failure message' do
          expect(response.body).to match(/Validation failed: First name can't be blank/)
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
      end
    end
  end

  describe 'PUT /people/:id' do
    let(:valid_attributes) { { first_name: 'Saucy' } }

    context 'when the record exists' do
      before { put "/people/#{id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /people/:id' do
    before { delete "/people/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
