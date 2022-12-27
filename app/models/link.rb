class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true

  validates :url, url: { no_local: true, schemes: ['http', 'https'], public_suffix: true }

  def gist?
    URI.parse(url).host.include?('gist')
  end

  def gist_id
    URI.parse(url).path.split('/').last
  end
end
