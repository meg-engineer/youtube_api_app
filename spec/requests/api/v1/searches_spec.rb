require 'rails_helper'

describe Api::V1::SearchesController, type: :request do
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:keyword) { "test" }
  let(:order) { "viewCount" }

  describe 'GET /api/v1/searches' do
    context 'パラメータ正常の場合' do
      it 'ステータスが200を返すこと' do
        get "/api/v1/searches?keyword=#{keyword}&order=#{order}"
        expect(response).to have_http_status 200
      end
    end
  end
end
