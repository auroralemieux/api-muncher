require 'test_helper'

describe EdamamApiWrapper do


  # THESE ARE NOT PASSING -- NOT SURE WHY
  describe "self.querySearch(search_terms, from, to, health)" do

    before do
      VCR.insert_cassette("recipes")
    end

    after do
      VCR.eject_cassette("recipes")
    end

    it "response must be an array" do
      response = EdamamApiWrapper.querySearch("chicken", 0, 12)

      response.must_be_kind_of Array

    end

    it "will return just the search and the count if no search term or health is given" do
      response = EdamamApiWrapper.querySearch("", 0, 12)
      response.length.must_equal 2
    end

    #this isn't working
    it "returns 12 recipes at a time (and a count & a recent search)" do
      to = 12
      from = 0
      num = to + 2
      health = "vegetarian"
      response = EdamamApiWrapper.querySearch("chicken", from, to, health)
      response.length.must_equal num
    end

    it "can be given a health param and search_terms" do

      response = EdamamApiWrapper.querySearch("chicken", 0, 12, "vegetarian")

      response.must_be_instance_of Array
      response.length.must_be :>, 2
      response.first.must_be_instance_of RecipeResult

    end

    it "can be given a health param and no search_terms" do
      response = EdamamApiWrapper.querySearch("", 0, 12, "vegetarian")
      response.length.must_be :>, 2

      response.first.must_be_instance_of RecipeResult
    end

    it "returns empty array if crappy params passed in resulting in error" do
      response = EdamamApiWrapper.querySearch("sdlkjslkdjf", -1, 12)
      response.must_equal []
    end

  end

  describe "testing self.getRecipe(recipe_uri)" do
    before do
      VCR.insert_cassette("recipe")
    end

    after do
      VCR.eject_cassette("recipe")
    end

    it "should get a single recipe successfully" do
      real_uri = "http://www.edamam.com/ontologies/edamam.owl%23recipe_b63034f899ef1b5c7c939ec7e1ca6b1b"
      recipe = EdamamApiWrapper.getRecipe(real_uri)
      recipe.must_be_instance_of RecipeResult
    end

    it "should return nil if error" do
      recipe = EdamamApiWrapper.getRecipe("http://www.edamam.com/ontologies/edamam.owl%23recipe_b63034f899efake")
      recipe.must_equal nil
    end


  end


end
