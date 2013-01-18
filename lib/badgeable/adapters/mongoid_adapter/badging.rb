class Badging
  include ::Mongoid::Document
  include ::Mongoid::Timestamps
  belongs_to :badge
  field :seen, :type => Boolean, :default => false
  scope :unseen, ->{ where(seen: false) }
  
  def mark_as_seen
    update_attributes(:seen => true)
  end
end
