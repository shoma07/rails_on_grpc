# frozen_string_literal: true

ActionController::Renderers.add :proto do |obj, _options|
  response.set_header('Content-Type', Mime[:proto])
  obj.respond_to?(:to_proto) ? obj.to_proto : obj.to_s
end
