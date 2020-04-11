module Concerns
  module Findable
  
    def find_by_name(name)
      self.all.find{|i| i.name == name}
    end
    
    def find_or_create_by_name(name)
      thing = self.find_by_name(name)
      if thing
      thing
      else
      self.create(name) 
      end
    end
  end

  
end


