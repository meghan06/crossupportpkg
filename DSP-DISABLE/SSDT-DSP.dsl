DefinitionBlock ("", "SSDT", 2, "cbOSX", "croskb", 0)
{

    External (_SB.PCI0.HDAS, DeviceObj)
    Scope (_SB.PCI0.HDAS)
    
        {
        OperationRegion (DE01, PCI_Config, 0x50, 0x01)
        Field (DE01, AnyAcc, NoLock, Preserve)
            {
                , 4,
            DDDD, 1
            }
        		//possible start
		    Method (_STA, 0, Serialized)
		{
				If (_OSI ("Darwin"))
				{
					Return (Zero)
				}
		}
		//possible end
    }  
    Scope (\)
    
    {
        If (_OSI ("Darwin"))
    {
        \_SB.PCI0.HDAS.DDDD = One
    }
    }
}