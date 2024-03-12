# frozen_string_literal: true

class V1Controller < ApplicationController
  skip_before_action :verify_authenticity_token
end
