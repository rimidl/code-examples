# Abstract Factory 2
#
class Repository2
  attr_reader :app, :type

  def initialize(app, type)
    raise ArgumentError unless [:in_memory, :backend].include?(repository_type)

    @app = app
    @type = type
  end

  def meta_messages
    get_repository_for(:meta_messages).new(app)
  end

  def video_streams
    get_repository_for(:video_streams).new(app)
  end

  private

  def get_repository_for(data_type)
    raise ArgumentError unless [:meta_messages, :video_streams].include?(data_type)

    "Repositories::#{data_type.camelize}Repository::#{type.camelize}".constantize
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

    class MetaMessagesRepository
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
