require 'nokogiri'
require 'open-uri'

class CallNumOnGo
  attr_reader :word

  def initialize(word)
    @word = URI.encode_www_form(q: word)
  end

  def url
    @url ||= "https://www.google.com/search?#{word}"
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

  # ファイルが欲しい時
  # def set_file
  #   File.open("test.html", "w") do |f| 
  #     f.puts(doc)
  #   end
  # end

  def num
    doc.css(".BNeawe > span").text
  end
end

p CallNumOnGo.new("MSK安心ステーション").set_file