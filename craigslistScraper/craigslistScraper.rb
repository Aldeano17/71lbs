require 'nokogiri'
require 'httparty'
require 'byebug'
require 'csv'

def craigslistScraper
  #initial url to the 3x2houses
  url = "https://miami.craigslist.org/search/apa?min_bedrooms=3&max_bedrooms=3&min_bathrooms=2&max_bathrooms=2&availabilityMode=0&sale_date=all+dates"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)

  #how many house posts per page and total posts 
  houses_per_page = parsed_page.css('div.content').css('ul.rows').css('li.result-row').count
  total_post = parsed_page.css('section.page-container').css('form.search-form').css('div.search-legend').css('div.paginator').css('span.buttons').css('span.totalcount')

  #how many pages to keep all the posts 
  page = 1
  total_pages = total_post.first.text.to_f / houses_per_page.to_f

  #modify url for pagination
  start_posts = 0
  pagination = "https://miami.craigslist.org/search/apa?availabilityMode=0&max_bathrooms=2&max_bedrooms=3000&min_bathrooms=2&min_bedrooms=3"

  #save all houses by hashes
  all_houses = Array.new

  puts "Running... Please be patient this may take a few mins"
  #stack all the info need it from craigslist
  while page <= total_pages do
    #take the url of the page that will stract the info
    houses_unparsed_page = HTTParty.get(pagination)
    houses_parsed_page = Nokogiri::HTML(houses_unparsed_page)
    all_houses_in_page = houses_parsed_page.css('div.content').css('ul.rows').css('li.result-row')
    
    all_houses_in_page.each do |house_listed|
      house_url = house_listed.css('a.result-image')[0].attributes["href"].value
      house_unparsed = HTTParty.get(house_url)
      house_parsed = Nokogiri::HTML(house_unparsed)
      house = {
        title: house_parsed.css('section.body').css('span.postingtitletext').css('span#titletextonly').text,
        rent: house_parsed.css('section.body').css('span.postingtitletext').css('span.price').text,
        address: house_parsed.css('section.page-container').css('section.body').css('section.userbody').css('div.mapAndAttrs').css('div.mapbox').css('div.mapaddress').text,
        url: house_url
      }
      all_houses << house
      puts all_houses
    end

    #url will update every time the while loop run for pagination
    pagination = pagination = "https://miami.craigslist.org/search/apa?s=#{start_posts += 120}&availabilityMode=0&max_bathrooms=2&max_bedrooms=3000&min_bathrooms=2&min_bedrooms=3"
    page += 1
  end
  
  #pass all the info to csv file
  CSV.open('3x2hoses.csv', 'wb') do |csv|
    csv << ['Title', 'Rent', 'Address', 'URL']
    all_houses.each do |house|
      csv << [house[:title], house[:rent], house[:address], house[:url]]
    end
  end

  puts "...Done"
end

#all function
craigslistScraper