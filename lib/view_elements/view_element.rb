# module ViewElements
#   class ViewElement
#     include ViewElements::RailsSupport
#
#     attr_reader :action_view, :locals
#
#     def initialize(action_view, locals = {})
#       @locals = locals
#       @action_view = action_view
#
#       define_locals_accessors(locals) if locals.present?
#     end
#
#     def helper
#       @action_view
#     end
#
#     def expose_locals
#       {}.tap do |e|
#         exposes = self.class.exposes
#         if exposes
#           exposes.each do |name, block|
#             e[name] = instance_eval(&block)
#           end
#         end
#       end
#     end
#
#     def self.expose(name, &block)
#       @exposes ||= {}
#       @exposes[name] = block
#     end
#
#     def self.exposes
#       @exposes
#     end
#
#     private
#
#     def define_locals_accessors(locals)
#       (class << self; self; end).class_eval do
#         locals.each do |k, v|
#           define_method(k) { v }
#         end
#       end
#     end
#   end
# end
