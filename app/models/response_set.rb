class ResponseSet < ActiveRecord::Base
  unloadable
  include Surveyor::Models::ResponseSetMethods

  def self.toggle_debug
    $DEBUG = !$DEBUG
  end
end
