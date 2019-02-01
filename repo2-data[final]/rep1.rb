#Encoding:UTF-8
incr=1
#data_travel1~3の順にファイルを開く
Dir.glob('data_travel*.txt').sort.each{|txt|;File.open(txt, 'r'){|txtdata|
  month={:MAY=> 5,:JUL=> 7,:NOV=> 11,:APR=> 4,:SEP=> 9,:JAN=> 1}
  date=(data= txtdata.read).scan(/([0-9]{2})([A-Z]{3})([0-9]{2})/).flatten
  idd=data.scan(/reserve-id, (.*)?\n/)
  mon_v=month[date[1].to_sym]
  fri=data.scan(/flight,(.*)?\n/).flatten.map{|aa|aa.split(", ")}
  File.open("data#{incr}-flight.txt","w"){|aaaa|
    aaaa
    .puts "20#{date[2]}年#{mon_v}月#{date[0]}日に予約された旅行スケジュールです."
    aaaa.puts "予約番号は「#{idd[0][0]}」です."
    aaaa.puts ""
    fri.size.times{|ii|
      mmm=month[fri[ii][2].scan(/[A-Z]{3}/)[0].to_sym]
      aaaa.print "フライト#{ii+1}:#{fri[ii][0]}便,"
      aaaa
      .print "20#{date[2]}年#{mmm}月#{fri[ii][2].scan(/\d+/)[0]}日の#{fri[ii][3]
      .slice(0,2)}時"
      aaaa
      .print "#{fri[ii][3].slice(2,2)}分に#{fri[ii][5].slice(0,3)}出発,#{fri[ii][4]
      .slice(0,2)}時"
      aaaa.print "#{fri[ii][4].slice(2,2)}分に#{fri[ii][5].slice(4,3)}到着\n"
    }
  }
  incr+=1
}}##dir&open-end
################################################################################
incr=1
File.open('merged.txt', 'w'){|file| file = nil}
File.open('merged.txt', 'a+'){|merge|
  #3つのtxtをマージ
  Dir.glob('data_travel*.txt').sort.each{|txt|;File.open(txt, 'r'){|txtdata|
    merge.puts txtdata.read
  }}
}
n = [11,12,21,22,31,32,33]
user=File.open("merged.txt","r").read.scan(/pax, (.*?)\n/).flatten.uniq
hhh = Hash[*([n, user].transpose.flatten)]

user.each do |use|
  nnn =hhh.key(use).to_s[0]
  filename=use.scan(/[A-Z]+/).flatten
  filename="data#{nnn}_"+filename[2]+"_"+filename[0]+filename[1]+".txt"
  File.open("data_travel#{nnn}.txt", 'r'){|txtdata|
    month={:MAY=> 5,:JUL=> 7,:NOV=> 11,:APR=> 4,:SEP=> 9,:JAN=> 1}
    date=(data= txtdata.read).scan(/([0-9]{2})([A-Z]{3})([0-9]{2})/).flatten
    idd=data.scan(/reserve-id, (.*)?\n/)
    mon_v=month[date[1].to_sym]
    fri=data.scan(/flight,(.*)?\n/).flatten.map{|aa|aa.split(", ")}
    File.open(filename,"w"){|aaaa|
      aaaa.puts "Mr. #{use.scan(/[A-Z]+/).flatten[0].capitalize} #{use.scan(/[A-Z]+/).flatten[1].capitalize} さん\n"
      aaaa
      .puts "20#{date[2]}年#{mon_v}月#{date[0]}日に予約された旅行スケジュールです."
      aaaa.puts "予約番号は「#{idd[0][0]}」です."
      aaaa.puts ""
      fri.size.times{|ii|
        mmm=month[fri[ii][2].scan(/[A-Z]{3}/)[0].to_sym]
        aaaa.print "フライト#{ii+1}:#{fri[ii][0]}便,"
        aaaa
        .print "20#{date[2]}年#{mmm}月#{fri[ii][2].scan(/\d+/)[0]}日の#{fri[ii][3]
        .slice(0,2)}時"
        aaaa
        .print "#{fri[ii][3].slice(2,2)}分に#{fri[ii][5]
        .slice(0,3)}出発,#{fri[ii][4].slice(0,2)}時"
        aaaa.print "#{fri[ii][4].slice(2,2)}分に#{fri[ii][5].slice(4,3)}到着\n"
      }
      aaaa.puts "飛行機に#{fri.size}回乗ります."
      head=0
      unless (seat=data.scan(/seat, (.*)?\n/)).size==0
        seat.size.times do |ss|
          #ユーザの座席かどうか判断
          if seat[ss][0].scan(/, (.*), /)[0][0]==use
          #繰り返し1回目で見出し出力
          aaaa.puts "\n\n座席番号について:" if head==0;head+=1
          arr = seat[ss][0].split(", ")
          aaaa.puts "#{arr[0]}便の座席:#{arr[2]}"
        end
      end
      aaaa.puts "\n\n"
    end
    unless (meal=data.scan(/meal, (.*)?\n/)).size==0
      aaaa.puts "食事について:"
      meal.each do |mmmm|
        mmmm = mmmm[0].split(", ")
        if mmmm[0]=="all"#料理指定がallか個人どうか判断
          aaaa.puts "全ての便:#{mmmm[2]}"
        else
          aaaa.puts "#{mmmm[0]}便:#{mmmm[2]}"
        end
      end
    end
    }
  }
end