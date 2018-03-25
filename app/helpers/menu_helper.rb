require 'yaml'

module MenuHelper

  # Se arma una lista de <li> de acuerdo a los datos del menus.yml
  def main_menu
    menu = MENU_DATA['menu']
    html = ""
    menu.each do |item, options|
      active = is_active_main_menu?(options['active_menu'])
      if(item == "audit" || item == "reports")
        html << "<li class='treeview #{active ? 'active' : ''}'>"
        html << "<a href='#{options['url']}'><i class='fa fa-#{options['icon']}'></i><span>#{options['text']}</span><span class='pull-right-container'></span></a>"
      else
        html << "<li class='treeview #{active ? 'active' : ''}'>"
        html << "<a href='#'><i class='fa fa-#{options['icon']}'></i><span>#{options['text']}</span><span class='pull-right-container'><i class='fa fa-angle-left pull-right'></i></span></a>"
        html << build_submenus(options['submenus'])
      end
      html << "</li>"
    end
    html.html_safe
  end

  def build_submenus(submenus)
      html = "<ul class='treeview-menu'>"
      submenus.each do |item, options|
        active = is_active_submenu_menu?(options['active_submenu'])
        html << "<li class='#{active ? 'active' : ''}'><a href='#{options['url']}'><i class='active fa fa-#{options['icon']}'></i><span>#{options['text']}</span></a></li>"
      end
      html << "</ul>"
      html.html_safe
  end

  def is_active_main_menu?(active_indicator)
    @menu_setup[:main_menu] == active_indicator
  end

  def is_active_submenu_menu?(active_indicator)
    @menu_setup[:side_menu] == active_indicator
  end

end
