module Jekyll
	class CategoryIndex < Page
		def initialize(site, base, dir, category)
			@site = site
			@base = base
			@dir = dir
			@name = 'index.html'
			
			self.process(@name)
			self.read_yaml(File.join(base, '_layouts'), 'comic.html')
			self.data['category'] = category
		end
	end

	class CategoryGenerator < Generator
		safe true

		def generate(site)
			site.categories.keys.each do |category|
				slug = Slugalizer::slugalize(category)
				index = CategoryIndex.new(site, site.source, File.join('comic', slug), category)
				index.render(site.layouts, site.site_payload)
				index.write(site.dest)
				site.pages << index
			end
		end
	end
end