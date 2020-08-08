module Youtube
  class SearchService
    def initialize(keyword, order)
      @keyword = keyword
      @order= order
    end

    def run
      uri = URI.parse URI.encode("https://www.googleapis.com/youtube/v3/search?type=video&part=snippet&q=#{@keyword}&key=AIzaSyCHS2EX-KLdOMMTIh3hHwDObZleQShGp6s&order=#{@order}&maxResults=5")
      response = JSON.load(Net::HTTP.get(uri))
      response["items"]
    end
  end
end