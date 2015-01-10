module ApplicationHelper
  def new_field_template(f, association)
    new_object = f.object.send(association).klass.new
    key = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: key) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    render partial: "new_field_template", locals: { key: key, fields: fields }
  end
end
