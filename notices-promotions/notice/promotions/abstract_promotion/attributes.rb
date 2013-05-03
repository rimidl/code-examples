module Notice::Promotions
  module AbstractPromotion::Attributes

    def self.included(base)
      base.extend ClassMethods
    end

    class Attribute
      attr_reader :object, :attr_name

      def initialize(object, attr_name)
        @object = object
        @attr_name = attr_name
      end

      def write(val)
        @object.send(:write_attribute, @attr_name, val)
      end

      def read
        @object.send(:read_attribute, @attr_name)
      end
    end

    module ClassMethods

      def uses_attr(name, options = {})
        options.assert_valid_keys(:from, :source)

        src_object_name = options[:from]
        src_attr_name = options.fetch(:source, name)

        @attributes ||= {}
        @attributes[name] = src_attr_name

        define_method "attr_#{name}" do
          Attribute.new(send(src_object_name), src_attr_name)
        end
      end
      private :uses_attr

    end

  end
end
