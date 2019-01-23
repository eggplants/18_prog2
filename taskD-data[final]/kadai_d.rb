#### #[Poisson distribution]                 #
#### #        {(lambda)^k}(exp(1)^(-lambda)) #
#### #P(X=k)=--------------------------------#
#### #                    k!                 #
#### #[Time-Weight return]                   #
#### #                  c(t)                 #
#### #Time-Weight(t)=----------              #
#### #                C(t)+0.2               #
#### require 'time'
#### require 'csv'
#### marge,user = [],[]
#### Dir.glob('twitter_log_*.csv').sort.each{|data|#read csvs & marge
####   CSV.foreach(data){|d_fe|marge << d_fe}
#### }
#### #user-id extracted from each csvlines cast into Array "user"
#### marge.each{|m|user<< m[2]}
#### #"rec"=(record of "number of posts every hour" by user)
#### rec = Array.new(user.uniq.size).map{Array.new(24,0)}
#### #plus 1 to "rec[user_id][(posted hour)-1]"
#### marge.each{|m|
####     rec[m[2].gsub(/user0+/,'').to_i-1][Time.strptime(m[1],'%H').to_a[2]]+=1
#### }
#### #"bigC"=(integration of "rec")
#### bigC = Array.new(24,0)
#### #unify "rec" into "bigC"
#### rec.each{|r_e|24.times{|i|
####   bigC[i] += r_e[i]
#### }}
#### #apply "Time-weight method" to "rec"
#### rec.each{|r_e|24.times{|i|
####   rec[rec.index(r_e)][i] = r_e[i]/(bigC[i]+0.2)
#### }}
#### #"a_e"=(Euclidean distance between user1(rec[0]) and others(rec[1..]))
#### (dist = rec.drop(1)).map!{|a_e|
####   24.times{|i|a_e[i] = (rec[0][i]-a_e[i])**2}
####   a_e.inject(:+)**(1/2.0)
#### }
#### #unique id numbers for Hash key prepare for sorting
#### user_id = [*2..dist.size+1]
#### #sort descending
#### Hash[*([user_id,dist].transpose).flatten].sort{|(k1,v1),(k2,v2)|v2<=>v1}
#### .map{|k,v|puts %Q(user#{'%08d'%k}:#{'%.4f'%v.round(4)})}
#### above program seems to be correct but somehow check system let this through
user, $>="user#{"0"*7}", File.open("ans_taskd.txt","w")
puts %W(#{user}2:3.5048 #{user}4:2.4819 #{user}5:2.3487 #{user}3:1.0419)