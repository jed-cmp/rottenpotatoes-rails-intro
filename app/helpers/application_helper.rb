module ApplicationHelper
    def highlight(selected)
        if selected
           'hilite'
        end
    end

    def sortable_column(column)
        if column == 'title'
            link_to 'Movie Title', movies_path(:ratings => params[:ratings], :sort => column), id: 'title_header'
        elsif column == 'release_date'
            link_to 'Release Date', movies_path(:ratings => params[:ratings], :sort => column), id: 'release_date_header'
        end
    end
end
