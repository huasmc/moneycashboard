require_relative('../db/sql_runner.rb')

class Transaction
  # attr_reader
  attr_accessor :id, :amount, :tag, :shop
  def initialize(options)
    @id = options['id'].to_i
    @amount = options['amount'].to_i
    @tag = options['tag']
    @shop = options['shop']
  end

  def save()
    sql = "INSERT INTO transactions (amount, tag, shop)
     VALUES ($1, $2, $3)RETURNING *"
     values = [@amount, @tag, @shop]
     @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    values = []
    results = SqlRunner.run(sql, values)
    transactions = results.map {|result| Transaction.new(result)}
    return transactions
  end
end
