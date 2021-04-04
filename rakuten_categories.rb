require 'nokogiri'
require 'open-uri'

charset = nil

url = "https://search.rakuten.co.jp/search/event/%E3%81%B5%E3%82%8B%E3%81%95%E3%81%A8%E7%B4%8D%E7%A8%8E/?ev=40&lang=ja&s=4"

html = open(url) do |f|
  charset = f.charset
  f.read
end
doc = Nokogiri::HTML.parse(html, nil, charset)

category_names = doc.css(".item > .dui-list ._ellipsis").map(&:text)
