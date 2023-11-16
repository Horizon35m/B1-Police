RegisterNetEvent('B1-police:Notify', function(header, desc, thing)
    lib.notify({
        title = header,
        description = desc,
        type = thing
    })
end)