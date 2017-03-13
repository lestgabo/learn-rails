class VisitorsController < ApplicationController
  def new
    @visitor = Visitor.new
  end
  
  def create
    @visitor = Visitor.new(secure_params)
    if @visitor.valid?
      @visitor.subscribe
      flash[:notice] = "Signed up #{@visitor.email}."
      redirect_to more_path
      
      
    else
      render :new
    end
  end
  
  def more
    require 'rest-client'
    require 'json'
    
    @test5 = {}
    url = 'https://www.reddit.com/r/NatalieDormer/top.json?sort=top&t=all'
    response = RestClient.get(url)
    doc = JSON.parse(response.body)
    @test = doc['data']['children']
    
    # @test = doc['data']['children'] -> is at children, an array containing 2 things -> kind: and data:
    # I need to extract title and url from data:
    (0..@test.size-1).each do |i|
      @test[i].map do |j|
        # j[1] means the second index of children, so it will be data:
        @test3 = j[1]['title']
        @test4 = j[1]['url']
        @test5[@test3] = @test4
      end
    end
  end
  
  private
  
    def secure_params
      params.require(:visitor).permit(:email)
    end
end