class PaginationRenderer < WillPaginate::ActionView::LinkRenderer
    def container_attributes
        {class: "pagination"}
    end
    
    def page_number(page)
        if page == current_page
            "<li class='page-item active'>#{link(page, page, class: 'page-link')}</li>"
        else
            "<li class=""page-item"">#{link(page, page, class: 'page-link', rel: rel_value(page))}</li>"
        end
    end

    def gap
        text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
        %(<span class="mr2">#{text}</span>)
    end

    def previous_page
        num = @collection.current_page > 1 && @collection.current_page - 1
        previous_or_next_page(num, @options[:previous_label], 'page-item')
    end

    def next_page
        num = @collection.current_page < total_pages && @collection.current_page + 1
        previous_or_next_page(num, @options[:next_label], 'page-item')
    end

    def previous_or_next_page(page, text, classname)
        if(!page)
            return nil    
        end
        "<li class='page-item'>#{link(text, page, :class => 'page-link')}</li>"
    end
end
