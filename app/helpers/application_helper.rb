module ApplicationHelper
  def format_time(time)
    time.strftime("%A, %b %-d, %Y")
  end
end
