require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 2000
  DIGEST = OpenSSL::Digest::SHA256.new

  REGULAR_FOR_USERNAME = /\A[a-z_\d]+\z/
  REGULAR_FOR_NAME = /\A[a-zA-ZА-яа-я]+\z/
  REGULAR_FOR_AVATAR_URL = /\A((http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?)|avatar.jpg\z/ix
  REGULAR_FOR_COLOR = /\A#(?:[0-9a-fA-F]{3}){1,2}\z/

  attr_accessor :password

  has_many :questions

  validates :name, format: { with: REGULAR_FOR_NAME }, presence: true
  validates :username, format: { with: REGULAR_FOR_USERNAME }, length: { maximum: 40 }, presence: true, uniqueness: true
  validates :email, email: true, presence: true, uniqueness: true
  validates :password, on: :create, presence: true, confirmation: true
  validates_format_of :color_block, with: REGULAR_FOR_COLOR
  validates_format_of :avatar_url, with: REGULAR_FOR_AVATAR_URL

  before_validation :to_lower_case, :default_values_for_avatar_and_colorblock
  before_save :encrypt_password

  def colors
    [
      ["purple pain", "#8458B3"],
      ["heavy purple", "#a28089"],
      ["brutal blue", "#0049B7"],
      ["redline", "#9e363a"]
    ]
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email&.downcase)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password
    nil
  end

  private

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def default_values_for_avatar_and_colorblock
    self.avatar_url = 'avatar.jpg' if avatar_url.nil?
    self.color_block = '#8458B3' if color_block.nil? || !(colors.map {|name, hex| hex}.include? color_block)
  end

  def to_lower_case
    username&.downcase!
    email&.downcase!
  end
end
