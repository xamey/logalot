class Subscribers::Datadog
  def emit(event)
     event[:timestamp] = timestamp_to_milliseconds(event[:timestamp])

     Rails.logger.info(event.to_json)
  end

  private

   # Datadog expects the timestamp to be in milliseconds (13 chars)
  # And doesn't collect nanoseconds (19 chars)
  def timestamp_to_milliseconds(timestamp)
    timestamp.to_s[0...-6].to_i
  end
end