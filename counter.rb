class Video
    attr_accessor :topic_ids, :views_count
    def initialize(args)
        @id = args['id']
        @views_count = args['views_count']
        @likes_count = args['likes_count']
        @dislikes_count = args['dislikes_count']
        @topic_ids = args['topic_ids']
    end
end
