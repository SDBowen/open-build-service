module MainHelper


  def statistics_limit_form( action, title='' )
    out = ''
    out << start_form_tag( nil, :method => :get )
    out << statistics_limit_select( "#{title} " )
    out << hidden_field_tag( 'more', params[:more] )
    out << image_submit_tag( 'system-search' )
    out << image_tag( 'rotating-tail.gif', :border => 0, :style => 'display: none;', :id => 'spinner' )
    out << end_form_tag
    out << observe_field( :limit, :update => action,
      :url => { :controller => 'main', :action  => action, :more => true },
      :with => "'limit=' + escape(value)", :loading => "Element.show('spinner')",
      :complete => "Element.hide('spinner')"
    )
    return out
  end


  def statistics_limit_select( left_text='', right_text='' )
    out = ''
    out << "#{left_text}"
    out << select_tag( 'limit', options_for_select([['...',10],[25,25],[50,50],[100,100],[250,250],[500,500]]) )
    out << javascript_tag( "document.getElementById('limit').focus();" )
    out << "#{right_text}"
    return out
  end


  def link_to_package_view( item, title='' )
    link_to image_tag( 'package', :border => 0 ) + " #{item.name}",
      { :action => 'view', :controller => 'package',
        :package => item.name, :project => item.project },
      :title => "Package #{title}"
  end


  def link_to_project_view( item, title='' )
    link_to image_tag( 'project', :border => 0 ) + " #{item.name}",
      { :action => 'view', :controller => 'project',
        :project => item.name },
      :title => "Project #{title}"
  end


  def link_to_mainpage
    link_to image_tag( 'start', :border => 0 ) + ' back to main page...', :controller => 'main'
  end

end
