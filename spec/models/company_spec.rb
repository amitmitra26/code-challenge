require "rails_helper"

RSpec.describe Company, type: :model do
  let(:company) { Company.new }

  describe 'fetch_city_and_state' do
    context 'when zip_code is not valid' do
      before(:each) do
        company.zip_code = Faker::Number.number(5)
        company.fetch_city_and_state
      end

      it 'should not set state' do
        expect(company.state).to eq('')
      end

      it 'should not set city' do
        expect(company.city).to eq('')
      end
    end #__End of context 'when zip_code is not valid'__

    context 'when zip_code is valid' do
      before(:each) do
        zip_code = '30301'
        @rv = ZipCodes.identify(zip_code)
        company.zip_code = zip_code
        company.fetch_city_and_state
        company.save!
      end

      it 'should set state' do
        expect(company.state).to eq(@rv[:state_name])
      end

      it 'should set city' do
        expect(company.city).to eq(@rv[:city])
      end
    end #__End of context 'when zip_code is valid'__
  end #__End of describe 'fetch_city_and_state'__
end #__End of describe 'Company'__
