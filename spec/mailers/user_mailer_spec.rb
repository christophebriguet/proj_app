require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    let(:user) { FactoryGirl.create(:user, :password_reset_token => "anything") }
    let(:mail) { UserMailer.password_reset(user) }

    it "sends user password reset url" do
      expect(mail.subject).to eq("Password Reset")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["cbriguetvd@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(edit_password_reset_path(user.password_reset_token))
    end
  end
  
  describe "registration_confirmation" do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { UserMailer.registration_confirmation(user) }

    it "sends registration_confirmation" do
      expect(mail.subject).to eq("Registered")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["cbriguetvd@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(edit_user_url(user))
    end
  end  
  
  describe "micropost_mail" do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { UserMailer.micropost_mail(user, micropost) }
    let(:micropost){ FactoryGirl.create(:micropost, user: user) }

    it "sends micropost" do
      expect(mail.subject).to eq("New Micropost from #{user.name}")
      expect(mail.to).to eq(["cbriguetvd@gmail.com"])
      expect(mail.cc).to eq([user.email])
      expect(mail.from).to eq([user.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(micropost.content)
    end
  end  
end
