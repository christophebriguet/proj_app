require 'spec_helper'

describe "Micropost pages" do
  subject { page }
    
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
        
        it 'should not send an email' do
          expect(ActionMailer::Base.deliveries.count).to eq(0)
        end
      end
    end

    describe "with valid information" do
      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
      describe do
        before { click_button "Post" }
        it 'should send an email' do
          expect(ActionMailer::Base.deliveries.count).to eq(1)
        end
        it 'renders the receiver email' do
          expect(ActionMailer::Base.deliveries.first.to).to eq(["cbriguetvd@gmail.com"])
        end
        it 'renders the receiver email' do
          expect(ActionMailer::Base.deliveries.first.cc).to eq([user.email])
        end
        it 'should set the subject to the correct subject' do
          expect(ActionMailer::Base.deliveries.first.subject).to eq("New Micropost from #{user.name}")
        end
        it 'renders the sender email' do  
          expect(ActionMailer::Base.deliveries.first.from).to eq([user.email])
        end
      end
    end
  end
  
  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end  
end
