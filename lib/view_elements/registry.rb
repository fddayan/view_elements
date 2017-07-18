module ViewElements

  module Registry

    def self.component_tag_prefix
      :cmp
    end

    def self.define_component_helpers(helper_module, map)
      map.each do |k,v|
        define_component_helper helper_module, k, v
      end
    end

    def self.define_component_helper(helper_module, name, component)
      helper_module.instance_eval do
        m = "#{name}_#{ViewElements::Registry.component_tag_prefix}"
        define_method m do |*args|
          component.new(self, *args).render
        end
      end
    end

  end
end
