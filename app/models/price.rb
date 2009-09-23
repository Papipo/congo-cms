class Price
  include MongoMapper::EmbeddedDocument
  
  key :amount, Float
  key :currency, Currency
  
  def to_s
    eval(currency.format)
  end
end