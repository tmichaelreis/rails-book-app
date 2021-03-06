class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def show
    @user = User.find(params[:id])
    @books = @user.books.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = "Account created successfully."
      log_in @user
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def add_book_to_list
    book = Book.find(params[:book_id])
    current_user.add_to_list(book)
    flash[:success] = "#{book.title} has been added to your reading " +
                      "list!"
    redirect_to current_user
  end
  
  def add_book_from_api
    @book = Book.new(book_params)
    if @book.save
      new_book = Book.find(@book.id)
      current_user.add_to_list(new_book)
      flash[:success] = "#{@book.title} has been added to your " + 
                        "reading list!"
      redirect_to current_user
    else
      flash[:warning] = "Book could not be added to the database!"
    end
  end
  
  def remove_book_from_list
    book = Book.find(params[:book_id])
    current_user.remove_from_list(book)
    flash[:success] = "#{book.title} has been removed from your reading list!"
    redirect_to current_user
  end
  
  private 
  
    def book_params
      params.require(:book_params).permit(:title, :author,
                                          :thumbnail_url, :openlibrary_key, 
                                          :first_publish_year)
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation)
    end
    
    # Before filters
    
    # Confirms correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Confirms admin user
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
    
end
