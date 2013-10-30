require 'spec_helper'

describe "StaticPages" do

  subject {page}

  describe "Contacts page" do
    before { visit contacts_path }

    it { should have_selector('h1', text: 'Contact us') }
    it { should have_title(full_title('Contacts')) }    

  end

	describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1', text: 'Приветствуем в Sample App') }
    it { should have_title(full_title('')) }
    it { should_not have_title(full_title('Home')) }	
    
	end

  describe "Help page" do
   before { visit help_path }

   it { should have_selector('h1', text: 'Help') }
   it { should have_title(full_title('Help')) }  

  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('h1', text: 'About') }
    it { should have_title('About') }
  end


  # describe "GET /static_pages" do
  #   it "works! (now write some real specs)" do
  #     # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #     get static_pages_index_path
  #     response.status.should be(200)
  #   end
  # end
end
