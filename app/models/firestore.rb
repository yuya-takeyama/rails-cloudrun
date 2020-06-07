class Firestore < Gcp
  require 'google/cloud/firestore'
  require 'base64'

  class_attribute :connection

  self.connection = Google::Cloud::Firestore.new(
    project_id: ENV.fetch('GCP_PROJECT_ID'),
    credentials: JSON.parse(Base64.decode64(ENV.fetch('GCP_CREDENTIALS_BASE64'))),
  )
end
