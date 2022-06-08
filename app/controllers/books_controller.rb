class BooksController < ApplicationController



 def new
  @book = Book.new
 end

# 投稿データの保存
 def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book.id),notice:"You have created book successfully."
    else
      @user =current_user
      @books =Book.all
      render :index
    end
 end

    def show
     @book =Book.find(params[:id])
     @user =@book.user
     @books = Book.all
     @book1 = Book.new
    end

    def index
     @books = Book.all
     @user = current_user
     @book = Book.new
    end

    def edit
      @books = Book.all
      @book = Book.find(params[:id])
    if @book.user.id == current_user.id
       render "edit"
    else
       redirect_to books_path

    end
    end


   def update
    @book =Book.find(params[:id])
    @book.update(book_params)

    if @book.update(book_params)
     redirect_to book_path(@book), notice:"Book was successfully updated."
    else
      render :edit
    end
   end

   def destroy
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @book.destroy  # データ（レコード）を削除
    if redirect_to books_path  # 投稿一覧画面へリダイレクト
    @books = Book.all
    end
   end

 private
   def book_params
     params.require(:book).permit(:title, :body)
   end



end
