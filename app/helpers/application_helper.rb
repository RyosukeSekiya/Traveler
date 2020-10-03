module ApplicationHelper
  def datetime(datetime)
    return unless datetime

    datetime.strftime('%Y/%m/%d %H:%M')
  end
end
