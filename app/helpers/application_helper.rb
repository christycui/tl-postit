module ApplicationHelper
  def format_time(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end
    dt.strftime("%A, %b %-d, %Y %l:%M%P %Z")
  end
end
