require 'spec_helper'

describe "Autentication Pages - " do
    subject { page }

    describe "signin page" do 
      before { visit signin_path }

      it { should have_title('Sign in') }
      it { should have_content('Sign in') }
    end

    describe "signin" do 
      before { visit signin_path }

      describe "with invalid information" do
        before { click_button "Sign in" }

        it { should have_title "Sign in" }
        it { should have_selector('div.alert.alert-error', text: 'Invalid') }

        describe "after visiting another page" do
          before { click_link 'Home' }
          it { should_not have_selector('div.alert.alert-error') }
        end
      end

      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do 
          sign_in user 
          # puts "***********************user is"
          # puts current_user?(user)
        end

        it { should have_title(user.name) }
        it { should have_link('Profile',      href: user_path(user)) }
        it { should have_link('Settings',     href: edit_user_path(user)) }
        it { should have_link('Users',       href: users_path) }
        it { should have_link('Sign out',     href: signout_path) } 
        it { should_not have_link('Sign in',  href: signin_path) }
      end
    end

    describe "authorisation" do

      describe "for non-signed users" do
        let(:user) { FactoryGirl.create(:user) }

        describe "in the User controller" do

          describe "visiting the edit page" do
            before { visit edit_user_path(user) }
            it { should have_title('Sign in') }
          end

          describe "submiting update action" do
            before { patch user_path(user) }
            specify { expect(response).to redirect_to(signin_path) }
          end
        end 

        describe "visiting user index" do
          before { visit users_path }
          it { should have_title('Sign in') }        
        end

        describe "when attempting to visid protected page" do
          before do
            visit edit_user_path(user)
            fill_in "Email",    with: user.email
            fill_in "Password", with: user.password
            click_button "Sign in"          
          end

          describe "after sign in" do

            it "should should render desired protected page" do
              expect(page).to have_title('Edit user')        
            end
            
          end
          
        end
      end  

      describe "for signed users" do
        let(:user) { FactoryGirl.create(:user) }

        describe "in the Users controller" do
          describe "visiting new page" do
            before(:each) do
              sign_in user
              visit signup_path           
            end     
            it { should have_content('Приветствуем') }            
          end
          

          describe "creating new user" do
            before(:each) do
              sign_in user, no_capybara: true
              post users_path
            end
            specify {expect(response).to redirect_to(root_url)}
          end
          
        end

        
      end

      describe "as wrong user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }    
        before(:each) do        
          sign_in user, no_capybara: true        
        end

        

        describe "submitting a GET request to the Users#edit action" do
          before { get edit_user_path(wrong_user) }
          specify { expect(response.body).not_to match(full_title('Edit user')) }
          specify { expect(response).to redirect_to(root_url) }
        end
   
        describe "submitting a PATCH request to the Users#update action" do
          before { patch user_path(wrong_user) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end  

      describe "for non-admin users" do

        let(:user) { FactoryGirl.create(:user) }
        let(:non_admin) { FactoryGirl.create(:user) }

        before { sign_in non_admin, no_capybara: true }

        describe "submitting a DELETE request to the Users#destroy action" do
          before { delete user_path(user) }
          specify { expect(response).to redirect_to(root_url) }
        end       
      end 

      describe "for admin users" do
        let(:admin) { FactoryGirl.create(:admin) }
        before { sign_in admin, no_capybara: true }

        describe "submitting admin delete" do
          before(:each) do
            delete user_path(admin)           
          end
          specify do
            expect(response).to redirect_to(users_url) 
            
          end
        end


      end

      describe "patch" do
        let(:user) { FactoryGirl.create(:user) }
        before { sign_in user, no_capybara: true }

        describe "with forbidden attributes" do
          let(:params) do 
            { user: { admin: true, password: user.password, 
                      password_confirmation: user.password } }
          end
          before { patch user_path(user), params }      
          specify { expect(user.reload).not_to be_admin }
        end
      end
      
    end


end





