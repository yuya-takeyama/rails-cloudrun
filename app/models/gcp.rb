class Gcp
  require 'google/cloud'
  class_attribute :client

  self.client = Google::Cloud.new(ENV['GCP_PROJECT_ID'])
end
