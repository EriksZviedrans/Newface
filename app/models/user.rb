class User < ActiveRecord::Base
  require 'log4r'
  has_many :events
  attr_accessible :fullname, :login, :password, :password_confirmation, :mail, :facebookid, :access_token, :image_file
  attr_accessor :password
  
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :login
  validates_uniqueness_of :login
  validates_presence_of :password, :on => :create
  validates_presence_of :mail
  validates_presence_of :fullname
  validates_uniqueness_of :mail
  validates_format_of :mail, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
   
  def image_file=(input_data)
    self.file_name = input_data.original_filename
    self.content_type = input_data.content_type.chomp
    self.binary_data = input_data.read
  end
  
  def self.authenticate(login, password)
    user = find_by_login(login)
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
  
  def self.loaduserfromxml
    @xmldata = Nokogiri::XML(open("users.xml"))
    @xmldata.xpath('//user').each do |node|
    if !node.at('facebook-id').nil?
       facebookid = node.at('facebook-id').text 
    else
       facebookid = ''
    end
    if !node.at('access-token').nil?
       access_token = node.at('access-token').text 
    else
       access_token = ''
    end
     @user = User.new(
        :fullname => node.at('full-name').text,
        :login => node.at('username').text,
        :mail => node.at('email').text,
        :facebookid => facebookid,
        :password => node.at('password').text,
        :password_confirmation => node.at('password').text,
        :access_token => access_token
      )   
      if @user.save
       logger.debug "#{@user.fullname} imported!"
      else
       logger.debug "This didn't save!"
      end

    end
  end
  

  
end
