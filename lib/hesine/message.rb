module Hesine
  module Message 
    class << self     
      # from example - "stephen"<support@mhqx001>  
      # mhqx001 are system_id at hesine  
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
              data.Phone("+86"+params[:phone])
              data.Message{
                data.Type('Hesine')
                data.From(params[:from]) 
                data.To(params[:to]) 
                data.Cc(params[:cc]) if params.has_key?(:cc)
                data.Bcc(params[:bcc]) if params.has_key?(:bcc)
                data.Subject(params[:subject])
                data.Body(params[:body])
                data.NumOfAttach(params[:num_of_attach])
                if (params[:num_of_attach].to_i > 0 && params[:num_of_attach].to_i >= 5 && !params[:attachments].blank?)
                   params[:attachments].each do |attachment|
                     data.Attach{
                       data.AttacName(attachment[:attch_name])
                       data.AttacName(attachment[:attch_body])
                     }
                   end
                end 
              }
            }
          }
          return out_string  
      end  
      
      def send(pra = {})       
          pra.reverse_merge! :command => 'Submit',:num_of_attach => '0'
          xml = params_builder(pra) 
          Hesine.request(xml)
      end

    end
  end
end