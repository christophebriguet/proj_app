require 'spec_helper'

describe "PasswordResetsPages" do
  subject { page }
  
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end
  
  describe "emails user when requesting password reset" do
    let(:user) { FactoryGirl.create(:user) }
    
    before do
      visit signin_path
      click_link "Forgotten password?"
      fill_in "Email", with: user.email.upcase
      click_button "Reset Password"
    end
    
    it { should have_content('Email sent with password reset instructions.') }
 
    it 'should send an email' do
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
    it 'renders the receiver email' do
      expect(ActionMailer::Base.deliveries.first.to).to eq([user.email])
    end
    it 'should set the subject to the correct subject' do
      expect(ActionMailer::Base.deliveries.first.subject).to eq('Password Reset')
    end
    it 'renders the sender email' do  
      expect(ActionMailer::Base.deliveries.first.from).to eq(['cbriguetvd@gmail.com'])
    end    
  end
  
  describe "does not email invalid user when requesting password reset" do
    before do
      visit signin_path
      click_link "Forgotten password?"
      fill_in "Email", with: "madeupuser@example.com"
      click_button "Reset Password"
    end
    
    it { should have_content('Email sent with password reset instructions.') }
    
    it 'should not send an email' do
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
  end
end
