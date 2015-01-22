module ApplicationHelper
  def prettier_time(dt)
    dt.strftime("%d/%m/%Y %l:%M%P")
  end

  def time_ago(datetime)
    seconds = (Time.now - datetime).to_i
    mm, ss = seconds.divmod(60)            #=> [4515, 21]
    hh, mm = mm.divmod(60)           #=> [75, 15]
    dd, hh = hh.divmod(24)           #=> [3, 3]
    if dd == 0 && hh == 0 && mm == 0
      "%d #{'second'.pluralize(ss)}" % [ss]
    elsif dd == 0 && hh == 0
      "%d #{'minute'.pluralize(mm)} and %d #{'second'.pluralize(ss)}" % [mm, ss]
    elsif dd == 0
      "%d #{'hour'.pluralize(hh)}, %d #{'minute'.pluralize(mm)} and %d #{'second'.pluralize(ss)}" % [hh, mm, ss]
    else      
      "%d #{'days'.pluralize(dd)}, %d #{'hour'.pluralize(hh)}, %d #{'minute'.pluralize(mm)} and %d #{'second'.pluralize(ss)}" % [dd, hh, mm, ss]      
    end
  end

  def url_fixer(str)
    str.start_with?('http://') ? str : "http://#{str}"
  end
end
