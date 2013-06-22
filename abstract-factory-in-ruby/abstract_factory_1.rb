# encoding: utf-8

# Abstract Factory 1
#
class Repository
  attr_reader :factory

  def initialize(app, type)
    case type
    when :in_memory
      RepositoryFactory::InMemory.new(app)
    when :backend
      RepositoryFactory::Backend.new(app)
    else
      raise ArgumentError
    end
  end

  # -- factories --

  class RepositoryFactory
    def initialize(app)
      @app = app
    end

    def meta_messages
      raise NotImplementedError
    end

    def video_streams
      raise NotImplementedError
    end

    class InMemory < RepositoryFactory
      # реализация методов абстрактного класса
    end

    class Backend < RepositoryFactory
      # реализация методов абстрактного класса
    end

  end

  # -- families --

  module Repositories
    class MetaMessagesRepository
      def get_all
        raise NotImplementedError
      end

      class InMemory < MetaMessagesRepository
        # реализация методов абстрактного класса
      end

      class Backend < MetaMessagesRepository
        # реализация методов абстрактного класса
      end

    end

    class VideoStreamsRepository
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
