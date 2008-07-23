readme_path = File.join(File.dirname(__FILE__), 'README')
File.open(readme_path) do |f|
  puts "\n"
  f.readlines.each{|line| puts line }
  puts "\n"
end