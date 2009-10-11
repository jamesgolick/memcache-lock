$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'memcached-lock'
require 'rubygems'
require 'memcache'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  config.mock_with :rr
  config.before :suite do
    config = YAML.load(IO.read((File.expand_path(File.dirname(__FILE__) + "/memcached.yml"))))['test']
    $memcache = MemCache.new(config)
    $memcache.servers = config['servers']
    $lock = MemcachedLock.new($memcache)
  end

  config.before :each do
    $memcache.flush_all
  end  
end
