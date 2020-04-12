
module Concerns::Findable


  def find_by_name(given_argument)
    self.all.find {|argument| argument.name == given_argument}
  end

def find_or_create_by_name(given_argument)
    if self.find_by_name(given_argument) == nil
      self.create(given_argument)
    else
      self.find_by_name(given_argument)
   end
  end
end
