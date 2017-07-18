# require 'view_elements/registry'

module ViewElements
  class Component < ViewElement
    # cattr_accessor :components_registry

    def render
      validate_properties!
      if self.class.template_proc
        type, proc = self.class.template_proc
        action_view.render inline: proc.call, type: type, locals: build_locals(locals)
      elsif self.class.template_file_name.present?
        action_view.render file: view_path_for(self.class.template_file_name), locals: build_locals(locals)
      else
        super
      end
    end

    def validate_properties!
      return unless self.class.properties_list.present?

      missing_properties = _calc_missing_properties(locals)

      raise "Missing #{missing_properties.to_sentence} propertie(s) for #{self.class} component." if missing_properties.present?
    end

    def self.let(name, &block)
      @lets ||= {}
      @lets[name] = block

      # instance_eval do
      define_method name do
        v = instance_variable_get("@#{name}") || instance_eval(&self.class.lets[name])
        instance_variable_set("@#{name}", v)
      end
      # end
    end

    def self.define_helper(helper_module)
      ViewElements::Registry.define_component_helper(helper_module, @selector, self)
    end

    def self.components_registry
      @components_registry ||= {}
    end

    def self.lets
      @lets
    end

    def self.properties_list
      @properties
    end

    def self.properties(*args)
      @properties = args
    end

    def self.selector(name)
      @selector = name
      Component.components_registry[name] = self
      ViewElements.register(name, self)
    end

    def self.template_proc
      @template_proc
    end

    def self.template_file_name
      @template_file_name
    end

    def self.template(options = nil, &block)
      if block_given?
        @template_proc = [(options || :erb) , block]
      else
        @template_file_name = options
      end
    end

    private

    def _calc_missing_properties(locals)
      if locals.present?
        self.class.properties_list.map(&:to_s) - locals.keys.map(&:to_s)
      else
        self.class.properties_list.map(&:to_s)
      end
    end
  end
end
