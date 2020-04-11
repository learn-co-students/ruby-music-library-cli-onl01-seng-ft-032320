module Concerns                                   #module name
  module Findable                                 #module type/ because the methods were class?
    
    def find_by_name(name)                        #searching array for matching name
      self.all.detect {|a| a.name == name}        #iterate over @@all[], detect will return first match name
    end
  
    def find_or_create_by_name(name)              #search for name if none create new
        found = self.find_by_name(name)           #iterate over @@all[], find will return first match
      if found                                    #if match is found
         found                                    #implicit return 
      else
        self.create(name)                         #invokes class's create method
      end
    end
  end
end