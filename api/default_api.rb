require 'json'
require 'logdna'

#logger = LogDNA::RubyLogger.new("62724bb68e694f4cbf8047a0c1f628cb", "https://logdnatestracingapi.herokuapp.com")
#logger.level = LogDNA::LEVELS[0]
logger = Logger.new(STDOUT)
logger.level = Logger::DEBUG

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
  puts "post racingeTracks logger"
  logger.debug {"Debug"}
  #logger.info {"Info"}
  #logger.warn {"Warn"}
  #logger.error {"Error"}
  #logger.fatal {"Fatal"}
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

  {"message" => "yes, it worked"}.to_json
end

