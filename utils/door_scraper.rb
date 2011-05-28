#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'nokogiri'

door_num = 1
file = File.new('orions.txt','w')
while true
  uri = URI.parse("http://www-space.arc.nasa.gov/~rubin/door#{door_num}.html")
  http = Net::HTTP.new(uri.host,uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  if response.code == "404"
    break
  end
  body = response.body
  doc = Nokogiri::HTML(body)
  tds = doc.xpath("//td").each { |this|
    begin
      a = this > 'a'
      imgsrc = a[0]['href']
      timg = a > 'img'
      timgsrc = timg[0]['src']
      name = a.inner_text.strip
    
      contributor = this.inner_text.match(/\([^)]+\)/, a.inner_text.length)
      if !contributor
        contributor = "(Contributed by Bob Rubin)"
      end
      
      file.write([name,contributor,imgsrc,timgsrc].join("\t") + "\n")
    rescue
    end
  }

  door_num += 1
end
file.close
