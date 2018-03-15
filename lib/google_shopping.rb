require 'capybara/dsl'

class GoogleShopping
  include Capybara::DSL

  def verify_search(string)
    elements = all('div.pslline')
    case "string"
      when 'marmite'
        elements.each do |element|
          unless element.text =~ /Marmite/
            fail
          end
        end
    end
  end

  def verify_books
    find(:xpath, '//*[@id="lb"]/div/a[3]').click
    sleep(1)
  end

  def verify_seller_ocado(string)
    elements = all('div.pslline')
    case "string"
      when 'ocado'
        elements.each do |element|
          unless element.text =~ /Ocado/
            fail
          end
        end
    end
  end

  def verify_seller_eatbig(string)
    elements = all('div.pslline')
    case "string"
      when 'eatbig'
        elements.each do |element|
          unless element.text =~ /Eatbig/
            fail
          end
        end
    end
  end

  def verify_range()
    elements = all('span.price')
    prices = elements.map { |e| e.text.sub('£', '').to_i }
    prices.each do |price|
      unless price >=20 && price <= 30
        fail
      end
    end
  end

end
