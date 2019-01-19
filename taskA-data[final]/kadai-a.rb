#standard inputs to file "posts-out.txt"
$stdout = File.open('posts-out.txt', 'w')
require 'time'
require 'csv'
require "fileutils"
#erase merged contain
File.open('out.csv','w'){|file| file = nil}
#search for csv files and load it
Dir.glob('posts*.csv').each {|csvpath|
  #"posts~.csv" files merge "out.csv"
  csvdata = CSV.read(csvpath)
  CSV.open('out.csv','a') {|merge|
    for data in csvdata
      merge.puts data
    end
  }
}
#head of table(this is the templete of result-data)
print("user_id,")
for hours in 0..22
  print(hours,",")
end
  print("23\n")
#load a csv file
File.open('out.csv'){|csvdata|
  #detect num of users
  usernum = csvdata.read.scan(/user[0-9]+/).uniq.size
  #make new 2D-array to save the result of analysis
  rec = Array.new(usernum).map{Array.new(24,0)}
  #load each line of a csv file
  File.readlines(csvdata).each {|csveach|
    #split into strings in an array
    csveachs = csveach.split(",")
    #make string 0:00:00~23:59:59 treat as time class and change into array
    csveachs[1] = Time.strptime(csveachs[1], "%H:%M:%S").to_a
    #change "userXXXXXXXX" into "X(1-degit)"
    csveachs[2].gsub!(/user0+/, "")
    #detect post-time and save this count
    rec[csveachs[2].to_i-1][csveachs[1][2]] += 1
  }
   rec = rec.map{|a|a.map{|b|b = b **2}}
    #shape appearance of result-data following example templete
    for usernum_e in 1..usernum
      #change "X(1-degit)" into "userXXXXXXXX"
      usernum_8 = '%08d' % usernum_e
      anldata = "user" + usernum_8 + "," + rec[usernum_e-1].join(",")
      puts anldata
    end
}
FileUtils.rm('out.csv')
