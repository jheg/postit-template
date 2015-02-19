module Voteable
  
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      my_class_method
    end
  end

  module InstanceMethods
    def total_votes
      up_votes - down_votes
    end

    def up_votes
      self.votes.where(vote: true).count
    end

    def down_votes
      self.votes.where(vote: false).count
    end
  end

  module ClassMethods
    def my_class_method
      puts "This is a class method"
    end
  end

end