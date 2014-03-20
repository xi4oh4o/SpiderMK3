module Db
  CLIENT = Mysql2::Client.new(:host => '192.168.199.210', :username => 'root', :password => '912913', :database => 'newmv')

  def getEpisode(source)
    episode = CLIENT.query(" SELECT * FROM mv_episode WHERE e_source = \"#{source}\" AND vid = '7621' LIMIT 10", :cast => false, :cache_row => false)
    return episode
  end

  def setEpisode(play, row)
    CLIENT.query(" UPDATE mv_episode SET e_play = \"#{play}\" WHERE eid = \"#{row['eid']}\" ")
    puts "#{row['e_source']} #{row['e_epname']} Ep #{row['e_number']} Done."
  end

end
