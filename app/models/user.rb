require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 2000
  DIGEST = OpenSSL::Digest::SHA256.new

  REGULAR_FOR_USERNAME = /\A[[:alnum:]_]+\z/
  REGULAR_FOR_NAME = /\A[[:upper:]][[:lower:]]+\z/

  COLORS =
    [
      ["purple pain", "#8458B3"],
      ["heavy purple", "#a28089"],
      ["brutal blue", "#0049B7"],
      ["redline", "#9e363a"]
    ]

  attr_accessor :password

  has_many :questions, dependent: :destroy

  validates :name, format: { with: REGULAR_FOR_NAME }, presence: true
  validates :username, format: { with: REGULAR_FOR_USERNAME }, length: { maximum: 40 }, presence: true, uniqueness: true
  validates :email, email: true, presence: true, uniqueness: true
  validates :password, on: :create, presence: true, confirmation: true
  validates :color_block, inclusion: {in: COLORS.map{ |name, hex| hex }}

  before_validation :to_lower_case
  before_save :encrypt_password

  def self.colors
    COLORS
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

  def to_lower_case
    username&.downcase!
    email&.downcase!
  end
end

