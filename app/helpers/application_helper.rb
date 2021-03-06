# encoding: utf-8
module ApplicationHelper
  def site_intro
    append_notification_count(Siteconf.site_name + ' - ' + Siteconf.short_intro)
  end

  # 加载js: <%= javascripts 'my1','my2' %>
  def javascripts(*args)
    javascript_include_tag(*args)
  end

  def append_notification_count(title)
    return title if @unread_count == 0
    title + " (#{@unread_count})"
  end

  def title
    return @full_title if @full_title.present?
    add_title_item @title if @title.present?
    @title_items.join(' - ')
  end

  def link_to_blank(*args, &block)
    if block_given?
      args = [(args.first || {}), (args.second || {}).merge(:target => '_blank')]
    else
      args = [(args.first || {}), (args.second || {}), (args.third || {}).merge(:target => '_blank')]
    end
    link_to(*args, block)
  end

  def include_my97
    javascripts "/plugins/My97DatePicker/WdatePicker.js"
  end

  def label_tag_html(text, options = {})
    options[:style] = 'info' unless options[:style]
    "<span title='#{options[:title]}' class='label label-#{options[:style]}'>#{text}</span>".html_safe
  end

  # 温馨提示
  def tips(*args)
    content_tag(:div, :class => "alert alert-info") do
      content_tag(:h5, "小贴士：", :class => "alert-heading") <<
        content_tag(:ol) do
          args.map{|arg| concat content_tag(:li, arg) }
        end
    end
  end

  # 生成列表序号
  def index_no(index, per = 30)
    params[:page] ||= 1
    (params[:page].to_i - 1) * per + index + 1
  end

  def options_html(survey_question)
    case survey_question.qtype
    when '1' # 文本
      (text_area_tag("q[#{survey_question.id}]")).html_safe
    end
    # (survey_question.title).html_safe
  end

  def question_label(survey_question, index, content = "", nofify_link = "")
    content_tag(:div, "#{nofify_link} #{index}、#{survey_question.title}：#{content}".html_safe, :class => :question_title)
  end
  
  # survey[survey_questions_attributes][5][title]
  def question_html(survey_question, survey_user_answer, index)
   # survey_question = survey_user_answer.survey_question
    survey_user_answer ||= SurveyUserAnswer.new(:answers => "")
    nofify_link = ""  #(current_user.can_manage_site? && !survey_user_answer.new_record?) ? link_to("提醒更新", notify_admin_surveys_path(:survey_user_answer_id => survey_user_answer.id), :method => :post , :class => "btn btn-small btn-warning") : ""
    option_id = "q[#{survey_question.id}]"
    content_tag(:div, :class => "cell oa") do
      label = question_label(survey_question, index, nofify_link)
      content = ""
      case survey_question.qtype
      when '1' # 文本
        label = question_label(survey_question, index, "#{text_field_tag(option_id, survey_user_answer.answers,:type => '', :class=>'underline_input')}") + nofify_link
      when '0' # 多选
        content = content_tag(:div, :class => :question_options) do
          content_tag(:ul) do 
            survey_question.options.split.collect{|option| concat(content_tag(:li, check_box_tag(option_id+'[]', option, survey_user_answer.answers.include?(option)).concat(content_tag(:span, option, :class => "vm ml3")), :class => "m3_10"))}
          end
        end
      when '2' # 单选
        content = content_tag(:div, :class => :question_options) do
          content_tag(:ul) do 
            survey_question.options.split.collect{|option| concat(content_tag(:li, radio_button_tag(option_id, option, survey_user_answer.answers == option ).concat(content_tag(:span, option, :class => "vm ml3")), :class => "m3_10"))}
          end
        end
      when '3' # 日期
        label = question_label(survey_question, index, "#{text_field_tag(option_id, survey_user_answer.answers, :class => 'my97_date')}") + nofify_link
      when '4' # 图片
        label = question_label(survey_question, index, "#{file_field_tag(option_id, :class => 'question_file')}") + nofify_link
        label += image_tag(survey_user_answer.photos.first.file.url) unless survey_user_answer.new_record?
      end
      label + content
    end.html_safe
  end

  def add_title_item(item)
    @title_items.unshift item unless request.format.to_sym == :js
  end

  def build_navigation(items, class_name='gray')
    items.unshift(link_to(Siteconf.site_name, root_path, :class => :rabel))
    items.join(' <span class="chevron">&nbsp;›&nbsp;</span> ').html_safe
  end

  def add_breadcrumb(item)
    @breadcrumbs << item
  end

  def build_breadcrumbs
    result_html =
      case @breadcrumbs.length
        when 1
          ''
        else
          @breadcrumbs.join('&nbsp;›&nbsp;')
        end
    result_html.html_safe
  end

  def build_admin_navigation(items, class_name='fade')
    items.unshift(link_to('管理后台', admin_root_path))
    build_navigation(items, class_name)
  end

  def edit_topic_navigation(node, topic)
    build_navigation([
      link_to(node.name, go_path(node.key)),
      link_to(topic.title, t_path(topic.id)),
      '编辑'
    ], 'bigger')
  end

  def format_page(page_content)
    if Siteconf.allow_markdown_in_pages?
      parse_markdown(page_content)
    else
      format_content(page_content)
    end
  end

  def format_topic(topic_content)
    if Siteconf.allow_markdown_in_topics?
      parse_markdown(topic_content)
    else
      format_content(topic_content)
    end
  end

  def format_comment(comment_content)
    if Siteconf.allow_markdown_in_comments?
      parse_markdown(comment_content)
    else
      format_content(comment_content)
    end
  end

  def format_content(text)
    begin
      text = Rabel::LinkEmailParser.parse_url(Rabel::Base.h(text)) do |link|
        Rabel::Base.smart_url(link)
      end
      text = Rabel::LinkEmailParser.parse_email(text) do |address|
        Rabel::Base.protect_at_symbol(address)
      end

      nl_to_br(Rabel::Base.decode_symbols(Rabel::Base.make_mention_links(text))).html_safe
    rescue
      h(text)
    end
  end

  def nl_to_br(text)
    text.gsub("\r\n", "<br/>").gsub("\r", "<br/>").gsub("\n", "<br/>")
  end

  def parse_markdown(text)
    begin
      nl_to_br(Rabel::Base.decode_symbols(
        Rabel::Base.make_mention_links(
          MarkdownConverter.convert(text)
        )
      )).html_safe
    rescue Exception => e
      h(text)
    end
  end

  def flash_messages
    @flash_messages ||= flash.select {|type, message| message.length > 0}
  end

  def show_flash_messages
    result = []
    flash_messages.each do |type, message|
      result << content_tag(:span, message, :class => "#{type}-message")
    end
    result.join('<br/>').html_safe
  end

  def show_mobile_messages
    if flash_messages.any?
      content_tag(:div, show_flash_messages, :class => :cell)
    end
  end

  def search_engines
    {
      :google => 'http://www.google.com.hk/search?q=',
      :bing => 'http://cn.bing.com/search?q=',
      :baidu => 'http://www.baidu.com/s?wd='
    }
  end

  def search_engine_url
    search_engines[Siteconf.default_search_engine.to_sym]
  end

  def large_avatar(user)
    image_tag user.avatar.url, :class => :large_avatar, :alt => "#{user.nickname} large avatar"
  end

  def medium_avatar(user)
    image_tag user.avatar.url(:medium), :class => :medium_avatar, :alt => "#{user.nickname} medium avatar"
  end

  def mini_avatar(user)
    image_tag user.avatar.url(:mini), :class => :mini_avatar, :alt => "#{user.nickname} mini avatar"
  end

  def hash_key_append(hash, key, value)
    if hash[key].present?
      hash[key] = "#{hash[key]} #{value}"
    else
      hash[key] = value
    end
  end

  def nickname_profile_link(nickname, options={})
    options[:title] = nickname
    hash_key_append(options, :class, 'rabel profile_link')

    link_to nickname, member_path(url_encode(nickname)), options
  end

  def user_profile_link(user, options={})
    nickname_profile_link(user.nickname, options)
  end

  def user_profile_avatar_link(user, avatar_size, options={})
    avatar_method = "#{avatar_size}_avatar"

    options[:title] = user.nickname
    hash_key_append(options, :class, 'profile_link')

    link_to(member_path(url_encode(user.nickname)), options) { send(avatar_method, user) }
  end

  def page_real_url(page)
    if page.content.start_with?('http')
      page.content
    elsif page.content.start_with?('/')
      page.content
    else
      page_path(page.key)
    end
  end

  def show_posting_device(comment)
    content_tag(:span, "&nbsp;&nbsp;via #{comment.posting_device}".html_safe, class: :snow) if comment.posting_device.present?
  end

  def auth_admin(error_tip='tips.no_permission')
    redirect_to root_path, :notice => t(error_tip) unless current_user.can_manage_site?
  end

  def cannonical_url(url)
    return url if url.length == 0
    url.start_with?('http://') ? url : 'http://' + url
  end

  def weibo_icon_for(weibo_link)
    if weibo_link.include?('weibo.com')
      'sina_weibo'
    elsif weibo_link.include?('t.qq.com')
      'tx_weibo'
    else
      'twitter'
    end
  end

  def proper_length(str, len)
    if str.size > len
      str[0..len] + ' ...'
    else
      str
    end
  end
end
