require 'json'
module Counter
    def input
        JSON.parse(File.read('videos.json'))
    end

    def videos
        input.map {|e| Video.new(e)}
    end

    def most_views
        count = Hash.new(0)
        videos.each do |v|
            v.topic_ids.each {|topic_id| count[topic_id] += v.views_count if not v.views_count.nil?}
        end
        count
    end

    def sorted_most_views
        most_views.sort_by {|k,v| -v}.to_h
    end

    def output
        JSON.pretty_generate(
            "Most Viewed Topics" => sorted_most_views.map {|k, v| {
                "topic_id" => k, 
                "views" => v}
            }
        )
    end

    def write
        File.open("output.json", "w") {|file| file.write(output)}
    end
end

class Video
    extend Counter
    attr_accessor :topic_ids, :views_count
    def initialize(args)
        @id = args['id']
        @views_count = args['views_count']
        @likes_count = args['likes_count']
        @dislikes_count = args['dislikes_count']
        @topic_ids = args['topic_ids']
    end
end


Video.write