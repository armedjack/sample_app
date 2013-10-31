require 'spec_helper'

describe "StaticPages" do

  subject { page }

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    should have_selector('h1', text: "About")
    click_link "Help"
    should have_selector('h1', text: "Help")
    click_link "Contact us"
    should have_selector('h1', text: "Contact us")
    click_link "Home"
    click_link "Регистрируйтесь!"
    should have_selector('h1', text: "Sign up")
    click_link "sample app"
    should have_selector('h1', text: "Sign up")
  end

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    
  end

  describe "Contacts page" do
    before { visit contacts_path }

    let(:heading) { 'Contact us' }
    let(:page_title) { 'Contacts' }  
    it_should_behave_like "all static pages" 

  end

	describe "Home page" do
    before { visit root_path }

    let(:heading) { 'Приветствуем в Sample App' }
    let(:page_title) { '' } 
    it_should_behave_like "all static pages"
    
	end

  describe "Help page" do
    before { visit help_path }

    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }  
    it_should_behave_like "all static pages"

  end

  describe "About page" do
    before { visit about_path }

    let(:heading) { 'About' }
    let(:page_title) { 'About' }  
    it_should_behave_like "all static pages"
  end




end
