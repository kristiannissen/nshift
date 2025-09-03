# frozen_string_literal: true
#
require "nshift/request"

module Nshift
  extend self

  # https://helpcenter.nshift.com/hc/en-us/articles/360001457853-Methods#getstacks
  def get_stacks
    res = post_form(cmd: "GetStacks", data: {}, options: {})

    res
  end

  def transmit_stack(stack_id:)
    raise ArgumentError, "Stack_id is mandatory, got #{stack_id}" if stack_id.nil?
    res = post_form(cmd: "TransmitStack", data: {
                      "StackCSID": stack_id,
                    }, options: {})

    res
  end
end
