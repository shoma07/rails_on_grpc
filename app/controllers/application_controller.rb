# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  private

  # @return [ActionController::Parameters]
  def decode_params
    return @decode_params unless @decode_params.nil?

    @decode_params = ActionController::Parameters.new(
      request_message_class.decode(request.body.read.sub(/\A(\x00)*\x02/, '')).to_h
    ).permit!
  end

  # @return [GRPC::GenericService]
  def rpc_desc
    @rpc_desc ||=
      "#{controller_path}/service".camelize.constantize.rpc_descs[action_name.camelize.to_sym] ||
      (raise StandardError)
  end

  # @return [Google::Protobuf::MessageExts]
  def request_message_class
    rpc_desc.input
  end

  # @return [Google::Protobuf::MessageExts]
  def response_message_class
    rpc_desc.output
  end
end
