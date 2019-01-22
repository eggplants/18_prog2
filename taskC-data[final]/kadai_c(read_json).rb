def listing(num)
  puts "Poisson distribution", "lambda: #{num}"#heading
  #iterate with k(=incr)=0~20
  [*0..20].each{|incr|
    #to avoid devide 0 change cases of k=0 and k>0 & round f(k) to 7th decimal
    result = "%.6f" % (incr == 0 ?
    (1/(Math.exp(1)**num.to_f)).round(6)
    : ((num**incr)/((1..incr).inject(:*)*(Math.exp(1)**num.to_f))).round(6))
    #put "(num of k):(f(k)):(*(s))"
    puts %Q(#{"%02d"%incr}:#{result}:#{'*'*((result.to_f*100).floor+1)})
  }
end
#ans_taskc.txt inputs the contains of"stdout
$>= File.open('ans_taskc.txt', 'w')
#get values(elements "lambda") from a json file
File.open('params.json', 'r'){|data|
  data.read.scan(/\d+/).map(&:to_i).each{|n|listing(n)}#iterate with "lambda"(=num)
}