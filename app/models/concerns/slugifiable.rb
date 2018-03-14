module Concerns
  module Slugify
    def slug
      self.username.downcase.gsub(" ",'-')
    end
  end
  module Findable
    def find_by_slug(slug)
      slug = slug.gsub("-", " ")
      self.all.detect{|i| i.username.downcase == slug}

    end
  end
end
