# -*- encoding : utf-8 -*-
module TreeHelper

  def init_tree_js(link_title = '')
    js = '$(document).ready(function(){
            $.fn.zTree.init($("#" + treeOpts.current_tree), ztreeSetting, treeOpts.zNodes);
          '
    js += '$(".new_btn").click(function (){
             $(".menu_content").load(treeOpts.url + "new");
               return false;
             })' unless link_title.empty?
    js += '});'
    javascript_tag(js)
  end

  def tree_content(link_title = '', opts = {})
    if link_title.empty?
      header = ''.html_safe
    else
      title_link = link_to link_title, opts[:url], :class => "btn btn-small btn-primary new_btn"
      header = content_tag :div, title_link + tip_messages, class: 'page-header'
    end
    right_content = content_tag :div, '', class: "menu_content fl"
    list_content = content_tag :div, tree_list(link_title) + right_content

    content_tag(:section, header + list_content, id: 'tables')
  end

  def tree_list(link_title = '')
    ul = content_tag :ul, '', id: 'tree-list', class: 'menus_ztree ztree small', style: "width:260px; overflow:auto;"
    init_tree_js(link_title) +  content_tag(:div, ul, class: 'ground fl')
  end

  def tip_messages
    content_tag(:span, "操作成功", class: 'success hide') + 
    content_tag(:span, "操作失败，原因：", class: 'failed hide')
  end

  def ztree_settings(opts = {})
    default_settings = {
      view: {
        addHoverDom: "addHoverDom",
        removeHoverDom: "removeHoverDom",
        selectedMulti: false,
      },
      check: {
        #enable: true
      },
      edit: {
        enable: true,
        editNameSelectAll: true,
        showRemoveBtn: true,
        showRenameBtn: true,
        drag: {
          isCopy: true,
          isMove: true,
          prev: true,
          inner: false,
          next: true,
        }
      },
      data: {
        simpleData: {
          enable: true
        }
      },
      callback: {
        beforeDrag: "beforeDrag",
        beforeDrop: "beforeDrop",
        beforeEditName: "beforeEditName",
        beforeRemove: "beforeRemove",
        onDrop: "onDrop",
        onRemove: "onRemove",
        beforeRename: "beforeRename",
        onRename: "onRename",
        onClick: "onClick",
      }
    }
    default_settings.merge(opts).to_json.html_safe.delete("\"").gsub("=>",": ")
  end
end

