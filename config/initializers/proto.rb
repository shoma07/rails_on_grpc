# frozen_string_literal: true

Rails.application.config.x.grpc_services = Dir[
  Rails.root.join('lib/proto/**/*.rb')
].sort.filter_map do |file|
  const = file.sub(/\A#{Rails.root.join('lib\/')}/, '')
              .sub(/(_services)?_pb\.rb\z/, '').camelize
  require file unless Object.const_defined?(const)

  service_name = "#{const}::Service"
  Object.const_get(service_name) if Object.const_defined?(service_name)
end
