###################################
#           Spider MK3            #
#      for Ruby Ver.1994α         #
#   Video play address fetching   #
###################################

class Spider
  require 'mysql2'
  require 'nokogiri'
  require 'open-uri'
  require './modules/Db'
  require './modules/TudouParse'
  require './modules/YoukuParse'
  require './modules/PPSParse'
  require './modules/SohuParse'
  require './modules/QQParse'
  require './modules/LetvParse'
  require './modules/FsParse'

  extend Db
  extend TudouParse
  extend YoukuParse
  extend PPSParse
  extend SohuParse
  extend QQParse
  extend LetvParse
  extend FsParse

  # Optimize 可改为循环source列表
  def Spider.runSpider(source)
    case source
    when "tudou"
      Spider.getEpisode(source).each do |row|
        play = Spider.tudouParse(row['e_url'])
        Spider.setEpisode(play, row)
      end
    when "youku"
      Spider.getEpisode(source).each do |row|
        play = Spider.youkuParse(row['e_url'])
        Spider.setEpisode(play, row)
      end
    when "pps"
      Spider.getEpisode(source).each do |row|
        play = Spider.ppsParse(row['e_url'])
        Spider.setEpisode(play, row)
      end
    when "sohu"
      Spider.getEpisode(source).each do |row|
        play = Spider.sohuParse(row['e_url'])
        Spider.setEpisode(play, row)
      end
    when "qq"
      Spider.getEpisode(source).each do |row|
        play = Spider.qqParse(row['e_url'])
        Spider.setEpisode(play, row)
      end
    when "letv"
      Spider.getEpisode(source).each do |row|
        play = Spider.letvParse(row['e_url'])
        Spider.setEpisode(play, row)
      end
    when "56"
      Spider.getEpisode(source).each do |row|
        play = Spider.fsParse(row['e_url'])
        Spider.setEpisode(play, row)
      end
    end
  end
end
# Spider.runSpider('56')
# Spider.runSpider('letv')
# Spider.runSpider('qq')
# Spider.runSpider('sohu')
# Spider.runSpider('pps')
# Spider.runSpider('tudou')
# Spider.runSpider('youku')
