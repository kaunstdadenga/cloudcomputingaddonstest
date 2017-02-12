require 'json'
require 'geocoder'

# config/initializers/geocoder.rb
Geocoder.configure(
  # geocoding service:
  :lookup => :google,

  # IP address geocoding service:
  :ip_lookup => :maxmind,

  # to use an API key:
  :api_key => 'AIzaSyAfTjdechLjnh-BHmP3kWwGiSFis5u-pms',

  # this is very important option for configuring geocoder with API key
  :use_https => true,

  # geocoding service request timeout, in seconds (default 3):
  :timeout => 3,

  # set default units to kilometers:
  :units => :km,
  
  :http_proxy => ENV['QUOTAGUARD_URL'],
  
  :timeout => 5
)

MyApp.add_route('POST', '/racingTracks', {
  "resourcePath" => "/Default",
  "summary" => "",
  "nickname" => "create_racing_track", 
  "responseClass" => "racingTrack", 
  "endpoint" => "/racingTracks", 
  "notes" => "Creates a new racing track with a given namen and returns the racing track object which id is needed to update and finalize the racing track. Optionally position can be initally be added and the track can also be finalized. The ID of the racing track is server side generated.",
  "parameters" => [
    {
      "name" => "body",
      "description" => "body in form of a racing track. invalid positions in array will be ignored",
      "dataType" => "RacingTrack",
      "paramType" => "body",
    }
    ]}) do
  cross_origin
  # the guts live here

  {"message" => "yes, it worked"}.to_json
end


MyApp.add_route('DELETE', '/racingTracks/{id}', {
  "resourcePath" => "/Default",
  "summary" => "",
  "nickname" => "delete_racing_track", 
  "responseClass" => "void", 
  "endpoint" => "/racingTracks/{id}", 
  "notes" => "Deletes a single racing track based on the ID supplied",
  "parameters" => [
    {
      "name" => "id",
      "description" => "ID of racing track to delete",
      "dataType" => "int",
      "paramType" => "path",
    },
    ]}) do
  cross_origin
  # the guts live here

  {"message" => "yes, it worked"}.to_json
end


MyApp.add_route('POST', '/racingTracks/{id}/finalize', {
  "resourcePath" => "/Default",
  "summary" => "",
  "nickname" => "finalize_racing_track", 
  "responseClass" => "racingTrack", 
  "endpoint" => "/racingTracks/{id}/finalize", 
  "notes" => "Finalizes a racing track to prevent editing based on the ID supplied",
  "parameters" => [
    {
      "name" => "id",
      "description" => "ID of racing track to update",
      "dataType" => "int",
      "paramType" => "path",
    },
    ]}) do
  cross_origin
  # the guts live here

  {"message" => "yes, it worked"}.to_json
end


MyApp.add_route('GET', '/racingTracks', {
  "resourcePath" => "/Default",
  "summary" => "",
  "nickname" => "find_racing_track", 
  "responseClass" => "array[racingTrack]", 
  "endpoint" => "/racingTracks", 
  "notes" => "Returns all finalized racing tracks from the system",
  "parameters" => [
    {
      "name" => "finalized",
      "description" => "optional filter for the finalized field. Default: true",
      "dataType" => "boolean",
      "paramType" => "query",
      
      "allowableValues" => "",
      
    },
    ]}) do
  cross_origin
  # the guts live here

  {"message" => "yes, it worked"}.to_json
end


MyApp.add_route('GET', '/racingTracks/{id}', {
  "resourcePath" => "/Default",
  "summary" => "",
  "nickname" => "find_racing_track_by_id", 
  "responseClass" => "racingTrack", 
  "endpoint" => "/racingTracks/{id}", 
  "notes" => "Returns a racing track based on a single ID",
  "parameters" => [
    {
      "name" => "id",
      "description" => "ID of racing track to fetch",
      "dataType" => "int",
      "paramType" => "path",
    },
    ]}) do
  cross_origin
  # the guts live here

  {"message" => "yes, it worked"}.to_json
end


MyApp.add_route('POST', '/racingTracks/{id}/positions', {
  "resourcePath" => "/Default",
  "summary" => "",
  "nickname" => "update_racing_track_position", 
  "responseClass" => "position", 
  "endpoint" => "/racingTracks/{id}/positions", 
  "notes" => "Creates and adds a postion of a racing track as long as it is not finalized based on the ID supplied",
  "parameters" => [
    {
      "name" => "id",
      "description" => "ID of racing track to update",
      "dataType" => "int",
      "paramType" => "path",
    },
    {
      "name" => "body",
      "description" => "position body",
      "dataType" => "Position",
      "paramType" => "body",
    }
    ]}) do
  cross_origin
  # the guts live here
  
  begin
    body = JSON.parse(request.body.read)
  rescue JSON::ParserError, ArgumentError => e
    puts(e)
    return error(400, "Parameter not valid.")
  end

  position = body["position"]

  if position.nil? then
    error(400, "Parameter not valid.")
  else
    latitude = position["latitude"]
    longitude = position["longitude"]
    
    puts latitude
    puts longitude
    result = Geocoder.search("#{latitude},#{longitude}")
    puts result.first.data['formatted_address']
    #street = result[0].data['address']['road']
    #puts street
    puts ""
    puts ""
    
    {"Addresse" => "Soon Schwaigaustraße irgendwos"}.to_json
  end
end

