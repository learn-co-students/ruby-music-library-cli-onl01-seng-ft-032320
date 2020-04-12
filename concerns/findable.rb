module Findable

    def find_by_name(object_name)
      self.all.find do |object|
        object.name == object_name
      end
    end

    def find_or_create_by_name(object_name)
      if find_by_name(object_name)
        find_by_name(object_name)
      else
        self.create(object_name)
      end
    end
end
