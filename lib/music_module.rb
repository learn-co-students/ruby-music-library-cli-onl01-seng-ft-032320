require 'pry'

module Concerns
    module Findable 
        def find_by_name(name)
            self.all.find{|o| o.name == name}
        end

        def find_or_create_by_name(name)
            find_by_name(name) == nil ? self.create(name) : find_by_name(name)
        end

    end 

    module Instances 
        def save 
            self.class.all << self 
        end 
    end 
end 