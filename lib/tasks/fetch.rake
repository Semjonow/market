namespace :data do
  desc "FETCH DATA FROM REMOTE SERVER AND IMPORT TO DATABASE"
  task :fetch => :environment do
    doc = Nokogiri::XML(open(DATA_URL))

    categories = doc.xpath("//categories/category")
    products   = doc.xpath("//offers/offer")

    puts "::Import categories"
    categories.each do |node|
      save_category(categories, node)
    end

    puts "::Import products"
    products.each do |node|
      save_product(node)
    end
  end

  def save_category(tree, node=nil, xpath="")
    node = tree.at_xpath(xpath) unless node
    return nil unless node

    category      = Category.find_by_id(node.attr("id")) || Category.new
    category.id   = node.attr("id") if category.new_record?
    category.name = node.text

    if parent_id = node.attr("parentId")
      category.parent = save_category(tree, nil, "//category[@id=#{parent_id}]") || Category.find_by_id(parent_id)
    end

    category.save!
    node.remove
    puts ">> #{category.name}"
    category
  end

  def save_product(node)
    product           = Product.find_by_id(node.attr("id")) || Product.new
    product.id        = node.attr("id") if product.new_record?
    product.available = node.attr("available")
    product.bid       = node.attr("bid")

    node.children.each do |value|
      if value.name == "currencyId"
        product.currency = value.text
      elsif value.name == "model"
        product.name = value.text
      elsif value.name == "categoryId"
        product.category = Category.find_by_id(value.text)
      elsif product.respond_to?("#{value.name}=")
        product.send("#{value.name}=", value.text)
      end
    end

    product.save!
    puts ">> #{product.name}"
  end
end
