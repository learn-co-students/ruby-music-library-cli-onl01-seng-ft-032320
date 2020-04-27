#Allows us to extend these class methods into other Classes 
module Concerns::Findable
   def find_by_name(name)
      #Returns FIRST instance where true
      self.all.detect {|a| a.name == name}
   end

   def find_or_create_by_name(name)
      # if truthy ? return : create
      self.find_by_name(name) ? self.find_by_name(name) : self.create(name) 
   end
end
