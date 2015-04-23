class LandingPageController < ApplicationController
layout "landing"

  def landing
    @strategies=Strategy.all
    @strategiesOrdered = @strategies.order('created_at DESC').limit(20)
    @strategiesAscOrdered = @strategies.order('created_at ASC')
    @authors = Author.all
  end

  def about
  end

  # def pricing_plans
  # end

  def wire_explanation
  end

  def cancelar_cuenta
  end


   def landing_corporate
    @strategies=Strategy.all
    @strategiesOrdered = @strategies.order('created_at DESC').limit(20)
    @strategiesAscOrdered = @strategies.order('created_at ASC')
    @authors = Author.all
  end

  def landing_universities
    @strategies=Strategy.all
    @strategiesOrdered = @strategies.order('created_at DESC').limit(20)
    @strategiesAscOrdered = @strategies.order('created_at ASC')
    @authors = Author.all
  end

  def privacyandterms
  end
end
