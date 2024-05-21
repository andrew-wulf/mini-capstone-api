require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/products.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Product.count, data.length
  end

  test "show" do
    get "/products/#{Product.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert data.keys.include?("price")
    assert data.keys.include?("after_tax")
    assert data.keys.include?("current_item") 
  end

  test "create" do
    last_id = Product.last.id
    post "/products/create.json", params: {name: "test product", price: 200, image_url: "image.jpg", description: "test description", deps: "test", on_sale: 10, in_stock: 5}
    assert_response 200
    new_last_id = Product.last.id
    assert new_last_id > last_id
  end
 
  test "update" do
    test_entry = {name: "test product", price: 199.99, image_url: "image.jpg", description: "test description", deps: "test", on_sale: 10, in_stock: 5}


    patch "/products/#{Product.first.id}.json", params: test_entry
  
    assert_response 200

    data = JSON.parse(response.body)
    p data
    p test_entry
    test_entry.each {|k, v| assert data[k] == v}
  end

  test "destroy" do
    delete "/products/#{Product.first.id}.json"
    data = JSON.parse(response.body)
    assert data["removed_successfully"] = true
  end
end
