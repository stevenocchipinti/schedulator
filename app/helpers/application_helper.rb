module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    partial_name = association.to_s.singularize

    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(partial_name, f: builder)
    end

    render partial: "link_to_add_field", locals: {
      id: id,
      fields: fields.gsub("\n", ""),
      partial_name: partial_name
    }
  end
end
