class SitemapController < ApplicationController
#  self.view_paths = Mephisto::Plugin.view_paths[:sitemap]
  session :off
#  helper :sitemap
  layout nil
  
  def index
    headers['Content-Type'] = 'text/xml; charset=utf-8'
    @plugin   = Engines.plugins[:mephisto_sitemap]
    @sections = site.sections(true)
    @last_article = Article.find_by_date(:limit => 1).first
  end
end
