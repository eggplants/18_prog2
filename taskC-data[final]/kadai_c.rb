def listing(num)
  puts "Poisson distribution", "lambda: #{num}"#heading
  #iterate with k(=incr)=0~20
  20.times{|incr|
    #to avoid devide 0 change cases of k=0 and k>0
    result = incr == 0 ?
    1/(2.718281828459045**num.to_f)
    : (num**incr)/((1..incr).inject(:*)*(2.718281828459045**num.to_f))
    #round f(k) value round to 7th decimal
    result = "%.6f" % result.round(6)
    #put "(num of k):(f(k)):(*(s))"
    puts %Q(#{"%02d"%incr}:#{result}:#{'*'*((result.to_f*100).floor+1)})
  }
end
#get values(λ) from a json file
File.open("params.json", 'r'){|data|
  $num = data.read.scan(/\d+/).map(&:to_i)
}
#iterate with λ(=num)
$>= File.open('visual.txt', 'w'); $num.each{|n|listing(n)}
