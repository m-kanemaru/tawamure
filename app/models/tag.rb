class Tag < ApplicationRecord
    belongs_to :post
    
    def self.looks(word)
        Tag.where("name LIKE?","%#{word}%")
    end
    
end
