Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B02A2F615A
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2019 21:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfKIUVi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 9 Nov 2019 15:21:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46283 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfKIUVi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 9 Nov 2019 15:21:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so7399583pfc.13
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Nov 2019 12:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Qvx8G3yf6fbbwLkJYIFjCTK+xo+SoGdKKiPoBZSr33M=;
        b=wUNz7m9S52PBZOllqQzsbplaTZwrQbMUgstGC93BqJOaD36OOkAtUg5qevxrxZfeKT
         gotWbq0aflSvOVap1zivtDpx0d1ojmI2SniofmMQT6h4Lwrlp9cBrnkjhxP2WeniFi7e
         FZBgdaGzFS3huuOloHxx6ivlqfyiZ6divx/5ZeEBQJZ9IQhylnyI+u5fLGuzMI7/B3I1
         iYpi8qz3+n20WK9VxnhL2qP5FOnzWab5uQi3a8/eskxexTBgvrV8+eMOCOC72UxjdJY4
         VjWRoEm9d8htZJpAiWYzEXP5xLRy7NqjawaRizB9NDROK78h0C33HiYAiEse9EZ1fbBv
         55ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Qvx8G3yf6fbbwLkJYIFjCTK+xo+SoGdKKiPoBZSr33M=;
        b=tjcyyTmMSc0PcC/MKJOTKoJ/AlWAaMsterGQHL5A+SBYry/J2IsJBBr8aWg2x3Kghq
         bJ9oU9pa5xRXB7SPz2C1MMsWFhqp/1iX7jUX7TVCeD3qCIMYrzr278uC7W3QE9RqTByv
         LkUHMSVJmigdorxjL0WfaGrZI4mXsPDP1aZOHvNUe/xamkTW4gqYIT6Mm53/rfvQUuya
         MUCDQYoIp8qi+tpFZgrY13pz8xoXVtj97acQnqU8Q9uSzwPJVHcwci5MgRFe62tYU+pK
         KPr964pWJ9LSfWvlehJmBxLuPWqPyiNd6E6K7whgMsr2IumXZJVB/VsngG0tCq7hSyDl
         HI6Q==
X-Gm-Message-State: APjAAAVFgM0lJQwYg116T9C6BLDAtW1ZrJWuZi2ODI0Xs+iSe++14RJt
        8+4iuDQemb9V92SmhKDz0f0ytQ==
X-Google-Smtp-Source: APXvYqz6poI46GikvRL6PdQaDg5hfLr9kt+rDeTF9D4cbZxqDXhQfL548UzR93o9a8NjoXcAoUuQeA==
X-Received: by 2002:a63:4562:: with SMTP id u34mr19380698pgk.399.1573330895658;
        Sat, 09 Nov 2019 12:21:35 -0800 (PST)
Received: from debian ([122.174.231.44])
        by smtp.gmail.com with ESMTPSA id a66sm10497165pfb.166.2019.11.09.12.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 12:21:34 -0800 (PST)
Date:   Sun, 10 Nov 2019 01:51:25 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com,
        bhelgaas@google.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PROBLEM: PCIe Error atleast "help and other detail related"
Message-ID: <20191109202125.GA5083@debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hello,

i just got some mail deleted. so incase some of you have
send mail to me after https://lkml.org/lkml/2019/11/4/824
please kindly resend it to me.

I have also noticed the error in 5.4.0-rc1+ of linux-kselftest tree.

iam attaching two related files again.

--
software engineer
rajagiri school of engineering and technology



--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="full-dmesg-related.txt"

[    0.000000] microcode: microcode updated early to revision 0xb4, date = 2019-04-01
[    0.000000] Linux version 5.3.8 (root@debian) (gcc version 9.2.1 20191025 (Debian 9.2.1-14)) #3 SMP Thu Oct 31 03:02:06 IST 2019
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.3.8 root=UUID=be7e4f1c-8719-4ceb-bfbd-c79f9c974ff9 ro earlyprink=vga quiet
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000008a06afff] usable
[    0.000000] BIOS-e820: [mem 0x000000008a06b000-0x000000008a06bfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000008a06c000-0x000000008a06cfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008a06d000-0x000000009965cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000009965d000-0x000000009a4d8fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009a4d9000-0x000000009a520fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000009a521000-0x000000009a93afff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000009a93b000-0x000000009aeaafff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009aeab000-0x000000009af7efff] type 20
[    0.000000] BIOS-e820: [mem 0x000000009af7f000-0x000000009affefff] usable
[    0.000000] BIOS-e820: [mem 0x000000009afff000-0x000000009fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000025effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.60 by American Megatrends
[    0.000000] efi:  TPMFinalLog=0x9a90a000  ACPI 2.0=0x9a4e7000  ACPI=0x9a4e7000  SMBIOS=0x9ad69000  SMBIOS 3.0=0x9ad68000  ESRT=0x97f84798 
[    0.000000] SMBIOS 3.1.1 present.
[    0.000000] DMI: ASUSTeK COMPUTER INC. VivoBook 15_ASUS Laptop X507UAR/X507UAR, BIOS X507UAR.203 05/31/2018
[    0.000000] tsc: Detected 2300.000 MHz processor
[    0.001795] tsc: Detected 2299.968 MHz TSC
[    0.001795] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001797] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001804] last_pfn = 0x25f000 max_arch_pfn = 0x400000000
[    0.001811] MTRR default type: write-back
[    0.001812] MTRR fixed ranges enabled:
[    0.001813]   00000-9FFFF write-back
[    0.001814]   A0000-BFFFF uncachable
[    0.001815]   C0000-FFFFF write-protect
[    0.001816] MTRR variable ranges enabled:
[    0.001817]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.001818]   1 base 00A0000000 mask 7FE0000000 uncachable
[    0.001819]   2 base 009C000000 mask 7FFC000000 uncachable
[    0.001819]   3 base 009B800000 mask 7FFF800000 uncachable
[    0.001820]   4 disabled
[    0.001820]   5 disabled
[    0.001821]   6 disabled
[    0.001821]   7 disabled
[    0.001822]   8 disabled
[    0.001822]   9 disabled
[    0.002371] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002553] last_pfn = 0x9afff max_arch_pfn = 0x400000000
[    0.017918] esrt: Reserving ESRT space from 0x0000000097f84798 to 0x0000000097f847d0.
[    0.017927] Using GB pages for direct mapping
[    0.017929] BRK [0x207c01000, 0x207c01fff] PGTABLE
[    0.017931] BRK [0x207c02000, 0x207c02fff] PGTABLE
[    0.017932] BRK [0x207c03000, 0x207c03fff] PGTABLE
[    0.017977] BRK [0x207c04000, 0x207c04fff] PGTABLE
[    0.017979] BRK [0x207c05000, 0x207c05fff] PGTABLE
[    0.018216] BRK [0x207c06000, 0x207c06fff] PGTABLE
[    0.018268] BRK [0x207c07000, 0x207c07fff] PGTABLE
[    0.018435] BRK [0x207c08000, 0x207c08fff] PGTABLE
[    0.018516] BRK [0x207c09000, 0x207c09fff] PGTABLE
[    0.018596] Secure boot could not be determined
[    0.018597] RAMDISK: [mem 0x2dd25000-0x32e89fff]
[    0.018609] ACPI: Early table checksum verification disabled
[    0.018612] ACPI: RSDP 0x000000009A4E7000 000024 (v02 _ASUS_)
[    0.018615] ACPI: XSDT 0x000000009A4E70C0 0000FC (v01 _ASUS_ Notebook 01072009 AMI  00010013)
[    0.018620] ACPI: FACP 0x000000009A5133E8 000114 (v06 _ASUS_ Notebook 01072009 AMI  00010013)
[    0.018624] ACPI: DSDT 0x000000009A4E7248 02C19B (v02 _ASUS_ Notebook 01072009 INTL 20160422)
[    0.018627] ACPI: FACS 0x000000009A909F00 000040
[    0.018629] ACPI: APIC 0x000000009A513500 000084 (v03 _ASUS_ Notebook 01072009 AMI  00010013)
[    0.018632] ACPI: FPDT 0x000000009A513588 000044 (v01 _ASUS_ Notebook 01072009 AMI  00010013)
[    0.018634] ACPI: FIDT 0x000000009A5135D0 00009C (v01 _ASUS_ Notebook 01072009 AMI  00010013)
[    0.018636] ACPI: ECDT 0x000000009A513670 0000C1 (v01 _ASUS_ Notebook 01072009 AMI. 00000005)
[    0.018639] ACPI: MCFG 0x000000009A513738 00003C (v01 _ASUS_ Notebook 01072009 MSFT 00000097)
[    0.018641] ACPI: SSDT 0x000000009A513778 000359 (v01 SataRe SataTabl 00001000 INTL 20160422)
[    0.018644] ACPI: SSDT 0x000000009A513AD8 006117 (v02 DptfTa DptfTabl 00001000 INTL 20160422)
[    0.018646] ACPI: SSDT 0x000000009A519BF0 0006B4 (v02 GddvDu GddvDumm 00001000 INTL 20160422)
[    0.018649] ACPI: MSDM 0x000000009A51A2A8 000055 (v03 _ASUS_ Notebook 01072009 ASUS 00000001)
[    0.018651] ACPI: SSDT 0x000000009A51A300 003158 (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
[    0.018654] ACPI: HPET 0x000000009A51D458 000038 (v01 INTEL  KBL-ULT  00000001 MSFT 0000005F)
[    0.018656] ACPI: UEFI 0x000000009A51D490 000042 (v01 _ASUS_ Notebook 00000002      01000013)
[    0.018658] ACPI: SSDT 0x000000009A51D4D8 0017AE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
[    0.018661] ACPI: LPIT 0x000000009A51EC88 000094 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
[    0.018663] ACPI: SSDT 0x000000009A51ED20 00018F (v02 INTEL  HdaDsp   00000000 INTL 20160422)
[    0.018666] ACPI: SSDT 0x000000009A51EEB0 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
[    0.018668] ACPI: SSDT 0x000000009A51F150 000517 (v02 INTEL  TbtTypeC 00000000 INTL 20160422)
[    0.018670] ACPI: SSDT 0x000000009A51F668 0002E9 (v02 INTEL  Wwan     00000001 INTL 20160422)
[    0.018673] ACPI: DBGP 0x000000009A51F958 000034 (v01 INTEL           00000002 MSFT 0000005F)
[    0.018675] ACPI: DBG2 0x000000009A51F990 000054 (v00 INTEL           00000002 MSFT 0000005F)
[    0.018678] ACPI: DMAR 0x000000009A51F9E8 000138 (v01 INTEL  EDK2     00000001 INTL 00000001)
[    0.018680] ACPI: BGRT 0x000000009A51FB20 000038 (v01 _ASUS_ Notebook 01072009 AMI  00010013)
[    0.018682] ACPI: UEFI 0x000000009A51FB58 00063A (v01 INTEL  RstSataE 00000000 ??   00000000)
[    0.018685] ACPI: UEFI 0x000000009A520198 00005C (v01 INTEL  RstSataV 00000000 ??   00000000)
[    0.018687] ACPI: TPM2 0x000000009A5201F8 000034 (v04 _ASUS_ Notebook 00000001 AMI  00000000)
[    0.018690] ACPI: WSMT 0x000000009A520230 000028 (v01 _ASUS_ Notebook 01072009 AMI  00010013)
[    0.018697] ACPI: Local APIC address 0xfee00000
[    0.018895] No NUMA configuration found
[    0.018896] Faking a node at [mem 0x0000000000000000-0x000000025effffff]
[    0.018899] NODE_DATA(0) allocated [mem 0x25effb000-0x25effffff]
[    0.018923] Zone ranges:
[    0.018924]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.018925]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.018926]   Normal   [mem 0x0000000100000000-0x000000025effffff]
[    0.018927]   Device   empty
[    0.018928] Movable zone start for each node
[    0.018929] Early memory node ranges
[    0.018929]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.018930]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    0.018931]   node   0: [mem 0x0000000000100000-0x000000008a06afff]
[    0.018932]   node   0: [mem 0x000000008a06d000-0x000000009965cfff]
[    0.018932]   node   0: [mem 0x000000009af7f000-0x000000009affefff]
[    0.018933]   node   0: [mem 0x0000000100000000-0x000000025effffff]
[    0.019165] Zeroed struct page in unavailable ranges: 27017 pages
[    0.019167] Initmem setup node 0 [mem 0x0000000000001000-0x000000025effffff]
[    0.019168] On node 0 totalpages: 2066039
[    0.019169]   DMA zone: 64 pages used for memmap
[    0.019170]   DMA zone: 23 pages reserved
[    0.019171]   DMA zone: 3996 pages, LIFO batch:0
[    0.019214]   DMA32 zone: 9756 pages used for memmap
[    0.019215]   DMA32 zone: 624347 pages, LIFO batch:63
[    0.029972]   Normal zone: 22464 pages used for memmap
[    0.029973]   Normal zone: 1437696 pages, LIFO batch:63
[    0.050637] Reserving Intel graphics memory at [mem 0x9c000000-0x9fffffff]
[    0.050954] ACPI: PM-Timer IO Port: 0x1808
[    0.050956] ACPI: Local APIC address 0xfee00000
[    0.050961] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.050962] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.050962] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.050963] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.050993] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.050995] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.050997] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.050998] ACPI: IRQ0 used by override.
[    0.050999] ACPI: IRQ9 used by override.
[    0.051001] Using ACPI (MADT) for SMP configuration information
[    0.051002] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.051010] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.051029] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.051031] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.051032] PM: Registered nosave memory: [mem 0x0009e000-0x000fffff]
[    0.051034] PM: Registered nosave memory: [mem 0x8a06b000-0x8a06bfff]
[    0.051034] PM: Registered nosave memory: [mem 0x8a06c000-0x8a06cfff]
[    0.051036] PM: Registered nosave memory: [mem 0x9965d000-0x9a4d8fff]
[    0.051036] PM: Registered nosave memory: [mem 0x9a4d9000-0x9a520fff]
[    0.051037] PM: Registered nosave memory: [mem 0x9a521000-0x9a93afff]
[    0.051037] PM: Registered nosave memory: [mem 0x9a93b000-0x9aeaafff]
[    0.051038] PM: Registered nosave memory: [mem 0x9aeab000-0x9af7efff]
[    0.051039] PM: Registered nosave memory: [mem 0x9afff000-0x9fffffff]
[    0.051040] PM: Registered nosave memory: [mem 0xa0000000-0xefffffff]
[    0.051040] PM: Registered nosave memory: [mem 0xf0000000-0xf7ffffff]
[    0.051041] PM: Registered nosave memory: [mem 0xf8000000-0xfdffffff]
[    0.051041] PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.051041] PM: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    0.051042] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.051042] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.051043] PM: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.051043] PM: Registered nosave memory: [mem 0xfed01000-0xfedfffff]
[    0.051044] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.051044] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.051045] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.051047] [mem 0xa0000000-0xefffffff] available for PCI devices
[    0.051048] Booting paravirtualized kernel on bare hardware
[    0.051051] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.137151] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 nr_node_ids:1
[    0.137450] percpu: Embedded 53 pages/cpu s177752 r8192 d31144 u524288
[    0.137457] pcpu-alloc: s177752 r8192 d31144 u524288 alloc=1*2097152
[    0.137458] pcpu-alloc: [0] 0 1 2 3 
[    0.137482] Built 1 zonelists, mobility grouping on.  Total pages: 2033732
[    0.137483] Policy zone: Normal
[    0.137484] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.3.8 root=UUID=be7e4f1c-8719-4ceb-bfbd-c79f9c974ff9 ro earlyprink=vga quiet
[    0.138384] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.138823] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.138874] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.145779] Calgary: detecting Calgary via BIOS EBDA area
[    0.145781] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.178585] Memory: 7675836K/8264156K available (10243K kernel code, 1180K rwdata, 3484K rodata, 1644K init, 2196K bss, 588320K reserved, 0K cma-reserved)
[    0.178714] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.178726] Kernel/User page tables isolation: enabled
[    0.178741] ftrace: allocating 32588 entries in 128 pages
[    0.192186] rcu: Hierarchical RCU implementation.
[    0.192187] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
[    0.192189] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.192189] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.195667] NR_IRQS: 33024, nr_irqs: 1024, preallocated irqs: 16
[    0.196023] random: crng done (trusting CPU's manufacturer)
[    0.196048] Console: colour dummy device 80x25
[    0.196052] printk: console [tty0] enabled
[    0.196068] ACPI: Core revision 20190703
[    0.196386] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.196461] APIC: Switch to symmetric I/O mode setup
[    0.196463] DMAR: Host address width 39
[    0.196464] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.196472] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.196473] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.196476] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.196477] DMAR: RMRR base: 0x0000009aaf8000 end: 0x0000009ad41fff
[    0.196478] DMAR: RMRR base: 0x0000009b800000 end: 0x0000009fffffff
[    0.196479] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    0.196480] DMAR: ANDD device: 2 name: \_SB.PCI0.I2C1
[    0.196480] DMAR: ANDD device: 7 name: \_SB.PCI0.SPI0
[    0.196481] DMAR: ANDD device: 9 name: \_SB.PCI0.UA00
[    0.196482] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.196483] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.196484] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.198403] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.198404] x2apic enabled
[    0.198419] Switched APIC routing to cluster x2apic.
[    0.202478] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.220473] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x212717146a7, max_idle_ns: 440795291431 ns
[    0.220478] Calibrating delay loop (skipped), value calculated using timer frequency.. 4599.93 BogoMIPS (lpj=9199872)
[    0.220480] pid_max: default: 32768 minimum: 301
[    0.228516] LSM: Security Framework initializing
[    0.228521] Yama: becoming mindful.
[    0.228541] AppArmor: AppArmor initialized
[    0.228543] TOMOYO Linux initialized
[    0.228585] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.228612] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.228860] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.228879] process: using mwait in idle threads
[    0.228882] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.228882] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.228885] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.228886] Spectre V2 : Mitigation: Full generic retpoline
[    0.228886] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.228887] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.228888] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.228889] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    0.228889] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.228892] MDS: Mitigation: Clear CPU buffers
[    0.229136] Freeing SMP alternatives memory: 20K
[    0.231646] TSC deadline timer enabled
[    0.231655] smpboot: CPU0: Intel(R) Core(TM) i3-7020U CPU @ 2.30GHz (family: 0x6, model: 0x8e, stepping: 0x9)
[    0.231753] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.231759] ... version:                4
[    0.231760] ... bit width:              48
[    0.231760] ... generic registers:      4
[    0.231761] ... value mask:             0000ffffffffffff
[    0.231762] ... max period:             00007fffffffffff
[    0.231762] ... fixed-purpose events:   3
[    0.231763] ... event mask:             000000070000000f
[    0.231805] rcu: Hierarchical SRCU implementation.
[    0.232415] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.232456] smp: Bringing up secondary CPUs ...
[    0.232475] x86: Booting SMP configuration:
[    0.232475] .... node  #0, CPUs:      #1 #2
[    0.232494] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.232583]  #3
[    0.232982] smp: Brought up 1 node, 4 CPUs
[    0.232982] smpboot: Max logical packages: 1
[    0.232982] smpboot: Total of 4 processors activated (18399.74 BogoMIPS)
[    0.234101] devtmpfs: initialized
[    0.234101] x86/mm: Memory block size: 128MB
[    0.234101] PM: Registering ACPI NVS region [mem 0x8a06b000-0x8a06bfff] (4096 bytes)
[    0.234101] PM: Registering ACPI NVS region [mem 0x9a521000-0x9a93afff] (4300800 bytes)
[    0.234101] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.234101] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.234101] pinctrl core: initialized pinctrl subsystem
[    0.234101] NET: Registered protocol family 16
[    0.234101] audit: initializing netlink subsys (disabled)
[    0.234101] audit: type=2000 audit(1572872430.036:1): state=initialized audit_enabled=0 res=1
[    0.234101] cpuidle: using governor ladder
[    0.234101] cpuidle: using governor menu
[    0.234101] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.234101] ACPI: bus type PCI registered
[    0.234101] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.234101] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
[    0.234101] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
[    0.234101] PCI: Using configuration type 1 for base access
[    0.236519] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.237259] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.237259] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.380697] alg: No test for lzo-rle (lzo-rle-generic)
[    0.380697] alg: No test for lzo-rle (lzo-rle-scomp)
[    0.380697] ACPI: Added _OSI(Module Device)
[    0.380697] ACPI: Added _OSI(Processor Device)
[    0.380697] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.380697] ACPI: Added _OSI(Processor Aggregator Device)
[    0.380697] ACPI: Added _OSI(Linux-Dell-Video)
[    0.380697] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.380697] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.423933] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.425287] ACPI: EC: EC started
[    0.425288] ACPI: EC: interrupt blocked
[    0.427130] ACPI: \: Used as first EC
[    0.427132] ACPI: \: GPE=0x50, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.427132] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.432544] ACPI: Dynamic OEM Table Load:
[    0.432550] ACPI: SSDT 0xFFFF9B07D5326800 00060F (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
[    0.433940] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
[    0.435298] ACPI: Dynamic OEM Table Load:
[    0.435304] ACPI: SSDT 0xFFFF9B07D4C70800 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
[    0.436672] ACPI: Dynamic OEM Table Load:
[    0.436676] ACPI: SSDT 0xFFFF9B07D4F20300 0000BA (v02 PmRef  Cpu0Hwp  00003000 INTL 20160422)
[    0.437952] ACPI: Dynamic OEM Table Load:
[    0.437956] ACPI: SSDT 0xFFFF9B07D5324800 000628 (v02 PmRef  HwpLvt   00003000 INTL 20160422)
[    0.439568] ACPI: Dynamic OEM Table Load:
[    0.439575] ACPI: SSDT 0xFFFF9B07D5377000 000D14 (v02 PmRef  ApIst    00003000 INTL 20160422)
[    0.441474] ACPI: Dynamic OEM Table Load:
[    0.441478] ACPI: SSDT 0xFFFF9B07D4C71800 000317 (v02 PmRef  ApHwp    00003000 INTL 20160422)
[    0.442884] ACPI: Dynamic OEM Table Load:
[    0.442888] ACPI: SSDT 0xFFFF9B07D4C70C00 00030A (v02 PmRef  ApCst    00003000 INTL 20160422)
[    0.445763] ACPI: Interpreter enabled
[    0.445811] ACPI: (supports S0 S3 S4 S5)
[    0.445812] ACPI: Using IOAPIC for interrupt routing
[    0.445852] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.446856] ACPI: Enabled 6 GPEs in block 00 to 7F
[    0.466548] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    0.466553] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.468532] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
[    0.468533] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.469296] PCI host bridge to bus 0000:00
[    0.469298] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.469299] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.469301] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.469301] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[    0.469302] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    0.469303] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[    0.469304] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[    0.469305] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    0.469306] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    0.469307] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    0.469308] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    0.469309] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
[    0.469310] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
[    0.469310] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
[    0.469311] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
[    0.469312] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
[    0.469313] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xefffffff window]
[    0.469314] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    0.469315] pci_bus 0000:00: root bus resource [bus 00-7e]
[    0.469327] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
[    0.469694] pci 0000:00:02.0: [8086:5921] type 00 class 0x030000
[    0.469707] pci 0000:00:02.0: reg 0x10: [mem 0xee000000-0xeeffffff 64bit]
[    0.469714] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.469718] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.469735] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.469873] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
[    0.469887] pci 0000:00:04.0: reg 0x10: [mem 0xef1a8000-0xef1affff 64bit]
[    0.470111] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.470134] pci 0000:00:14.0: reg 0x10: [mem 0xef190000-0xef19ffff 64bit]
[    0.470206] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.470435] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.470457] pci 0000:00:14.2: reg 0x10: [mem 0xef1c0000-0xef1c0fff 64bit]
[    0.470727] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    0.470991] pci 0000:00:15.0: reg 0x10: [mem 0xef1bf000-0xef1bffff 64bit]
[    0.472058] pci 0000:00:15.1: [8086:9d61] type 00 class 0x118000
[    0.472322] pci 0000:00:15.1: reg 0x10: [mem 0xef1be000-0xef1befff 64bit]
[    0.473308] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.473335] pci 0000:00:16.0: reg 0x10: [mem 0xef1bd000-0xef1bdfff 64bit]
[    0.473413] pci 0000:00:16.0: PME# supported from D3hot
[    0.473614] pci 0000:00:17.0: [8086:282a] type 00 class 0x010400
[    0.473633] pci 0000:00:17.0: reg 0x10: [mem 0xef1a0000-0xef1a7fff]
[    0.473641] pci 0000:00:17.0: reg 0x14: [mem 0xef1bc000-0xef1bc0ff]
[    0.473649] pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
[    0.473656] pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
[    0.473664] pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
[    0.473672] pci 0000:00:17.0: reg 0x24: [mem 0xef100000-0xef17ffff]
[    0.473717] pci 0000:00:17.0: PME# supported from D3hot
[    0.473878] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.474037] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.474226] pci 0000:00:1c.5: [8086:9d15] type 01 class 0x060400
[    0.474318] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.474598] pci 0000:00:1e.0: [8086:9d27] type 00 class 0x118000
[    0.474862] pci 0000:00:1e.0: reg 0x10: [mem 0xef1bb000-0xef1bbfff 64bit]
[    0.475930] pci 0000:00:1e.2: [8086:9d29] type 00 class 0x118000
[    0.476194] pci 0000:00:1e.2: reg 0x10: [mem 0xef1ba000-0xef1bafff 64bit]
[    0.477172] pci 0000:00:1e.6: [8086:9d2d] type 00 class 0x080501
[    0.477194] pci 0000:00:1e.6: reg 0x10: [mem 0xef1b9000-0xef1b9fff 64bit]
[    0.477401] pci 0000:00:1f.0: [8086:9d4e] type 00 class 0x060100
[    0.477651] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.477665] pci 0000:00:1f.2: reg 0x10: [mem 0xef1b4000-0xef1b7fff]
[    0.477843] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.477870] pci 0000:00:1f.3: reg 0x10: [mem 0xef1b0000-0xef1b3fff 64bit]
[    0.477896] pci 0000:00:1f.3: reg 0x20: [mem 0xef180000-0xef18ffff 64bit]
[    0.477947] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.478206] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.478267] pci 0000:00:1f.4: reg 0x10: [mem 0xef1b8000-0xef1b80ff 64bit]
[    0.478338] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    0.478604] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.478693] pci 0000:02:00.0: [168c:0036] type 00 class 0x028000
[    0.478744] pci 0000:02:00.0: reg 0x10: [mem 0xef000000-0xef07ffff 64bit]
[    0.478803] pci 0000:02:00.0: reg 0x30: [mem 0xef080000-0xef08ffff pref]
[    0.478932] pci 0000:02:00.0: supports D1 D2
[    0.478933] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.479097] pci 0000:00:1c.5: PCI bridge to [bus 02]
[    0.479101] pci 0000:00:1c.5:   bridge window [mem 0xef000000-0xef0fffff]
[    0.481452] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.481509] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.481565] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.481619] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.481673] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.481728] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.481781] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.481836] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.482484] ACPI: EC: interrupt unblocked
[    0.482509] ACPI: EC: event unblocked
[    0.482522] ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0x50, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.482523] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions and events
[    0.482594] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.482594] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.482594] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.482594] vgaarb: loaded
[    0.482594] EDAC MC: Ver: 3.0.0
[    0.482594] Registered efivars operations
[    0.482594] PCI: Using ACPI for IRQ routing
[    0.498452] PCI: pci_cache_line_size set to 64 bytes
[    0.498618] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.498619] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.498620] e820: reserve RAM buffer [mem 0x8a06b000-0x8bffffff]
[    0.498621] e820: reserve RAM buffer [mem 0x9965d000-0x9bffffff]
[    0.498622] e820: reserve RAM buffer [mem 0x9afff000-0x9bffffff]
[    0.498622] e820: reserve RAM buffer [mem 0x25f000000-0x25fffffff]
[    0.499212] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.499215] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.501510] clocksource: Switched to clocksource tsc-early
[    0.509514] VFS: Disk quotas dquot_6.6.0
[    0.509527] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.509638] AppArmor: AppArmor Filesystem Enabled
[    0.509651] pnp: PnP ACPI init
[    0.509968] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.509970] system 00:00: [io  0xffff] has been reserved
[    0.509971] system 00:00: [io  0xffff] has been reserved
[    0.509972] system 00:00: [io  0xffff] has been reserved
[    0.509973] system 00:00: [io  0x1800-0x18fe] has been reserved
[    0.509974] system 00:00: [io  0x164e-0x164f] has been reserved
[    0.509979] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.510086] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.510123] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.510126] system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.510293] pnp 00:03: Plug and Play ACPI device, IDs ATK3001 PNP030b (active)
[    0.510513] system 00:04: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.510514] system 00:04: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.510515] system 00:04: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.510516] system 00:04: [mem 0xf0000000-0xf7ffffff] has been reserved
[    0.510517] system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.510519] system 00:04: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.510520] system 00:04: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.510521] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    0.510522] system 00:04: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.510523] system 00:04: [mem 0xeffe0000-0xefffffff] has been reserved
[    0.510526] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.510565] system 00:05: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.510566] system 00:05: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.510567] system 00:05: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.510569] system 00:05: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.510570] system 00:05: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.510571] system 00:05: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.510572] system 00:05: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.510575] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.510896] system 00:06: [io  0xff00-0xfffe] has been reserved
[    0.510899] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.512028] system 00:07: [mem 0xfe029000-0xfe029fff] has been reserved
[    0.512030] system 00:07: [mem 0xfe028000-0xfe028fff] has been reserved
[    0.512032] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.513196] pnp: PnP ACPI: found 8 devices
[    0.514280] thermal_sys: Registered thermal governor 'fair_share'
[    0.514281] thermal_sys: Registered thermal governor 'bang_bang'
[    0.514281] thermal_sys: Registered thermal governor 'step_wise'
[    0.514282] thermal_sys: Registered thermal governor 'user_space'
[    0.518781] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.518811] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    0.518813] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    0.518814] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 01] add_size 200000 add_align 100000
[    0.518825] pci 0000:00:1c.0: BAR 14: assigned [mem 0xa0000000-0xa01fffff]
[    0.518834] pci 0000:00:1c.0: BAR 15: assigned [mem 0xa0200000-0xa03fffff 64bit pref]
[    0.518837] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.518839] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.518846] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    0.518850] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xa01fffff]
[    0.518853] pci 0000:00:1c.0:   bridge window [mem 0xa0200000-0xa03fffff 64bit pref]
[    0.518858] pci 0000:00:1c.5: PCI bridge to [bus 02]
[    0.518861] pci 0000:00:1c.5:   bridge window [mem 0xef000000-0xef0fffff]
[    0.518868] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.518869] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.518870] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.518871] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    0.518872] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    0.518873] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    0.518874] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    0.518875] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    0.518876] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    0.518877] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    0.518878] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    0.518878] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
[    0.518879] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
[    0.518880] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
[    0.518881] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
[    0.518882] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff window]
[    0.518883] pci_bus 0000:00: resource 20 [mem 0xa0000000-0xefffffff window]
[    0.518884] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff window]
[    0.518885] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.518886] pci_bus 0000:01: resource 1 [mem 0xa0000000-0xa01fffff]
[    0.518887] pci_bus 0000:01: resource 2 [mem 0xa0200000-0xa03fffff 64bit pref]
[    0.518888] pci_bus 0000:02: resource 1 [mem 0xef000000-0xef0fffff]
[    0.519042] NET: Registered protocol family 2
[    0.519155] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.519170] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.519265] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.519509] TCP: Hash tables configured (established 65536 bind 65536)
[    0.519537] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.519566] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.519626] NET: Registered protocol family 1
[    0.519639] NET: Registered protocol family 44
[    0.519651] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.520001] PCI: CLS 64 bytes, default 64
[    0.520035] Unpacking initramfs...
[    1.819165] Freeing initrd memory: 83348K
[    1.819285] DMAR: ACPI device "device:71" under DMAR at fed91000 as 00:15.0
[    1.819288] DMAR: ACPI device "device:72" under DMAR at fed91000 as 00:15.1
[    1.819290] DMAR: ACPI device "device:73" under DMAR at fed91000 as 00:1e.2
[    1.819293] DMAR: ACPI device "device:74" under DMAR at fed91000 as 00:1e.0
[    1.848543] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.848545] software IO TLB: mapped [mem 0x84d7f000-0x88d7f000] (64MB)
[    1.848970] Initialise system trusted keyrings
[    1.848977] Key type blacklist registered
[    1.849023] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[    1.850146] zbud: loaded
[    1.850430] Platform Keyring initialized
[    1.850432] Key type asymmetric registered
[    1.850432] Asymmetric key parser 'x509' registered
[    1.850438] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    1.850470] io scheduler mq-deadline registered
[    1.850826] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    1.850859] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
[    1.851134] pcieport 0000:00:1c.5: PME: Signaling with IRQ 123
[    1.851189] pcieport 0000:00:1c.5: AER: enabled with IRQ 123
[    1.851256] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.851269] efifb: probing for efifb
[    1.851283] efifb: framebuffer at 0xd0000000, using 1920k, total 1920k
[    1.851284] efifb: mode is 800x600x32, linelength=3200, pages=1
[    1.851284] efifb: scrolling: redraw
[    1.851285] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.851354] Console: switching to colour frame buffer device 100x37
[    1.852262] fb0: EFI VGA frame buffer device
[    1.852268] intel_idle: MWAIT substates: 0x11142120
[    1.852269] intel_idle: v0.4.1 model 0x8E
[    1.852469] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.853630] thermal LNXTHERM:00: registered as thermal_zone0
[    1.853631] ACPI: Thermal Zone [THRM] (38 C)
[    1.853817] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.854506] Linux agpgart interface v0.103
[    1.854554] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    1.854555] AMD-Vi: AMD IOMMUv2 functionality not available on this system
[    1.854740] i8042: PNP: PS/2 Controller [PNP030b:PS2K] at 0x60,0x64 irq 1
[    1.854741] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    1.856221] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.856338] mousedev: PS/2 mouse device common for all mice
[    1.856386] rtc_cmos 00:01: RTC can wake from S4
[    1.856728] rtc rtc0: invalid alarm value: 2019-11-04T13:63:31
[    1.856751] rtc_cmos 00:01: registered as rtc0
[    1.856762] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    1.856769] intel_pstate: Intel P-state driver initializing
[    1.857116] intel_pstate: HWP enabled
[    1.857186] ledtrig-cpu: registered to indicate activity on CPUs
[    1.857507] NET: Registered protocol family 10
[    1.869071] Segment Routing with IPv6
[    1.869096] mip6: Mobile IPv6
[    1.869098] NET: Registered protocol family 17
[    1.869178] mpls_gso: MPLS GSO support
[    1.869515] microcode: sig=0x806e9, pf=0x40, revision=0xb4
[    1.869532] microcode: Microcode Update Driver: v2.2.
[    1.869542] sched_clock: Marking stable (1868917562, 501463)->(1875020560, -5601535)
[    1.869692] registered taskstats version 1
[    1.869693] Loading compiled-in X.509 certificates
[    1.890633] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.908172] Loaded X.509 cert 'Build time autogenerated kernel key: 7b36bdf50c16ceb3f257b52e6c0198758025a497'
[    1.908195] zswap: loaded using pool lzo/zbud
[    1.908280] AppArmor: AppArmor sha1 policy hashing enabled
[    1.909484] integrity: Loading X.509 certificate: UEFI:db
[    1.909695] integrity: Loaded X.509 cert 'ASUSTeK Notebook SW Key Certificate: b8e581e4df77a5bb4282d5ccfc00c071'
[    1.909696] integrity: Loading X.509 certificate: UEFI:db
[    1.909897] integrity: Loaded X.509 cert 'ASUSTeK MotherBoard SW Key Certificate: da83b990422ebc8c441f8d8b039a65a2'
[    1.909898] integrity: Loading X.509 certificate: UEFI:db
[    1.909919] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.909919] integrity: Loading X.509 certificate: UEFI:db
[    1.909937] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.909937] integrity: Loading X.509 certificate: UEFI:db
[    1.910140] integrity: Loaded X.509 cert 'Canonical Ltd. Master Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    1.910623] Couldn't get size: 0x800000000000000e
[    1.910643] Couldn't get UEFI MokListRT
[    1.912952] rtc_cmos 00:01: setting system clock to 2019-11-04T13:00:32 UTC (1572872432)
[    1.914119] Freeing unused kernel image memory: 1644K
[    1.937027] Write protecting the kernel read-only data: 16384k
[    1.937575] Freeing unused kernel image memory: 2036K
[    1.937726] Freeing unused kernel image memory: 612K
[    1.945801] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.945802] x86/mm: Checking user space page tables
[    1.953759] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.953760] Run /init as init process
[    2.022005] video: module verification failed: signature and/or required key missing - tainting kernel
[    2.033676] hidraw: raw HID events driver (C) Jiri Kosina
[    2.036605] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    2.046671] ACPI: bus type USB registered
[    2.046855] SCSI subsystem initialized
[    2.047020] usbcore: registered new interface driver usbfs
[    2.047031] usbcore: registered new interface driver hub
[    2.047061] usbcore: registered new device driver usb
[    2.048202] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    2.048302] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    2.048681] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
[    2.054181] intel-lpss 0000:00:1e.0: enabling device (0000 -> 0002)
[    2.056579] dw-apb-uart.2: ttyS0 at MMIO 0xef1bb000 (irq = 20, base_baud = 115200) is a 16550A
[    2.058204] sdhci: Secure Digital Host Controller Interface driver
[    2.058205] sdhci: Copyright(c) Pierre Ossman
[    2.060903] intel-lpss 0000:00:1e.2: enabling device (0000 -> 0002)
[    2.061598] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.061781] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.063106] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
[    2.063115] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    2.063332] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.03
[    2.063334] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.063336] usb usb1: Product: xHCI Host Controller
[    2.063337] usb usb1: Manufacturer: Linux 5.3.8 xhci-hcd
[    2.063339] usb usb1: SerialNumber: 0000:00:14.0
[    2.063469] hub 1-0:1.0: USB hub found
[    2.063489] hub 1-0:1.0: 12 ports detected
[    2.063604] libata version 3.00 loaded.
[    2.070208] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.070213] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    2.070217] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.070437] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.03
[    2.070439] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.070440] usb usb2: Product: xHCI Host Controller
[    2.070442] usb usb2: Manufacturer: Linux 5.3.8 xhci-hcd
[    2.070443] usb usb2: SerialNumber: 0000:00:14.0
[    2.070565] hub 2-0:1.0: USB hub found
[    2.070583] hub 2-0:1.0: 6 ports detected
[    2.072098] sdhci-pci 0000:00:1e.6: SDHCI controller found [8086:9d2d] (rev 21)
[    2.072111] sdhci-pci 0000:00:1e.6: enabling device (0000 -> 0002)
[    2.072165] ahci 0000:00:17.0: version 3.0
[    2.073880] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl RAID mode
[    2.073886] ahci 0000:00:17.0: flags: 64bit ncq pm led clo only pio slum part deso sadm sds apst 
[    2.076050] sdhci-pci 0000:00:1e.6: failed to setup card detect gpio
[    2.079830] mmc0: SDHCI controller on PCI [0000:00:1e.6] using ADMA 64-bit
[    2.082536] pxa2xx-spi pxa2xx-spi.3: no DMA channels available, using PIO
[    2.082571] scsi host0: ahci
[    2.082686] ata1: SATA max UDMA/133 abar m524288@0xef100000 port 0xef100100 irq 125
[    2.108191] i2c_hid i2c-ELAN1300:00: i2c-ELAN1300:00 supply vdd not found, using dummy regulator
[    2.108232] i2c_hid i2c-ELAN1300:00: i2c-ELAN1300:00 supply vddl not found, using dummy regulator
[    2.147490] checking generic (d0000000 1e0000) vs hw (d0000000 10000000)
[    2.147491] fb0: switching to inteldrmfb from EFI VGA
[    2.147552] Console: switching to colour dummy device 80x25
[    2.147584] i915 0000:00:02.0: vgaarb: deactivate vga console
[    2.148335] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.148335] [drm] Driver supports precise vblank timestamp query.
[    2.148793] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.149356] [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
[    2.178201] [drm] Initialized i915 1.6.0 20190619 for 0000:00:02.0 on minor 0
[    2.180295] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.180629] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input1
[    2.186940] fbcon: i915drmfb (fb0) is primary device
[    2.192932] Console: switching to colour frame buffer device 240x67
[    2.214607] i915 0000:00:02.0: fb0: i915drmfb frame buffer device
[    2.396111] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.404554] usb 1-6: new high-speed USB device number 2 using xhci_hcd
[    2.408176] ata1.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
[    2.408178] ata1.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
[    2.408180] ata1.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGURATION OVERLAY) filtered out
[    2.537482] ata1.00: ATA-10: ST1000LM035-1RK172, SDM4, max UDMA/133
[    2.537485] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    2.562209] ata1.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
[    2.562212] ata1.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
[    2.562214] ata1.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGURATION OVERLAY) filtered out
[    2.580031] usb 1-6: New USB device found, idVendor=13d3, idProduct=5a11, bcdDevice=17.02
[    2.580034] usb 1-6: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    2.580036] usb 1-6: Product: USB2.0 VGA UVC WebCam
[    2.580037] usb 1-6: Manufacturer: Azurewave
[    2.580038] usb 1-6: SerialNumber:  
[    2.600198] ata1.00: configured for UDMA/133
[    2.600425] scsi 0:0:0:0: Direct-Access     ATA      ST1000LM035-1RK1 SDM4 PQ: 0 ANSI: 5
[    2.606797] input: ELAN1300:00 04F3:3057 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-ELAN1300:00/0018:04F3:3057.0001/input/input2
[    2.606898] input: ELAN1300:00 04F3:3057 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-ELAN1300:00/0018:04F3:3057.0001/input/input3
[    2.606978] hid-generic 0018:04F3:3057.0001: input,hidraw0: I2C HID v1.00 Mouse [ELAN1300:00 04F3:3057] on i2c-ELAN1300:00
[    2.607824] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    2.607827] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    2.607837] sd 0:0:0:0: [sda] Write Protect is off
[    2.607839] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.607858] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.677824]  sda: sda1 sda2 sda3
[    2.678627] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.708563] usb 1-8: new full-speed USB device number 3 using xhci_hcd
[    2.852624] tsc: Refined TSC clocksource calibration: 2303.995 MHz
[    2.852633] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2135f2f0a94, max_idle_ns: 440795243793 ns
[    2.852650] clocksource: Switched to clocksource tsc
[    2.858220] usb 1-8: New USB device found, idVendor=04ca, idProduct=3018, bcdDevice= 0.01
[    2.858223] usb 1-8: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.208482] raid6: avx2x4   gen() 23782 MB/s
[    3.276479] raid6: avx2x4   xor() 14760 MB/s
[    3.344481] raid6: avx2x2   gen() 20428 MB/s
[    3.412478] raid6: avx2x2   xor() 13381 MB/s
[    3.480482] raid6: avx2x1   gen() 16720 MB/s
[    3.548480] raid6: avx2x1   xor() 11328 MB/s
[    3.616478] raid6: sse2x4   gen()  9840 MB/s
[    3.684478] raid6: sse2x4   xor()  6050 MB/s
[    3.752482] raid6: sse2x2   gen()  8467 MB/s
[    3.820480] raid6: sse2x2   xor()  5706 MB/s
[    3.888485] raid6: sse2x1   gen()  7558 MB/s
[    3.956486] raid6: sse2x1   xor()  4256 MB/s
[    3.956487] raid6: using algorithm avx2x4 gen() 23782 MB/s
[    3.956487] raid6: .... xor() 14760 MB/s, rmw enabled
[    3.956488] raid6: using avx2x2 recovery algorithm
[    3.956865] async_tx: api initialized (async)
[    3.957189] xor: automatically using best checksumming function   avx       
[    3.990769] PM: Image not found (code -22)
[    4.232645] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[    4.861096] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[    6.622739] systemd[1]: Inserted module 'autofs4'
[    6.908446] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    6.929125] systemd[1]: Detected architecture x86-64.
[    6.992104] systemd[1]: Set hostname to <debian>.
[    7.002714] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid argument
[    8.323879] systemd[1]: Reached target Remote File Systems.
[    8.324236] systemd[1]: Listening on Journal Socket.
[    8.324417] systemd[1]: Listening on udev Control Socket.
[    8.326443] systemd[1]: Mounting Kernel Debug File System...
[    8.326720] systemd[1]: Listening on fsck to fsckd communication Socket.
[    8.327120] systemd[1]: Created slice User and Session Slice.
[    8.712493] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[    8.842355] systemd-journald[267]: Received request to flush runtime journal from PID 1
[   10.218669] battery: ACPI: Battery Slot [BAT0] (battery present)
[   10.257664] idma64 idma64.0: Found Intel integrated DMA 64-bit
[   10.258072] idma64 idma64.1: Found Intel integrated DMA 64-bit
[   10.258469] idma64 idma64.2: Found Intel integrated DMA 64-bit
[   10.258910] idma64 idma64.3: Found Intel integrated DMA 64-bit
[   10.271178] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:19/PNP0C09:01/PNP0C0D:00/input/input4
[   10.271186] ACPI: Lid Switch [LID]
[   10.271264] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input5
[   10.271270] ACPI: Sleep Button [SLPB]
[   10.271301] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input6
[   10.271307] ACPI: Power Button [PWRB]
[   10.271339] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input7
[   10.271348] ACPI: Power Button [PWRF]
[   10.304525] ACPI: AC Adapter [AC0] (on-line)
[   10.488880] input: Asus Wireless Radio Control as /devices/LNXSYSTM:00/LNXSYBUS:00/ATK4002:00/input/input8
[   10.733379] mei_me 0000:00:16.0: enabling device (0004 -> 0006)
[   10.752246] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[   10.752247] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   10.752248] RAPL PMU: hw unit of domain package 2^-14 Joules
[   10.752248] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   10.752248] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   10.792855] input: PC Speaker as /devices/platform/pcspkr/input/input9
[   10.839036] input: ELAN1300:00 04F3:3057 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-ELAN1300:00/0018:04F3:3057.0001/input/input11
[   10.839233] hid-multitouch 0018:04F3:3057.0001: input,hidraw0: I2C HID v1.00 Mouse [ELAN1300:00 04F3:3057] on i2c-ELAN1300:00
[   11.032421] EFI Variables Facility v0.08 2004-May-17
[   11.245601] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   11.500591] pstore: Using crash dump compression: deflate
[   11.500606] pstore: Registered efi as persistent store backend
[   11.513800] cryptd: max_cpu_qlen set to 1000
[   11.601745] iTCO_vendor_support: vendor-support=0
[   11.695889] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   11.696048] iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
[   11.696269] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   11.817100] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[   11.818472] intel_rapl_common: Found RAPL domain package
[   11.818474] intel_rapl_common: Found RAPL domain dram
[   11.818617] proc_thermal 0000:00:04.0: Creating sysfs group for PROC_THERMAL_PCI
[   11.900904] asus_wmi: ASUS WMI generic driver loaded
[   11.976339] asus_wmi: Initialization: 0x1
[   11.976410] asus_wmi: BIOS WMI version: 9.0
[   11.976463] asus_wmi: SFUN value: 0x21
[   11.976474] asus-nb-wmi asus-nb-wmi: Detected ATK, not ASUSWMI, use DSTS
[   11.976507] asus-nb-wmi asus-nb-wmi: Detected ATK, enable event queue
[   11.978685] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input12
[   11.978849] asus_wmi: Number of fans: 0
[   12.043240] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[   12.043480] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[   12.221304] AVX2 version of gcm_enc/dec engaged.
[   12.221306] AES CTR mode by8 optimization enabled
[   12.365210] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC256: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   12.365213] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   12.365215] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[   12.365217] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   12.365218] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   12.365220] snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
[   12.365222] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x1b
[   12.365224] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x13
[   12.467003] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[   12.513778] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[   12.513840] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[   12.513897] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[   12.513949] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[   12.514001] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[   12.514059] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[   13.281438] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   13.281878] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   13.285555] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   13.285557] cfg80211: failed to load regulatory.db
[   13.438883] mc: Linux media interface: v0.10
[   13.614098] videodev: Linux video capture interface: v2.00
[   14.402908] Bluetooth: Core ver 2.22
[   14.402925] NET: Registered protocol family 31
[   14.402925] Bluetooth: HCI device and connection manager initialized
[   14.402930] Bluetooth: HCI socket layer initialized
[   14.402932] Bluetooth: L2CAP socket layer initialized
[   14.402935] Bluetooth: SCO socket layer initialized
[   14.593740] uvcvideo: Found UVC 1.00 device USB2.0 VGA UVC WebCam (13d3:5a11)
[   14.596277] uvcvideo 1-6:1.0: Entity type for entity Extension 4 was not initialized!
[   14.596279] uvcvideo 1-6:1.0: Entity type for entity Processing 2 was not initialized!
[   14.596281] uvcvideo 1-6:1.0: Entity type for entity Camera 1 was not initialized!
[   14.596370] input: USB2.0 VGA UVC WebCam: USB2.0 V as /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.0/input/input19
[   14.596459] usbcore: registered new interface driver uvcvideo
[   14.596460] USB Video Class driver (1.1.1)
[   14.672813] usbcore: registered new interface driver btusb
[   16.120819] usb 1-8: USB disconnect, device number 3
[   16.121487] usbcore: registered new interface driver ath3k
[   16.281012] Adding 8263676k swap on /dev/sda3.  Priority:-2 extents:1 across:8263676k FS
[   16.428994] usb 1-8: new full-speed USB device number 4 using xhci_hcd
[   16.892861] ath9k 0000:02:00.0: enabling device (0000 -> 0002)
[   16.893052] ath: phy0: Set BT/WLAN RX diversity capability
[   16.902687] ath: phy0: Enable LNA combining
[   16.903945] ath: phy0: ASPM enabled: 0x43
[   16.903946] ath: EEPROM regdomain: 0x6c
[   16.903946] ath: EEPROM indicates we should expect a direct regpair map
[   16.903948] ath: Country alpha2 being used: 00
[   16.903949] ath: Regpair used: 0x6c
[   16.904813] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   16.905105] ieee80211 phy0: Atheros AR9565 Rev:2 mem=0xffffb9a380680000, irq=17
[   17.596426] ath9k 0000:02:00.0 wlp2s0: renamed from wlan0
[   19.098990] audit: type=1400 audit(1572872449.679:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-xpdfimport" pid=556 comm="apparmor_parser"
[   19.145453] audit: type=1400 audit(1572872449.727:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=555 comm="apparmor_parser"
[   19.145462] audit: type=1400 audit(1572872449.727:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=555 comm="apparmor_parser"
[   19.245745] audit: type=1400 audit(1572872449.827:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=559 comm="apparmor_parser"
[   19.245751] audit: type=1400 audit(1572872449.827:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=559 comm="apparmor_parser"
[   19.245754] audit: type=1400 audit(1572872449.827:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=559 comm="apparmor_parser"
[   19.251411] audit: type=1400 audit(1572872449.831:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-senddoc" pid=560 comm="apparmor_parser"
[   19.274869] audit: type=1400 audit(1572872449.855:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-oopslash" pid=562 comm="apparmor_parser"
[   19.369119] audit: type=1400 audit(1572872449.951:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/evince" pid=558 comm="apparmor_parser"
[   19.369126] audit: type=1400 audit(1572872449.951:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/evince//sanitized_helper" pid=558 comm="apparmor_parser"
[   21.821690] usb 1-8: New USB device found, idVendor=04ca, idProduct=3018, bcdDevice= 0.02
[   21.821694] usb 1-8: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   25.327290] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   25.327292] Bluetooth: BNEP filters: protocol multicast
[   25.327298] Bluetooth: BNEP socket layer initialized
[   29.622922] wlp2s0: authenticate with 0c:d2:b5:91:a8:0b
[   29.640099] wlp2s0: send auth to 0c:d2:b5:91:a8:0b (try 1/3)
[   29.642073] wlp2s0: authenticated
[   29.644564] wlp2s0: associate with 0c:d2:b5:91:a8:0b (try 1/3)
[   29.649258] wlp2s0: RX AssocResp from 0c:d2:b5:91:a8:0b (capab=0x411 status=0 aid=3)
[   29.649403] wlp2s0: associated
[   30.003257] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes ready
[   45.433980] Bluetooth: RFCOMM TTY layer initialized
[   45.433988] Bluetooth: RFCOMM socket layer initialized
[   45.433997] Bluetooth: RFCOMM ver 1.11
[   93.510957] fuse: init (API version 7.31)
[   97.410154] rfkill: input handler disabled
[ 5013.697978] perf: interrupt took too long (2513 > 2500), lowering kernel.perf_event_max_sample_rate to 79500
[ 7962.803264] perf: interrupt took too long (3164 > 3141), lowering kernel.perf_event_max_sample_rate to 63000
[10113.316218] wlp2s0: AP 0c:d2:b5:91:a8:0b changed bandwidth, new config is 2442 MHz, width 1 (2442/0 MHz)
[10585.240934] usb 1-1: new high-speed USB device number 5 using xhci_hcd
[10585.389752] usb 1-1: New USB device found, idVendor=0781, idProduct=5567, bcdDevice= 1.26
[10585.389757] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[10585.389760] usb 1-1: Product: Cruzer Blade
[10585.389762] usb 1-1: Manufacturer: SanDisk
[10585.389765] usb 1-1: SerialNumber: 20044324630766802A54
[10585.495317] usb-storage 1-1:1.0: USB Mass Storage device detected
[10585.495525] scsi host1: usb-storage 1-1:1.0
[10585.495707] usbcore: registered new interface driver usb-storage
[10585.514691] usbcore: registered new interface driver uas
[10586.526620] scsi 1:0:0:0: Direct-Access     SanDisk  Cruzer Blade     1.26 PQ: 0 ANSI: 5
[10586.528222] sd 1:0:0:0: Attached scsi generic sg1 type 0
[10586.529755] sd 1:0:0:0: [sdb] 7821312 512-byte logical blocks: (4.00 GB/3.73 GiB)
[10586.530501] sd 1:0:0:0: [sdb] Write Protect is off
[10586.530506] sd 1:0:0:0: [sdb] Mode Sense: 43 00 00 00
[10586.530765] sd 1:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[10586.539698]  sdb: sdb1 sdb2
[10586.543732] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[10586.976055] ISO 9660 Extensions: Microsoft Joliet Level 3
[10586.978552] ISO 9660 Extensions: Microsoft Joliet Level 3
[10586.993937] ISO 9660 Extensions: RRIP_1991A
[10620.853355] usb 1-1: USB disconnect, device number 5
[10649.463437] usb 1-1: new high-speed USB device number 6 using xhci_hcd
[10649.612595] usb 1-1: New USB device found, idVendor=0781, idProduct=5567, bcdDevice= 1.26
[10649.612599] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[10649.612602] usb 1-1: Product: Cruzer Blade
[10649.612604] usb 1-1: Manufacturer: SanDisk
[10649.612606] usb 1-1: SerialNumber: 20044324630766802A54
[10649.613669] usb-storage 1-1:1.0: USB Mass Storage device detected
[10649.619059] scsi host1: usb-storage 1-1:1.0
[10650.624578] scsi 1:0:0:0: Direct-Access     SanDisk  Cruzer Blade     1.26 PQ: 0 ANSI: 5
[10650.626426] sd 1:0:0:0: Attached scsi generic sg1 type 0
[10650.627930] sd 1:0:0:0: [sdb] 7821312 512-byte logical blocks: (4.00 GB/3.73 GiB)
[10650.628682] sd 1:0:0:0: [sdb] Write Protect is off
[10650.628687] sd 1:0:0:0: [sdb] Mode Sense: 43 00 00 00
[10650.628944] sd 1:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[10650.637169]  sdb: sdb1 sdb2
[10650.640513] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[10650.976566] ISO 9660 Extensions: Microsoft Joliet Level 3
[10650.978399] ISO 9660 Extensions: Microsoft Joliet Level 3
[10650.979857] ISO 9660 Extensions: RRIP_1991A
[10765.927629] perf: interrupt took too long (3985 > 3955), lowering kernel.perf_event_max_sample_rate to 50000

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="newlspci-vv.txt"

00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers (rev 03)
	Subsystem: ASUSTeK Computer Inc. Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=10 <?>
	Kernel driver in use: skl_uncore

00:02.0 VGA compatible controller: Intel Corporation Device 5921 (rev 06) (prog-if 00 [VGA controller])
	Subsystem: ASUSTeK Computer Inc. Device 1311
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 127
	Region 0: Memory at ee000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at f000 [size=64]
	[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [40] Vendor Specific Information: Len=0c <?>
	Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
	Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00018  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Process Address Space ID (PASID)
		PASIDCap: Exec- Priv-, Max PASID Width: 14
		PASIDCtl: Enable- Exec- Priv-
	Capabilities: [200 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable-, Smallest Translation Unit: 00
	Capabilities: [300 v1] Page Request Interface (PRI)
		PRICtl: Enable- Reset-
		PRISta: RF- UPRGI- Stopped+
		Page Request Capacity: 00008000, Page Request Allocation: 00000000
	Kernel driver in use: i915
	Kernel modules: i915

00:04.0 Signal processing controller: Intel Corporation Skylake Processor Thermal Subsystem (rev 03)
	Subsystem: ASUSTeK Computer Inc. Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ef1a8000 (64-bit, non-prefetchable) [size=32K]
	Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: proc_thermal
	Kernel modules: processor_thermal_device

00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller (rev 21) (prog-if 30 [XHCI])
	Subsystem: ASUSTeK Computer Inc. Sunrise Point-LP USB 3.0 xHCI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 124
	Region 0: Memory at ef190000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee002b8  Data: 0000
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

00:14.2 Signal processing controller: Intel Corporation Sunrise Point-LP Thermal subsystem (rev 21)
	Subsystem: ASUSTeK Computer Inc. Sunrise Point-LP Thermal subsystem
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at ef1c0000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Kernel driver in use: intel_pch_thermal
	Kernel modules: intel_pch_thermal

00:15.0 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 (rev 21)
	Subsystem: ASUSTeK Computer Inc. Sunrise Point-LP Serial IO I2C Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ef1bf000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:15.1 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1 (rev 21)
	Subsystem: ASUSTeK Computer Inc. Sunrise Point-LP Serial IO I2C Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at ef1be000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:16.0 Communication controller: Intel Corporation Sunrise Point-LP CSME HECI #1 (rev 21)
	Subsystem: ASUSTeK Computer Inc. Sunrise Point-LP CSME HECI
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 128
	Region 0: Memory at ef1bd000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00358  Data: 0000
	Kernel driver in use: mei_me
	Kernel modules: mei_me

00:17.0 RAID bus controller: Intel Corporation 82801 Mobile SATA Controller [RAID mode] (rev 21)
	Subsystem: ASUSTeK Computer Inc. 82801 Mobile SATA Controller [RAID mode]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 125
	Region 0: Memory at ef1a0000 (32-bit, non-prefetchable) [size=32K]
	Region 1: Memory at ef1bc000 (32-bit, non-prefetchable) [size=256]
	Region 2: I/O ports at f090 [size=8]
	Region 3: I/O ports at f080 [size=4]
	Region 4: I/O ports at f060 [size=32]
	Region 5: Memory at ef100000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee002f8  Data: 0000
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Kernel driver in use: ahci
	Kernel modules: ahci

00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port (rev f1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 122
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: a0000000-a01fffff
	Prefetchable memory behind bridge: 00000000a0200000-00000000a03fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 8GT/s, Width x4, ASPM L0s L1, Exit Latency L0s unlimited, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Via WAKE# ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00218  Data: 0000
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Sunrise Point-LP PCI Express Root Port
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport

00:1c.5 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #6 (rev f1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 123
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: ef000000-ef0fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #6, Speed 8GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #9, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+, OBFF Not Supported ARIFwd+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00258  Data: 0000
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Sunrise Point-LP PCI Express Root Port
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [200 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=40us PortTPowerOnTime=44us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=0us LTR1.2_Threshold=0ns
		L1SubCtl2: T_PwrOn=44us
	Capabilities: [220 v1] #19
	Kernel driver in use: pcieport

00:1e.0 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO UART Controller #0 (rev 21)
	Subsystem: ASUSTeK Computer Inc. Sunrise Point-LP Serial IO UART Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at ef1bb000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1e.2 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO SPI Controller #0 (rev 21)
	Subsystem: ASUSTeK Computer Inc. Sunrise Point-LP Serial IO SPI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 22
	Region 0: Memory at ef1ba000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1e.6 SD Host controller: Intel Corporation Sunrise Point-LP Secure Digital IO Controller (rev 21) (prog-if 01)
	Subsystem: Intel Corporation Sunrise Point-LP Secure Digital IO Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at ef1b9000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: sdhci-pci
	Kernel modules: sdhci_pci

00:1f.0 ISA bridge: Intel Corporation Sunrise Point LPC Controller/eSPI Controller (rev 21)
	Subsystem: ASUSTeK Computer Inc. Sunrise Point LPC Controller/eSPI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
	Subsystem: ASUSTeK Computer Inc. Sunrise Point-LP PMC
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at ef1b4000 (32-bit, non-prefetchable) [disabled] [size=16K]

00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
	Subsystem: ASUSTeK Computer Inc. Sunrise Point-LP HD Audio
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 129
	Region 0: Memory at ef1b0000 (64-bit, non-prefetchable) [size=16K]
	Region 4: Memory at ef180000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00378  Data: 0000
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel, snd_soc_skl

00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
	Subsystem: ASUSTeK Computer Inc. Sunrise Point-LP SMBus
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at ef1b8000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at f040 [size=32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801

02:00.0 Network controller: Qualcomm Atheros QCA9565 / AR9565 Wireless Network Adapter (rev 01)
	Subsystem: Lite-On Communications Inc QCA9565 / AR9565 Wireless Network Adapter
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at ef000000 (64-bit, non-prefetchable) [size=512K]
	Expansion ROM at ef080000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Kernel driver in use: ath9k
	Kernel modules: ath9k


--pf9I7BMVVzbSWLtt--
