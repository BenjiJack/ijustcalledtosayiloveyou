class User < ActiveRecord::Base
  attr_accessible :recipientname, :recipientphone, :sendername
end
