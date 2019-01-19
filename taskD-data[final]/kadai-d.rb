require 'time';require 'csv'
###---def---###
#def1. anylise "number of posts by user" & "its integration"
def make_24(marge)
  user = []
  #user-id extracted from each csvlines cast into Array "user"
  marge.each{|m|user << m[2]}
  #"rec"=(record of "number of posts every hour" by user)
  rec = Array.new((user_id = user.uniq).size).map{Array.new(24,0)}
  #plus 1 to "rec[user_id][(posted hour)-1]"
  marge.each{|m|
    m[1] = Time.strptime(m[1],'%H:%M:%S').to_a
    m[2].gsub!(/user0+/,'')
    rec[m[2].to_i-1][m[1][2]] += 1
  }
  #"bigC"=(integration of "rec")
  bigC = Array.new(24,0)
  #unify "rec" into "bigC"
  rec.each{|r_e|24.times{|i|bigC[i] += r_e[i]}}
  return rec,bigC
end
#def2. turn "rec" into new one adapted to "Time-weighted return"
def fr24_toTW(rec,bC)
  #apply "Time-weighted return" to "rec"
  rec.each{|r_e|24.times{|i|rec[rec.index(r_e)][i] = r_e[i]/(bC[i]+0.2)}}
  return rec
end
#def3. calculate "Euclidean distance" between "rec[0]" and "rec[1..4]"
def euc(rec)
  basis = rec[0]
  (dist = rec.drop(1)).map{|a_e|24.times{|i|a_e[i] = (basis[i]-a_e[i])**2}}
  dist.map!{|a_e|a_e.inject(:+)**(1/2.to_f)}
  user_id = [*2..dist.size+1]
  answer = Hash[*([user_id,dist].transpose).flatten]
  .sort{|(k1,v1),(k2,v2)|v2<=>v1}
  return answer
end
###---exe---###
$>= File.open('order.txt','w')
marge = []
Dir.glob('twitter_log_*.csv').sort.each{|data|#read csvs & marge
  CSV.foreach(data){|d_fe|marge << d_fe}
}
rec,bC = make_24(marge)
euc(fr24_toTW(rec,bC)).map{|k,v|puts %Q(user#{'%08d'%k}:#{'%.4f'%v.round(4)})}
