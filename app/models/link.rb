class Link < ActiveRecord::Base
  belongs_to :user

  def valid_url?
    uri = URI.parse(self.url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  end

  def update_attributes(attributes)
    self.update(attributes)
  end

end
