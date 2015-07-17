module PageVisits
  include ActionView::Helpers::TextHelper
  extend ActiveSupport::Concerns

  public
  
  def page_visit_show 
  	do_counter
  	if @counter>=5 
  		pluralize @counter, 'time', 'times' + ' visited'
    end
  end

  private
  
    def do_counter
      if session[:counter].nil? then reset_counter else @counter = session[:counter] = session[:counter]+1 end
    end

    def reset_counter
      session[:counter] = 1
    end
end