require 'rails_helper'
require 'jsonapi_spec_helper'

describe 'orders create on api v1', :type => :request do
  include JsonapiSpecHelper

  let!(:valid_params) do
    to_jsonapi(build(:order))
  end

  before do
    post '/api/v1/orders', params: valid_params, headers: { 'Content-Type': 'application/vnd.api+json' }
  end

  it 'returns the order' do
    expect(JSON.parse(response.body)['data']['attributes']['reference']).to eq(JSON.parse(valid_params)['data']['attributes']['reference'])
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end