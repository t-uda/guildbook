ENV['RACK_ENV'] = 'test'

require_relative '../lib/app'
require 'tmpdir'
require 'thread'
require 'ladle'
require 'test/unit'

class LadleTest < Test::Unit::TestCase
  class << self
    def startup
      @tmpdir = Dir.mktmpdir
      @server = Ladle::Server.new(
        :port => 3897,
        :ldif => File.expand_path('../test_users.ldif', __FILE__),
        :domain => 'dc=box2,dc=kmc,dc=gr,dc=jp',
        :tmpdir => @tmpdir,
        :verbose => true,
        :quiet => false
      )
      @server.start
    end
    def shutdown
      @server.stop
      FileUtils.remove_entry_secure @tmpdir
    end
  end

  def setup
    @app = GuildBook::App.new
  end

  def test_user
    #users = @app.user_repo.get('aa729')
    #assert_equal(users.length, 1)
    #user = users.first
    #assert_equal(user.cn, 'Alexandra Adams')
  end

end

