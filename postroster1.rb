#!usr/bin/env ruby
# grades hw1 after the roster has been created
# TODO: add cmd line support for other hws
require 'csv'

def make_roster(gl_name, csv_name)
  `make-roster #{gl_name} > #{gl_name}_roster`
end

def grade(gl_name, csv_name)
  # Do grade entering
  skip_first = true
  # construct hash of logins
  roster = {}
  File.open("hw1.roster").each do |line|
    roster[line[6..7]] = line
  end

  login_index = nil
  iter_index = nil

  CSV.foreach('hw1.csv', :encoding => "UTF-8") do |row|
    if skip_first
      login_index = row.index "LOGIN"
      # multiple scores and comments to keep track of
      #iter_indeces = row.index "#{csv_name}"
      skip_first = false
      next
    end
    login = row[login_index] 
    if roster.has_key? login
      # calculate score and reduce comments
      score = 0
      [1,3,5,7].each do |i|
        score = score + row[i].to_i
      end
      # comments
      comments = ""
      [2,4,6,8].each do |i|
        comments << row[i].to_s << "; "
      end
      roster[login] = roster[login][0..-2] << score.to_s << " " << comments << "\n"
    end
  end
  out = File.open("#{gl_name}", 'wb')
  roster.each_value do |val|
    out << val
  end
  out.close
end

def main(gl_name, csv_name)
  grade(gl_name, csv_name)
end

if __FILE__ == $0
  # Get the assignment name for glookup, csv containing grades (Respectively)
  gl_name = ARGV[0]
  csv_name = ARGV[1]
  main(gl_name, csv_name)
end
