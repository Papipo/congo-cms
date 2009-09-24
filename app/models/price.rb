class Price
  include MongoMapper::EmbeddedDocument
  
  key :amount, Float
  key :currency, Currency
  
  def to_s
    currency.format % amount
  end
end