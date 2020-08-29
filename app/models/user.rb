require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 2000
  DIGEST = OpenSSL::Digest::SHA256.new

  REGULAR_FOR_USERNAME = /\A[a-zA-Z_\d]+\z/

  attr_accessor :password

  has_many :questions

  validates :email, email: true, presence: true, uniqueness: true
  validates :username, format: { with: REGULAR_FOR_USERNAME }, presence: true, uniqueness: true
  validates_length_of :username, maximum: 40

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_validation :username_to_lower_case
  before_save :encrypt_password

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def username_to_lower_case
    self.username = self.username.downcase
  end

  private

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password

    nil
  end
end
