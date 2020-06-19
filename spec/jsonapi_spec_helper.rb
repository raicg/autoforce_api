module JsonapiSpecHelper
  def to_jsonapi(object)
    body = {
      "data": {
        "type": object.class.name.pluralize,
        "attributes": object.attributes.delete_if { |key, value| value.nil? }.transform_keys { |key| key.sub('_', '-') }
      }
    }.to_json
    
  end
end