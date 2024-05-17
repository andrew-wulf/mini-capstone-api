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
    assert_equal Product.find(1).length, data.length
  end

  last_id = Product.last.id
  test "create" do
    post "/products/create.json", params: {name: "test product", price: 200, image_url: "image.jpg", description: "test description", deps: "test", on_sale: 10, in_stock: 5}
    assert_response 200
    new_last_id = Product.last.id
    assert new_last_id > last_id
  end
  new_last_id = Product.last.id


  test "delete" do
    delete "/products/#{Product.first.id}.json"
    assert response 200
    data = JSON.parse(response.body)
    assert data["removed_successfully"] = true
  end
end
