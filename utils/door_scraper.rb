#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require "nokogiri"

door_num = 1
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
      txt = a.inner_text.strip
      puts a.inner_text.length
      contributor = this.inner_text.match(/\([^)]+\)/, a.inner_text.length)
      if !contributor
        contributor = "(Contributed by Bob Rubin)"
      end
    
      puts(imgsrc)
      puts(timgsrc)
      puts(txt)
      puts(contributor)
    rescue
    end
  }
  
  door_num += 1
end