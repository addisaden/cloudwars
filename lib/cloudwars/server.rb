# encoding: utf-8
require "drb/drb"

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
    # start self as the DRbServer
    def initialize(uri, userfile=File.expand_path("../../userlist.yml", File.dirname(__FILE__)), safelevel=2)
      @sessions = {}
      @userfile = userfile
      @uri = uri
      @server = DRb.start_service(@uri, self, { safe_level: safelevel })
    end

    # registration of a new user
    def registration(user, password)
    end

    # login creates a new playerobject as session
    def login(user, password)
    end

    # logout destroys a session of playerobject
    def logout(user, password)
    end
  end
end
