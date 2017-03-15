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
 
        @test4 = @test4.to_s
        if @test4[7,5] == "imgur" 
          @test4 = @test4.sub!("http://","")
          @test4 = "https://i.#{@test4}.jpeg"
        elsif @test4[-1] == "v"
          @test4 = @test4[0,@test4.size-1]
        elsif @test4[8,6] == "gfycat"
          @test4 = @test4.sub!("https://gfycat.com/","")
      #    @test4 = "<div style='position:relative;padding-bottom:57%'><iframe src='https://gfycat.com/ifr/#{@test4}' frameborder='0' scrolling='no' width='100%' height='100%' style='position:absolute;top:0;left:0;' allowfullscreen></iframe></div>"
      #    @test4 = @test4.to_s
        elsif @test4[7,6] == "gfycat"
          @test4 = @test4.sub!("http://gfycat.com/","")
      #    @test4 = @test4.to_s
        end
        @test5[@test3] = @test4
      end
    end
  end
  
  private
  
    def secure_params
      params.require(:visitor).permit(:email)
    end
end