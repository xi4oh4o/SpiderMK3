module QiyiParse
  def qiyiParse(url)
    # Parse HTML
    doc = Nokogiri::HTML(open(url))
    # Parse <div#flashbox> attr data-player-videoid
    vid = doc.css('div#flashbox')[0]['data-player-videoid']
    return vid
  end
end
