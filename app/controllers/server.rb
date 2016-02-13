module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources/:identifier/data' do |identifier|
      the_status, the_body = PayloadRequestParser.new(params[:payload], identifier).server_response
      status the_status
      body the_body
    end

    post '/sources' do
      the_status, the_body = ClientResponseParser.new(params).server_response
      status the_status
      body the_body
    end

    get '/sources/:identifier' do |identifier|
      @client = Client.find_by(:identifier => identifier)
      file = PayloadDataResponseParser.new.server_response(identifier)
      erb file
    end

    get '/:identifier/delete' do
      #This just has a delete button
    end

    post '/:identifier/delete' do
      #This is what happens when the above button is submitted, and does all the stuff
    end

    get '/sources/:identifier/urls/:relativepath' do |identifier, relativepath|
      file, @relative_path, @url = UrlPathResponseParser.new(identifier, relativepath).server_response
      erb file
    end

    get '/:identifier/events' do |identifier|
      file, @client = EventIndexParser.new(identifier).server_response
      erb file
    end

    get '/events/:client/:event_name' do |client_name, event_name|
      client = Client.find_by(identifier: client_name)
      if client != nil
        event = client.event_names.find_by(:event => event_name)
      end
      if !Client.exists?(identifier: client_name)
        erb :client_not_found
      elsif !client.event_names.exists?(:event => event_name)
        redirect "/#{client_name}/events"
      else
        erb :hourly_breakdown, locals: { event: event }
      end
    end

    helpers do
      def link_to_url_statistics(path, url)
        "<a href= 'http://localhost:9393/sources/#{@client.identifier}/urls/#{path}' >#{url}</a>"
      end

      def singluar_or_plural_hits(hits)
        hits == 1 ? "hit" : "hits"
      end
    end

  end
end
