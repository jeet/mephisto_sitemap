
require File.join(lib_path, 'sitemap')
option :site_uri, 'http://www.example.com'
      option :home_priority, 0.9
      option :article_priority, 0.5
      option :home_frequency, 'daily'
      option :blog_frequency, 'daily'
      option :page_frequency, 'weekly'
      
      
Dependencies.load_once_paths.delete(lib_path)
