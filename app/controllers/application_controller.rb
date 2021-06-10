# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  private

  # @return [ActionController::Parameters]
  def decode_params
    @decode_params ||= ActionController::Parameters.new(
      rpc_desc.input.decode(request.body.read.sub(/\A(\x00)*\x02/, '')).to_h
    ).permit!
  end

  # @return [GRPC::GenericService]
  def rpc_desc
    @rpc_desc ||=
      "#{controller_path}/service".camelize.constantize.rpc_descs[action_name.camelize.to_sym] ||
      (raise StandardError)
  end
end
