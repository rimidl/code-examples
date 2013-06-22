# Abstract Factory 4
#
class Repository
  attr_reader :app, :namespace

  def initialize(app, type)
    @app = app
    @namespace = "Repositories::#{type.camelize}".constantize
  rescue NameError
    raise ArgumentError
  end

  def method_missing(meth_name, *args)
    namespace.const_get("#{meth_name.camelize}Repository")
  end

  # -- families --
  module Repositories

    module InMemory

      class MetaMessagesRepository < AbstractMetaMessagesRepository
        # реализация методов абстрактного класса
      end

      class VideoStreamsRepository < AbstractVideoStreamsRepository
        # реализация методов абстрактного класса
      end

    end

    module Backend

      class MetaMessagesRepository < AbstractMetaMessagesRepository
        # реализация методов абстрактного класса
      end

      class VideoStreamsRepository < AbstractVideoStreamsRepository
        # реализация методов абстрактного класса
      end

    end

    class AbstractMetaMessagesRepository
      def get_all
        raise NotImplementedError
      end
    end

    class AbstractVideoStreamsRepository
      def get
        raise NotImplementedError
      end
    end

  end

end
