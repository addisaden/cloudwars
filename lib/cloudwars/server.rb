# encoding: utf-8

module Cloudwars
  # The server is just the connectionpoint for cloudwars-clients.
  # It has only three methods:
  # - registration
  # - login
  # - logout
  #
  # Here is all the Usermanagement and on successful login
  # it return an DRbObject named Player
  #
  class Server
    # start the DRbFront
    def initialize(uri, userfile=File.expand_path("../../userlist.yml", File.dirname(__FILE__)), safelevel=2)
    end

    def registration(user, password)
    end

    def login(user, password)
    end

    def logout(user, password)
    end
  end
end
