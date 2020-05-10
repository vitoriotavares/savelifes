class User < ApplicationRecord

  has_many :services
  has_many :clients
  has_many :order_services

  has_one_attached :logo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :logo,  attached: true,
  #                   content_type: ['image/png', 'image/jpg', 'image/jpeg'],
  #                   aspect_ratio: :landscape
  
  def logo_thumbnail
    self.logo.variant(resize: '300x140!') rescue nil
  end

  private

  def self.payload
    payload = [
      "sub" => "1",
      "name"=> "DETRAN",
      "iat"=> '1585569801' , # timestamp atual
      "USER_AGENT" => "VIPROC",
      "action"=> "to_view",
      "search_condition"=> [
        "id_tipo_documento" => "267",
        "campo_pesquisa" => "val_campo1",
        "valor_pesquisa" => "00017619/2020"
      ]
    ]
  end

  def self.teste
    require 'json'
    require "base64"
    require "base64url"
    require 'jwt'
    header = [
              'alg' => 'HS256',
              'typ' => 'JWT'
              ];
    header = header.to_json
    header = Base64.encode64(header)

    payload = self.payload
    payload = payload.to_json
    payload = Base64URL.encode(payload)

    signature = JWT.encode(
      header + "." + payload,
      '48cf78c05f8211616e1dfb36c742b7ef',
      'HS256'
      )
    signature = Base64URL.encode(signature);

    token = header + "." + payload + "." + signature
  end

  def self.teste_sem_jwt
    require 'json'
    require "base64"
    require "base64url"
    header = [
              'alg' => 'HS256',
              'typ' => 'JWT'
              ];
    header = header.to_json
    header = Base64.encode64(header)

    payload = self.payload
    payload = payload.to_json
    payload = Base64URL.encode(payload)

    signature = OpenSSL::HMAC.hexdigest("SHA256",
      '48cf78c05f8211616e1dfb36c742b7ef',
      header + "." + payload
      )
    signature = Base64URL.encode(signature);

    token = header + "." + payload + "." + signature
  end

  def self.teste_jwt
    require 'jwt'

    hmac_secret = '48cf78c05f8211616e1dfb36c742b7ef'
    token = JWT.encode self.payload, hmac_secret, 'HS256'
  end
  
end
