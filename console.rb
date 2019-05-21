require('pry')
require_relative('models/property.rb')

Property.delete_all()

property1 = Property.new(
  {
    'address' => '1 Park Way',
    'value' => 250000,
    'bedrooms' => 4,
    'buy_let_status' => 'buy'
  }
)

property2 = Property.new(
  {
    'address' => '100 West Street',
    'value' => 500000,
    'bedrooms' => 6,
    'buy_let_status' => 'let'
  }
)

property1.save()
property2.save()
# property1.delete()
property1.bedrooms=3
property1.update()

#property1.find()

properties = Property.all()

binding.pry
nil
