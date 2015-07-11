module ApplicationHelper
  
  #Returns full app title if needed
  def full_title(page_title = '')
    base_title = "Book Club"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
