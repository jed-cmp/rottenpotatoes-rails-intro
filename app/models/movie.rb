class Movie < ActiveRecord::Base

    scope :filter_by_rating, -> (rating) { where rating: rating }

    def self.get_all_ratings
        @all_ratings = ['G', 'PG', 'PG-13', 'R']
    end
end
