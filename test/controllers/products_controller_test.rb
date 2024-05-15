require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/products/index.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Product.count, data.length
  end

  test "create" do
    assert_difference "Product.count", 1 do
      post "/products/create.json", params: { name: "test product", price: 200, image_url: "image.jpg", description: "test description", category: "test", on_sale: 10, in_stock: 5}
    end
  end

  test "show" do
    get "/products/1.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_difference data.length 0
  end
end
