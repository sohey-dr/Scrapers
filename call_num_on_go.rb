require 'nokogiri'
require 'open-uri'

class CallNumOnGo
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def parse_html
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    Nokogiri::HTML.parse(html, nil, charset)
  end

  def doc
    @doc ||= parse_html
  end
end

p RakutenCategory.new("https://search.rakuten.co.jp/search/event/%E3%81%B5%E3%82%8B%E3%81%95%E3%81%A8%E7%B4%8D%E7%A8%8E/?ev=40&lang=ja&s=4").show