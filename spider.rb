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

  extend Db
  extend TudouParse
  extend YoukuParse
  extend PPSParse
  extend SohuParse

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
    end
  end
end
Spider.runSpider('sohu')
# Spider.runSpider('pps')
# Spider.runSpider('tudou')
# Spider.runSpider('youku')
