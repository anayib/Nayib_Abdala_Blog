module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |tip|
      render(association.to_s.singularize + "_fields", t: tip)
    end
    link_to(name, '#', class: "Add_tip", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def highlighted_title(strategy)
    strategy.try(:highlight).try(:title) ? strategy.highlight.title[0].html_safe : strategy.title
  end

  def highlighted_intro(strategy)
    strategy.try(:highlight).try(:intro) ? strategy.highlight.intro[0].html_safe : strategy.intro.html_safe
  end

  # def truncate(text, options = {}, &block)
  #     if text
  #       length  = options.fetch(:length, 80)
  #       content = text.truncate(length, options)
  #       # content = options[:escape] == false ? content.html_safe : ERB::Util.html_escape(content)
  #       # content << capture(&block) if block_given? && text.length > length
  #       content
  #     end
  # end
end
