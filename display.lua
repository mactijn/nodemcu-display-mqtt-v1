config = {
    -- yes these are actual credentials. Come stand on my doorstep with your laptop pressed against the window, please.
    -- or just ring the doorbell and come in, I have better wifi available.
    mqtt_user = 'lamp',
    mqtt_pass = 'lamp',
    ssid = 'macGadget',
    password = 'foobarbaz'
}

local driver = require 'ssd1306_i2c'
driver:init_preset(0x3c, 2, 1, 'wemos_64x48')
console = require 'console'(driver)

-- m = mqtt.Client(wifi.sta.getmac(), c:get('mqtt_user'), c:get('mqtt_pass'), true)
m = mqtt.Client(wifi.sta.getmac(), config.mqtt_user, config.mqtt_pass, true)

gateway = '127.0.0.1'

sensor_data = {
    id = '00:00:00:00:00:00',
    temp = ' 0.0',
    humidity = ' 0.0'
}

m:on('connect', function(conn)
    print('mqtt: connected; subscribing...')
    conn:subscribe('devices/' .. wifi.sta.getmac(), 0, function(c)
        print('mqtt: subscribed')
    end)

    conn:subscribe('house/floor1/room1/temp1', 0, function(c)
        print('mqtt: subscribed')
    end)

    console:clear()
    tmr.start(0)

end)

m:on('offline', function(c)
    print('mqtt: disconnected\ntmr: stopping timer 0')
    console:pos(0, 4)
    console:write('lost mqtt connection')
    tmr.stop(0)
    tmr.alarm(1, 1000, tmr.ALARM_SINGLE, function()
        m:connect(gateway, 1883, 0, 0)
    end)
end)

m:on('message', function(c, topic, message)
    string.gsub(message, '([^=]+)=([^&]+)&?', function(key, val)
        sensor_data[key] = val
    end)
    print(string.format("got message id=%s temp=%s humidity=%s", sensor_data.id, sensor_data.temp, sensor_data.humidity))
    if (sensor_data.temp:len() < 4) then sensor_data.temp = ' ' + sensor_data.temp end
    if (sensor_data.humidity:len() < 4) then sensor_data.humidity = ' ' + sensor_data.humidity end
end)

-- set up timer
tmr.register(0, 5000, tmr.ALARM_AUTO, function()
    client_id = string.format('%s%s%s', sensor_data.id:sub(10,11), sensor_data.id:sub(13,14), sensor_data.id:sub(16,17))
    console:pos(0,0)
    console:write(string.format('id: %s', client_id))
    console:pos(0,2)
    console:write(string.format('  %s C  ', sensor_data.temp))
    console:write(string.format('  %s %% ', sensor_data.humidity))
    m:publish('house/floor1/room1/disp1', string.format('id=%s&keepalive=1', wifi.sta.getmac()), 0, 0)
end)


-- set up wi-fi
wifi.setmode(wifi.STATION)
wifi.sta.config(config.ssid, config.password, 1)


wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(args)
    print(string.format('wi-fi: got ip address=%s netmask=%s gateway=%s', args.IP, args.netmask, args.gateway))
    print(string.format('mqtt: connecting to server %s...', args.gateway))
    gateway = args.gateway
    m:connect(args.gateway, 1883, 0, 0)
end)


wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, function(args)
    print(string.format('wi-fi: disconnected ssid=%s bssid=%s reason=%i', args.SSID, args.BSSID, args.REASON or 0))
    console:pos(0, 4)
    console:write('lost wifi connection')
    tmr.alarm(1, 10000, tmr.ALARM_SINGLE, function() wifi.sta.connect() end)
end)


wifi.eventmon.register(wifi.eventmon.STA_DHCP_TIMEOUT, function(args)
    console:pos(0,5)
    console:write('dhcp timedout')
    -- TODO: zeroconf
end)

console:clear()
console:pos(0,5)
console:write('connecting')
wifi.sta.connect()
