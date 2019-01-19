###first, load redirected txt
str_0 = $stdin.read.to_s.delete('"')#receive txt, delete quotation and save at str_0
###then split into elements in array
str_1 = str_0.gsub(/\n/, " ")#line break replace space
.gsub(/\?/, ".").gsub(/!/, ".").gsub(/:/, ".")#sentence-end marks replace period
.gsub(/'/, "s").gsub(/-/, "h")#strings that treat as one alphabet replace into it
.delete(",").split(".")#split array str0 into arrays by a sentence
###split into sentences
str_2 = []#str_2 is a array to save sentences
incr = 0#Initialize variable "incr" *this finally show how many sentences*
#Every sentence split into words and save in str_2
str_1.each {|sentence|
  str_2[incr] = sentence.scan(/\w+/)
  incr += 1
}
str_2.delete_at(-1)#delete one blank line to the end of str_2
incr -= 1#this value equals num. of sentence(s)
###detect length of president name
p_lng_0 = str_0.scan(/^[A-Z]{1}[a-z]+.*\n/)
p_lng_1 = p_lng_0[0].split.length
###retrive asitating president name
president = str_2[0][0, p_lng_1]
presidentName = president.join(' ')#erements in array changes one string
#goodbye, president
str_2[0].slice!(0..p_lng_1-1)
#detect how many paragraphs does this sentenses have
para_n = str_0.scan(/\n\n/).size + 1
###average of word(s) per sentence
sum_w = 0.to_f
for a in 0..(incr - 1)#sum of num. of word(s) in sentence
  sum_w += str_2[a].size
end
avg_w = sum_w / incr#sum devides num. of sentence
###variance of word(s) per sentence
dev_sq_w = 0.to_f
for b in 0..(incr - 1)#sum of number that deviate num. of sentence, and then squar
  dev_sq_w += (str_2[b].size - avg_w)** 2
end
var_w = dev_sq_w / incr#sum devides num. of sentence
###split array str0 into arrays of entire word(s) in str_3(array)
#strings that treat as one alphabet replace into it, and then split into words
str_3 = str_0.downcase.gsub(/'/, "s").gsub(/-/, "h").scan(/\w+/)
str_3.slice!(0, p_lng_1)# delete president name
###avg. of entire word(s)
avg_e = 0.to_f
for c in 0..(str_3.size - 1)#sum of length of word
  avg_e += str_3[c].length
end
avg_e = avg_e / str_3.size#sum devides num. of word
###var. of entire word(s)
dev_sq_e = 0.to_f
for d in 0..(str_3.size - 1)#sum of number that deviate num. of word and then squar
  dev_sq_e += (str_3[d].size - avg_e) ** 2
end
var_e = dev_sq_e / str_3.sizen‚†#sum devides num. of word
###entire word(s)
word_n = str_3.uniq.size#num. of entire word(s)
#export results
print(presidentName, ",",#president name
   para_n, ",",#num. of entire paragraph(s)
    incr, ",",#num. of entire sentence(s)
    "%.2f" % avg_w, ",",#avg. of word(s) per sentence
     "%.2f" % var_w, ",",#var. of word(s) per sentence
      "%.2f" % avg_e, ",",#avg. of entire word(s)
       "%.2f" % var_e, ",",#var. of entire word(s)
        word_n,#num. of entire word(s)
          "\n"
      )
