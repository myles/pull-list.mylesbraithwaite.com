module Jekyll
  class YearArchiveIndex < Page
    def initialize(site, base, dir, period, posts)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'archive.html')
      self.data['period'] = period
      self.data['period_posts'] = posts
      self.data['title'] = "#{period["year"]}"
    end
  end
  
  class YearArchiveGenerator < Generator
    safe true
    
    def generate(site)
      site.posts.group_by{ |c| { "year" => c.date.year } }.each do |period, posts|
        archive_dir = File.join(period["year"].to_s())
        index = YearArchiveIndex.new(site, site.source, archive_dir, period, posts)
        index.render(site.layouts, site.site_payload)
        index.write(site.dest)
        site.pages << index
      end
    end
  end
end