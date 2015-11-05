class User < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	after_destroy :ensure_admin_remains
  has_secure_password

  private

  def ensure_admin_remains
  	if User.count.zero? 
  		raise "Last user can't be deleted"
  	end
  end
  
end
