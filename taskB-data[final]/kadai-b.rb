#make past merge-file brand-new
File.open('merged.txt', 'w'){|file| file = nil}
#merge txts into just one
File.open('merged.txt', 'a+'){|merge|
  #bring each txt file and additionally write
  Dir.glob('task_B-data*.txt').sort.each{|txt|;File.open(txt, 'r'){|txtdata|
    merge.puts txtdata.read
    }}
}
#save merged data in this array
data = []
#retrieve merged data from file
File.open("merged.txt"){|m_data|;m_data.each_line{|line|
    data.push(line.split(","))
}}
#save results
saved = Array.new(data.size).map{Array.new(7)}
for e_lines in 0...data.size
  #0, Title
  saved[e_lines][0] = data[e_lines][0].scan(/\w+/).map{|a|a.capitalize}.join(" ")
  #1, old ISBN-code
  old_inst = data[e_lines][1].scan(/[0-9]+/)
  saved[e_lines][1] = old_inst.join("-")
  #2, Publisher-code
  saved[e_lines][2] = old_inst[1]
  #3, Title-code
  saved[e_lines][3] = old_inst[2]
  #4, old ISBN-check-d
  saved[e_lines][4] = old_inst[-1]
  #5, new ISBN-check-d
  new_inst = ("978"+old_inst.join.chop).to_s.scan(/\d{1}/)
  odd = new_inst.select.with_index{|e, i|i % 2 == 0}
        .map{|o_3|o_3.to_i}.inject(:+)
  even = new_inst.select.with_index{|e, i|i % 2 == 1}
        .map{|o_2|o_2.to_i}.inject(:+)
  saved[e_lines][5] = ((10-((odd + (even * 3)) % 10)) % 10).to_s
  #6, new ISBN-code
  saved[e_lines][6] = "978-#{saved[e_lines][1].chop}#{saved[e_lines][5]}"
end
$>= File.open('posts-out.txt', 'w')
#print results
saved.each{|output|
  puts '*'*(output[0].size+6),
  "*\s\s#{output[0]}\s\s*",
  '*'*(output[0].size+6)
  output.map{|n|puts n}
 }
 #delete merged file
 File.delete("merged.txt")
