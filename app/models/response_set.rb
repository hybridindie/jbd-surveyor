class ResponseSet < ActiveRecord::Base
  unloadable
  include Surveyor::Models::ResponseSetMethods

  cattr_reader :per_page
  @@per_page = 20
  
  def self.toggle_debug
    $DEBUG = !$DEBUG
  end
end
