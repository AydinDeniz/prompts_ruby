
require 'nokogiri'
require 'open-uri'
require 'csv'

class ProductScraper
  attr_reader :base_url, :output_file

  def initialize(base_url, output_file = 'products.csv')
    @base_url = base_url
    @output_file = output_file
  end

  def scrape
    page_number = 1
    CSV.open(output_file, 'w') do |csv|
      csv << ['Name', 'Price', 'Rating', 'Image URL']

      loop do
        puts "Scraping page \#{page_number}..."
        page = Nokogiri::HTML(URI.open("\#{base_url}?page=\#{page_number}"))

        products = page.css('.product-item')
        break if products.empty?

        products.each do |product|
          name = product.css('.product-title').text.strip
          price = product.css('.product-price').text.strip
          rating = product.css('.product-rating').text.strip
          image_url = product.css('.product-image img').attribute('src').value

          csv << [name, price, rating, image_url]
        end

        page_number += 1
        sleep(1) # to avoid rate limits
      end
    end
    puts "Scraping completed! Data saved to \#{output_file}."
  rescue => e
    puts "An error occurred: \#{e.message}"
  end
end

# Usage example
scraper = ProductScraper.new('https://example.com/products')
scraper.scrape
