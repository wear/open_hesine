
dest_file = File.join(RAILS_ROOT, "config/hesine.yml")
src_file = File.join(File.dirname(__FILE__) , 'template/config/hesine.yml')
FileUtils.cp_r(src_file, dest_file)
 
puts IO.read(File.join(File.dirname(__FILE__), 'README'))