module QQParse
  def qqParse(url)
    # Parse HTML
    doc = Nokogiri::HTML(open(url))
    # Parse <script> content
    page = doc.css('head script')[3].to_s
    # Regular match vid
    vid = /[^"]\w+/.match(/[^vid:"]\w+/.match(/vid:"\w+/.match(page).to_s).to_s)
    return vid
  end
end
