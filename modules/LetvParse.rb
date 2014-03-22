module LetvParse
  def letvParse(url)
    # Parse HTML
    doc = Nokogiri::HTML(open(url))
    # Parse <script> content
    page = doc.css('head script').to_s
    # Regular match vid
    vid = /[^vid:]\d+/.match(/vid:\d+/.match(page).to_s).to_s
    return vid
  end
end
