DefinitionBlock ("", "SSDT", 2, "nouu", "lcd", 0x00000000)
{
    External (_SB_.PCI0.PS2K, DeviceObj)

    Name (_SB.PCI0.PS2K.RMCF, Package (0x02)
    {
        "Keyboard", 
        Package (0x02)
        {
            "Custom ADB Map", 
            Package (0x03)
            {
                Package (0x00){}, 
                "40=6b", 
                "41=71"
            }
        }
    })
}

