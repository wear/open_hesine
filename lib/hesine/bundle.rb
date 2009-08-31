module Hesine
  module Bundle 
    class << self
    def params_builder(params = {})         
        data = Builder::XmlMarkup.new( :target => out_string = "", :indent => 2 )
        data.instruct!  
        data.XML{
          data.System{
            data.SystemID(ENV['SYSTEM_ID'])
            data.MsgID('0')
            data.Signature(ENV['SIGNATURE'])
            data.Command(params[:command])
          } 
          data.User{
            data.UserId(params[:user_id]) if params.has_key?(:user_id)
            data.Phone("+86" + params[:phone])
            data.VerifyCode(params[:verify_code]) if params.has_key?(:verify_code)  
          }
        }
        return out_string  
    end     
    
     def bind(pra = {})       
        pra.reverse_merge! :command => 'Bind'
        xml = params_builder(pra) 
        Hesine.request(xml)
     end
     
     def unbind(pra = {})
        pra.reverse_merge! :command => 'UnBind'   
        xml = params_builder(pra) 
        Hesine.request(xml)
     end 
    
    end
  end
end