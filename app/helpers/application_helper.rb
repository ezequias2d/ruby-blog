module ApplicationHelper
  def custom_paginate_renderer
    Class.new(WillPaginate::ActionView::LinkRenderer) do
      def container_attributes
        {class: "blog-pagination"}
      end

      def page_number(page)
        if page == current_page
          "<li class=\"cyan active\">"+link(page, page, rel: rel_value(page))+"</li>"
        else
          "<li class=\"waves-effect\">"+link(page, page, rel: rel_value(page))+"</li>"
        end
      end

      def previous_page
        num = @collection.current_page > 1 && @collection.current_page - 1
        if num == 0
          previous_or_next_page(num, "Newer", "btn btn-outline-secondary disabled")
        else
          previous_or_next_page(num, "Newer", "btn btn-outline-secondary")
        end
      end

      def next_page
        num = @collection.current_page < total_pages && @collection.current_page + 1
        if @collection.total_pages == num
          previous_or_next_page(num, "Older", "btn btn-outline-primary disable")
        else
          previous_or_next_page(num, "Older", "btn btn-outline-primary")
        end
      end
    end
  end
end
