require 'test_helper'

class ShoeTest < ActiveSupport::TestCase
  def setup
    @shoe = shoes(:running_shoe)
  end

  test 'invalid below minimum price' do
    @shoe.price = Shoe::MINIMUM_PRICE - 0.01
    assert_not @shoe.valid?, 'Shoe is valid with a price below the minimum'
  end

  test 'invalid above maximum price' do
    @shoe.price = Shoe::MAXIMUM_PRICE + 0.01
    assert_not @shoe.valid?, 'Shoe is valid with a price above the maximum'
  end

  test 'invalid without positive price' do
    @shoe.price = -2.99
    assert_not @shoe.valid?, 'Shoe is valid without a negative price'
  end

  test 'invalid non-numeric price' do
    @shoe.price = 'abc'
    assert_not @shoe.valid?, 'Shoe is valid with a non-numeric price'
  end

  test 'valid with minimum price' do
    @shoe.price = Shoe::MINIMUM_PRICE
    assert @shoe.valid?, 'Shoe is not valid with the minimum price'
  end

  test 'valid with maximum price' do
    @shoe.price = Shoe::MAXIMUM_PRICE
    assert @shoe.valid?, 'Shoe is not valid with the maximum price'
  end
  
  test 'invalid without brand_name' do
    @shoe.brand_name = nil
    assert_not @shoe.valid?, 'Shoe is valid without a brand_name'
  end

  test 'invalid without style' do
    @shoe.style = nil
    assert_not @shoe.valid?, 'Shoe is valid without a style'
  end

  test 'invalid without color' do
    @shoe.color = nil
    assert_not @shoe.valid?, 'Shoe is valid without a color'
  end

  test 'invalid shoe size' do
    @shoe.size = 16
    assert_not @shoe.valid?, 'Shoe is valid with an out-of-range size'
  end

  test 'invalid shoe color' do
    @shoe.color = 'Light Red'
    assert_not @shoe.valid?, 'Shoe is valid with an out-of-range color'
  end

  test 'valid shoe size' do
    @shoe.size = 10.5
    assert_includes Shoe::FOOT_SIZES, @shoe.size.to_s
  end

  test 'invalid with duplicate shoe attributes' do
    duplicate_shoe = @shoe.dup
    assert_not duplicate_shoe.valid?, 'Shoe is valid with duplicate attributes'
  end

  test 'valid shoe' do
    assert @shoe.valid?
  end
end
