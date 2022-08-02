class Public::HomesController < ApplicationController
  def top
    @diaries = Diary.all.reverse
  end

  def about
  end
end
