module Pitchr
  module Routing
    class ForceDomain
      def initialize(domain)
        if domain and domain != ""
          @domain = domain

          # set host from domain
          domain_parts = domain.split(":")
          @host = domain_parts[0]

          # add port if applicable
          if domain_parts[1]
            port = domain_parts[1].to_i
            @port = port if port > 0
          end
        end
      end

      def redirect?(request)
        host_mismatch = (@host && request.host != @host)
        port_mismatch = (@port && request.port != @port)
        if host_mismatch or port_mismatch
          fake_request = Rack::Request.new(request.env.merge("HTTP_HOST" => @domain, "SERVER_PORT" => @port || request.port))
          fake_request.url
        else
          return nil
        end
      end
    end
  end
end