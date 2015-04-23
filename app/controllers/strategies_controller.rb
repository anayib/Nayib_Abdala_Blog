class StrategiesController < ApplicationController

  before_action :set_strategy, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :destroy, :create]
  layout :set_layout_by_role

  # GET /strategies
  # GET /strategies.json
  def index
    @strategies = Strategy.search(params[:keyword]).results

    # Loads all strategies if there was no keyword matches
    if params[:keyword].present? && @strategies.size == 0
      flash[:notice] = 'Intenta una nueva búsqueda con palabras relacionadas a lo que quieres aprender hoy.'
      @strategies = Strategy.all
    end

    # @strategies = Strategy.order("date DESC")
    # @categories = Categories.all
    #
    # if params[:search].present?
    #   @strategies = Strategy.search(params[:search])
    # else
    #   @strategies = Strategy.all
    # end

  end

  # GET /strategies/1
  # GET /strategies/1.json
  def show
    # if user_signed_in? && current_user.user?
    #   allowed_strategies = Strategy.free + Strategy.just_members
    #   #allowed_strategies += Strategy.just_members  esto es lo mismo que el renglón anterior, le suma lo que venia antes
    #   #@startregies = Strategy.where(servicetype: 'just_members') esto si fuera string y no hubiera creado enum
    # elsif user_signed_in? && current_user.pro?
    #   allowed_strategies = Strategy.all
    #   #allowed_strategies = Strategy.where(servicetype: 'pro_members') esto si fuera string y no hubiera creado enum
    # else
    #   allowed_strategies = Strategy.free
    # end

    if user_signed_in?
      allowed_strategies = current_user.allowed_strategies
    else
      allowed_strategies = Strategy.Gratuita
    end

    if allowed_strategies.include?(@strategy)
      render :show
    else
      if @strategy.Miembros?
      redirect_to new_user_registration_path, alert: "Esta estrategia es sólo para miembros suscritos. Suscríbete ahora para obtener acceso completo a las estrategias gratuitas y de sólo miembro y empieza a tomar decisiones acertadas de negocio"
      else
      redirect_to suscriptors_new_path, alert: "Esta estrategia es sólo para miembros Pro. Necesitas suscribirte al servicio Pro para acceder a esta estrategia. Suscríbete ahora para obtener acceso completo a las estrategias que te ayudarán a ser más productivo en tu trabajo"
      end
    end


  end

  # GET /strategies/new
  def new
    if current_user.admin?
      @strategy = Strategy.new
      2.times {@strategy.tips.build}
    else
      redirect_to strategies_path, alert: "no tienes derechos para crear estrategias"
    end

  end

  # GET /strategies/1/edit
  def edit
    if current_user.admin?
      render "edit"
    else
      redirect_to strategies_path, notice: "no tienes derechos para editar esta estrategia"
    end
  end

  # POST /strategies
  # POST /strategies.json
  def create

  if current_user.admin?
    @strategy = Strategy.new(strategy_params)

    respond_to do |format|
      if @strategy.save
        format.html { redirect_to @strategy, notice: 'Strategy was successfully created.' }
        format.json { render :show, status: :created, location: @strategy }
      else
        format.html { render :new }
        format.json { render json: @strategy.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  # PATCH/PUT /strategies/1
  # PATCH/PUT /strategies/1.json
  def update

    if current_user.admin?
      respond_to do |format|
        if @strategy.update(strategy_params)
          format.html { redirect_to @strategy, notice: 'Strategy was successfully updated.' }
          format.json { render :show, status: :ok, location: @strategy }
        else
          format.html { render :edit }
          format.json { render json: @strategy.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /strategies/1
  # DELETE /strategies/1.json
  def destroy
    if current_user.admin?
      @strategy.destroy
      respond_to do |format|
        format.html { redirect_to strategies_url, notice: 'Strategy was successfully destroyed.' }
      end
    else
      redirect_to strategies_url, notice: 'no tienes derechos para destruir esta estrategia'
    end
  end

  def set_layout_by_role

    if user_signed_in? && current_user.admin?
         "adminpanel"
       else
         "application"
    end
  end

  def contact
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_strategy
      @strategy = Strategy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def strategy_params
      params.require(:strategy).permit(:title, :intro, :date, :user_id, :search, :servicetype, author_ids: [], category_ids: [], tips_attributes: [:id, :tip_title, :content, :_destroy, :strategy_id])
    end
end
