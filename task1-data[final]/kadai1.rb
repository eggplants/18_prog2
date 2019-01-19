###first, load redirected txt
str_0 = $stdin.read.to_s.delete('"')
str_1 = str_0.gsub(/\n/, " ").gsub(/(\?|!|:)/, ".")
.gsub(/'/, "s").gsub(/-/, "h")
.delete(",").split(".")
str_2,incr = [],0
str_1.each {|sentence|
  str_2[incr] = sentence.scan(/\w+/)
  incr += 1
}
str_2.delete_at(-1)
incr -= 1
p_lng_0 = str_0.scan(/^[A-Z]{1}[a-z]+.*\n/)
p_lng_1 = p_lng_0[0].split.length

###retrive asitating president name
president = str_2[0][0, p_lng_1]
presidentName = president.join(' ')
#goodbye, president
str_2[0].slice!(0..p_lng_1-1)
para_n = str_0.scan(/\n\n/).size + 1

###average of word(s) per sentence
sum_w = 0.to_f
for a in 0..(incr - 1)
  sum_w += str_2[a].size
end
avg_w = sum_w / incr

###variance of word(s) per sentence
dev_sq_w = 0.to_f
for b in 0..(incr - 1)
  dev_sq_w += (str_2[b].size - avg_w)** 2
end
var_w = dev_sq_w / incr

###split array str0 into arrays of entire word(s) in str_3(array)
str_3 = str_0.downcase.gsub(/'/, "s").gsub(/-/, "h").scan(/\w+/)
str_3.slice!(0, p_lng_1)

###avg. of entire word(s)
avg_e = 0.to_f
for c in 0..(str_3.size - 1)
  avg_e += str_3[c].length
end
avg_e = avg_e / str_3.size

###var. of entire word(s)
dev_sq_e = 0.to_f
for d in 0..(str_3.size - 1)
  dev_sq_e += (str_3[d].size - avg_e) ** 2
end
var_e = dev_sq_e / str_3.size

###entire word(s)
word_n = str_3.uniq.size

#export results
puts %W(#{presidentName} #{para_n,incr} #{"%.2f" % avg_w}
#{"%.2f" % var_w} #{"%.2f" % avg_e} #{"%.2f" % var_e} #{word_n}).join(",")
