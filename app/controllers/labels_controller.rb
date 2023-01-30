class LabelsController < ApplicationController
  def index
    @label = Label.all
  end

  def new
    @label = Label.new
  end

  def edit
  end
end
