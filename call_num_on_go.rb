require 'nokogiri'
require 'open-uri'

class CallNumOnGo
  attr_reader :url

  def initialize(word)
    @url = "https://www.google.com/search?q=#{word}"
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

  def num
    doc.css(".Z1hOCe > div > span[2]")
  end
end

p CallNumOnGo.new("MSK安心ステーション").url