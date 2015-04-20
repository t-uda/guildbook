ENV['RACK_ENV'] = 'test'

require_relative '../lib/app'
require_relative '../lib/base'
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
        :custom_schemas => File.expand_path('../kmc.ldif', __FILE__),
        :domain => 'dc=box2,dc=kmc,dc=gr,dc=jp',
        :tmpdir => @tmpdir,
        :verbose => false,
        :quiet => false
      )
      @server.start
    end
    def shutdown
      @server.stop
      FileUtils.remove_entry_secure @tmpdir
    end
  end

  def base_repo
    GuildBook::BaseRepo.new('ldap://localhost:3897/dc=box2,dc=kmc,dc=gr,dc=jp')
  end

  def user_repo
    GuildBook::UserRepo.new('ldap://localhost:3897/ou=users,dc=box2,dc=kmc,dc=gr,dc=jp')
  end

  def test_user
    user = user_repo.get('aa729')
    assert_equal(user.cn.first, 'Alexandra Adams')
    assert_equal(user['x-kmc-Lodging'].first, 'TRUE')
  end

  #def test_samba
  #  domain_sid = base_repo.get_domain_sid('KMC')
  #  assert_equal(domain_sid, 'S-1-5-21-792563724-434869193-1042426199')
  #end

end

