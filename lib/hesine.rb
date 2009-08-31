
module Hesine 

  class << self

    def load_configuration(config_file)
      if File.exist?(config_file)
        if defined? RAILS_ENV
          hesine = YAML.load_file(config_file)[RAILS_ENV] 
        else
          hesine = YAML.load_file(config_file)           
        end 
        ENV['SYSTEM_ID'] = hesine['system_id']
        ENV['SIGNATURE'] = hesine['signature']
      end     
      @hesine_configuration = hesine
    end 
    
    def hesine_config
      @hesine_configuration 
    end
    
    def request(xml)
      resource = RestClient::Resource.new 'http://www.hesine.com/openapi'   
      Crack::XML.parse(resource.post(xml, :content_type => 'application/xml'))['Xml']
    end
    
  end
end
