require 'test/unit'
require 'greenhouse-ioc'

class KernelTest < Test::Unit::TestCase

	def test_can_initialize

    	result=GreenhouseIoc::Kernel.new
    	assert_not_nil result

  	end

end