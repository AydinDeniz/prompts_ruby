
require 'nokogiri'
require 'json'

class XMLToJSONConverter
  attr_reader :xml_file_path, :json_file_path

  def initialize(xml_file_path, json_file_path = 'output.json')
    @xml_file_path = xml_file_path
    @json_file_path = json_file_path
  end

  def process
    File.open(json_file_path, 'w') do |json_file|
      json_file.write('[\n')

      Nokogiri::XML::Reader(File.open(xml_file_path)).each do |node|
        if node.name == 'product' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
          product_hash = parse_product(Nokogiri::XML(node.outer_xml))
          json_file.write(product_hash.to_json)
          json_file.write(',\n')
        end
      end

      # Remove the last comma and close the JSON array
      json_file.seek(-2, IO::SEEK_END)
      json_file.write('\n]\n')
    end
    puts "Conversion completed! JSON saved to \#{json_file_path}."
  end

  private

  def parse_product(product_node)
    product = {}
    product[:id] = product_node.at('id')&.text
    product[:name] = clean_text(product_node.at('name')&.text)
    product[:price] = clean_text(product_node.at('price')&.text).to_f
    product[:category] = clean_text(product_node.at('category')&.text)
    product[:description] = clean_text(product_node.at('description')&.text)
    product
  end

  def clean_text(text)
    text&.strip&.gsub(/[^0-9a-zA-Z .-]/, '') || ''
  end
end

# Usage example
converter = XMLToJSONConverter.new('products.xml')
converter.process
