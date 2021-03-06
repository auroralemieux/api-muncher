require "test_helper"

describe Search do

  it "can create a search" do
    search = Search.create(search_terms: "chicken", user_id: 1)
    search.must_be_instance_of Search

  end

  it "must fail without search_terms" do
    search = Search.new(user_id: 1)
    search.save.must_equal false
  end

  it "must fail without user_id" do
    search = Search.new(search_terms: "chicken")
    search.save.must_equal false
  end

  it "must fail with no params" do
    search = Search.new()
    search.save.must_equal false
  end
  # not sure why not passing
  it "may have health param" do
    search = Search.create(search_terms: "chicken", user_id: 1, health: "kosher")
    search.must_be_instance_of Search
  end

  it "get_health works as expected" do
    search1 = Search.create(search_terms: "chicken", user_id: 1, health: "kosher")
    search2 = Search.create(search_terms: "chicken", user_id: 1)
    search1.get_health.must_equal "(kosher)"
    search2.get_health.must_equal ""

  end


end
