load("render.star", "render")
load("http.star", "http")
load("time.star", "time")

ROUTE_ID = "550685"
BUSTIME_STOP_TIMES_URL = "http://bustime.mta.info/api/siri/stop-monitoring.json"
BUSTIME_STOP_INFO_URL = "http://bustime.mta.info/api/where/stop/MTA_%s.json" % ROUTE_ID


def get_line_info(line_ref, api_key):
    rep = http.get(
        BUSTIME_STOP_INFO_URL,
        params={
            "key": api_key,
        }
    )
    if rep.status_code != 200:
        fail("MTA BusTime request failed with status %d", rep.status_code)

    routes = rep.json()["data"]["routes"]
    route = [x for x in routes if x["id"] == line_ref][0]

    return {
        "color": route["color"],
    }


def build_row(journey, api_key):
    line_ref = journey["LineRef"]
    line_info = get_line_info(line_ref, api_key)
    line_color = line_info["color"]
    line_name = journey["PublishedLineName"][0]
    destination_name = journey["DestinationName"][0]
    eta = journey["MonitoredCall"]["ExpectedArrivalTime"]
    now = time.now()
    eta_time = time.parse_time(eta)
    diff = eta_time - now
    diff_minutes = int(diff.minutes)
    diff_text = "%d minutes" % diff_minutes if diff_minutes > 0 else "now"

    return render.Row(
        expanded=True,
        main_align="space_evenly",
        cross_align = "center",
        children=[
            render.Box(
                color = "#%s" % line_color,
                width = 22,
                height = 11,
                child = render.Text(line_name, color = "#000", font = "CG-pixel-4x5-mono"),
            ),
            render.Column(
                children=[
                    render.Marquee(
                        width=40,
                        child=render.Text(destination_name),
                    ),
                    render.Text(diff_text, color="#c1773e",
                                font="tom-thumb"),
                ]
            ),
        ]
    )


def main(config):
    api_key = config.get("api_key")
    rep = http.get(
        BUSTIME_STOP_TIMES_URL,
        params={
            "version": "2",
            "key": api_key,
            "MonitoringRef": ROUTE_ID,
        }
    )
    if rep.status_code != 200:
        fail("MTA BusTime request failed with status %d", rep.status_code)

    journies = rep.json()[
        "Siri"]["ServiceDelivery"]["StopMonitoringDelivery"][0]["MonitoredStopVisit"]
    first_journey = journies[0]["MonitoredVehicleJourney"]
    second_journey = journies[1]["MonitoredVehicleJourney"]

    return render.Root(
        child=render.Column(
            expanded=True,
            main_align="space_evenly",
            children=[
                build_row(first_journey, api_key),
                render.Box(
                    width=64,
                    height=1,
                    color="#aaa",
                ),
                build_row(second_journey, api_key),
            ]
        )
    )
