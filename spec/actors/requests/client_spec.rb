# frozen_string_literal: true

require 'rails_helper'
require 'net/http'

RSpec.describe Requests::Client, type: :actor do
  let(:http_mock) do
    instance_double(Net::HTTP, 'use_ssl=': true).tap { |m| allow(Net::HTTP).to receive(:new).and_return(m) }
  end
  let(:mock_response) { instance_double(Net::HTTPResponse, body: response_body) }

  context 'with default endpoint' do
    let(:response_body) { '{"content": []}' }

    it 'requests default endpoint' do
      expect(http_mock).to receive(:request) do |req|
        expect(req.path).to eq(URI("#{described_class::URI_BASE}/properties").path)
        expect(req['X-Authorization']).to eq(described_class::API_KEY)
        mock_response
      end
      expect(described_class.call.json_response).to eq({ 'content' => [] })
    end
  end

  context 'with custom endpoint' do
    let(:response_body) { '{"status": "ok"}' }

    it 'requests custom endpoint' do
      expect(http_mock).to receive(:request) do |req|
        expect(req.path).to eq(URI("#{described_class::URI_BASE}/custom").path)
        mock_response
      end
      expect(described_class.call(endpoint_path: '/custom').json_response).to eq({ 'status' => 'ok' })
    end
  end
end
