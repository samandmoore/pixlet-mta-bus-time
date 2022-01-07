require 'base64'

def render_and_push(event: nil, context: nil)
   system('pixlet render bus_times.star api_key=$BUS_TIMES_API_KEY -o /tmp/bus_times.webp')
   system('pixlet push --api-token $PIXLET_API_TOKEN $PIXLET_DEVICE_ID /tmp/bus_times.webp --background --installation-id $INSTALLATION_ID')
   {
      statusCode: 200,
      data: Base64.encode64(File.read('/tmp/bus_times.webp'))
   }
end
