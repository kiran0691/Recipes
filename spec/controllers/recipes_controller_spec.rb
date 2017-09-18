require 'spec_helper'

describe RecipesController do
  render_views
  describe "index" do
    before do
      Recipe.create!(name: "Chicken Biryani")
      Recipe.create!(name: "Egg Biryani")
      Recipe.create!(name: "Chicken Tikka")
      Recipe.create!(name: "Chicken Tandoori")
      Recipe.create!(name: "Curry Chicken")

      xhr :get, :index, format: :json, keywords: keywords
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_name
      ->(object) {object["name"]}
    end

    context "when the search finds the results" do
      let(:keywords) {"Biryani"}
      it "should 200" do
        expect(response.status).to eq(200)
      end

      it "should return two results" do
        expect(results.size).to eq(2)
      end

      it "should include 'Chicken Biryani'" do
        expect(results.map(&extract_name)).to include('Chicken Biryani')
      end

      it "should include 'Egg Biryani'" do
        expect(results.map(&extract_name)).to include('Egg Biryani')
      end
    end

    context "when the search don't find the results" do
      let(:keywords) {"foo"}

      it "should return 0 results" do
        expect(results.size).to eq(0)
      end
    end
  end


end
