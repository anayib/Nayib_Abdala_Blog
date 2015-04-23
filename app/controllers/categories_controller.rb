class CategoriesController < ApplicationController
  #layout "adminpanel"
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :destroy, :create]
  layout :set_layout_by_role

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    if current_user.admin?
      @category = Category.new
    end
  end

  # GET /categories/1/edit
  def edit
     if current_user.admin?
      render "edit"
    else
      redirect_to strategies_path, notice: "no tienes derechos para editar esta categoria"
    end
  end

  # POST /categories
  # POST /categories.json
  def create

    if current_user.admin?
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    if current_user.admin?
      respond_to do |format|
        if @category.update(category_params)
          format.html { redirect_to @category, notice: 'Category was successfully updated.' }
          format.json { render :show, status: :ok, location: @category }
        else
          format.html { render :edit }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    if current_user.admin?
      @category.destroy
      respond_to do |format|
        format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to strategies_url, notice: 'no tienes derechos para destruir esta categoría'
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
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:category_name)
    end
end
