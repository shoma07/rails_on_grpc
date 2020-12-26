# frozen_string_literal: true

Rails.application.routes.draw do
  Rails.application.config.x.grpc_services.each do |service|
    service.rpc_descs.each_value do |rpc_desc|
      post "#{service.service_name}/#{rpc_desc.name}",
           to: "#{service.module_parent_name.underscore}##{rpc_desc.name.to_s.underscore}"
    end
  end
end
