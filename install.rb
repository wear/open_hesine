
dir = File.dirname(__FILE__)
templates = File.join(dir,'templates')
config = File.join('config', 'hesine.yml')

FileUtils.cp File.join(templates, config), File.join(RAILS_ROOT, config) unless File.exist?(File.join(RAILS_ROOT, config))

puts IO.read(File.join(File.dirname(__FILE__), 'README'))
