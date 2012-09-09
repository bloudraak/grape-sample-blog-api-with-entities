require 'grape'

module Blog

  class API < Grape::API
  
    # default format if no accept header is specified
    format :json
  
    resource :weblogs do
    
      get do
        @weblogs = Weblog.all
        present @weblogs, with: Blog::Entities::Weblog
      end
      
      get ':id' do
        @weblog = Weblog.find(params[:id])
        present @weblog, with: Blog::Entities::Weblog
      end
      
      get ':id/posts' do
        @weblog = Weblog.find(params[:id])
        @posts = @weblog.posts
        present @posts, with: Blog::Entities::Post
      end
      
      post ':id/posts' do
        @weblog = Weblog.find(params[:id])
        @post = Post.new
        @post.title = params[:title] if params[:title]
        @post.body = params[:body] if params[:body]
        @weblog.posts << @post
        
        status 201
        present @post, with: Blog::Entities::Post
      end
      
      delete ':id/posts' do
        @weblog = Weblog.find(params[:id])
        @weblog.posts.clear
      end
      
      post do
        @weblog = Weblog.new
        @weblog.title = params[:title] if params[:title]
        @weblog.description = params[:description] if params[:description]
        @weblog.save 
        
        status 201
        present @weblog, with: Blog::Entities::Weblog
      end
      
      put ':id' do
        @weblog = Weblog.find(params[:id])
        @weblog.title = params[:title] if params[:title]
        @weblog.description = params[:description] if params[:description]
        @weblog.save
        
        present @weblog, with: Blog::Entities::Weblog
      end
      
      delete do
        Weblog.destroy_all()
      end
    
      delete ':id' do
        Weblog.destroy(params[:id])
      end
    
    end 
    
    resource :posts do
    
      get do
        @posts = Post.all
        present @posts, with: Blog::Entities::Post
      end
      
      get ':id' do
        @post = Post.find(params[:id])
        present @post, with: Blog::Entities::Post
      end
      
      get ':id/comments' do
        @post = Post.find(params[:id])
        @comments = @post.comments
        present @comments, with: Blog::Entities::Comment
      end
      
      delete ':id/comments' do
        @post = Post.find(params[:id])
        @post.comments.clear
      end
      
      post ':id/comments' do
        @post = Post.find(params[:id])
        @comment = Comment.new
        @comment.name = params[:name] if params[:name]
        @comment.name = params[:body] if params[:body]
        @post.comments << @comment
        
        status 201
        present @comment, with: Blog::Entities::Comment
      end
      
      delete ':id' do
        Post.destroy(params[:id])
      end
      
      put ':id' do
        @post = Post.find(params[:id])
        @post.title = params[:title] if params[:title]
        @post.body = params[:body] if params[:body]
        @post.save
       
        present @post, with: Blog::Entities::Post
      end
      
      delete do
        Post.destroy_all()
      end
      
    end
    
    resource :comments do
      get do
        @comments = Comment.all
        present @comments, with: Blog::Entities::Comment
      end
      
      get ':id' do
        @comment = Comment.find(params[:id])
        present @comment, with: Blog::Entities::Comment
      end
      
      put ':id' do
        @comment = Comment.find(params[:id])
        @comment.name = params[:name] if params[:name]
        @comment.body = params[:body] if params[:body]
        
        present @comment, with: Blog::Entities::Comment
      end
      
      delete ':id' do
        Comment.destroy(params[:id])
      end
      
      delete do
        Comment.destroy_all()
      end      
    end
      
  end

end

