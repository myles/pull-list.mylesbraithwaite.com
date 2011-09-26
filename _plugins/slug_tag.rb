module Slugify
	def slugify(text)
		return Slugalizer::slugalize(text)
	end
end

Liquid::Template.register_filter(Slugify)