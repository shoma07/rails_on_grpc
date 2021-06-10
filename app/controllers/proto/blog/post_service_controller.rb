# frozen_string_literal: true

module Proto
  module Blog
    # Proto::Blog::PostServiceController
    class PostServiceController < ApplicationController
      # POST /proto.blog.PostService/GetPost
      #
      # @return [String]
      def get_post
        render proto: rpc_desc.output.new(
          post: Proto::Blog::Post.new(id: decode_params[:id])
        )
      end
    end
  end
end
