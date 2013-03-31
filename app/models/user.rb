class User < ActiveRecord::Base

require 'validates_phone_number'

  attr_accessible :recipientname, :recipientphone, :sendername

  validates :sendername, presence: true, length: { maximum: 25 }
  validates :recipientname, presence: true, length: { maximum: 25 }

  validates :recipientphone, presence: true, :phone_number => { :format => /\+1\s\(\d{3}\)\s\d{3}\-\d{4}/ }

end
