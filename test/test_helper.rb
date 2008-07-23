require 'test/unit'
require File.expand_path(File.join(File.dirname(__FILE__), '../../../../config/environment'))
require 'action_controller/test_process'
require 'application'

class ApplicationController
  def self.template_root=(*args); end
  def rescue_action(e) 
    raise e
  end
end

require 'sitemap_controller'
@logger = Logger.new(File.dirname(__FILE__) + "/debug.log")

# This pair of methods lets us easily use assert_select on XML docs
# thanks to Jamis Buck: http://weblog.jamisbuck.org/2007/1/4/assert_xml_select
def xml_document
  @xml_document ||= HTML::Document.new(@response.body, false, true)
end

def assert_xml_select(*args)
  @html_document = xml_document
  assert_select(*args)
end