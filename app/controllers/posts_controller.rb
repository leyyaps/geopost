class PostsController < ApplicationController

	before_action :find_post, except: [:index, :new, :create]

  def index
  	# ActiveRecord gives us queries like Post.all. See app/models/post.rb
  	if params[:featured].present? and params[:featured] == "true"
  	# Get only the featured posts
  		@posts = Post.where(is_featured: true)
  	
  	else
  	# GET all the posts from the posts table in the DB
  		@posts = Post.order("created_at DESC")
  end
	end
  def show
    @comments = @post.comments
  	# Get the post with the id from the URL
  	# @post = Post.find(params["id"])
  end
#  ----------------------------------------------
  def new
  	@post = Post.new

  end
# The new form gets submitted to the create action
  def create
  	@post = Post.new(post_params)

  	if @post.save
  		flash[:success] = "Thanks for posting! Now get a life!"
  	redirect_to root_path
  else
  		flash[:error] = "Woopsie Daisy, something went wrong. Please try again."
  		render :new
  	end
  end
#  ----------------------------------------------
  def edit
  	# @post = Post.find(params[:id])
  end
# The edit form gets submitted to the update action
  def update
  	# @post = Post.find(params[:id])
  	if @post.update(post_params)
  		flash[:success] = "Updated '#{@post.title}'."
  		redirect_to post_path(@post)
  	else
  		flash[:error] = ""
  		render :edit
  	end
  end
#  ---------------------------------------------- 
	def destroy
		# @post = Post.find(params[:id])
		@post.destroy
		redirect_to root_path

	end

	private
	def post_params
		# allow attributes that I trust, ignore any unsanctioned data
		params.require(:post).permit(:title, :body, :is_published, :is_featured)
	end

	def find_post
		@post = Post.find(params[:id])
	end

end
