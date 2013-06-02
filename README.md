bus-alert
=========

Lexington mobile app that reminds you when your bus is approaching.

### User experience
1. Choose a stop.
2. Wait.
3. Get an alert when the bus is near.

### Available information from Lextran API
- Given a bus, we know incoming/outgoing, last stop, current position
- Given a stop, we know next arrival time(s) for given route (HTML) or all routes (noscript)
- Given a route, we know stop IDs, bus IDs, and KML for route

### Resources
- XML API
  - Route - All stops, link to route KML: http://realtime.lextran.com/InfoPoint/map/GetRouteXml.ashx?RouteId=10
  - Bus - Current position, bus number: http://realtime.lextran.com/InfoPoint/map/GetVehicleXml.ashx?RouteId=10
- HTML API
  - Stop - Scheduled & estimated departure times: http://realtime.lextran.com/InfoPoint/map/GetStopHtml.ashx?stopId=1157
  - Bus - Name of last stop, direction, status (early/late/on-time): http://realtime.lextran.com/InfoPoint/map/GetVehicleHtml.ashx?stopId=552&limit=1
  - All routes: http://realtime.lextran.com/InfoPoint/noscript.aspx
  - All stops: http://realtime.lextran.com/InfoPoint/noscript.aspx?route_id=1
  - All scheduled departures for stop (including inbound/outbound labels): http://realtime.lextran.com/InfoPoint/departures.aspx?stopid=1544
- KML sample
  - http://realtime.lextran.com/infopoint/traces/Georgetown_Road.kml

### This app's JSON API
```javascript
// GET /
// GET /routes
{
  routes: [
    { name: 'Hamburg Pavilion', id: 10 }
  ]
}

// GET /routes/10/stops
{
  stops: [
    { id: 943, name: 'Vendor Way @ Best Buy', lat:  '38.023392', long: '-84.419754' }
  ]
}

// GET /routes/10/stops/943
{
  arrivals: [
    { bus_no: '415', sdt: '14:30:00-0500', edt: '14:32:00-0500' },
    { bus_no: '415', sdt: '14:35:00-0500', edt: '' }
  ]
}

// GET /routes/10/stops/943/next
{ bus_no: '415', edt: '14:32:00-0500' }
```

### Future expansion
API data that would make this app better:
- XML for departure times
- XML for bus direction, status (early/late/on-time)
- Given a stop, is it inbound or outbound?
  - If both, are scheduled departures inbound or outbound?
- Given a bus, what's its next stop (id)?
