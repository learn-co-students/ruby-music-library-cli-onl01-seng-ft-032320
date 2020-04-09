module Concerns::Findable
  
  def find_by_name(name)
    self.all.detect {|song| song.name == name}
  end
  
  def find_or_create_by_name(name)
    self.all.include?(name)
    self.find_by_name(name) || self.create(name)
  end

end
  
  
  
  
  #rspec spec/008_findable_module_spec.rb