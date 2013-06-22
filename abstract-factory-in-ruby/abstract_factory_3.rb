# Abstract Factory 3
#
class Repository3
  attr_reader :app, :namespace

  def initialize(app, type)
    raise ArgumentError unless [:in_memory, :backend].include?(repository_type)

    @app = app
    @namespace = "Repositories::#{type.camelize}".constantize
  end

  def meta_messages
    namespace::MetaMessagesRepository
  end

  def video_streams
    namespace::VideoStreamsRepository
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

      class InMemory < VideoStreamsRepository
        # реализация методов абстрактного класса
      end

      class Backend < VideoStreamsRepository
        # реализация методов абстрактного класса
      end

    end

  end

end
