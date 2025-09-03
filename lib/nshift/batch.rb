# frozen_string_literal: true
#

require "nshift/request"

module Nshift
  extend self
  # GetBatchList returns a list of batches from the criteria in the request.
  # When shipments are transmitted they are placed in a batch. A batch will
  # only contain the currently transmitted shipments for the carrier it belongs to.
  # at means that next time shipments are transmitted, a new batch is created for them.
  #
  # @start_index
  # @count
  # @sort_field
  # @sort_direction
  #
  #   => {}
  def get_batch_list(start_index: 0, count: 10, sort_field: "BatchCSID", sort_direction: 0)
    res = post_form(cmd: "GetBatchList", data: {
                      'StartIndex': start_index,
                      'Count': count,
                      'SortField': sort_field,
                      'SortDirection': sort_direction,
                    }, options: {})

    res
  end
end
