module YoukuParse
  def Spider.youkuParse(url)
    # Parse HTML
    doc = Nokogiri::HTML(open(url))
    # Parse #link3 content
    page = doc.css('input#link3')[0]['value'].to_s
    # Regular match vid
    vid = /\w+(?=\/v.swf)/.match(page)
    return vid
  end
end
