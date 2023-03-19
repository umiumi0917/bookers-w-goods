class BooksController < ApplicationController
  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def new
    @book = Book.new
  end

  def show
    @user = current_user
    @book = Book.find(params[:id])
    @book_new = Book.new
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "Book was successfully created "
       redirect_to book_path(@book.id)
    else
      @books = Book.all
      flash[:notice] = ' errors prohibited this obj from being saved:'
        render "index"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully deleted "
    redirect_to books_path
  end
  
  def edit
    	@book = Book.find(params[:id])
    end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
     if @book.save
      flash[:notice] = "Book was successfully updated "
      redirect_to book_path(@book.id)
     else
       @books = Book.all
       flash[:notice]= ' errors prohibited this obj from being saved:'
       render :edit
     end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
   end

end