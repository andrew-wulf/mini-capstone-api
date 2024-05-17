json.current_item @data['name']


json.price @data['price']

if @data['on_sale'] > 0
  json.percent_off "#{@data['on_sale']}%"
end

json.after_tax @data['total']


json.categories @data['category']
json.image_url @data['image_url']
json.description @data['description']
json.id @data['id']

