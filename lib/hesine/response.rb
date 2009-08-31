module Hesine
  module Response
    class << self 
      # xml is request.parameters['<?xml version'] in your controller method
      def bind?(xml)
        begin
          res = ('<?xml version=' + xml).gsub!(/\n/,'')
          @res = Crack::XML.parse(res)['Xml'] 
          command = @res['System']['Command']
          status =  @res['User']['Status']
          if  command == 'BindResult' &&  status == '0' 
            return @res['User']['Phone'] 
          else
            return false
          end
        rescue
          logger.info('hesine goes wrong!!!')
        end
      end  
      
      def cn_message(code)
        case code
        when '200'
          '操作成功'
        when '400'
          '语法错误或者缺少必须的参数'
        when '401'
          '认证失败'
        when '402'
          '不是和信用户'
        when '403'
          '和信用户但不在线'
        when '404'
          '没有绑定关系'
        when '405'
          '已经绑定'
        when '500'
          '服务器内部错误'
        when '503'
          '服务暂时中断'
        when '505'
          'HTTP版本不支持'
        end
      end
    end
  end
end