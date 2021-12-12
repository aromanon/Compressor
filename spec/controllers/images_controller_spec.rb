# frozen_string_literal: true

require 'rails_helper'

describe ImagesController do
  let(:email) { 'email@email.com' }
  let(:upload_path) { 'uploads/test.png' }

  let(:request) { post :compress, params: { image: image, email: email } }

  after do
    File.delete(upload_path) if File.exist?(upload_path)
  end

  describe 'POST compress' do
    let(:image) do
      Rack::Test::UploadedFile.new(File.join(Rails.root, 'public', 'test.png'), 'image/png')
    end


    context 'with valid image' do
      it 'returns success message' do
        request

        expect(flash.to_h).to eq({ 'success' => 'Image has been uploaded' })
      end

      it 'creates a new job' do
        expect { request }.to change { CompressWorker.jobs.size }.by(1)
      end
    end

    context 'with invalid image' do
      let(:image) do
        Rack::Test::UploadedFile.new(File.join(Rails.root, 'public', 'test.webp'), 'image/webp')
      end

      let(:danger_flash) do
        { 'danger' => 'You are not allowed to upload "webp" files, allowed types: jpg, jpeg, gif, png' }
      end

      it 'returns error message' do
        request

        expect(flash.to_h).to eq(danger_flash)
      end


      it 'not creates a new job' do
        expect { request }.to change { CompressWorker.jobs.size }.by(0)
      end
    end
  end
end
