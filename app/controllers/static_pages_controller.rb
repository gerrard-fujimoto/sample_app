class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def contact
  end

  def yeller(array)
    array.map(&:upcase).join
  end

  def string_shuffle(s)
    s.split('').shuffle.join
  end
end
