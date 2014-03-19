###################################
#           SpiderMK3             #
#      for Ruby Ver.8964a         #
#   Video play address fetching   #
###################################

# Using mysql2 nokogirl and open-uri
require 'mysql2'
require 'nokogiri'
require 'open-uri'

class Spider

  def Spider.runSpider(source)
    client = Mysql2::Client.new(:host => '192.168.199.210', :username => 'root', :password => '912913', :database => 'newmv')

    case source

    when "tudou"
      client.query(" SELECT * FROM T_SCollectsMK2 WHERE C_Source = \"#{source}\" LIMIT 10 ").each do |row|
        play = Spider.tudouSpider(row['C_Url'])
        client.query(" UPDATE T_SCollectsMK2 SET C_Play = \"#{play}\" WHERE C_ID = \"#{row['C_ID']}\" ")
      end

    when "youku"
      puts "未完成功能"
    end

  end

  def Spider.tudouSpider(url)
    # Parse HTML
    doc = Nokogiri::HTML(open(url))
    # Parse <script> content
    page = doc.css('body > script[1]').to_s
    # Regular match lcode
    lcode = /[^']\w+/.match(/[^,lcode:\s]\w+/.match(/,lcode:\s'\w+/.match(page).to_s).to_s)
    # Regular match iid
    iid = /\d+/.match(/,iid:\s\d+/.match(page).to_s)
    result = lcode.to_s + ',' + iid.to_s
    return result
  end

end
Spider.runSpider('tudou')
# Spider.tudouSpider('http://www.tudou.com/albumplay/_gsuDUn1g4k/genyefrgHdY.html')
