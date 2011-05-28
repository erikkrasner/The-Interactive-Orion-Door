#!/usr/bin/env ruby

orions_file = File.open('orions.txt','r')
rows = [[],[],[],[]]
js_string = "var infoTable = {\n"
count = 0
orions_file.lines do |line|
  split = line.chomp.split("\t")
  if split and split.length == 4
    name = split[0].gsub("'","\'")
    contributor = split[1].gsub("'","\'")
    imgsrc = split[2].gsub("'","\'")
    timgsrc = split[3].gsub("'","\'")
    js_string += "\t'#{timgsrc}':{name:'#{name}',\n\tcontributor:'#{contributor}',\n\timgsrc:'#{imgsrc}'\n\t},\n"
    rows[count % 4] += [timgsrc]
    count += 1
  end
end
js_string += "}\n"
html_string = "<table id=\"orions\">\n"
rows.each do |row|
  html_string += "\t<tr>\n"
  row.each do |timgsrc|
    html_string += "\t\t<td><img src='#{timgsrc}'></img>\n"
  end
  html_string += "\t</tr>\n"
end
html_string += "</table>\n"

html_file = File.open('orions_table.html','w')
html_file.write(html_string)
html_file.close
js_file = File.open('orions_table.js','w')
js_file.write(js_string)
js_file.close