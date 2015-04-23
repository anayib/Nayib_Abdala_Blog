class Strategy < ActiveRecord::Base
  include Searchable

  has_and_belongs_to_many :authors,    after_add:    [ lambda { |a,c| a.__elasticsearch__.index_document } ],
                                       after_remove: [ lambda { |a,c| a.__elasticsearch__.index_document } ]
  has_and_belongs_to_many :categories, after_add:    [ lambda { |a,c| a.__elasticsearch__.index_document } ],
                                       after_remove: [ lambda { |a,c| a.__elasticsearch__.index_document } ]
  has_many :tips, dependent: :destroy

  enum servicetype: [:Gratuita, :Miembros, :SuscriptoresPro]
  belongs_to :user
  accepts_nested_attributes_for :tips, reject_if: lambda {|attributes| attributes['content'].blank?}, allow_destroy: true
  #scope :search, ->(keyword){where("intro OR title like ?", "%#{keyword}%")if keyword.present?}
  # scope :search, ->(keyword){joins(:authors, :tips, :categories).where("authors.name LIKE :value OR tips.content LIKE :value OR strategies.title LIKE :value OR strategies.intro LIKE :value OR categories.category_name LIKE :value", value: "%#{keyword}%") if keyword.present?}
    #para optimizar la busqueda remplazar el joins por el includes para que precarge las relaciones y se demore menos la busqueda y no deje busquedas por fuesra.
  #writing the search as a scope. :search is the name of the method im creating
  # (keyword) es la forma de pasar parámetros
  #{where(title: keyword} representa el query que quiero hacer
  #the difference btwn the scope and the class method is that the scope always
  #return a collection  so you dont have to put return all after the if because
  #it does authomaticaly.
  #before_save :set_keywords
  #As these queries -OR..OR..-  could become infinite long  ("intro OR title LIKE ?", "%#{keyword}%"
  #it´s better to create a call back before_save
  #to make this callback work, we need to do a migration rails g migration adds_keywords_to_strategies keywords:text
  validates :title, presence: true
  validates :intro, presence: true
  # protected

  #   def set_keywords
  #     self.keywords = [title, intro].map{|p| p.downcase}.join('')
  #     #hay que agregarle self para poder asignarle valores a la propiedad Keyword que agregamos
  #     #con la migración al modelo Strategies
  #     #we need to map all the properties and make sure all are downcase
  #     #para que retorne un array de los mismas palabras en mminúscula
  #     #es lo mismo que haber hecho map(&:downcase)
  #   end



  #se deben guardar los callback methods as protected a menos que sean parte de las APIS públicas



  # def self.search(keyword) #estoy creando un class method por eso el self que recibe como parámetro keyword
  #   if keyword.present?
  #     where(title: keyword)
  #   else
  #     all
  #   end
  # end

  # def self.search(query)
  #   # where(:intro, query) -> This would return an exact match of the query
  # where("intro OR title like ?", "%#{query}%")
  # end

end
