###################################
#           Spider MK3            #
#      for Ruby Ver.1994α         #
#   Video play address fetching   #
###################################

require 'mysql2'
require 'nokogiri'
require 'open-uri'

class Spider

  def Spider.runSpider(source)
    client = Mysql2::Client.new(:host => '192.168.199.210', :username => 'root', :password => '912913', :database => 'newmv')

    case source
    when "tudou"
      client.query(" SELECT * FROM T_SCollectsMK2 WHERE C_Source = \"#{source}\" LIMIT 10 ").each do |row|
        play = Spider.tudouParse(row['C_Url'])
        client.query(" UPDATE T_SCollectsMK2 SET C_Play = \"#{play}\" WHERE C_ID = \"#{row['C_ID']}\" ")
      end
    when "youku"
      puts "未完成功能"
    end
  end

  def Spider.tudouParse(url)
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

# fetching tudou play
Spider.runSpider('tudou')
