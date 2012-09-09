require 'grape'

module Blog
  module Entities
    
    class Weblog < Grape::Entity
      expose :title, :documentation => {:type => "string", :desc => "The title of the weblog"}
      expose :description, :documentation => {:type => "string", :desc => "A description of the weblog"}
    end
    
    class Post < Grape::Entity
      expose :title, :documentation => {:type => "string", :desc => "The title of the weblog"}
      expose :body, :documentation => {:type => "string", :desc => "The body of the post"}
    end
    
    class Comment < Grape::Entity
      expose :name, :documentation => {:type => "string", :desc => "The name of the commentor"}
      expose :body, :documentation => {:type => "string", :desc => "The body of the post"}
    end
  end
end