class AuthorsController < ApplicationController
  #layout "adminpanel"
  before_action :set_author, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :destroy, :create]
  layout :set_layout_by_role

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.all
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
  end

  # GET /authors/new
  def new
      if current_user.admin?
        @author = Author.new
      else
       redirect_to strategies_path, alert: "no tienes derechos para crear autores"
      end
  end

  # GET /authors/1/edit
  def edit
     if current_user.admin?
      render "edit"
    else
      redirect_to strategies_path, notice: "no tienes derechos para editar este autor"
    end
  end

  # POST /authors
  # POST /authors.json
  def create
    if current_user.admin?
      @author = Author.new(author_params)

      respond_to do |format|
        if @author.save
          format.html { redirect_to @author, notice: 'Author was successfully created.' }
          format.json { render :show, status: :created, location: @author }
        else
          format.html { render :new }
          format.json { render json: @author.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
  def update
    if current_user.admin?
      respond_to do |format|
        if @author.update(author_params)
          format.html { redirect_to @author, notice: 'Author was successfully updated.' }
          format.json { render :show, status: :ok, location: @author }
        else
          format.html { render :edit }
          format.json { render json: @author.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    if current_user.admin?
      @author.destroy
      respond_to do |format|
        format.html { redirect_to authors_url, notice: 'Author was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to strategies_url, notice: 'no tienes derechos para destruir esta estrategia'
    end
  end

  def set_layout_by_role
    if current_user.admin?
         "adminpanel"
       else
         "application"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def author_params
      params.require(:author).permit(:name, :bio, :image_url, :date, :image)
    end
end
