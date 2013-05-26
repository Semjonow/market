class Product < ActiveRecord::Base
  belongs_to :category
  serialize :properties, ActiveRecord::Coders::Hstore

  %w[name url price currency picture store pickup delivery vendor description sales_notes manufacturer_warranty available bid].each do |key|
    attr_accessible key

    define_method(key) do
      properties && properties[key]
    end

    define_method("#{key}=") do |value|
      self.properties = (properties || {}).merge(key => value)
    end
  end
end
