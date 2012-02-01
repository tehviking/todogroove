class User
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :password
  before_save :encrypt_password

  field :name,          :type => String
  field :email,         :type => String
  field :password_hash, :type => String
  field :password_salt, :type => String
  field :reset_token,   :type => String
  
  references_many :tasks

  validates_presence_of :password, :on => :create
  validates_confirmation_of :password

  validates :name, :presence => true, :length => { :maximum => 50, :allow_blank => false }
  validates :email, :presence => true, :length => { :minimum => 6, :maximum => 255, :allow_blank => false }
  validates_uniqueness_of :email

  def self.authenticate(email, password)
    user = User.where(email: email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  def make_reset_token
    self.reset_token = self.class.make_token
  end
  
  def clear_reset_token
    self.reset_token = nil
    save!
  end

  protected
  
  def self.make_token
    secure_digest(Time.now, (1..10).map{ rand.to_s })
  end
  
  def self.secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end
end

