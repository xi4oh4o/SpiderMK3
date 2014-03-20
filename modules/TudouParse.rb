module TudouParse
  def tudouParse(url)
    # Parse HTML
    doc = Nokogiri::HTML(open(url))
    # Parse <script> content
    page = doc.css('body > script[1]').to_s
    # Regular match lcode
    lcode = /[^']\w+/.match(/[^,lcode:\s]\w+/.match(/,lcode:\s'\w+/.match(page).to_s).to_s)
    # Regular match iid
    iid = /\d+/.match(/,iid:\s\d+/.match(page).to_s)
    result = lcode.to_s + ',' + iid.to_s
    return result
  end
end
