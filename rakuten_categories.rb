require 'nokogiri'
require 'open-uri'

class RakutenCategory
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def title
    puts "# #{doc.css(".-active").text.chop}"
  end

  def output_categories
    title
    category_nums.zip(category_names) do |num,name|
      puts "'#{num}', # #{name}"
    end
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

  def category_names
    @category_names ||= doc.css(".item > .dui-list > a > ._ellipsis").map(&:text)
  end

  def category_nums
    @category_nums ||= extracting_number
  end

  def extracting_number
    nums = []
    doc.css(".item > .dui-list > a").each do |link|
      num = link[:href].slice(-17..-12)
      nums.push(num)
    end
    nums
  end
end

RakutenCategory.new(ARGV[0]).output_categories