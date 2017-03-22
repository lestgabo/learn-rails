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
        if @test4.include?("reddituploads.com")
          @test4 = @test4.gsub!("amp;","")
        end
        
        if @test4[7,5] == "imgur" 
          @test4 = @test4.sub!("http://","")
          @test4 = "https://i.#{@test4}.jpeg"
        elsif @test4[-1] == "v"
          @test4 = @test4[0,@test4.size-1]
        elsif @test4[8,6] == "gfycat"
          @test4 = @test4.sub!("https://gfycat.com/","")
        elsif @test4[7,6] == "gfycat"
          @test4 = @test4.sub!("http://gfycat.com/","")
        end
        @test5[@test3] = @test4
        
      end
    end
    # very first @test5 seems to be a nil=>"", therefore I am going to remove that first index with the next line
    @test5.shift
  end
  
  def more2
    require 'rest-client'
    require 'json'
    
    @test5 = {}
    url = 'https://www.reddit.com/r/EmmaWatson/top.json?sort=top&t=all'
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
        if @test4.include?("reddituploads.com")
          @test4 = @test4.gsub!("amp;","")
        end
        
        if @test4.include?("imgur.com/a/")
          #http://imgur.com/a/0WiEn#0
          @test4 = @test4.sub!("http://imgur.com/","")
          if @test4.include?("#")
            @test4 = @test4[0,@test4.size-2]
          end
        elsif @test4[7,5] == "imgur" 
          @test4 = @test4.sub!("http://","")
          @test4 = "https://i.#{@test4}.jpeg"
        elsif @test4[-1] == "v"
          @test4 = @test4[0,@test4.size-1]
        elsif @test4[8,6] == "gfycat"
          @test4 = @test4.sub!("https://gfycat.com/","")
        elsif @test4[7,6] == "gfycat"
          @test4 = @test4.sub!("http://gfycat.com/","")
        elsif @test4[11,7] == "foxnews" 
          @test4 = nil
        elsif @test4 == ""
          @test4 = nil
        end
        @test5[@test3] = @test4
        
      end
    end
    # very first @test5 seems to be a nil=>"", therefore I am going to remove that first index with the next line
    # @test5.shift   ---> replaced with turning blank to nil and then using compact
    @test5 = @test5.compact
  end
  
  private
  
    def secure_params
      params.require(:visitor).permit(:email)
    end
end