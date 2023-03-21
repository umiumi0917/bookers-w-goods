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
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @book_comment = BookComment.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "Book was successfully created "
       redirect_to book_path(@book.id)
    else
      @user = current_user
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
    if @book.user == current_user
        render "edit"
    else
        redirect_to books_path
    end
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

end