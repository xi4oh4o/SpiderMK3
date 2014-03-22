module SohuParse
  def sohuParse(url)
    # Parse HTML
    doc = Nokogiri::HTML(open(url), nil, "UTF-8")
    # Parse <script> content
    page = doc.css('head script')[2].to_s
    vid = /[^"]\d+/.match(/[^vid=\s]\d+/.match(page).to_s).to_s
    return vid
  end
end
