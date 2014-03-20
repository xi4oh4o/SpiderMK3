###################################
#           Spider MK3            #
#      for Ruby Ver.1994α         #
#   Video play address fetching   #
###################################

class Spider
  require 'mysql2'
  require 'nokogiri'
  require 'open-uri'

  def Spider.runSpider(source)
    # 建立数据库链接
    client = Mysql2::Client.new(:host => '192.168.199.210', :username => 'root', :password => '912913', :database => 'newmv')
    # 加载播放源为source参数的剧集
    episode = client.query(" SELECT * FROM T_SCollectsMK2 WHERE C_Source = \"#{source}\" LIMIT 10", :cast => false, :cache_row => false)
    # 判断方法参数执行不同规则
    case source
    when "tudou"
      # 循环结果集
      episode.each do |row|
        # 循环解析播放参数
        play = Spider.tudouParse(row['C_Url'])
        # 结果更新至数据库
        client.query(" UPDATE T_SCollectsMK2 SET C_Play = \"#{play}\" WHERE C_ID = \"#{row['C_ID']}\" ")
      end
    when "youku"
      episode.each do |row|
        play = Spider.youkuParse(row['C_Url'])
        client.query(" UPDATE T_SCollectsMK2 SET C_Play = \"#{play}\" WHERE C_ID = \"#{row['C_ID']}\" ")
      end
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

  def Spider.youkuParse(url)
    # Parse HTML
    doc = Nokogiri::HTML(open(url))
    page = doc.css('input#link3')[0]['value'].to_s
    # Regular match vid
    vid = /\w+(?=\/v.swf)/.match(page)
    return vid
  end

end

Spider.runSpider('youku')
