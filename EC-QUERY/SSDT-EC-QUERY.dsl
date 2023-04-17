// Make sure this SSDT loads before the keyboard remap SSDT.

DefinitionBlock ("", "SSDT", 2, "cbOSX", "croskb", 0)
{
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)
    External (_SB_.PCI0.PS2K, DeviceObj)

    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q12, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            Notify (\_SB.PCI0.PS2K, 0x40) // Reserved
        }

        Method (_Q13, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            Notify (\_SB.PCI0.PS2K, 0x41) // Reserved
        }
    }
}

 
// Credits:
// isi95010 for writing this

