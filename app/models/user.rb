class User < ActiveRecord::Base
  enum role: [:user, :pro, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, presence: true


  def allowed_strategies
    if self.user?
      Strategy.Gratuita + Strategy.Miembros
    elsif self.pro? || self.admin?
      Strategy.all
    end
  end

end
