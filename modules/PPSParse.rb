module PPSParse
  def ppsParse(url)
    # Parse HTML
    doc = Nokogiri::HTML(open(url))
    # Parse #<script> content
    page = doc.css('head > script')[3].to_s
    key = /[^"]\w+/.match(/[^url_key:\s]\w+/.match(/url_key:\s"\w+/.match(page).to_s).to_s)
    return key
  end
end
