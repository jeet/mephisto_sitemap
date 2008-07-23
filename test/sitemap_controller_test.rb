require File.dirname(__FILE__) + '/test_helper'

class SitemapControllerTest < Test::Unit::TestCase
  def setup
    @controller = SitemapController.new
    @request, @response = ActionController::TestRequest.new, ActionController::TestResponse.new
  end
  
  def test_controller_is_available
    assert_not_nil @controller
    assert_not_nil @request
    assert_not_nil @response
  end
  
  # Functionals
  def test_routing
    options = {:controller => 'sitemap', :action => 'index'}
    assert_generates '/sitemap.xml', options
    assert_recognizes options, 'sitemap.xml'
  end

  def test_index_template
    get :index
    assert_response :success
    assert_template 'index'
  end

  def test_response_has_urlset
    get :index
    assert_response :success
    assert_select 'urlset'
  end
  
  def test_urlset_has_a_url_child
    get :index
    assert_response :success
    assert_select 'urlset url', nil, 'urlset must have at least one url child'
  end
  
  def test_url_tag_has_correct_structure
    get :index
    assert_response :success
    assert_select "urlset url" do
      assert_select "loc"
      assert_select "priority"
      assert_select "changefreq"
      assert_select "lastmod"
    end
  end
  
  def test_tags_have_sensible_content
    freqs = /(always|hourly|daily|weekly|monthly|yearly|never)/
    
    freq_sentence = freqs.to_s.split('|').map do |e|
      e.gsub(/\W|mix/,'')
    end.to_sentence(:connector => 'or', :skip_last_comma => true)
    
    get :index
    assert_response :success
    assert_select 'priority', /^\d\.\d$/, 'priority is of an improper format'
    assert_select 'changefreq', freqs, "changefreq must be one of #{freq_sentence}"
  end
  
  def test_should_produce_iso_8601_compliant_date_for_lastmod
    iso_8601 = Regexp.new(
      "([0-9]{4})(-([0-9]{2})(-([0-9]{2})(T([0-9]{2}):([0-9]{2})" \
      "(:([0-9]{2})(\.([0-9]+))?)?(Z|(([-+])([0-9]{2}):([0-9]{2})))?)?)?)?"
    )
    get :index
    assert_response :success
    assert_select 'lastmod', iso_8601, 'lastmod should be of ISO 8601 format.'
  end
end