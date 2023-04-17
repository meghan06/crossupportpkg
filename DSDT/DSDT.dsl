/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of DSDT.aml, Thu Apr 13 13:35:27 2023
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x0000449D (17565)
 *     Revision         0x02
 *     Checksum         0x86
 *     OEM ID           "COREv4"
 *     OEM Table ID     "COREBOOT"
 *     OEM Revision     0x20110725 (537986853)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20221020 (539103264)
 */
DefinitionBlock ("", "DSDT", 2, "COREv4", "COREBOOT", 0x20110725)
{
    External (_SB_.CNOT, MethodObj)    // 1 Arguments
    External (_SB_.CP00._PSS, PkgObj)
    External (_SB_.DPTF.TPWR, DeviceObj)
    External (_SB_.MPDL, IntObj)
    External (_SB_.MPTS, MethodObj)    // 1 Arguments
    External (_SB_.MWAK, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.A4GB, IntObj)
    External (_SB_.PCI0.A4GS, IntObj)
    External (_SB_.PCI0.EGPM, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.GFX0.LCD0, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.PTS_, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.LPCB.EC0_.RCDP, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.WAK_, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.RGPM, MethodObj)    // 0 Arguments
    External (A4GB, IntObj)
    External (A4GS, IntObj)
    External (DNVS, OpRegionObj)
    External (GNVS, OpRegionObj)
    External (MPDL, IntObj)

    Scope (\)
    {
        OperationRegion (GNVS, SystemMemory, 0x7AFFE920, 0x38)
    }

    Name (OSYS, Zero)
    Name (PICM, Zero)
    Name (PWRS, One)
    Method (_PIC, 1, NotSerialized)  // _PIC: Interrupt Model
    {
        PICM = Arg0
    }

    Scope (_SB)
    {
        Name (PCBA, 0xE0000000)
        Name (PCLN, 0x10000000)
        OperationRegion (PCFG, SystemMemory, PCBA, PCLN)
    }

    Scope (_SB)
    {
        Method (_SWS, 0, NotSerialized)  // _SWS: System Wake Source
        {
            Return (PM1I) /* \PM1I */
        }
    }

    Scope (_GPE)
    {
        Method (_SWS, 0, NotSerialized)  // _SWS: System Wake Source
        {
            Return (GPEI) /* \GPEI */
        }
    }

    Name (DBG0, Zero)
    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        DBG0 = 0x96
        If (CondRefOf (\_SB.PCI0.LPCB.EC0.PTS))
        {
            \_SB.PCI0.LPCB.EC0.PTS (Arg0)
        }

        If (CondRefOf (\_SB.MPTS))
        {
            \_SB.MPTS (Arg0)
        }

        If (CondRefOf (\_SB.PCI0.EGPM))
        {
            \_SB.PCI0.EGPM ()
        }
    }

    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        DBG0 = 0x97
        If (CondRefOf (\_SB.PCI0.LPCB.EC0.WAK))
        {
            \_SB.PCI0.LPCB.EC0.WAK (Arg0)
        }

        If (CondRefOf (\_SB.MWAK))
        {
            \_SB.MWAK (Arg0)
        }

        If (CondRefOf (\_SB.PCI0.RGPM))
        {
            \_SB.PCI0.RGPM ()
        }

        Return (Package (0x02)
        {
            Zero, 
            Zero
        })
    }

    Field (GNVS, ByteAcc, NoLock, Preserve)
    {
        Offset (0x02), 
        SMIF,   8, 
        Offset (0x04), 
        PPCM,   8, 
        TLVL,   8, 
        LIDS,   8, 
        Offset (0x08), 
        CBMC,   32, 
        PM1I,   64, 
        GPEI,   64, 
        DPTE,   8, 
        NHLA,   64, 
        NHLL,   32, 
        Offset (0x2B), 
        U2WE,   16, 
        U3WE,   16, 
        UIOR,   8, 
        Offset (0x38)
    }

    Method (PNOT, 0, NotSerialized)
    {
        \_SB.CNOT (0x81)
    }

    Method (PPCN, 0, NotSerialized)
    {
        \_SB.CNOT (0x80)
    }

    Method (TNOT, 0, NotSerialized)
    {
        \_SB.CNOT (0x82)
    }

    Scope (_SB)
    {
        Device (PCI0)
        {
            Device (IPU0)
            {
                Name (_ADR, 0x00050000)  // _ADR: Address
                Name (_DDN, "Imaging Unit")  // _DDN: DOS Device Name
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (CAMD, One)
            }

            Device (CIO2)
            {
                Name (_ADR, 0x00140003)  // _ADR: Address
                Name (_DDN, "Camera and Imaging Subsystem")  // _DDN: DOS Device Name
                Name (CAMD, Zero)
            }

            Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
            Name (_SEG, Zero)  // _SEG: PCI Segment
            Name (_UID, Zero)  // _UID: Unique ID
            Device (MCHC)
            {
                Name (_ADR, Zero)  // _ADR: Address
                OperationRegion (MCHP, PCI_Config, Zero, 0x0100)
                Field (MCHP, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x40), 
                    EPEN,   1, 
                        ,   11, 
                    EPBR,   27, 
                    Offset (0x48), 
                    MHEN,   1, 
                        ,   14, 
                    MHBR,   24, 
                    Offset (0x60), 
                    PXEN,   1, 
                    PXSZ,   2, 
                        ,   23, 
                    PXBR,   13, 
                    Offset (0x68), 
                    DIEN,   1, 
                        ,   11, 
                    DIBR,   27, 
                    Offset (0x70), 
                    MEBA,   64, 
                    Offset (0xA0), 
                    TOM,    64, 
                    TUUD,   64, 
                    Offset (0xBC), 
                    TLUD,   32
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (MCRS, ResourceTemplate ()
                {
                    WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                        0x0000,             // Granularity
                        0x0000,             // Range Minimum
                        0x00FF,             // Range Maximum
                        0x0000,             // Translation Offset
                        0x0100,             // Length
                        ,, )
                    DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                        0x00000000,         // Granularity
                        0x00000000,         // Range Minimum
                        0x00000CF7,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00000CF8,         // Length
                        ,, , TypeStatic, DenseTranslation)
                    IO (Decode16,
                        0x0CF8,             // Range Minimum
                        0x0CF8,             // Range Maximum
                        0x01,               // Alignment
                        0x08,               // Length
                        )
                    DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                        0x00000000,         // Granularity
                        0x00000D00,         // Range Minimum
                        0x0000FFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x0000F300,         // Length
                        ,, , TypeStatic, DenseTranslation)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000A0000,         // Range Minimum
                        0x000BFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00020000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000C0000,         // Range Minimum
                        0x000C3FFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00004000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000C4000,         // Range Minimum
                        0x000C7FFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00004000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000C8000,         // Range Minimum
                        0x000CBFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00004000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000CC000,         // Range Minimum
                        0x000CFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00004000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000D0000,         // Range Minimum
                        0x000D3FFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00004000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000D4000,         // Range Minimum
                        0x000D7FFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00004000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000D8000,         // Range Minimum
                        0x000DBFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00004000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000DC000,         // Range Minimum
                        0x000DFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00004000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000E0000,         // Range Minimum
                        0x000E3FFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00004000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000E4000,         // Range Minimum
                        0x000E7FFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00004000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000E8000,         // Range Minimum
                        0x000EBFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00004000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000EC000,         // Range Minimum
                        0x000EFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00004000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x000F0000,         // Range Minimum
                        0x000FFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x00010000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x00000000,         // Range Minimum
                        0xDFFFFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0xE0000000,         // Length
                        ,, _Y00, AddressRangeMemory, TypeStatic)
                    QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x0000000000010000, // Range Minimum
                        0x000000000001FFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x0000000000010000, // Length
                        ,, _Y01, AddressRangeMemory, TypeStatic)
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0xFC800000,         // Range Minimum
                        0xFE7FFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x02000000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                })
                CreateDWordField (MCRS, \_SB.PCI0._CRS._Y00._MIN, PMIN)  // _MIN: Minimum Base Address
                CreateDWordField (MCRS, \_SB.PCI0._CRS._Y00._MAX, PMAX)  // _MAX: Maximum Base Address
                CreateDWordField (MCRS, \_SB.PCI0._CRS._Y00._LEN, PLEN)  // _LEN: Length
                Local0 = (^MCHC.TLUD & 0xFFF00000)
                Local1 = ^MCHC.MEBA /* \_SB_.PCI0.MCHC.MEBA */
                If ((Local0 == Local1))
                {
                    Local0 = (^MCHC.TOM & 0x0000007FFFF00000)
                }

                PMIN = Local0
                PLEN = ((PMAX - PMIN) + One)
                If ((A4GS == Zero))
                {
                    CreateQWordField (MCRS, \_SB.PCI0._CRS._Y01._LEN, MSEN)  // _LEN: Length
                    MSEN = Zero
                }
                Else
                {
                    CreateQWordField (MCRS, \_SB.PCI0._CRS._Y01._MIN, MMIN)  // _MIN: Minimum Base Address
                    CreateQWordField (MCRS, \_SB.PCI0._CRS._Y01._MAX, MMAX)  // _MAX: Maximum Base Address
                    CreateQWordField (MCRS, \_SB.PCI0._CRS._Y01._LEN, MLEN)  // _LEN: Length
                    MLEN = A4GS /* External reference */
                    MMIN = A4GB /* External reference */
                    MMAX = ((MMIN + MLEN) - One)
                }

                Return (MCRS) /* \_SB_.PCI0._CRS.MCRS */
            }

            Method (GMHB, 0, Serialized)
            {
                Local0 = (^MCHC.MHBR << 0x0F)
                Return (Local0)
            }

            Method (GEPB, 0, Serialized)
            {
                Local0 = (^MCHC.EPBR << 0x0C)
                Return (Local0)
            }

            Method (GPCB, 0, Serialized)
            {
                Local0 = (^MCHC.PXBR << 0x1A)
                Return (Local0)
            }

            Method (GPCL, 0, Serialized)
            {
                Local0 = (0x10000000 >> ^MCHC.PXSZ) /* \_SB_.PCI0.MCHC.PXSZ */
                Return (Local0)
            }

            Method (GDMB, 0, Serialized)
            {
                Local0 = (^MCHC.DIBR << 0x0C)
                Return (Local0)
            }

            Device (PDRC)
            {
                Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                {
                    Name (BUF0, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadWrite,
                            0x00000000,         // Address Base
                            0x00008000,         // Address Length
                            _Y02)
                        Memory32Fixed (ReadWrite,
                            0x00000000,         // Address Base
                            0x00001000,         // Address Length
                            _Y03)
                        Memory32Fixed (ReadWrite,
                            0x00000000,         // Address Base
                            0x00001000,         // Address Length
                            _Y04)
                        Memory32Fixed (ReadWrite,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y05)
                        Memory32Fixed (ReadOnly,
                            0xFED90000,         // Address Base
                            0x00004000,         // Address Length
                            )
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x01000000,         // Address Length
                            _Y06)
                        Memory32Fixed (ReadOnly,
                            0xFEE00000,         // Address Base
                            0x00100000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            )
                    })
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._CRS._Y02._BAS, MBR0)  // _BAS: Base Address
                    MBR0 = GMHB ()
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._CRS._Y03._BAS, DBR0)  // _BAS: Base Address
                    DBR0 = GDMB ()
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._CRS._Y04._BAS, EBR0)  // _BAS: Base Address
                    EBR0 = GEPB ()
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._CRS._Y05._BAS, XBR0)  // _BAS: Base Address
                    XBR0 = GPCB ()
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._CRS._Y05._LEN, XSZ0)  // _LEN: Length
                    XSZ0 = GPCL ()
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._CRS._Y06._BAS, FBR0)  // _BAS: Base Address
                    FBR0 = 0xFF000000
                    Return (BUF0) /* \_SB_.PCI0.PDRC._CRS.BUF0 */
                }
            }

            Device (GFX0)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
            }

            Name (PICP, Package (0x29)
            {
                Package (0x04)
                {
                    0x001FFFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    0x02, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    0x03, 
                    Zero, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    Zero, 
                    Zero, 
                    0x14
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    One, 
                    Zero, 
                    0x15
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    0x02, 
                    Zero, 
                    0x16
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    0x03, 
                    Zero, 
                    0x17
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    0x02, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    0x03, 
                    Zero, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    0x02, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    0x03, 
                    Zero, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0019FFFF, 
                    Zero, 
                    Zero, 
                    0x20
                }, 

                Package (0x04)
                {
                    0x0019FFFF, 
                    One, 
                    Zero, 
                    0x21
                }, 

                Package (0x04)
                {
                    0x0019FFFF, 
                    0x02, 
                    Zero, 
                    0x22
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    0x02, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    0x03, 
                    Zero, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0017FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    0x02, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    0x03, 
                    Zero, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x02, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x03, 
                    Zero, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    Zero, 
                    Zero, 
                    0x14
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x02, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x03, 
                    Zero, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }
            })
            Name (PICN, Package (0x21)
            {
                Package (0x04)
                {
                    0x001FFFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001CFFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001BFFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001BFFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001BFFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x001BFFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0017FFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0002FFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0008FFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (PICP) /* \_SB_.PCI0.PICP */
                }
                Else
                {
                    Return (PICN) /* \_SB_.PCI0.PICN */
                }
            }

            Method (GRXS, 1, Serialized)
            {
                OperationRegion (PREG, SystemMemory, GADD (Arg0), 0x04)
                Field (PREG, AnyAcc, NoLock, Preserve)
                {
                        ,   1, 
                    RXST,   1
                }

                Return (RXST) /* \_SB_.PCI0.GRXS.RXST */
            }

            Method (GTXS, 1, Serialized)
            {
                OperationRegion (PREG, SystemMemory, GADD (Arg0), 0x04)
                Field (PREG, AnyAcc, NoLock, Preserve)
                {
                    TXST,   1
                }

                Return (TXST) /* \_SB_.PCI0.GTXS.TXST */
            }

            Method (STXS, 1, Serialized)
            {
                OperationRegion (PREG, SystemMemory, GADD (Arg0), 0x04)
                Field (PREG, AnyAcc, NoLock, Preserve)
                {
                    TXST,   1
                }

                TXST = One
            }

            Method (CTXS, 1, Serialized)
            {
                OperationRegion (PREG, SystemMemory, GADD (Arg0), 0x04)
                Field (PREG, AnyAcc, NoLock, Preserve)
                {
                    TXST,   1
                }

                TXST = Zero
            }

            Method (GPMO, 2, Serialized)
            {
                OperationRegion (PREG, SystemMemory, GADD (Arg0), 0x04)
                Field (PREG, AnyAcc, NoLock, Preserve)
                {
                        ,   10, 
                    MODE,   3
                }

                MODE = Arg1
            }

            Method (GTXE, 2, Serialized)
            {
                OperationRegion (PREG, SystemMemory, GADD (Arg0), 0x04)
                Field (PREG, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x01), 
                    TXDI,   1
                }

                TXDI = !Arg1
            }

            Method (GRXE, 2, Serialized)
            {
                OperationRegion (PREG, SystemMemory, GADD (Arg0), 0x04)
                Field (PREG, AnyAcc, NoLock, Preserve)
                {
                        ,   9, 
                    RXDI,   1
                }

                RXDI = !Arg1
            }

            Method (GSCI, 2, Serialized)
            {
                OperationRegion (PREG, SystemMemory, GADD (Arg0), 0x04)
                Field (PREG, AnyAcc, NoLock, Preserve)
                {
                        ,   19, 
                    SCIR,   1
                }

                SCIR = Arg1
            }

            Device (GPIO)
            {
                Name (_HID, "INT344B")  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (_DDN, "GPIO Controller")  // _DDN: DOS Device Name
                Name (RBUF, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y07)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y08)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y09)
                    Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, _Y0A)
                    {
                        0x00000000,
                    }
                })
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y07._BAS, BAS0)  // _BAS: Base Address
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y07._LEN, LEN0)  // _LEN: Length
                    BAS0 = PCRB (0xAF)
                    LEN0 = 0x00010000
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y08._BAS, BAS1)  // _BAS: Base Address
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y08._LEN, LEN1)  // _LEN: Length
                    BAS1 = PCRB (0xAE)
                    LEN1 = 0x00010000
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y09._BAS, BAS3)  // _BAS: Base Address
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y09._LEN, LEN3)  // _LEN: Length
                    BAS3 = PCRB (0xAC)
                    LEN3 = 0x00010000
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y0A._INT, IRQN)  // _INT: Interrupts
                    Local0 = (PCRR (0xAF, 0x10) & 0x08)
                    If ((Local0 == Zero))
                    {
                        IRQN = 0x0E
                    }
                    Else
                    {
                        IRQN = 0x0F
                    }

                    Return (RBUF) /* \_SB_.PCI0.GPIO.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }
            }

            Method (GADD, 1, NotSerialized)
            {
                If (((Arg0 >= Zero) && (Arg0 <= 0x2F)))
                {
                    Local0 = 0xAF
                    Local1 = (Arg0 - Zero)
                }

                If (((Arg0 >= 0x30) && (Arg0 <= 0x77)))
                {
                    Local0 = 0xAE
                    Local1 = (Arg0 - 0x30)
                }

                If (((Arg0 >= 0x78) && (Arg0 <= 0x97)))
                {
                    Local0 = 0xAC
                    Local1 = (Arg0 - 0x78)
                }

                Local2 = PCRB (Local0)
                Local2 += 0x0400
                Return ((Local2 + (Local1 * 0x08)))
            }

            OperationRegion (ITSS, SystemMemory, 0xFDC43100, 0x08)
            Field (ITSS, ByteAcc, NoLock, Preserve)
            {
                PIRA,   8, 
                PIRB,   8, 
                PIRC,   8, 
                PIRD,   8, 
                PIRE,   8, 
                PIRF,   8, 
                PIRG,   8, 
                PIRH,   8
            }

            Name (IREN, 0x80)
            Name (IREM, 0x0F)
            Device (LNKA)
            {
                Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                {
                    IRQ (Level, ActiveLow, Shared, )
                        {3,4,5,6,10,11,12,14,15}
                })
                Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                {
                    Name (RTLA, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {}
                    })
                    CreateWordField (RTLA, One, IRQ0)
                    IRQ0 = Zero
                    IRQ0 = (One << (PIRA & IREM))
                    Return (RTLA) /* \_SB_.PCI0.LNKA._CRS.RTLA */
                }

                Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                {
                    CreateWordField (Arg0, One, IRQ0)
                    FindSetRightBit (IRQ0, Local0)
                    Local0--
                    PIRA = Local0
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    If ((PIRA & IREN))
                    {
                        Return (0x09)
                    }
                    Else
                    {
                        Return (0x0B)
                    }
                }

                Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                {
                    PIRA |= IREN /* \_SB_.PCI0.IREN */
                }
            }

            Device (LNKB)
            {
                Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                Name (_UID, 0x02)  // _UID: Unique ID
                Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                {
                    IRQ (Level, ActiveLow, Shared, )
                        {3,4,5,6,10,11,12,14,15}
                })
                Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                {
                    Name (RTLA, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {}
                    })
                    CreateWordField (RTLA, One, IRQ0)
                    IRQ0 = Zero
                    IRQ0 = (One << (PIRB & IREM))
                    Return (RTLA) /* \_SB_.PCI0.LNKB._CRS.RTLA */
                }

                Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                {
                    CreateWordField (Arg0, One, IRQ0)
                    FindSetRightBit (IRQ0, Local0)
                    Local0--
                    PIRB = Local0
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    If ((PIRB & IREN))
                    {
                        Return (0x09)
                    }
                    Else
                    {
                        Return (0x0B)
                    }
                }

                Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                {
                    PIRB |= IREN /* \_SB_.PCI0.IREN */
                }
            }

            Device (LNKC)
            {
                Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                Name (_UID, 0x03)  // _UID: Unique ID
                Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                {
                    IRQ (Level, ActiveLow, Shared, )
                        {3,4,5,6,10,11,12,14,15}
                })
                Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                {
                    Name (RTLA, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {}
                    })
                    CreateWordField (RTLA, One, IRQ0)
                    IRQ0 = Zero
                    IRQ0 = (One << (PIRC & IREM))
                    Return (RTLA) /* \_SB_.PCI0.LNKC._CRS.RTLA */
                }

                Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                {
                    CreateWordField (Arg0, One, IRQ0)
                    FindSetRightBit (IRQ0, Local0)
                    Local0--
                    PIRC = Local0
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    If ((PIRC & IREN))
                    {
                        Return (0x09)
                    }
                    Else
                    {
                        Return (0x0B)
                    }
                }

                Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                {
                    PIRC |= IREN /* \_SB_.PCI0.IREN */
                }
            }

            Device (LNKD)
            {
                Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                Name (_UID, 0x04)  // _UID: Unique ID
                Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                {
                    IRQ (Level, ActiveLow, Shared, )
                        {3,4,5,6,10,11,12,14,15}
                })
                Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                {
                    Name (RTLA, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {}
                    })
                    CreateWordField (RTLA, One, IRQ0)
                    IRQ0 = Zero
                    IRQ0 = (One << (PIRD & IREM))
                    Return (RTLA) /* \_SB_.PCI0.LNKD._CRS.RTLA */
                }

                Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                {
                    CreateWordField (Arg0, One, IRQ0)
                    FindSetRightBit (IRQ0, Local0)
                    Local0--
                    PIRD = Local0
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    If ((PIRD & IREN))
                    {
                        Return (0x09)
                    }
                    Else
                    {
                        Return (0x0B)
                    }
                }

                Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                {
                    PIRD |= IREN /* \_SB_.PCI0.IREN */
                }
            }

            Device (LNKE)
            {
                Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                Name (_UID, 0x05)  // _UID: Unique ID
                Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                {
                    IRQ (Level, ActiveLow, Shared, )
                        {3,4,5,6,10,11,12,14,15}
                })
                Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                {
                    Name (RTLA, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {}
                    })
                    CreateWordField (RTLA, One, IRQ0)
                    IRQ0 = Zero
                    IRQ0 = (One << (PIRE & IREM))
                    Return (RTLA) /* \_SB_.PCI0.LNKE._CRS.RTLA */
                }

                Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                {
                    CreateWordField (Arg0, One, IRQ0)
                    FindSetRightBit (IRQ0, Local0)
                    Local0--
                    PIRE = Local0
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    If ((PIRE & IREN))
                    {
                        Return (0x09)
                    }
                    Else
                    {
                        Return (0x0B)
                    }
                }

                Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                {
                    PIRE |= IREN /* \_SB_.PCI0.IREN */
                }
            }

            Device (LNKF)
            {
                Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                Name (_UID, 0x06)  // _UID: Unique ID
                Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                {
                    IRQ (Level, ActiveLow, Shared, )
                        {3,4,5,6,10,11,12,14,15}
                })
                Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                {
                    Name (RTLA, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {}
                    })
                    CreateWordField (RTLA, One, IRQ0)
                    IRQ0 = Zero
                    IRQ0 = (One << (PIRF & IREM))
                    Return (RTLA) /* \_SB_.PCI0.LNKF._CRS.RTLA */
                }

                Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                {
                    CreateWordField (Arg0, One, IRQ0)
                    FindSetRightBit (IRQ0, Local0)
                    Local0--
                    PIRF = Local0
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    If ((PIRF & IREN))
                    {
                        Return (0x09)
                    }
                    Else
                    {
                        Return (0x0B)
                    }
                }

                Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                {
                    PIRF |= IREN /* \_SB_.PCI0.IREN */
                }
            }

            Device (LNKG)
            {
                Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                Name (_UID, 0x07)  // _UID: Unique ID
                Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                {
                    IRQ (Level, ActiveLow, Shared, )
                        {3,4,5,6,10,11,12,14,15}
                })
                Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                {
                    Name (RTLA, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {}
                    })
                    CreateWordField (RTLA, One, IRQ0)
                    IRQ0 = Zero
                    IRQ0 = (One << (PIRG & IREM))
                    Return (RTLA) /* \_SB_.PCI0.LNKG._CRS.RTLA */
                }

                Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                {
                    CreateWordField (Arg0, One, IRQ0)
                    FindSetRightBit (IRQ0, Local0)
                    Local0--
                    PIRG = Local0
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    If ((PIRG & IREN))
                    {
                        Return (0x09)
                    }
                    Else
                    {
                        Return (0x0B)
                    }
                }

                Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                {
                    PIRG |= IREN /* \_SB_.PCI0.IREN */
                }
            }

            Device (LNKH)
            {
                Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                Name (_UID, 0x08)  // _UID: Unique ID
                Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                {
                    IRQ (Level, ActiveLow, Shared, )
                        {3,4,5,6,10,11,12,14,15}
                })
                Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                {
                    Name (RTLA, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared, )
                            {}
                    })
                    CreateWordField (RTLA, One, IRQ0)
                    IRQ0 = Zero
                    IRQ0 = (One << (PIRH & IREM))
                    Return (RTLA) /* \_SB_.PCI0.LNKH._CRS.RTLA */
                }

                Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                {
                    CreateWordField (Arg0, One, IRQ0)
                    FindSetRightBit (IRQ0, Local0)
                    Local0--
                    PIRH = Local0
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    If ((PIRH & IREN))
                    {
                        Return (0x09)
                    }
                    Else
                    {
                        Return (0x0B)
                    }
                }

                Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                {
                    PIRH |= IREN /* \_SB_.PCI0.IREN */
                }
            }

            Device (LPCB)
            {
                Name (_ADR, 0x001F0000)  // _ADR: Address
                Name (_DDN, "LPC Bus Device")  // _DDN: DOS Device Name
                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        IO (Decode16,
                            0x0081,             // Range Minimum
                            0x0081,             // Range Maximum
                            0x01,               // Alignment
                            0x11,               // Length
                            )
                        IO (Decode16,
                            0x0093,             // Range Minimum
                            0x0093,             // Range Maximum
                            0x01,               // Alignment
                            0x0D,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        DMA (Compatibility, NotBusMaster, Transfer8_16, )
                            {4}
                    })
                }

                Device (FWH)
                {
                    Name (_HID, EisaId ("INT0800") /* Intel 82802 Firmware Hub Device */)  // _HID: Hardware ID
                    Name (_DDN, "Firmware Hub")  // _DDN: DOS Device Name
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        Memory32Fixed (ReadOnly,
                            0xFF000000,         // Address Base
                            0x01000000,         // Address Length
                            )
                    })
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
                    Name (_CID, EisaId ("PNP0C01") /* System Board */)  // _CID: Compatible ID
                    Name (_DDN, "High Precision Event Timer")  // _DDN: DOS Device Name
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        Memory32Fixed (ReadWrite,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            )
                    })
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }
                }

                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04") /* x87-compatible Floating Point Processing Unit */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000") /* 8259-compatible Programmable Interrupt Controller */)  // _HID: Hardware ID
                    Name (_DDN, "8259 Interrupt Controller")  // _DDN: DOS Device Name
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0024,             // Range Minimum
                            0x0024,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0028,             // Range Minimum
                            0x0028,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x002C,             // Range Minimum
                            0x002C,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0030,             // Range Minimum
                            0x0030,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0034,             // Range Minimum
                            0x0034,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0038,             // Range Minimum
                            0x0038,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x003C,             // Range Minimum
                            0x003C,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A4,             // Range Minimum
                            0x00A4,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A8,             // Range Minimum
                            0x00A8,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00AC,             // Range Minimum
                            0x00AC,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B0,             // Range Minimum
                            0x00B0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B4,             // Range Minimum
                            0x00B4,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B8,             // Range Minimum
                            0x00B8,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00BC,             // Range Minimum
                            0x00BC,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {2}
                    })
                }

                Device (LDRC)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, 0x02)  // _UID: Unique ID
                    Name (_DDN, "Legacy Device Resources")  // _DDN: DOS Device Name
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x002E,             // Range Minimum
                            0x002E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x004E,             // Range Minimum
                            0x004E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0063,             // Range Minimum
                            0x0063,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0065,             // Range Minimum
                            0x0065,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0067,             // Range Minimum
                            0x0067,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0092,             // Range Minimum
                            0x0092,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x00B2,             // Range Minimum
                            0x00B2,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x1800,             // Range Minimum
                            0x1800,             // Range Maximum
                            0x01,               // Alignment
                            0xFF,               // Length
                            )
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
                    Name (_DDN, "Real Time Clock")  // _DDN: DOS Device Name
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                    })
                }

                Device (TIMR)
                {
                    Name (_HID, EisaId ("PNP0100") /* PC-class System Timer */)  // _HID: Hardware ID
                    Name (_DDN, "8254 Timer")  // _DDN: DOS Device Name
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                        IO (Decode16,
                            0x0050,             // Range Minimum
                            0x0050,             // Range Maximum
                            0x10,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {0}
                    })
                }
            }

            Scope (LPCB)
            {
            }

            Device (HDAS)
            {
                Name (_ADR, 0x001F0003)  // _ADR: Address
                Name (_DDN, "Audio Controller")  // _DDN: DOS Device Name
                Name (UUID, ToUUID ("a69f886e-6ceb-4594-a41f-7b5dce24c553") /* Unknown UUID */)
                Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
                Name (NBUF, ResourceTemplate ()
                {
                    QWordMemory (ResourceConsumer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadOnly,
                        0x0000000000000000, // Granularity
                        0x0000000000000000, // Range Minimum
                        0x0000000000000000, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x0000000000000001, // Length
                        ,, _Y0B, AddressRangeACPI, TypeStatic)
                })
                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg0 == UUID))
                    {
                        If ((Arg2 == Zero))
                        {
                            If ((((Arg1 == One) && (NHLA != Zero)) && (
                                NHLL != Zero)))
                            {
                                Return (Buffer (One)
                                {
                                     0x03                                             // .
                                })
                            }
                            Else
                            {
                                Return (Buffer (One)
                                {
                                     0x01                                             // .
                                })
                            }
                        }

                        If ((Arg2 == One))
                        {
                            CreateQWordField (NBUF, \_SB.PCI0.	._Y0B._MIN, NBAS)  // _MIN: Minimum Base Address
                            CreateQWordField (NBUF, \_SB.PCI0.HDAS._Y0B._MAX, NMAS)  // _MAX: Maximum Base Address
                            CreateQWordField (NBUF, \_SB.PCI0.HDAS._Y0B._LEN, NLEN)  // _LEN: Length
                            NBAS = NHLA /* \NHLA */
                            NMAS = NHLA /* \NHLA */
                            NLEN = NHLL /* \NHLL */
                            Return (NBUF) /* \_SB_.PCI0.HDAS.NBUF */
                        }
                    }

                    Return (Buffer (One)
                    {
                         0x00                                             // .
                    })
                }
            }

            Method (IRQM, 1, Serialized)
            {
                Name (IQAA, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x13
                    }
                })
                Name (IQAP, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKD, 
                        Zero
                    }
                })
                Name (IQBA, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x10
                    }
                })
                Name (IQBP, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKA, 
                        Zero
                    }
                })
                Name (IQCA, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x11
                    }
                })
                Name (IQCP, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKB, 
                        Zero
                    }
                })
                Name (IQDA, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x12
                    }
                })
                Name (IQDP, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKC, 
                        Zero
                    }
                })
                Switch (ToInteger (Arg0))
                {
                    Case (Package (0x04)
                        {
                            One, 
                            0x05, 
                            0x09, 
                            0x0D
                        }

)
                    {
                        If (PICM)
                        {
                            Return (IQAA) /* \_SB_.PCI0.IRQM.IQAA */
                        }
                        Else
                        {
                            Return (IQAP) /* \_SB_.PCI0.IRQM.IQAP */
                        }
                    }
                    Case (Package (0x04)
                        {
                            0x02, 
                            0x06, 
                            0x0A, 
                            0x0E
                        }

)
                    {
                        If (PICM)
                        {
                            Return (IQBA) /* \_SB_.PCI0.IRQM.IQBA */
                        }
                        Else
                        {
                            Return (IQBP) /* \_SB_.PCI0.IRQM.IQBP */
                        }
                    }
                    Case (Package (0x04)
                        {
                            0x03, 
                            0x07, 
                            0x0B, 
                            0x0F
                        }

)
                    {
                        If (PICM)
                        {
                            Return (IQCA) /* \_SB_.PCI0.IRQM.IQCA */
                        }
                        Else
                        {
                            Return (IQCP) /* \_SB_.PCI0.IRQM.IQCP */
                        }
                    }
                    Case (Package (0x04)
                        {
                            0x04, 
                            0x08, 
                            0x0C, 
                            0x10
                        }

)
                    {
                        If (PICM)
                        {
                            Return (IQDA) /* \_SB_.PCI0.IRQM.IQDA */
                        }
                        Else
                        {
                            Return (IQDP) /* \_SB_.PCI0.IRQM.IQDP */
                        }
                    }
                    Default
                    {
                        If (PICM)
                        {
                            Return (IQDA) /* \_SB_.PCI0.IRQM.IQDA */
                        }
                        Else
                        {
                            Return (IQDP) /* \_SB_.PCI0.IRQM.IQDP */
                        }
                    }

                }
            }

            Device (RP01)
            {
                Name (_ADR, 0x001C0000)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP02)
            {
                Name (_ADR, 0x001C0001)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP03)
            {
                Name (_ADR, 0x001C0002)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP04)
            {
                Name (_ADR, 0x001C0003)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP05)
            {
                Name (_ADR, 0x001C0004)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP06)
            {
                Name (_ADR, 0x001C0005)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP07)
            {
                Name (_ADR, 0x001C0006)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP08)
            {
                Name (_ADR, 0x001C0007)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP09)
            {
                Name (_ADR, 0x001D0000)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP10)
            {
                Name (_ADR, 0x001D0001)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP11)
            {
                Name (_ADR, 0x001D0002)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP12)
            {
                Name (_ADR, 0x001D0003)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP13)
            {
                Name (_ADR, 0x001D0004)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP14)
            {
                Name (_ADR, 0x001D0005)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP15)
            {
                Name (_ADR, 0x001D0006)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Device (RP16)
            {
                Name (_ADR, 0x001D0007)  // _ADR: Address
                OperationRegion (RPCS, PCI_Config, 0x4C, 0x04)
                Field (RPCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                    RPPN,   8
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (IRQM (RPPN))
                }
            }

            Method (PCRB, 1, NotSerialized)
            {
                Return ((0xFD000000 + (Arg0 << 0x10)))
            }

            Method (PCRR, 2, Serialized)
            {
                OperationRegion (PCRD, SystemMemory, (PCRB (Arg0) + Arg1), 0x04)
                Field (PCRD, DWordAcc, NoLock, Preserve)
                {
                    DATA,   32
                }

                Return (DATA) /* \_SB_.PCI0.PCRR.DATA */
            }

            Method (PCRA, 3, Serialized)
            {
                OperationRegion (PCRD, SystemMemory, (PCRB (Arg0) + Arg1), 0x04)
                Field (PCRD, DWordAcc, NoLock, Preserve)
                {
                    DATA,   32
                }

                DATA &= Arg2
                PCRR (Arg0, Arg1)
            }

            Method (PCRO, 3, Serialized)
            {
                OperationRegion (PCRD, SystemMemory, (PCRB (Arg0) + Arg1), 0x04)
                Field (PCRD, DWordAcc, NoLock, Preserve)
                {
                    DATA,   32
                }

                DATA |= Arg2
                PCRR (Arg0, Arg1)
            }

            Device (PMC)
            {
                Name (_ADR, 0x001F0002)  // _ADR: Address
                Name (_DDN, "Power Management Controller")  // _DDN: DOS Device Name
                OperationRegion (PMCP, PCI_Config, Zero, 0x0100)
                Field (PMCP, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x48), 
                        ,   12, 
                    PWRM,   20
                }

                OperationRegion (PMCM, SystemMemory, (PWRM << 0x0C), 0x3F)
                Field (PMCM, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x1C), 
                    Offset (0x1F), 
                    PMFS,   1, 
                    Offset (0x20), 
                    MPMC,   32, 
                    Offset (0x24), 
                        ,   20, 
                    UWAB,   1
                }
            }

            Device (I2C0)
            {
                Name (_ADR, 0x00150000)  // _ADR: Address
                Name (_DDN, "Serial IO I2C Controller 0")  // _DDN: DOS Device Name
            }

            Device (I2C1)
            {
                Name (_ADR, 0x00150001)  // _ADR: Address
                Name (_DDN, "Serial IO I2C Controller 1")  // _DDN: DOS Device Name
            }

            Device (I2C2)
            {
                Name (_ADR, 0x00150002)  // _ADR: Address
                Name (_DDN, "Serial IO I2C Controller 2")  // _DDN: DOS Device Name
            }

            Device (I2C3)
            {
                Name (_ADR, 0x00150003)  // _ADR: Address
                Name (_DDN, "Serial IO I2C Controller 3")  // _DDN: DOS Device Name
            }

            Device (I2C4)
            {
                Name (_ADR, 0x00190002)  // _ADR: Address
                Name (_DDN, "Serial IO I2C Controller 4")  // _DDN: DOS Device Name
            }

            Device (I2C5)
            {
                Name (_ADR, 0x00190001)  // _ADR: Address
                Name (_DDN, "Serial IO I2C Controller 5")  // _DDN: DOS Device Name
            }

            Device (SPI0)
            {
                Name (_ADR, 0x001E0002)  // _ADR: Address
                Name (_DDN, "Serial IO SPI Controller 0")  // _DDN: DOS Device Name
            }

            Device (SPI1)
            {
                Name (_ADR, 0x001E0003)  // _ADR: Address
                Name (_DDN, "Serial IO SPI Controller 1")  // _DDN: DOS Device Name
            }

            Device (UAR0)
            {
                Name (_ADR, 0x001E0000)  // _ADR: Address
                Name (_DDN, "Serial IO UART Controller 0")  // _DDN: DOS Device Name
            }

            Device (UAR1)
            {
                Name (_ADR, 0x001E0001)  // _ADR: Address
                Name (_DDN, "Serial IO UART Controller 1")  // _DDN: DOS Device Name
            }

            Device (UAR2)
            {
                Name (_ADR, 0x00190000)  // _ADR: Address
                Name (_DDN, "Serial IO UART Controller 2")  // _DDN: DOS Device Name
            }

            Device (SBUS)
            {
                Name (_ADR, 0x001F0004)  // _ADR: Address
            }

            Device (EMMC)
            {
                Name (_ADR, 0x001E0004)  // _ADR: Address
                Name (_DDN, "eMMC Controller")  // _DDN: DOS Device Name
                Name (UUID, ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */)
                Name (TEMP, Zero)
                OperationRegion (EMCR, PCI_Config, Zero, 0x0100)
                Field (EMCR, WordAcc, NoLock, Preserve)
                {
                    Offset (0x84), 
                    PMCR,   16, 
                    Offset (0xA2), 
                        ,   2, 
                    PGEN,   1
                }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg0 == UUID))
                    {
                        If ((Arg2 == 0x09))
                        {
                            If ((Arg1 == 0x03))
                            {
                                Return (Package (0x05)
                                {
                                    Zero, 
                                    Ones, 
                                    Ones, 
                                    Ones, 
                                    Ones
                                })
                            }
                        }
                    }

                    Return (Buffer (One)
                    {
                         0x00                                             // .
                    })
                }

                Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                {
                    PGEN = Zero
                    PCRA (0xC0, 0x0600, 0x7FFFFFBA)
                    Sleep (0x02)
                    PCRO (0xC0, 0x0600, 0x80000045)
                    PMCR &= 0xFFFC
                    TEMP = PMCR /* \_SB_.PCI0.EMMC.PMCR */
                }

                Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                {
                    PGEN = One
                    PMCR |= 0x03
                    TEMP = PMCR /* \_SB_.PCI0.EMMC.PMCR */
                }

                Device (CARD)
                {
                    Name (_ADR, 0x08)  // _ADR: Address
                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (Zero)
                    }
                }
            }

            Device (SDXC)
            {
                Name (_ADR, 0x001E0006)  // _ADR: Address
                Name (_DDN, "SD Controller")  // _DDN: DOS Device Name
                Name (TEMP, Zero)
                OperationRegion (SDCR, PCI_Config, Zero, 0x0100)
                Field (SDCR, WordAcc, NoLock, Preserve)
                {
                    Offset (0x84), 
                    PMCR,   16, 
                    Offset (0xA2), 
                        ,   2, 
                    PGEN,   1
                }

                Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                {
                    PCRA (0xAC, 0x04C4, 0xFFFFEFFF)
                    PCRA (0xAC, 0x04CC, 0xFFFFEFFF)
                    PCRA (0xAC, 0x04D4, 0xFFFFEFFF)
                    PCRA (0xAC, 0x04DC, 0xFFFFEFFF)
                    PCRA (0xAC, 0x04E4, 0xFFFFEFFF)
                    PCRA (0xAC, 0x04F4, 0xFFFFEFFF)
                    PGEN = Zero
                    PCRA (0xC0, 0x0600, 0xFFFFFE7A)
                    Sleep (0x02)
                    PCRO (0xC0, 0x0600, 0x0185)
                    PMCR &= 0xFFFC
                    TEMP = PMCR /* \_SB_.PCI0.SDXC.PMCR */
                }

                Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                {
                    PGEN = One
                    PMCR |= 0x03
                    TEMP = PMCR /* \_SB_.PCI0.SDXC.PMCR */
                    PCRO (0xAC, 0x04C4, 0x1000)
                    PCRO (0xAC, 0x04CC, 0x1000)
                    PCRO (0xAC, 0x04D4, 0x1000)
                    PCRO (0xAC, 0x04DC, 0x1000)
                    PCRO (0xAC, 0x04E4, 0x1000)
                    PCRO (0xAC, 0x04F4, 0x1000)
                }

                Device (CARD)
                {
                    Name (_ADR, 0x08)  // _ADR: Address
                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (One)
                    }
                }
            }

            Method (UPWE, 3, Serialized)
            {
                Local0 = (Arg1 + ((Arg0 - One) * 0x10))
                OperationRegion (PSCR, SystemMemory, ((Arg2 << 0x10) + Local0), 0x10)
                Field (PSCR, DWordAcc, NoLock, Preserve)
                {
                    PSCT,   32
                }

                Local0 = PSCT /* \_SB_.PCI0.UPWE.PSCT */
                Local0 &= 0xFFFFFFFF7F01FFED
                Local0 |= 0x06000000
                PSCT = Local0
            }

            Method (UWES, 3, Serialized)
            {
                Local0 = Arg0
                While (One)
                {
                    FindSetRightBit (Local0, Local1)
                    If ((Local1 == Zero))
                    {
                        Break
                    }

                    UPWE (Local1, Arg1, Arg2)
                    Local0 &= (Local0 - One)
                }
            }

            Device (XHCI)
            {
                Name (_ADR, 0x00140000)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x6D, 
                    0x03
                })
                Method (_DSW, 3, NotSerialized)  // _DSW: Device Sleep Wake
                {
                    PMEE = Arg0
                    UWES ((U2WE & 0x03FF), 0x0480, XMEM)
                    UWES ((U3WE & 0x3F), 0x0540, XMEM)
                }

                Name (_S3D, 0x03)  // _S3D: S3 Device State
                Name (_S4D, 0x03)  // _S4D: S4 Device State
                Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
                Name (_S3W, 0x03)  // _S3W: S3 Device Wake State
                Name (_S4W, 0x03)  // _S4W: S4 Device Wake State
                OperationRegion (XPRT, PCI_Config, Zero, 0x0100)
                Field (XPRT, AnyAcc, NoLock, Preserve)
                {
                    DVID,   16, 
                    Offset (0x10), 
                    Offset (0x12), 
                    XMEM,   16, 
                    Offset (0x50), 
                        ,   2, 
                    STGE,   1, 
                    Offset (0x74), 
                    D0D3,   2, 
                    Offset (0x75), 
                    PMEE,   1, 
                        ,   6, 
                    PMES,   1, 
                    Offset (0xA2), 
                        ,   2, 
                    D3HE,   1
                }

                OperationRegion (XREG, SystemMemory, ((XMEM << 0x10) + 0x8000), 0x0200)
                Field (XREG, DWordAcc, Lock, Preserve)
                {
                    Offset (0x1C4), 
                        ,   2, 
                    UPSW,   2
                }

                Method (_PSC, 0, Serialized)  // _PSC: Power State Current
                {
                    Return (D0D3) /* \_SB_.PCI0.XHCI.D0D3 */
                }

                Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                {
                    If ((DVID != 0xFFFF))
                    {
                        If (!((XMEM == 0xFFFF) || (XMEM == Zero)))
                        {
                            D3HE = Zero
                            STGE = Zero
                            If ((D0D3 == 0x03))
                            {
                                Local0 = Zero
                                D0D3 = Local0
                                Local0 = D0D3 /* \_SB_.PCI0.XHCI.D0D3 */
                            }

                            UPSW = Zero
                            If (^^PMC.UWAB)
                            {
                                ^^PMC.MPMC = One
                                Local0 = 0x0A
                                While (^^PMC.PMFS)
                                {
                                    If (!Local0)
                                    {
                                        Break
                                    }

                                    Local0--
                                    Sleep (0x0A)
                                }
                            }
                        }
                    }
                }

                Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                {
                    If ((DVID != 0xFFFF))
                    {
                        If (!((XMEM == 0xFFFF) || (XMEM == Zero)))
                        {
                            PMES = One
                            PMEE = One
                            If ((D0D3 == 0x03))
                            {
                                Local0 = Zero
                                D0D3 = Local0
                                Local0 = D0D3 /* \_SB_.PCI0.XHCI.D0D3 */
                            }

                            UPSW = 0x03
                            D3HE = One
                            STGE = One
                            Local0 = 0x03
                            D0D3 = Local0
                            Local0 = D0D3 /* \_SB_.PCI0.XHCI.D0D3 */
                            If (^^PMC.UWAB)
                            {
                                ^^PMC.MPMC = 0x03
                                Local0 = 0x0A
                                While (^^PMC.PMFS)
                                {
                                    If (!Local0)
                                    {
                                        Break
                                    }

                                    Local0--
                                    Sleep (0x0A)
                                }
                            }
                        }
                    }
                }

                Device (RHUB)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (GPLD, 1, Serialized)
                    {
                        Name (PCKG, Package (0x01)
                        {
                            Buffer (0x10){}
                        })
                        CreateField (DerefOf (PCKG [Zero]), Zero, 0x07, REV)
                        REV = 0x02
                        CreateField (DerefOf (PCKG [Zero]), 0x40, One, VISI)
                        VISI = Arg0
                        Return (PCKG) /* \_SB_.PCI0.XHCI.RHUB.GPLD.PCKG */
                    }

                    Device (HS01)
                    {
                        Name (_ADR, One)  // _ADR: Address
                    }

                    Device (HS02)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                    }

                    Device (HS03)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                    }

                    Device (HS04)
                    {
                        Name (_ADR, 0x04)  // _ADR: Address
                    }

                    Device (HS05)
                    {
                        Name (_ADR, 0x05)  // _ADR: Address
                    }

                    Device (HS06)
                    {
                        Name (_ADR, 0x06)  // _ADR: Address
                    }

                    Device (HS07)
                    {
                        Name (_ADR, 0x07)  // _ADR: Address
                    }

                    Device (HS08)
                    {
                        Name (_ADR, 0x08)  // _ADR: Address
                    }

                    Device (HS09)
                    {
                        Name (_ADR, 0x09)  // _ADR: Address
                    }

                    Device (HS10)
                    {
                        Name (_ADR, 0x0A)  // _ADR: Address
                    }

                    Device (USR1)
                    {
                        Name (_ADR, 0x0B)  // _ADR: Address
                    }

                    Device (USR2)
                    {
                        Name (_ADR, 0x0C)  // _ADR: Address
                    }

                    Device (SS01)
                    {
                        Name (_ADR, 0x0D)  // _ADR: Address
                    }

                    Device (SS02)
                    {
                        Name (_ADR, 0x0E)  // _ADR: Address
                    }

                    Device (SS03)
                    {
                        Name (_ADR, 0x0F)  // _ADR: Address
                    }

                    Device (SS04)
                    {
                        Name (_ADR, 0x10)  // _ADR: Address
                    }

                    Device (SS05)
                    {
                        Name (_ADR, 0x11)  // _ADR: Address
                    }

                    Device (SS06)
                    {
                        Name (_ADR, 0x12)  // _ADR: Address
                    }
                }
            }

            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
            {
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    Return (Arg3)
                }
                Else
                {
                    CreateDWordField (Arg3, Zero, CDW1)
                    CDW1 |= 0x04
                    Return (Arg3)
                }
            }

            Scope (GFX0)
            {
                OperationRegion (GFXC, PCI_Config, Zero, 0x0100)
                Field (GFXC, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x10), 
                    BAR0,   64, 
                    Offset (0xE4), 
                    ASLE,   32, 
                    Offset (0xFC), 
                    ASLS,   32
                }

                OperationRegion (GFRG, SystemMemory, (BAR0 & 0xFFFFFFFFFFFFFFF0), 0x00400000)
                Field (GFRG, DWordAcc, NoLock, Preserve)
                {
                    Offset (0xC8254), 
                    BCLV,   16
                }

                Field (GFRG, DWordAcc, NoLock, Preserve)
                {
                    Offset (0xC8256), 
                    BCLM,   16
                }

                Device (BOX3)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    OperationRegion (OPRG, SystemMemory, ASLS, 0x2000)
                    Field (OPRG, DWordAcc, NoLock, Preserve)
                    {
                        Offset (0x58), 
                        MBOX,   32, 
                        Offset (0x300), 
                        ARDY,   1, 
                        Offset (0x304), 
                        ASLC,   32, 
                        TCHE,   32, 
                        ALSI,   32, 
                        BCLP,   32, 
                        PFIT,   32, 
                        CBLV,   32
                    }

                    Method (XBCM, 1, Serialized)
                    {
                        If ((ASLS == Zero))
                        {
                            Return (Ones)
                        }

                        If ((MBOX & Zero))
                        {
                            Return (Ones)
                        }

                        Local1 = ((Arg0 * 0xFF) / 0x64)
                        If ((Local1 > 0xFF))
                        {
                            Local1 = 0xFF
                        }

                        BCLP = (Local1 | 0x80000000)
                        If ((ARDY == Zero))
                        {
                            Return (Ones)
                        }

                        ASLC = 0x02
                        ASLE = One
                        Local0 = 0x20
                        While ((Local0 > Zero))
                        {
                            Sleep (One)
                            If ((ASLC & Zero))
                            {
                                Local1 = ((ASLC >> 0x0C) & 0x03)
                                If ((Local1 == Zero))
                                {
                                    Return (Zero)
                                }
                                Else
                                {
                                    Return (Ones)
                                }
                            }

                            Local0--
                        }

                        Return (Ones)
                    }
                }

                Device (LEGA)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (DRCL, 2, NotSerialized)
                    {
                        Return (((Arg0 + (Arg1 / 0x02)) / Arg1))
                    }

                    Method (XBCM, 1, NotSerialized)
                    {
                        BCLV = DRCL ((Arg0 * BCLM), 0x64)
                    }

                    Method (XBQC, 0, NotSerialized)
                    {
                        If ((BCLM == Zero))
                        {
                            Return (Zero)
                        }

                        Local0 = DRCL ((BCLV * 0x64), BCLM)
                        Local1 = 0x02
                        While ((Local1 < (SizeOf (BRIG) - One)))
                        {
                            Local2 = DerefOf (BRIG [Local1])
                            Local3 = DerefOf (BRIG [(Local1 + One)])
                            If ((Local0 < Local3))
                            {
                                If (((Local0 < Local2) || ((Local0 - Local2) < (Local3 - 
                                    Local0))))
                                {
                                    Return (Local2)
                                }
                                Else
                                {
                                    Return (Local3)
                                }
                            }

                            Local1++
                        }

                        Return (Local3)
                    }
                }

                Method (XBCM, 1, NotSerialized)
                {
                    If ((^BOX3.XBCM (Arg0) == Ones))
                    {
                        ^LEGA.XBCM (Arg0)
                    }
                }

                Method (XBQC, 0, NotSerialized)
                {
                    Return (^LEGA.XBQC ())
                }

                Name (BRCT, Zero)
                Method (BRID, 1, NotSerialized)
                {
                    Local0 = Match (BRIG, MEQ, Arg0, MTR, Zero, 0x02)
                    If ((Local0 == Ones))
                    {
                        Return ((SizeOf (BRIG) - One))
                    }

                    Return (Local0)
                }

                Method (XBCL, 0, NotSerialized)
                {
                    BRCT = One
                    Return (BRIG) /* \_SB_.PCI0.GFX0.BRIG */
                }

                Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
                {
                }

                Method (DECB, 0, NotSerialized)
                {
                    If (BRCT)
                    {
                        Notify (LCD0, 0x87) // Device-Specific
                    }
                    Else
                    {
                        Local0 = BRID (XBQC ())
                        If ((Local0 != 0x02))
                        {
                            Local0--
                        }

                        XBCM (DerefOf (BRIG [Local0]))
                    }
                }

                Method (INCB, 0, NotSerialized)
                {
                    If (BRCT)
                    {
                        Notify (LCD0, 0x86) // Device-Specific
                    }
                    Else
                    {
                        Local0 = BRID (XBQC ())
                        If ((Local0 != (SizeOf (BRIG) - One)))
                        {
                            Local0++
                        }

                        XBCM (DerefOf (BRIG [Local0]))
                    }
                }
            }

            Scope (GFX0)
            {
                Name (BRIG, Package (0x12)
                {
                    0x64, 
                    0x64, 
                    0x02, 
                    0x04, 
                    0x05, 
                    0x07, 
                    0x09, 
                    0x0B, 
                    0x0D, 
                    0x12, 
                    0x14, 
                    0x18, 
                    0x1D, 
                    0x21, 
                    0x28, 
                    0x32, 
                    0x43, 
                    0x64
                })
            }
        }
    }

    Name (_S0, Package (0x04)  // _S0_: S0 System State
    {
        Zero, 
        Zero, 
        Zero, 
        Zero
    })
    Name (_S3, Package (0x04)  // _S3_: S3 System State
    {
        0x05, 
        Zero, 
        Zero, 
        Zero
    })
    Name (_S4, Package (0x04)  // _S4_: S4 System State
    {
        0x06, 
        Zero, 
        Zero, 
        Zero
    })
    Name (_S5, Package (0x04)  // _S5_: S5 System State
    {
        0x07, 
        Zero, 
        Zero, 
        Zero
    })
    Scope (_SB.PCI0.LPCB)
    {
        Device (SIO)
        {
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_ADR, Zero)  // _ADR: Address
            Device (ECMM)
            {
                Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                Name (_UID, 0x04)  // _UID: Unique ID
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    IO (Decode16,
                        0x0900,             // Range Minimum
                        0x0900,             // Range Maximum
                        0x08,               // Alignment
                        0xFF,               // Length
                        )
                })
            }

            Device (ECUI)
            {
                Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                Name (_UID, 0x03)  // _UID: Unique ID
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    IO (Decode16,
                        0x0200,             // Range Minimum
                        0x0200,             // Range Maximum
                        0x01,               // Alignment
                        0x01,               // Length
                        )
                    IO (Decode16,
                        0x0204,             // Range Minimum
                        0x0204,             // Range Maximum
                        0x01,               // Alignment
                        0x01,               // Length
                        )
                    IO (Decode16,
                        0x0800,             // Range Minimum
                        0x0800,             // Range Maximum
                        0x08,               // Alignment
                        0x80,               // Length
                        )
                    IO (Decode16,
                        0x0880,             // Range Minimum
                        0x0880,             // Range Maximum
                        0x08,               // Alignment
                        0x80,               // Length
                        )
                })
            }
        }

        Scope (^^PCI0)
        {
            Device (PS2K)
            {
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_HID, "GOOG000A")  // _HID: Hardware ID
                Name (_CID, Package (0x02)  // _CID: Compatible ID
                {
                    EisaId ("PNP0303") /* IBM Enhanced Keyboard (101/102-key, PS/2 Mouse) */, 
                    EisaId ("PNP030B")
                })
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    IO (Decode16,
                        0x0060,             // Range Minimum
                        0x0060,             // Range Maximum
                        0x01,               // Alignment
                        0x01,               // Length
                        )
                    IO (Decode16,
                        0x0064,             // Range Minimum
                        0x0064,             // Range Maximum
                        0x01,               // Alignment
                        0x01,               // Length
                        )
                    IRQ (Edge, ActiveHigh, Exclusive, )
                        {1}
                })
            }
        }

        Device (EC0)
        {
            Name (_HID, EisaId ("PNP0C09") /* Embedded Controller Device */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_GPE, 0x6E)  // _GPE: General Purpose Events
            Name (TOFS, 0xC8)
            Name (TNCA, 0xFC)
            Name (TNOP, 0xFD)
            Name (TBAD, 0xFE)
            Name (TNPR, 0xFF)
            Name (DWRN, 0x0F)
            Name (DLOW, 0x0A)
            OperationRegion (ERAM, EmbeddedControl, Zero, 0x20)
            Field (ERAM, ByteAcc, Lock, Preserve)
            {
                RAMV,   8, 
                TSTB,   8, 
                TSTC,   8, 
                KBLV,   8, 
                FAND,   8, 
                PATI,   8, 
                PATT,   8, 
                PATC,   8, 
                CHGL,   8, 
                TBMD,   1, 
                DDPN,   3, 
                STTB,   1, 
                Offset (0x0A), 
                DFUD,   1, 
                FLSH,   1, 
                PFAN,   1, 
                KBLE,   1, 
                LTBR,   1, 
                LEDC,   1, 
                MTNS,   1, 
                KEYB,   1, 
                PSTR,   1, 
                P80P,   1, 
                THRM,   1, 
                SBKL,   1, 
                WIFI,   1, 
                HOST,   1, 
                GPIO,   1, 
                I2CB,   1, 
                CHRG,   1, 
                BATT,   1, 
                SBAT,   1, 
                HANG,   1, 
                PMUI,   1, 
                DSEC,   1, 
                UPDC,   1, 
                UMUX,   1, 
                MSFF,   1, 
                TVST,   1, 
                TCMV,   1, 
                RTCD,   1, 
                FPRD,   1, 
                TPAD,   1, 
                RWSG,   1, 
                DEVE,   1, 
                Offset (0x0E), 
                Offset (0x12), 
                BTID,   8, 
                USPP,   8, 
                RFWU,   8, 
                PBOK,   8
            }

            OperationRegion (EMEM, SystemIO, 0x0900, 0xFF)
            Field (EMEM, ByteAcc, NoLock, Preserve)
            {
                TIN0,   8, 
                TIN1,   8, 
                TIN2,   8, 
                TIN3,   8, 
                TIN4,   8, 
                TIN5,   8, 
                TIN6,   8, 
                TIN7,   8, 
                TIN8,   8, 
                TIN9,   8, 
                Offset (0x10), 
                FAN0,   16, 
                Offset (0x24), 
                BTVR,   8, 
                Offset (0x30), 
                LIDS,   1, 
                PBTN,   1, 
                WPDI,   1, 
                RECK,   1, 
                RECD,   1, 
                Offset (0x40), 
                BTVO,   32, 
                BTPR,   32, 
                BTRA,   32, 
                ACEX,   1, 
                BTEX,   1, 
                BFDC,   1, 
                BFCG,   1, 
                BFCR,   1, 
                BFIV,   1, 
                BFCT,   1, 
                Offset (0x4D), 
                BTCN,   8, 
                BTIX,   8, 
                Offset (0x50), 
                BTDA,   32, 
                BTDV,   32, 
                BTDF,   32, 
                BTCC,   32, 
                BMFG,   64, 
                BMOD,   64, 
                BSER,   64, 
                BTYP,   64, 
                Offset (0x80), 
                ALS0,   16, 
                Offset (0xA6), 
                GPUD,   8, 
                Offset (0xA7), 
                PWRT,   8, 
                EOVD,   8
            }

            Device (LID0)
            {
                Name (_HID, EisaId ("PNP0C0D") /* Lid Device */)  // _HID: Hardware ID
                Method (_LID, 0, NotSerialized)  // _LID: Lid Status
                {
                    Return (LIDS) /* \_SB_.PCI0.LPCB.EC0_.LIDS */
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x70, 
                    0x05
                })
            }

            Method (TINS, 1, Serialized)
            {
                Switch (ToInteger (Arg0))
                {
                    Case (Zero)
                    {
                        Return (TIN0) /* \_SB_.PCI0.LPCB.EC0_.TIN0 */
                    }
                    Case (One)
                    {
                        Return (TIN1) /* \_SB_.PCI0.LPCB.EC0_.TIN1 */
                    }
                    Case (0x02)
                    {
                        Return (TIN2) /* \_SB_.PCI0.LPCB.EC0_.TIN2 */
                    }
                    Case (0x03)
                    {
                        Return (TIN3) /* \_SB_.PCI0.LPCB.EC0_.TIN3 */
                    }
                    Case (0x04)
                    {
                        Return (TIN4) /* \_SB_.PCI0.LPCB.EC0_.TIN4 */
                    }
                    Case (0x05)
                    {
                        Return (TIN5) /* \_SB_.PCI0.LPCB.EC0_.TIN5 */
                    }
                    Case (0x06)
                    {
                        Return (TIN6) /* \_SB_.PCI0.LPCB.EC0_.TIN6 */
                    }
                    Case (0x07)
                    {
                        Return (TIN7) /* \_SB_.PCI0.LPCB.EC0_.TIN7 */
                    }
                    Case (0x08)
                    {
                        Return (TIN8) /* \_SB_.PCI0.LPCB.EC0_.TIN8 */
                    }
                    Case (0x09)
                    {
                        Return (TIN9) /* \_SB_.PCI0.LPCB.EC0_.TIN9 */
                    }
                    Default
                    {
                        Return (TIN0) /* \_SB_.PCI0.LPCB.EC0_.TIN0 */
                    }

                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (ECMD, ResourceTemplate ()
                {
                    IO (Decode16,
                        0x0062,             // Range Minimum
                        0x0062,             // Range Maximum
                        0x00,               // Alignment
                        0x01,               // Length
                        )
                    IO (Decode16,
                        0x0066,             // Range Minimum
                        0x0066,             // Range Maximum
                        0x00,               // Alignment
                        0x01,               // Length
                        )
                })
                Return (ECMD) /* \_SB_.PCI0.LPCB.EC0_._CRS.ECMD */
            }

            Method (_REG, 2, NotSerialized)  // _REG: Region Availability
            {
                PWRS = ACEX /* \_SB_.PCI0.LPCB.EC0_.ACEX */
                PNOT ()
                \LIDS = LIDS /* \_SB_.PCI0.LPCB.EC0_.LIDS */
            }

            Method (TSRD, 1, Serialized)
            {
                Local0 = TINS (Arg0)
                If ((Local0 == TNCA))
                {
                    Return (Zero)
                }

                If ((Local0 == TNPR))
                {
                    Return (Zero)
                }

                If ((Local0 == TNOP))
                {
                    Return (Zero)
                }

                If ((Local0 == TBAD))
                {
                    Return (Zero)
                }

                Local0 += TOFS /* \_SB_.PCI0.LPCB.EC0_.TOFS */
                Local0 *= 0x0A
                Return (Local0)
            }

            Method (_Q01, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: LID CLOSE"
                \LIDS = LIDS /* \_SB_.PCI0.LPCB.EC0_.LIDS */
                Notify (LID0, 0x80) // Status Change
            }

            Method (_Q02, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: LID OPEN"
                \LIDS = LIDS /* \_SB_.PCI0.LPCB.EC0_.LIDS */
                Notify (CREC, 0x02) // Device Wake
                Notify (LID0, 0x80) // Status Change
            }

            Method (_Q03, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: POWER BUTTON"
            }

            Method (_Q04, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: AC CONNECTED"
                PWRS = ACEX /* \_SB_.PCI0.LPCB.EC0_.ACEX */
                Notify (AC, 0x80) // Status Change
                PNOT ()
            }

            Method (_Q05, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: AC DISCONNECTED"
                PWRS = ACEX /* \_SB_.PCI0.LPCB.EC0_.ACEX */
                Notify (AC, 0x80) // Status Change
                PNOT ()
            }

            Method (_Q06, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: BATTERY LOW"
                Notify (BAT0, 0x80) // Status Change
            }

            Method (_Q07, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: BATTERY CRITICAL"
                Notify (BAT0, 0x80) // Status Change
            }

            Method (_Q08, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: BATTERY INFO"
                Notify (BAT0, 0x81) // Information Change
            }

            Method (_Q0A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: THERMAL OVERLOAD"
                Notify (_TZ, 0x80) // Status Change
            }

            Method (_Q0B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: THERMAL"
                Notify (_TZ, 0x80) // Status Change
            }

            Method (_Q0D, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: KEY PRESSED"
                Notify (CREC, 0x02) // Device Wake
            }

            Method (_Q10, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: THERMAL SHUTDOWN"
                Notify (_TZ, 0x80) // Status Change
            }

            Method (_Q11, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: BATTERY SHUTDOWN"
                Notify (BAT0, 0x80) // Status Change
            }

            Method (_Q12, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
            }

            Method (_Q13, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
            }

            Method (_Q16, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: GOT PD EVENT"
                Notify (^CREC.ECPD, 0x80) // Status Change
                If (CondRefOf (\_SB.DPTF.TPWR))
                {
                    Notify (^^^^DPTF.TPWR, 0x81) // Information Change
                }
            }

            Method (_Q17, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: BATTERY STATUS"
                Notify (BAT0, 0x80) // Status Change
                PNOT ()
            }

            Method (_Q18, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: PANIC"
                Notify (CREC, 0xB0) // Device-Specific
            }

            Method (_Q1B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: MKBP"
                Notify (CREC, 0x80) // Status Change
            }

            Method (_Q1C, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: USB MUX"
                Notify (^CREC.ECPD, 0x80) // Status Change
            }

            Method (_Q1D, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Debug = "EC: TABLET mode switch Event"
                Notify (CREC, 0x02) // Device Wake
                If ((_OSI ("Linux") == One))
                {
                    Notify (^CREC.TBMC, 0x80) // Status Change
                }
                ElseIf ((TBMD == One))
                {
                    Notify (VBTN, 0xCC) // Hardware-Specific
                }
                Else
                {
                    Notify (VBTN, 0xCD) // Hardware-Specific
                }
            }

            Mutex (PATM, 0x01)
            Method (PAT0, 2, Serialized)
            {
                If (Acquire (PATM, 0x03E8))
                {
                    Return (Zero)
                }

                PATI = ToInteger (Arg0)
                Local1 = (ToInteger (Arg1) / 0x0A)
                PATT = (Local1 - TOFS) /* \_SB_.PCI0.LPCB.EC0_.TOFS */
                PATC = 0x02
                Release (PATM)
                Return (One)
            }

            Method (PAT1, 2, Serialized)
            {
                If (Acquire (PATM, 0x03E8))
                {
                    Return (Zero)
                }

                PATI = ToInteger (Arg0)
                Local1 = (ToInteger (Arg1) / 0x0A)
                PATT = (Local1 - TOFS) /* \_SB_.PCI0.LPCB.EC0_.TOFS */
                PATC = 0x03
                Release (PATM)
                Return (One)
            }

            Method (PATD, 1, Serialized)
            {
                If (Acquire (PATM, 0x03E8))
                {
                    Return (Zero)
                }

                PATI = ToInteger (Arg0)
                PATT = Zero
                PATC = Zero
                PATC = One
                Release (PATM)
                Return (One)
            }

            Method (_Q09, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                If (!Acquire (PATM, 0x03E8))
                {
                    Local0 = PATI /* \_SB_.PCI0.LPCB.EC0_.PATI */
                    While ((Local0 != 0xFF))
                    {
                        Local0 = PATI /* \_SB_.PCI0.LPCB.EC0_.PATI */
                    }

                    Release (PATM)
                }
            }

            Method (CHGS, 1, Serialized)
            {
                CHGL = ToInteger (Arg0)
            }

            Method (CHGD, 0, Serialized)
            {
                CHGL = 0xFF
            }

            Method (RCTM, 0, NotSerialized)
            {
                Return (TBMD) /* \_SB_.PCI0.LPCB.EC0_.TBMD */
            }

            Device (AC)
            {
                Name (_HID, "ACPI0003" /* Power Source Device */)  // _HID: Hardware ID
                Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
                {
                    _SB
                })
                Method (_PSR, 0, NotSerialized)  // _PSR: Power Source
                {
                    Return (ACEX) /* \_SB_.PCI0.LPCB.EC0_.ACEX */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }
            }

            Mutex (BATM, 0x00)
            Method (BTSW, 1, NotSerialized)
            {
                If ((Arg0 != Zero))
                {
                    Return (One)
                }

                Return (Zero)
            }

            Method (BSTA, 1, Serialized)
            {
                If (Acquire (BATM, 0x03E8))
                {
                    Return (Zero)
                }

                If ((~BTSW (Arg0) & BTEX))
                {
                    Local0 = 0x1F
                }
                Else
                {
                    Local0 = 0x0F
                }

                Release (BATM)
                Return (Local0)
            }

            Method (BBIF, 2, Serialized)
            {
                If (Acquire (BATM, 0x03E8))
                {
                    Return (Arg1)
                }

                If (BTSW (Arg0))
                {
                    Release (BATM)
                    Return (Arg1)
                }

                Arg1 [0x02] = BTDF /* \_SB_.PCI0.LPCB.EC0_.BTDF */
                Arg1 [0x04] = BTDV /* \_SB_.PCI0.LPCB.EC0_.BTDV */
                Local0 = BTDA /* \_SB_.PCI0.LPCB.EC0_.BTDA */
                Arg1 [One] = Local0
                Local2 = ((Local0 * DWRN) / 0x64)
                Arg1 [0x05] = Local2
                Local2 = ((Local0 * DLOW) / 0x64)
                Arg1 [0x06] = Local2
                Arg1 [0x09] = ToString (Concatenate (BMOD, Zero), Ones)
                Arg1 [0x0A] = ToString (Concatenate (BSER, Zero), Ones)
                Arg1 [0x0C] = ToString (Concatenate (BMFG, Zero), Ones)
                Release (BATM)
                Return (Arg1)
            }

            Method (BBIX, 2, Serialized)
            {
                If (Acquire (BATM, 0x03E8))
                {
                    Return (Arg1)
                }

                If (BTSW (Arg0))
                {
                    Release (BATM)
                    Return (Arg1)
                }

                Arg1 [0x03] = BTDF /* \_SB_.PCI0.LPCB.EC0_.BTDF */
                Arg1 [0x05] = BTDV /* \_SB_.PCI0.LPCB.EC0_.BTDV */
                Local0 = BTDA /* \_SB_.PCI0.LPCB.EC0_.BTDA */
                Arg1 [0x02] = Local0
                Local2 = ((Local0 * DWRN) / 0x64)
                Arg1 [0x06] = Local2
                Local2 = ((Local0 * DLOW) / 0x64)
                Arg1 [0x07] = Local2
                Arg1 [0x08] = BTCC /* \_SB_.PCI0.LPCB.EC0_.BTCC */
                Arg1 [0x10] = ToString (Concatenate (BMOD, Zero), Ones)
                Arg1 [0x11] = ToString (Concatenate (BSER, Zero), Ones)
                Arg1 [0x13] = ToString (Concatenate (BMFG, Zero), Ones)
                Release (BATM)
                Return (Arg1)
            }

            Method (BBST, 4, Serialized)
            {
                If (Acquire (BATM, 0x03E8))
                {
                    Return (Arg1)
                }

                If (BTSW (Arg0))
                {
                    Release (BATM)
                    Return (Arg1)
                }

                Local1 = Zero
                If (ACEX)
                {
                    If (BFCG)
                    {
                        Local1 = 0x02
                    }
                    ElseIf (BFDC)
                    {
                        Local1 = One
                    }
                }
                Else
                {
                    Local1 = One
                }

                If (BFCR)
                {
                    Local1 |= 0x04
                }

                Arg1 [Zero] = Local1
                If ((Local1 != DerefOf (Arg2)))
                {
                    Arg2 = Local1
                    If ((Arg0 == Zero))
                    {
                        Notify (BAT0, 0x80) // Status Change
                    }
                }

                Arg1 [One] = BTPR /* \_SB_.PCI0.LPCB.EC0_.BTPR */
                Local1 = BTRA /* \_SB_.PCI0.LPCB.EC0_.BTRA */
                If (((Arg3 && ACEX) && !(BFDC && BFCG)))
                {
                    Local2 = BTDF /* \_SB_.PCI0.LPCB.EC0_.BTDF */
                    Local3 = (Local2 >> 0x04)
                    If (((Local1 > (Local2 - Local3)) && (Local1 < (Local2 + 
                        Local3))))
                    {
                        Local1 = Local2
                    }
                }

                Arg1 [0x02] = Local1
                Arg1 [0x03] = BTVO /* \_SB_.PCI0.LPCB.EC0_.BTVO */
                Release (BATM)
                Return (Arg1)
            }

            Device (BAT0)
            {
                Name (_HID, EisaId ("PNP0C0A") /* Control Method Battery */)  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
                {
                    _SB
                })
                Name (PBIF, Package (0x0D)
                {
                    One, 
                    0xFFFFFFFF, 
                    0xFFFFFFFF, 
                    One, 
                    0xFFFFFFFF, 
                    0x03, 
                    0xFFFFFFFF, 
                    One, 
                    One, 
                    "", 
                    "", 
                    "LION", 
                    ""
                })
                Name (PBIX, Package (0x14)
                {
                    Zero, 
                    One, 
                    0xFFFFFFFF, 
                    0xFFFFFFFF, 
                    One, 
                    0xFFFFFFFF, 
                    0x03, 
                    0xFFFFFFFF, 
                    Zero, 
                    0x00018000, 
                    0x01F4, 
                    0x0A, 
                    0xFFFFFFFF, 
                    0xFFFFFFFF, 
                    One, 
                    One, 
                    "", 
                    "", 
                    "LION", 
                    ""
                })
                Name (PBST, Package (0x04)
                {
                    Zero, 
                    0xFFFFFFFF, 
                    0xFFFFFFFF, 
                    0xFFFFFFFF
                })
                Name (BSTP, Zero)
                Name (BFWK, One)
                Method (BFWE, 0, NotSerialized)
                {
                    BFWK = One
                }

                Method (BFWD, 0, NotSerialized)
                {
                    BFWK = Zero
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Return (BSTA (Zero))
                }

                Method (_BIF, 0, Serialized)  // _BIF: Battery Information
                {
                    Return (BBIF (Zero, PBIF))
                }

                Method (_BIX, 0, Serialized)  // _BIX: Battery Information Extended
                {
                    Return (BBIX (Zero, PBIX))
                }

                Method (_BST, 0, Serialized)  // _BST: Battery Status
                {
                    Return (BBST (Zero, PBST, RefOf (BSTP), BFWK))
                }
            }

            Device (CREC)
            {
                Name (_HID, "GOOG0004")  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (_DDN, "EC Command Device")  // _DDN: DOS Device Name
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x70, 
                    0x05
                })
                Device (ECPD)
                {
                    Name (_HID, "GOOG0003")  // _HID: Hardware ID
                    Name (_UID, One)  // _UID: Unique ID
                    Name (_DDN, "EC PD Device")  // _DDN: DOS Device Name
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }
            }

            Scope (CREC)
            {
                Device (KBLT)
                {
                    Name (_HID, "GOOG0002")  // _HID: Hardware ID
                    Name (_UID, One)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }
                }
            }

            Scope (\_SB)
            {
                Device (KBLT)
                {
                    Name (_HID, "GOOG0002")  // _HID: Hardware ID
                    Name (_UID, One)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (Zero)
                    }

                    Method (KBQC, 0, NotSerialized)
                    {
                        Return (^^PCI0.LPCB.EC0.KBLV) /* \_SB_.PCI0.LPCB.EC0_.KBLV */
                    }

                    Method (KBCM, 1, NotSerialized)
                    {
                        ^^PCI0.LPCB.EC0.KBLV = Arg0
                    }
                }
            }

            Scope (CREC)
            {
                Device (TBMC)
                {
                    Name (_HID, "GOOG0006")  // _HID: Hardware ID
                    Name (_UID, One)  // _UID: Unique ID
                    Name (_DDN, "Tablet Motion Control")  // _DDN: DOS Device Name
                    Method (TBMC, 0, NotSerialized)
                    {
                        If ((RCTM () == One))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }
                }
            }

            Device (VBTN)
            {
                Name (_HID, "INT33D6" /* Intel Virtual Buttons Device */)  // _HID: Hardware ID
                Name (_DDN, "Tablet Virtual Buttons")  // _DDN: DOS Device Name
                Method (VBDL, 0, NotSerialized)
                {
                }

                Method (VGBS, 0, NotSerialized)
                {
                    If ((RCTM () == One))
                    {
                        Return (Zero)
                    }
                    Else
                    {
                        Return (0x40)
                    }
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }
            }

            Device (VBTO)
            {
                Name (_HID, "INT33D3" /* Intel GPIO Buttons */)  // _HID: Hardware ID
                Name (_CID, "PNP0C60" /* Display Sensor Device */)  // _CID: Compatible ID
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }
            }
        }
    }

    Scope (_SB)
    {
        Name (CHPS, Package (0x04)
        {
            Package (0x08)
            {
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                0xFF, 
                0x06A4, 
                "mA", 
                Zero
            }, 

            Package (0x08)
            {
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                0x18, 
                0x0600, 
                "mA", 
                Zero
            }, 

            Package (0x08)
            {
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                0x10, 
                0x0400, 
                "mA", 
                Zero
            }, 

            Package (0x08)
            {
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                0x08, 
                0x0200, 
                "mA", 
                Zero
            }
        })
        Name (DTRT, Package (0x05)
        {
            Package (0x08)
            {
                PCI0.B0D4, 
                PCI0.B0D4, 
                0x64, 
                0x32, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            }, 

            Package (0x08)
            {
                PCI0.B0D4, 
                DPTF.TSR0, 
                0x64, 
                0x0258, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            }, 

            Package (0x08)
            {
                DPTF.TCHG, 
                DPTF.TSR1, 
                0x64, 
                0x0258, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            }, 

            Package (0x08)
            {
                PCI0.B0D4, 
                DPTF.TSR2, 
                0x64, 
                0x5A, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            }, 

            Package (0x08)
            {
                PCI0.B0D4, 
                DPTF.TSR3, 
                0x64, 
                0x0258, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            }
        })
        Name (MPPC, Package (0x03)
        {
            0x02, 
            Package (0x06)
            {
                Zero, 
                0x0640, 
                0x1194, 
                0x03E8, 
                0x03E8, 
                0xC8
            }, 

            Package (0x06)
            {
                One, 
                0x3A98, 
                0x3A98, 
                0x03E8, 
                0x03E8, 
                0x03E8
            }
        })
        Device (DPTF)
        {
            Name (_HID, EisaId ("INT3400") /* Intel Dynamic Power Performance Management */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (IDSP, Package (0x03)
            {
                ToUUID ("42a441d6-ae6a-462b-a84b-4a8ce79027d3") /* Unknown UUID */, 
                ToUUID ("97c68ae7-15fa-499c-b8c9-5da81d606e0a") /* Unknown UUID */, 
                ToUUID ("16caf1b7-dd38-40ed-b1c1-1b8a1913d531") /* Unknown UUID */
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((DPTE == One))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_OSC, 4, Serialized)  // _OSC: Operating System Capabilities
            {
                If ((DerefOf (IDSP [Zero]) == Arg0))
                {
                    TINI ()
                    ^TCHG.INIT ()
                }

                Return (Arg3)
            }

            Name (TRTR, One)
            Method (_TRT, 0, NotSerialized)  // _TRT: Thermal Relationship Table
            {
                Return (DTRT) /* \_SB_.DTRT */
            }

            Method (CTOK, 1, NotSerialized)
            {
                Local0 = (Arg0 * 0x0A)
                Local0 += 0x0AAC
                Return (Local0)
            }

            Method (TEVT, 1, NotSerialized)
            {
                If ((ToInteger (Arg0) == One))
                {
                    Notify (TSR0, 0x90) // Device-Specific
                }

                If ((ToInteger (Arg0) == 0x02))
                {
                    Notify (TSR1, 0x90) // Device-Specific
                }

                If ((ToInteger (Arg0) == 0x03))
                {
                    Notify (TSR2, 0x90) // Device-Specific
                }

                If ((ToInteger (Arg0) == 0x04))
                {
                    Notify (TSR3, 0x90) // Device-Specific
                }
            }

            Method (TINI, 0, NotSerialized)
            {
                ^TSR0.PATD ()
                ^TSR1.PATD ()
                ^TSR2.PATD ()
                ^TSR3.PATD ()
            }

            Method (TPET, 0, NotSerialized)
            {
                Notify (TSR0, 0x81) // Information Change
                Notify (TSR1, 0x81) // Information Change
                Notify (TSR2, 0x81) // Information Change
                Notify (TSR3, 0x81) // Information Change
            }

            Method (DTRP, 2, Serialized)
            {
                If (CondRefOf (\_SB.PCI0.LPCB.EC0.RCDP))
                {
                    If ((^^PCI0.LPCB.EC0.RCDP () == One))
                    {
                        Return (CTOK (Arg0))
                    }
                }

                Return (CTOK (Arg1))
            }

            Device (TSR0)
            {
                Name (_HID, EisaId ("INT3403") /* DPTF Temperature Sensor */)  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (PTYP, 0x03)
                Name (TMPI, One)
                Name (_STR, Unicode ("Ambient"))  // _STR: Description String
                Name (GTSH, 0x14)
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((DPTE == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_TMP, 0, Serialized)  // _TMP: Temperature
                {
                    Return (^^^PCI0.LPCB.EC0.TSRD (TMPI))
                }

                Method (_PSV, 0, NotSerialized)  // _PSV: Passive Temperature
                {
                    Return (DTRP (0x37, 0x37))
                }

                Method (_CRT, 0, NotSerialized)  // _CRT: Critical Temperature
                {
                    Return (DTRP (0x46, 0x46))
                }

                Name (PATC, 0x02)
                Method (PAT0, 1, Serialized)
                {
                    ^^^PCI0.LPCB.EC0.PAT0 (TMPI, Arg0)
                }

                Method (PAT1, 1, Serialized)
                {
                    ^^^PCI0.LPCB.EC0.PAT1 (TMPI, Arg0)
                }

                Method (PATD, 0, Serialized)
                {
                    ^^^PCI0.LPCB.EC0.PATD (TMPI)
                }
            }

            Device (TSR1)
            {
                Name (_HID, EisaId ("INT3403") /* DPTF Temperature Sensor */)  // _HID: Hardware ID
                Name (_UID, 0x02)  // _UID: Unique ID
                Name (PTYP, 0x03)
                Name (TMPI, 0x02)
                Name (_STR, Unicode ("Charger"))  // _STR: Description String
                Name (GTSH, 0x14)
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((DPTE == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_TMP, 0, Serialized)  // _TMP: Temperature
                {
                    Return (^^^PCI0.LPCB.EC0.TSRD (TMPI))
                }

                Method (_PSV, 0, NotSerialized)  // _PSV: Passive Temperature
                {
                    Return (DTRP (0x37, 0x37))
                }

                Method (_CRT, 0, NotSerialized)  // _CRT: Critical Temperature
                {
                    Return (DTRP (0x4B, 0x4B))
                }

                Name (PATC, 0x02)
                Method (PAT0, 1, Serialized)
                {
                    ^^^PCI0.LPCB.EC0.PAT0 (TMPI, Arg0)
                }

                Method (PAT1, 1, Serialized)
                {
                    ^^^PCI0.LPCB.EC0.PAT1 (TMPI, Arg0)
                }

                Method (PATD, 0, Serialized)
                {
                    ^^^PCI0.LPCB.EC0.PATD (TMPI)
                }
            }

            Device (TSR2)
            {
                Name (_HID, EisaId ("INT3403") /* DPTF Temperature Sensor */)  // _HID: Hardware ID
                Name (_UID, 0x03)  // _UID: Unique ID
                Name (PTYP, 0x03)
                Name (TMPI, 0x03)
                Name (_STR, Unicode ("DRAM"))  // _STR: Description String
                Name (GTSH, 0x14)
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((DPTE == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_TMP, 0, Serialized)  // _TMP: Temperature
                {
                    Return (^^^PCI0.LPCB.EC0.TSRD (TMPI))
                }

                Method (_PSV, 0, NotSerialized)  // _PSV: Passive Temperature
                {
                    Return (DTRP (0x34, 0x34))
                }

                Method (_CRT, 0, NotSerialized)  // _CRT: Critical Temperature
                {
                    Return (DTRP (0x4B, 0x4B))
                }

                Name (PATC, 0x02)
                Method (PAT0, 1, Serialized)
                {
                    ^^^PCI0.LPCB.EC0.PAT0 (TMPI, Arg0)
                }

                Method (PAT1, 1, Serialized)
                {
                    ^^^PCI0.LPCB.EC0.PAT1 (TMPI, Arg0)
                }

                Method (PATD, 0, Serialized)
                {
                    ^^^PCI0.LPCB.EC0.PATD (TMPI)
                }
            }

            Device (TSR3)
            {
                Name (_HID, EisaId ("INT3403") /* DPTF Temperature Sensor */)  // _HID: Hardware ID
                Name (_UID, 0x04)  // _UID: Unique ID
                Name (PTYP, 0x03)
                Name (TMPI, 0x04)
                Name (_STR, Unicode ("eMMC"))  // _STR: Description String
                Name (GTSH, 0x14)
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((DPTE == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_TMP, 0, Serialized)  // _TMP: Temperature
                {
                    Return (^^^PCI0.LPCB.EC0.TSRD (TMPI))
                }

                Method (_PSV, 0, NotSerialized)  // _PSV: Passive Temperature
                {
                    Return (DTRP (0x37, 0x37))
                }

                Method (_CRT, 0, NotSerialized)  // _CRT: Critical Temperature
                {
                    Return (DTRP (0x4B, 0x4B))
                }

                Name (PATC, 0x02)
                Method (PAT0, 1, Serialized)
                {
                    ^^^PCI0.LPCB.EC0.PAT0 (TMPI, Arg0)
                }

                Method (PAT1, 1, Serialized)
                {
                    ^^^PCI0.LPCB.EC0.PAT1 (TMPI, Arg0)
                }

                Method (PATD, 0, Serialized)
                {
                    ^^^PCI0.LPCB.EC0.PATD (TMPI)
                }
            }

            Device (TCHG)
            {
                Name (_HID, "INT3403" /* DPTF Temperature Sensor */)  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (PTYP, 0x0B)
                Name (_STR, Unicode ("Battery Charger"))  // _STR: Description String
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((DPTE == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (PPSS, 0, NotSerialized)
                {
                    Return (CHPS) /* \_SB_.CHPS */
                }

                Method (PPPC, 0, NotSerialized)
                {
                    Local0 = SizeOf (CHPS)
                    Local0--
                    If ((^^^PCI0.LPCB.EC0.ACEX == Zero))
                    {
                        Return (Local0)
                    }
                    Else
                    {
                        Return (Zero)
                    }

                    Return (Zero)
                }

                Method (SPPC, 1, NotSerialized)
                {
                    Local0 = DerefOf (DerefOf (CHPS [ToInteger (Arg0)]) [0x04]
                        )
                    ^^^PCI0.LPCB.EC0.CHGS (Local0)
                }

                Method (INIT, 0, NotSerialized)
                {
                    ^^^PCI0.LPCB.EC0.CHGD ()
                }
            }
        }

        Scope (PCI0)
        {
            Device (B0D4)
            {
                Name (_ADR, 0x00040000)  // _ADR: Address
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((DPTE == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
                {
                    Return (Zero)
                }

                Method (SPPC, 1, NotSerialized)
                {
                    PPCM = Arg0
                    PPCN ()
                }

                Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
                {
                    If (CondRefOf (\_SB.CP00._PSS))
                    {
                        Return (^^^CP00._PSS) /* External reference */
                    }
                    Else
                    {
                        Return (Package (0x01)
                        {
                            Package (0x06)
                            {
                                Zero, 
                                Zero, 
                                Zero, 
                                Zero, 
                                Zero, 
                                Zero
                            }
                        })
                    }
                }

                Method (_PDL, 0, NotSerialized)  // _PDL: P-state Depth Limit
                {
                    If (CondRefOf (\_SB.MPDL))
                    {
                        Return (MPDL) /* External reference */
                    }
                    ElseIf (CondRefOf (\_SB.CP00._PSS))
                    {
                        Local0 = SizeOf (^^^CP00._PSS)
                        Local0--
                        Return (Local0)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (PPCC, 0, NotSerialized)
                {
                    Return (MPPC) /* \_SB_.MPPC */
                }

                Method (_CRT, 0, NotSerialized)  // _CRT: Critical Temperature
                {
                    Return (^^^DPTF.CTOK (0x63))
                }

                Method (_PSV, 0, NotSerialized)  // _PSV: Passive Temperature
                {
                    Return (^^^DPTF.CTOK (0x5E))
                }
            }
        }
    }
}

