class User < ActiveRecord::Base
  attr_accessible :recipientname, :recipientphone, :sendername

  validates :sendername, presence: true, length: { maximum: 25 }
  validates :recipientname, presence: true, length: { maximum: 25 }

  validates :recipientphone, presence: true


end
