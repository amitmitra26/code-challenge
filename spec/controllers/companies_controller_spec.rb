require "rails_helper"

RSpec.describe CompaniesController, type: :controller do
  let(:company_params) { { name: Faker::Name.name, description: Faker::Lorem.sentence, zip_code: Faker::Number.number(digits: 5), email: 'test@getmainstreet.com',
                           phone: Faker::Number.number(digits: 10) } }
  describe 'create' do
    it 'should call create on Company' do
      Company.should_receive(:new).and_call_original
      post :create, params: { company: company_params }
    end

    context 'when company creation success' do
      before(:each) do
        Company.destroy_all
        post :create, params: { company: company_params }
      end

      it 'should redirect_to index' do
        expect(response).to redirect_to('/companies')
      end

      it 'should create new company' do
        expect(Company.count).to eq(1)
      end
    end #__End of context 'when company creation success'__

    context 'when company creation fails' do
      render_views

      before(:each) do
        Company.destroy_all
        company_params[:email] = 'test@test.com'
        post :create, params: { company: company_params }
      end

      it 'should render new' do
        expect(response).to render_template('new')
      end

      it 'should not create new company' do
        expect(Company.count).to eq(0)
      end
    end #__End of context 'when company creation fails'__
  end #__End of describe 'create'__
end #__End of describe 'CompaniesController'_
