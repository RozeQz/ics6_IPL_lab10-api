# frozen_string_literal: true

# XML controller class
class XmlController < ApplicationController
  def input; end

  def view
    @input = validate_input(params[:n])
    @numbers = (0..@input).select { |i| palindrome?(i * i) }
    @result = @numbers.size
  rescue StandardError => e
    @error = case e.class.to_s
             when 'ArgumentError' then 'Некорректный ввод. Используйте только цифры!'
             else e
             end
  ensure
    respond_to do |format|
      format.html
      format.xml
      format.rss { render 'view.xml' }
    end
  end

  private

  def palindrome?(number)
    number.to_s == number.to_s.reverse
  end

  def validate_input(input)
    raise 'Пустой ввод. Вы ничего не ввели!' if input.empty?

    Integer(input)
  end
end
