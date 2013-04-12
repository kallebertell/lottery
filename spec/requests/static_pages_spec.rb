require 'spec_helper'

describe "StaticPages" do
  
  describe "Home page" do
    before { visit root_path }
    subject { page }

    it { should have_content('Lottery') }

    it { should have_selector('title', :text => " | Home") }
  
  end

end
