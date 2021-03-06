require 'rails_helper'

RSpec.describe "As a guest" do
  context "When I visit /users/new" do
    it "I can create an account" do
      user = User.new(email: 'test@example.com', password_digest: 'test')
      visit new_user_path

      fill_in :user_email, with: user.email
      fill_in :user_password, with: user.password_digest
      fill_in :user_password_confirmation, with: user.password_digest
      click_on "Create User"
      expect(User.count).to eq(1)
      expect(User.first.email).to eq(user.email)
      expect(current_path).to eq(login_path)
    end
  end
  context "When I enter a taken email" do
    it "tells me the email has been taken" do
      created_user = User.create(email: 'test@example.com', password_digest: 'test')
      new_user = User.new(email: 'test@example.com', password_digest: 'test')
      visit new_user_path

      fill_in :user_email, with: new_user.email
      fill_in :user_password, with: new_user.password_digest
      fill_in :user_password_confirmation, with: new_user.password_digest
      click_on "Create User"

      expect(page).to have_content("Please enter a unique email")
      expect(current_path).to eq(new_user_path)
    end
  end
  context "When passwords do not match" do
    it "I see a flash message" do
      new_user = User.new(email: 'test@example.com', password_digest: 'test')
      visit new_user_path

      fill_in :user_email, with: new_user.email
      fill_in :user_password, with: new_user.password_digest
      fill_in :user_password_confirmation, with: "this is bad"
      click_on "Create User"

      expect(page).to have_content("Passwords do not match")
      expect(current_path).to eq(new_user_path)
    end
  end
end
