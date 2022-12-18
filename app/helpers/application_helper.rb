module ApplicationHelper
  APP_NAME = 'RailsDemo'

  def page_title
    base_tittle = APP_NAME
    return base_tittle if @title.blank?
    "#{base_tittle} | #{title}"
  end

  def flash_message(message, klass)
    content_tag(:div, class: "alert alert-#{klass}") do
      concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
      concat raw(message)
    end
  end
end
