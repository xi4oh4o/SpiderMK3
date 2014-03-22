module FsParse
  # five six 56网
  def fsParse(url)
    # Parse HTML
    doc = Nokogiri::HTML(open(url))
    # Parse <script> content
    page = doc.css('head script').to_s
    # Regular match id
    id = /[^"]\w+/.match(/"\w+/.match(/EnId":"\w+/.match(page).to_s).to_s)
    return id
  end
end
