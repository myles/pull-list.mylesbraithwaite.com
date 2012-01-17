module Jekyll
  class MonthArchiveIndex < Page
    def initialize(site, base, dir, period, posts)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'archive.html')
      self.data['period'] = period
      self.data['period_posts'] = posts
      self.data['title'] = "#{period["month"]}-#{period["year"]}"
    end
  end
  
  class MonthArchiveGenerator < Generator
    safe true
    
    def generate(site)
      site.posts.group_by{ |c| {"month" => c.date.month, "year" => c.date.year } }.each do |period, posts|
        archive_dir = File.join(period["year"].to_s(), "%02d" % period["month"].to_s())
        index = MonthArchiveIndex.new(site, site.source, archive_dir, period, posts)
        index.render(site.layouts, site.site_payload)
        index.write(site.dest)
        site.pages << index
      end
    end
  end
end