Return-Path: <linux-kselftest+bounces-43542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BDABF0108
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 10:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 387F14E92BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 08:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBFB2EBDE3;
	Mon, 20 Oct 2025 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D56PO1NP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533D1DE89A
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950773; cv=none; b=uVYvSJfa0p7+ysymZGLLrMm+QRMVVuzChVkxiLxJCvzJDw6driPkWsI0bvDzedJr9p0+wU9xRY1JYbl1kQHi08i/avE2HctmTE6GbBSnBdUboCSSwxiFGhCVwsbxfzq7w1QtFdBQJOGh7i8Ezg3IKn4G9fNF2jdqX0GLpFMZXFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950773; c=relaxed/simple;
	bh=xT7yZVdvZ7S2DsEqwZW/83FwyyonWxxUd3uONffqwes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPe3Vpa+tcY+HcDVIfs9mAxkyzzqgBF3gesJiiDXRUR6g6OUKTOaDE+JgSKfIVCDXIeGy1lq+CHDOS0tw4ArgdSXtFSn9Mj+ZeiWMU7oHqPRXw2QdT8sfMctSQKvwtgBCIRvftugaxvbO7St2AjSdX5WWF7nJZTyoBZFbvpWdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D56PO1NP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7835321bc98so3588939b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 01:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760950766; x=1761555566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vk4ng/Sa0upIy99kg7a9RMVgQvPe5tAYvj/i6cV0Dw4=;
        b=D56PO1NP8Sjh70sVrHUBjzFq5A6LCiqJp1i6WvVG+94+gKhhuEWyGwQ8fZ/BUBiCC9
         b2mssHSolpKh9yIzZDDeCOuk5Qq7yqaosDF93pXMJoEUayS5S3w/xSg6X4CuL98weaJg
         u+k4n0/UhHxHPDV+d3tX4nVnAMdsOQQeiWxnWuYhEdJXRbDLnsxMq5f4hJ4YZW0ytTfl
         5ihd3QGlc7dGc4znLYXAXgG1Vf6itsOULrZq9987fAUf/+VfKZiAWG2yCD6ki25UDN1t
         lfPPAslPvetjVJ7KfOsWqUNpbv43SohwGsVaFkWGxyQkFSTezZfh+hk2MK0nL7gN2Qow
         SQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760950766; x=1761555566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vk4ng/Sa0upIy99kg7a9RMVgQvPe5tAYvj/i6cV0Dw4=;
        b=ls9/GG5l3ONUaXD4qzP+Cecz9D2Bpw+wSxdBB4FnVSMDeggU/b/h3bkYbp+5dT0vNV
         1GL3j9PBHm8oVzv8z4Mk9Q5h9LNPP78oCoZTryNkKeR56kmcCFBlLCrA9cPiGovZWAja
         YvvAKQ5NwuvNwSBVjCN1iYTq/3jfi/q19cFP+nryEMl2DECagrzi4LOecMO2EmyhMxvz
         MjfFNyEuf/Y3hkqeiuLXJi9ndbYaLXVmDi7sQfH86Xnm8WxNu93HTXy86sG+gb02EhbL
         MmrutSFdvKKtJVwzN7Hcrrw0CAzZDa2GkYkswdZ7NLO7BP+vIxkQMdphuxQ+XOvd2Xlh
         Skmw==
X-Forwarded-Encrypted: i=1; AJvYcCUrxWDn2mZ5jUmaBF9OqHSEmrvg1HlPLmTjF29IKzQJFT1h8sxXlIUKPHRqjGCNMFnW+iHkWAaWF7zaIp+21YY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr7c8WQWpIEEpcaeoF4Y8mgoEsekP3SVbLr6NKHlnZ9JBj7bEg
	2WA38lIIuikp/l68ZIccztEhcMFNxgHL+I9gPVTwtB0hq9LoiV0WtNMog9B+UfSXtJM=
X-Gm-Gg: ASbGnct4hx9SZmeXzAIuOyMTUDLKSBjelGzBwcm4X9fKeOSu4PdOGgzOuFbVqCekxzR
	xvg4Jm1w1NItw7VLF1Yt8e0yCy6+q+A/k6pNqNPoGzMP5p6B/c1IK+0ix5Py7ETDH/AGA29AYul
	G5BycDzckzz2yLG7byYjXqP3nh6SNLssWLUmxN7HO18iMKCm7vqhymRogELyX2hWbDyAcQWMh7x
	0RL6r5ceZrD/HL6/ykPwKCKHEeEuJhx17IgfUsXdxvdamZKOFdsR3mQUB/YikrKxgQtuXmgHX6R
	g8A6sbYwI+gjOgUwP0AzHVA8VAvABECXRcBFevxHyRW4aBLlOLHCMlFAEUWGhaYMsUdrmWRZuIC
	/A5YoIMWQ7mDVP5UIpSML4tjGBEjKZq/tLlq7huKUjurXPrN3OPqrO7jXlYEzy2xQI6lm4scV4u
	eZm6PojPbsde5tMojD3NywtEbK9UCum3LVC7IH6Q/zEc7qjlKFSQ==
X-Google-Smtp-Source: AGHT+IGQJdOy3vlfhkgfm4tw/2K4pAeC2eUKCjPBuNVMBYc5sHrfm4pYNa8C6+9z74YkC78ByAc+5g==
X-Received: by 2002:a05:6a00:22d4:b0:7a2:1bfe:ac75 with SMTP id d2e1a72fcca58-7a220b1995cmr14441573b3a.16.1760950764805;
        Mon, 20 Oct 2025 01:59:24 -0700 (PDT)
Received: from laptop.dhcp.broadcom.net ([192.19.38.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34adasm7600555b3a.19.2025.10.20.01.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:59:23 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	higuoxing@gmail.com,
	linux-kselftest@vger.kernel.org,
	olsajiri@gmail.com,
	sveiss@meta.com
Subject: strace log before the fix, with fsync fix and with fclose fix.
Date: Mon, 20 Oct 2025 16:59:18 +0800
Message-ID: <20251020085918.1604034-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <CAEf4Bza6ynjUHanEEqQZ_mke3oBCzSitxBt9Jb5tx8rxt8q4vg@mail.gmail.com>
References: <CAEf4Bza6ynjUHanEEqQZ_mke3oBCzSitxBt9Jb5tx8rxt8q4vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test with fsync:

=> bzImage
===> Booting
No EFI environment detected.
early console in extract_kernel
input_data: 0x0000000003e8c2c4
input_len: 0x0000000000d59ef7
output: 0x0000000001000000
output_len: 0x0000000003156b50
kernel_total_size: 0x0000000003c30000
needed_size: 0x0000000003e00000
trampoline_32bit: 0x0000000000000000
Physical KASLR using RDRAND RDTSC...
Virtual KASLR using RDRAND RDTSC...

Decompressing Linux... Parsing ELF... Performing relocations... done.
Booting the kernel (entry_offset: 0x0000000002b46b90).
[    0.000000] Linux version 6.18.0-rc1-g1c64efcb083c (v@laptop) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Mon Oct 20 14:25:28 CST 2025
[    0.000000] Command line: rootfstype=9p rootflags=trans=virtio,cache=mmap,msize=1048576 rw earlyprintk=serial,0,115200 printk.devkmsg=on console=0,115200 loglevel=7 raid=noautodetect init=/tmp/vmtest-initukOgi.sh panic=-1
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable
[    0.000000] printk: legacy bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
[    0.000000] DMI: Memory slots populated: 1/1
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2495.911 MHz processor
[    0.000120] last_pfn = 0x140000 max_arch_pfn = 0x400000000
[    0.000480] MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
[    0.000982] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
Memory KASLR using RDRAND RDTSC...
[    0.001610] last_pfn = 0xbffe0 max_arch_pfn = 0x400000000
[    0.005879] found SMP MP-table at [mem 0x000f66a0-0x000f66af]
[    0.006221] Using GB pages for direct mapping
[    0.006673] ACPI: Early table checksum verification disabled
[    0.007012] ACPI: RSDP 0x00000000000F64B0 000014 (v00 BOCHS )
[    0.007354] ACPI: RSDT 0x00000000BFFE2379 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.007842] ACPI: FACP 0x00000000BFFE2225 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.008355] ACPI: DSDT 0x00000000BFFE0040 0021E5 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.008844] ACPI: FACS 0x00000000BFFE0000 000040
[    0.009109] ACPI: APIC 0x00000000BFFE2299 000080 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.009597] ACPI: HPET 0x00000000BFFE2319 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.010084] ACPI: WAET 0x00000000BFFE2351 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.010629] ACPI: Reserving FACP table memory at [mem 0xbffe2225-0xbffe2298]
[    0.011069] ACPI: Reserving DSDT table memory at [mem 0xbffe0040-0xbffe2224]
[    0.011502] ACPI: Reserving FACS table memory at [mem 0xbffe0000-0xbffe003f]
[    0.011934] ACPI: Reserving APIC table memory at [mem 0xbffe2299-0xbffe2318]
[    0.012367] ACPI: Reserving HPET table memory at [mem 0xbffe2319-0xbffe2350]
[    0.012786] ACPI: Reserving WAET table memory at [mem 0xbffe2351-0xbffe2378]
[    0.013378] No NUMA configuration found
[    0.013607] Faking a node at [mem 0x0000000000000000-0x000000013fffffff]
[    0.014004] NODE_DATA(0) allocated [mem 0x13fff9e80-0x13fffdfff]
[    0.014378] Zone ranges:
[    0.014528]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.014889]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.015247]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
[    0.015608] Movable zone start for each node
[    0.015855] Early memory node ranges
[    0.016062]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.016426]   node   0: [mem 0x0000000000100000-0x00000000bffdffff]
[    0.016789]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
[    0.017159] Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
[    0.017683] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.018057] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.026254] On node 0, zone Normal: 32 pages in unavailable ranges
[    0.026848] ACPI: PM-Timer IO Port: 0x608
[    0.027098] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.027476] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.027885] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.028255] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.028649] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.029035] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.029434] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.029832] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.030207] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.030512] TSC deadline timer available
[    0.030744] CPU topo: Max. logical packages:   1
[    0.031014] CPU topo: Max. logical dies:       1
[    0.031283] CPU topo: Max. dies per package:   1
[    0.031560] CPU topo: Max. threads per core:   1
[    0.031830] CPU topo: Num. cores per package:     2
[    0.032114] CPU topo: Num. threads per package:   2
[    0.032403] CPU topo: Allowing 2 present CPUs plus 0 hotplug CPUs
[    0.032774] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[    0.033144] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.037225] setup_percpu: NR_CPUS:128 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.037927] percpu: Embedded 56 pages/cpu s191568 r8192 d29616 u1048576
[    0.038336] Kernel command line: rootfstype=9p rootflags=trans=virtio,cache=mmap,msize=1048576 rw earlyprintk=serial,0,115200 printk.devkmsg=on console=0,115200 loglevel=7 raid=noautodetect init=/tmp/vmtest-initukOgi.sh panic=-1
[    0.039556] Unknown kernel command line parameters "raid=noautodetect", will be passed to user space.
[    0.040118] random: crng init done
[    0.040320] printk: log buffer data + meta data: 2097152 + 7340032 = 9437184 bytes
[    0.041143] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.041822] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.042345] software IO TLB: area num 2.
[    0.054949] Fallback order for Node 0: 0
[    0.054955] Built 1 zonelists, mobility grouping on.  Total pages: 1048446
[    0.055589] Policy zone: Normal
[    0.055771] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.061934] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Poking KASLR using RDRAND RDTSC...
[    0.069239] ftrace: allocating 41991 entries in 166 pages
[    0.069557] ftrace: allocated 166 pages with 4 groups
[    0.069904] Dynamic Preempt: full
[    0.070234] Running RCU self tests
[    0.070431] Running RCU synchronous self tests
[    0.070676] rcu: Preemptible hierarchical RCU implementation.
[    0.070991] rcu: 	RCU event tracing is enabled.
[    0.071243] rcu: 	RCU lockdep checking is enabled.
[    0.071509] rcu: 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=2.
[    0.071877] 	Trampoline variant of Tasks RCU enabled.
[    0.072154] 	Rude variant of Tasks RCU enabled.
[    0.072404] 	Tracing variant of Tasks RCU enabled.
[    0.072666] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.073086] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.073471] Running RCU synchronous self tests
[    0.073717] RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
[    0.074199] RCU Tasks Rude: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
[    0.074706] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
[    0.078193] NR_IRQS: 8448, nr_irqs: 440, preallocated irqs: 16
[    0.078723] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.079277] Console: colour *CGA 80x25
[    0.079522] printk: legacy console [ttyS0] enabled
[    0.079522] printk: legacy console [ttyS0] enabled
[    0.080060] printk: legacy bootconsole [earlyser0] disabled
[    0.080060] printk: legacy bootconsole [earlyser0] disabled
[    0.080690] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.081126] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.081361] ... MAX_LOCK_DEPTH:          48
[    0.081599] ... MAX_LOCKDEP_KEYS:        8192
[    0.081847] ... CLASSHASH_SIZE:          4096
[    0.082094] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.082348] ... MAX_LOCKDEP_CHAINS:      65536
[    0.082600] ... CHAINHASH_SIZE:          32768
[    0.082852]  memory used by lock dependency info: 6429 kB
[    0.083160]  memory used for stack traces: 4224 kB
[    0.083440]  per task-struct memory footprint: 1920 bytes
[    0.083763] ACPI: Core revision 20250807
[    0.084103] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.084694] APIC: Switch to symmetric I/O mode setup
[    0.085714] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.090704] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x23fa231d958, max_idle_ns: 440795322936 ns
[    0.091317] Calibrating delay loop (skipped), value calculated using timer frequency.. 4991.82 BogoMIPS (lpj=2495911)
[    0.092422] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.092866] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.093308] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.093654] mitigations: Enabled attack vectors: user_kernel, user_user, SMT mitigations: auto
[    0.094147] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.094308] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.094641] ITS: Mitigation: Aligned branch/return thunks
[    0.095309] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.095790] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    0.096310] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.096699] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.097308] active return thunk: its_return_thunk
[    0.097579] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.097993] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.098308] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.098649] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.099002] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.099308] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.099668] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.100308] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.100641] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.100979] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.101308] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.101643] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.102056] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
[    0.121102] Freeing SMP alternatives memory: 44K
[    0.121310] pid_max: default: 32768 minimum: 301
[    0.121614] LSM: initializing lsm=capability,selinux,bpf,ima
[    0.122011] SELinux:  Initializing.
[    0.122905] LSM support for eBPF active
[    0.123189] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.123312] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.124630] Running RCU synchronous self tests
[    0.124880] Running RCU synchronous self tests
[    0.125283] smpboot: CPU0: 11th Gen Intel(R) Core(TM) i7-11850H @ 2.50GHz (family: 0x6, model: 0x8d, stepping: 0x1)
[    0.125307] Performance Events: Icelake events, full-width counters, Intel PMU driver.
[    0.125316] ... version:                   2
[    0.125551] ... bit width:                 48
[    0.125792] ... generic counters:          8
[    0.126039] ... generic bitmap:            00000000000000ff
[    0.126309] ... fixed-purpose counters:    3
[    0.126544] ... fixed-purpose bitmap:      0000000000000007
[    0.126850] ... value mask:                0000ffffffffffff
[    0.127171] ... max period:                00007fffffffffff
[    0.127309] ... global_ctrl mask:          00000007000000ff
[    0.127755] signal: max sigframe size: 3232
[    0.128049] rcu: Hierarchical SRCU implementation.
[    0.128309] rcu: 	Max phase no-delay instances is 400.
[    0.128656] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.131129] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.133326] smp: Bringing up secondary CPUs ...
[    0.133793] smpboot: x86: Booting SMP configuration:
[    0.134077] .... node  #0, CPUs:      #1
[    0.194429] smp: Brought up 1 node, 2 CPUs
[    0.194801] smpboot: Total of 2 processors activated (10056.41 BogoMIPS)
[    0.195451] Memory: 3983096K/4193784K available (16460K kernel code, 9137K rwdata, 10296K rodata, 3224K init, 13904K bss, 200612K reserved, 0K cma-reserved)
[    0.196802] devtmpfs: initialized
[    0.197705] Running RCU synchronous self tests
[    0.197724] Running RCU synchronous self tests
[    0.198327] Running RCU Tasks wait API self tests
[    0.198605] Running RCU Tasks Rude wait API self tests
[    0.198605] Running RCU Tasks Trace wait API self tests
[    0.212320] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.213318] posixtimers hash table entries: 1024 (order: 4, 73728 bytes, linear)
[    0.213778] futex hash table entries: 512 (65536 bytes on 1 NUMA nodes, total 64 KiB, linear).
[    0.215026] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.215651] audit: initializing netlink subsys (disabled)
[    0.215975] audit: type=2000 audit(1760950234.129:1): state=initialized audit_enabled=0 res=1
[    0.215975] thermal_sys: Registered thermal governor 'step_wise'
[    0.216313] cpuidle: using governor ladder
[    0.216549] cpuidle: using governor menu
[    0.216719] PCI: Using configuration type 1 for base access
[    0.217361] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.221327] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.221739] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.222125] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.222310] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.226687] ACPI: Added _OSI(Module Device)
[    0.226935] ACPI: Added _OSI(Processor Device)
[    0.227207] ACPI: Added _OSI(Processor Aggregator Device)
[    0.229340] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.232368] Callback from call_rcu_tasks_trace() invoked.
[    0.235533] ACPI: Interpreter enabled
[    0.235796] ACPI: PM: (supports S0 S3 S5)
[    0.236069] ACPI: Using IOAPIC for interrupt routing
[    0.236331] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.236843] PCI: Using E820 reservations for host bridge windows
[    0.237329] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.240786] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.241149] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    0.242311] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.242883] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    0.243600] PCI host bridge to bus 0000:00
[    0.243837] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.244214] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.244310] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.244724] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    0.245156] pci_bus 0000:00: root bus resource [mem 0x7000000000-0x707fffffff window]
[    0.245310] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.245673] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 conventional PCI endpoint
[    0.246591] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100 conventional PCI endpoint
[    0.247420] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180 conventional PCI endpoint
[    0.248328] pci 0000:00:01.1: BAR 4 [io  0xc100-0xc10f]
[    0.248642] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
[    0.249030] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE quirk
[    0.249309] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
[    0.249688] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE quirk
[    0.250246] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000 conventional PCI endpoint
[    0.251477] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.251880] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.252545] pci 0000:00:02.0: [1af4:1003] type 00 class 0x078000 conventional PCI endpoint
[    0.253885] pci 0000:00:02.0: BAR 0 [io  0xc000-0xc03f]
[    0.254182] pci 0000:00:02.0: BAR 1 [mem 0xfebfc000-0xfebfcfff]
[    0.254324] pci 0000:00:02.0: BAR 4 [mem 0x7000000000-0x7000003fff 64bit pref]
[    0.255645] pci 0000:00:03.0: [1af4:1003] type 00 class 0x078000 conventional PCI endpoint
[    0.256844] pci 0000:00:03.0: BAR 0 [io  0xc040-0xc07f]
[    0.257149] pci 0000:00:03.0: BAR 1 [mem 0xfebfd000-0xfebfdfff]
[    0.258324] pci 0000:00:03.0: BAR 4 [mem 0x7000004000-0x7000007fff 64bit pref]
[    0.259613] pci 0000:00:04.0: [1af4:1009] type 00 class 0x000200 conventional PCI endpoint
[    0.260832] pci 0000:00:04.0: BAR 0 [io  0xc080-0xc0bf]
[    0.261184] pci 0000:00:04.0: BAR 1 [mem 0xfebfe000-0xfebfefff]
[    0.261325] pci 0000:00:04.0: BAR 4 [mem 0x7000008000-0x700000bfff 64bit pref]
[    0.263134] pci 0000:00:05.0: [1af4:1009] type 00 class 0x000200 conventional PCI endpoint
[    0.265168] pci 0000:00:05.0: BAR 0 [io  0xc0c0-0xc0ff]
[    0.265314] pci 0000:00:05.0: BAR 1 [mem 0xfebff000-0xfebfffff]
[    0.265757] pci 0000:00:05.0: BAR 4 [mem 0x700000c000-0x700000ffff 64bit pref]
[    0.267612] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.268231] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.268398] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.268945] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.269350] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.270333] iommu: Default domain type: Translated
[    0.270597] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.271452] pps_core: LinuxPPS API ver. 1 registered
[    0.271743] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.272316] PTP clock support registered
[    0.272995] NetLabel: Initializing
[    0.273310] NetLabel:  domain hash size = 128
[    0.273570] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.273927] NetLabel:  unlabeled traffic allowed by default
[    0.274272] PCI: Using ACPI for IRQ routing
[    0.274465] vgaarb: loaded
[    0.274500] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.274795] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.280370] clocksource: Switched to clocksource tsc-early
[    0.281133] pnp: PnP ACPI init
[    0.281769] pnp: PnP ACPI: found 5 devices
[    0.289844] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.290415] NET: Registered PF_INET protocol family
[    0.290777] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.297848] tcp_listen_portaddr_hash hash table entries: 2048 (order: 5, 147456 bytes, linear)
[    0.298522] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.298961] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.299553] TCP bind hash table entries: 32768 (order: 10, 4718592 bytes, vmalloc hugepage)
[    0.300804] TCP: Hash tables configured (established 32768 bind 32768)
[    0.301263] MPTCP token hash table entries: 4096 (order: 6, 360448 bytes, linear)
[    0.301756] UDP hash table entries: 2048 (order: 7, 524288 bytes, linear)
[    0.302214] UDP-Lite hash table entries: 2048 (order: 7, 524288 bytes, linear)
[    0.302764] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.303109] NET: Registered PF_XDP protocol family
[    0.303403] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.303759] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.304105] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.304509] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
[    0.304905] pci_bus 0000:00: resource 8 [mem 0x7000000000-0x707fffffff window]
[    0.305377] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.305715] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.306089] PCI: CLS 0 bytes, default 64
[    0.306341] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.306745] software IO TLB: mapped [mem 0x00000000bbfe0000-0x00000000bffe0000] (64MB)
[    0.307232] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
[    0.308832] Initialise system trusted keyrings
[    0.309211] workingset: timestamp_bits=40 max_order=20 bucket_order=0
[    0.309854] fuse: init (API version 7.45)
[    0.310198] 9p: Installing v9fs 9p2000 file system support
[    0.316487] NET: Registered PF_ALG protocol family
[    0.316780] Key type asymmetric registered
[    0.317020] Asymmetric key parser 'x509' registered
[    0.317330] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.317999] io scheduler mq-deadline registered
[    0.318314] io scheduler kyber registered
[    0.318877] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.321418] ACPI: button: Power Button [PWRF]
[    0.322909] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[    0.324646] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    0.326275] ACPI: \_SB_.LNKD: Enabled at IRQ 11
[    0.327979] ACPI: \_SB_.LNKA: Enabled at IRQ 10
[    0.348722] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.349392] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.383156] Linux agpgart interface v0.103
[    0.388755] brd: module loaded
[    0.391968] loop: module loaded
[    0.393512] tun: Universal TUN/TAP device driver, 1.6
[    0.394037] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.395029] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.395524] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.396292] Registered IR keymap rc-empty
[    0.396599] rc rc0: rc-core loopback device as /devices/virtual/rc/rc0
[    0.397085] rc rc0: lirc_dev: driver rc-loopback registered at minor = 0, raw IR receiver, raw IR transmitter
[    0.397743] input: rc-core loopback device as /devices/virtual/rc/rc0/input2
[    0.398328] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.398382] intel_powerclamp: CPU does not support MWAIT
[    0.399169] intel_pstate: CPU model not supported
[    0.400009] GACT probability NOT on
[    0.400294] Mirror/redirect action on
[    0.401060] ipip: IPv4 and MPLS over IPv4 tunneling driver
[    0.401648] gre: GRE over IPv4 demultiplexer driver
[    0.401926] ip_gre: GRE over IPv4 tunneling driver
[    0.402863] Initializing XFRM netlink socket
[    0.403123] IPsec XFRM device driver
[    0.403385] NET: Registered PF_INET6 protocol family
[    0.404098] Segment Routing with IPv6
[    0.404336] In-situ OAM (IOAM) with IPv6
[    0.404579] mip6: Mobile IPv6
[    0.404769] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.405585] ip6_gre: GRE over IPv6 tunneling driver
[    0.406077] NET: Registered PF_PACKET protocol family
[    0.406426] 8021q: 802.1Q VLAN Support v1.8
[    0.406698] 9pnet: Installing 9P2000 support
[    0.408431] Callback from call_rcu_tasks() invoked.
[    0.408978] Key type dns_resolver registered
[    0.409316] NET: Registered PF_VSOCK protocol family
[    0.409606] mpls_gso: MPLS GSO support
[    0.410167] IPI shorthand broadcast: enabled
[    0.415090] sched_clock: Marking stable (407143234, 7165999)->(426414673, -12105440)
[    0.415764] registered taskstats version 1
[    0.421211] Loading compiled-in X.509 certificates
[    0.422166] Loaded X.509 cert 'Build time autogenerated kernel key: 3cee96964ddebecf1b0b1438932e28ffced7b530'
[    0.432570] Demotion targets for Node 0: null
[    0.433024] ima: No TPM chip found, activating TPM-bypass!
[    0.433370] ima: Allocated hash algorithm: sha1
[    0.433655] ima: No architecture policies found
[    0.437101] check access for rdinit=/init failed: -2, ignoring
[    0.814905] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input4
[    0.815557] 9pnet_virtio: no channels available for device
[    0.815804] 9pnet: Limiting 'msize' to 512000 as this is the maximum supported by transport virtio
[    0.816901] VFS: Mounted root (9p filesystem) on device 0:21.
[    0.817402] devtmpfs: mounted
[    0.822223] Freeing unused kernel image (initmem) memory: 3224K
[    0.822490] Write protecting the kernel read-only data: 30720k
[    0.823314] Freeing unused kernel image (text/rodata gap) memory: 1968K
[    0.823955] Freeing unused kernel image (rodata/data gap) memory: 1992K
[    0.824206] Run /tmp/vmtest-initukOgi.sh as init process
[    0.915935] vmtest: Mounting tmpfs at /dev/shm
[    0.968207] vmtest: Mounting tmpfs at /run
[    1.002366] vmtest: Mounting sysfs at /sys
[    1.010582] vmtest: Mounting debugfs at /sys/kernel/debug
[    1.018868] vmtest: Mounting tracefs at /sys/kernel/debug/tracing
[    1.027652] vmtest: Mounting cgroup2 at /sys/fs/cgroup
[    1.041118] vmtest: Mounting tmpfs at /mnt
[    1.049794] vmtest: Symlink /dev/fd to /proc/self/fd
[    1.055532] vmtest: Init done
[    1.132943] vmtest: Located qemu-guest-agent virtio port: /dev/vport0p1
[    1.133451] vmtest: Spawning qemu-ga in the background
===> Setting up VM
[    1.335318] tsc: Refined TSC clocksource calibration: 2495.988 MHz
[    1.336156] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x23fa6bcc764, max_idle_ns: 440795206109 ns
[    1.337227] clocksource: Switched to clocksource tsc
[    1.423793] 9pnet: Limiting 'msize' to 512000 as this is the maximum supported by transport virtio
tty: ttyname error: Inappropriate ioctl for device
===> Running command
execve("./test_progs", ["./test_progs", "-t", "arg_parsing"], 0x7ffc8984ee30 /* 79 vars */) = 0
brk(NULL)                               = 0x55d43c4c0000
access("/etc/ld.so.preload", R_OK)      = 0
openat(AT_FDCWD, "/etc/ld.so.preload", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=20, ...}) = 0
mmap(NULL, 20, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0x7f58e4e24000
close(3)                                = 0
readlinkat(AT_FDCWD, "/proc/self/exe", "/home/v/linux_work/bpf/tools/tes"..., 4096) = 61
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f58e4e22000
openat(AT_FDCWD, "/lib/lib/liblsp.so", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P\24\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=19000, ...}) = 0
mmap(NULL, 4211528, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_DENYWRITE, -1, 0) = 0x7f58e4a1d000
mmap(0x7f58e4c00000, 2114376, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0x7f58e4c00000
munmap(0x7f58e4a1d000, 1978368)         = 0
munmap(0x7f58e4e05000, 115528)          = 0
mprotect(0x7f58e4c04000, 2093056, PROT_NONE) = 0
mmap(0x7f58e4e03000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7f58e4e03000
close(3)                                = 0
munmap(0x7f58e4e24000, 20)              = 0
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=234755, ...}) = 0
mmap(NULL, 234755, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f58e4bc6000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libelf.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=112728, ...}) = 0
mmap(NULL, 110616, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58e4e06000
mmap(0x7f58e4e09000, 77824, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7f58e4e09000
mmap(0x7f58e4e1c000, 16384, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x16000) = 0x7f58e4e1c000
mmap(0x7f58e4e20000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1a000) = 0x7f58e4e20000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libz.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=100368, ...}) = 0
mmap(NULL, 98320, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58e4bad000
mmap(0x7f58e4bb0000, 57344, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7f58e4bb0000
mmap(0x7f58e4bbe000, 24576, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11000) = 0x7f58e4bbe000
mmap(0x7f58e4bc4000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x17000) = 0x7f58e4bc4000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libpcap.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=309600, ...}) = 0
mmap(NULL, 311712, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58e4b60000
mmap(0x7f58e4b64000, 172032, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0x7f58e4b64000
mmap(0x7f58e4b8e000, 110592, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2e000) = 0x7f58e4b8e000
mmap(0x7f58e4ba9000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x48000) = 0x7f58e4ba9000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libLLVM.so.20.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=157076696, ...}) = 0
mmap(NULL, 157875224, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58db4d0000
mmap(0x7f58dba17000, 90820608, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x547000) = 0x7f58dba17000
mmap(0x7f58e10b4000, 58408960, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x5be4000) = 0x7f58e10b4000
mmap(0x7f58e4868000, 2318336, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9397000) = 0x7f58e4868000
mmap(0x7f58e4a9e000, 793624, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f58e4a9e000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0000x\2\0\0\0\0\0"..., 832) = 832
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 896, 64) = 896
fstat(3, {st_mode=S_IFREG|0755, st_size=2149728, ...}) = 0
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 896, 64) = 896
mmap(NULL, 2174000, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58db2bd000
mmap(0x7f58db2e1000, 1515520, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x24000) = 0x7f58db2e1000
mmap(0x7f58db453000, 454656, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x196000) = 0x7f58db453000
mmap(0x7f58db4c2000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x204000) = 0x7f58db4c2000
mmap(0x7f58db4c8000, 31792, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f58db4c8000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libdl.so.2", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=14352, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f58db2bb000
mmap(NULL, 16400, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58db2b6000
mmap(0x7f58db2b7000, 4096, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x7f58db2b7000
mmap(0x7f58db2b8000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x7f58db2b8000
mmap(0x7f58db2b9000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x7f58db2b9000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libzstd.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=935880, ...}) = 0
mmap(NULL, 933944, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58db1d1000
mmap(0x7f58db1dd000, 811008, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc000) = 0x7f58db1dd000
mmap(0x7f58db2a3000, 69632, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd2000) = 0x7f58db2a3000
mmap(0x7f58db2b4000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe3000) = 0x7f58db2b4000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libnl-genl-3.so.200", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=27576, ...}) = 0
mmap(NULL, 25432, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58db1ca000
mmap(0x7f58db1cc000, 8192, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x7f58db1cc000
mmap(0x7f58db1ce000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0x7f58db1ce000
mmap(0x7f58db1cf000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x5000) = 0x7f58db1cf000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libnl-3.so.200", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=133368, ...}) = 0
mmap(NULL, 131608, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58db1a9000
mmap(0x7f58db1b0000, 61440, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0x7f58db1b0000
mmap(0x7f58db1bf000, 32768, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x16000) = 0x7f58db1bf000
mmap(0x7f58db1c7000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e000) = 0x7f58db1c7000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libdbus-1.so.3", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=334008, ...}) = 0
mmap(NULL, 336624, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58db156000
mmap(0x7f58db164000, 200704, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe000) = 0x7f58db164000
mmap(0x7f58db195000, 69632, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3f000) = 0x7f58db195000
mmap(0x7f58db1a6000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4f000) = 0x7f58db1a6000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libffi.so.8", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=47336, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f58db154000
mmap(NULL, 46320, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58db148000
mmap(0x7f58db14a000, 28672, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x7f58db14a000
mmap(0x7f58db151000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9000) = 0x7f58db151000
mmap(0x7f58db152000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa000) = 0x7f58db152000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libedit.so.0", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=223344, ...}) = 0
mmap(NULL, 236672, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58db10e000
mmap(0x7f58db114000, 135168, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0x7f58db114000
mmap(0x7f58db135000, 53248, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x27000) = 0x7f58db135000
mmap(0x7f58db142000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x34000) = 0x7f58db142000
mmap(0x7f58db145000, 11392, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f58db145000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libxml2.so.16", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1260488, ...}) = 0
mmap(NULL, 1262640, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58dafd9000
mmap(0x7f58daff3000, 864256, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1a000) = 0x7f58daff3000
mmap(0x7f58db0c6000, 249856, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xed000) = 0x7f58db0c6000
mmap(0x7f58db103000, 40960, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12a000) = 0x7f58db103000
mmap(0x7f58db10d000, 1072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f58db10d000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libstdc++.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=22480456, ...}) = 0
mmap(NULL, 2699336, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58dad45000
mmap(0x7f58daddc000, 1396736, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x97000) = 0x7f58daddc000
mmap(0x7f58daf31000, 598016, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ec000) = 0x7f58daf31000
mmap(0x7f58dafc3000, 73728, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x27e000) = 0x7f58dafc3000
mmap(0x7f58dafd5000, 12360, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f58dafd5000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libm.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1100400, ...}) = 0
mmap(NULL, 1102152, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58dac37000
mmap(0x7f58dac46000, 569344, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xf000) = 0x7f58dac46000
mmap(0x7f58dacd1000, 466944, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9a000) = 0x7f58dacd1000
mmap(0x7f58dad43000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x10b000) = 0x7f58dad43000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libgcc_s.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=906056, ...}) = 0
mmap(NULL, 180712, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58dac0a000
mmap(0x7f58dac0e000, 143360, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0x7f58dac0e000
mmap(0x7f58dac31000, 16384, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x27000) = 0x7f58dac31000
mmap(0x7f58dac35000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2a000) = 0x7f58dac35000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f58dac08000
openat(AT_FDCWD, "/usr/lib/libsystemd.so.0", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1201600, ...}) = 0
mmap(NULL, 1202568, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58daae2000
mmap(0x7f58daaf7000, 798720, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15000) = 0x7f58daaf7000
mmap(0x7f58dabba000, 274432, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd8000) = 0x7f58dabba000
mmap(0x7f58dabfd000, 40960, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11b000) = 0x7f58dabfd000
mmap(0x7f58dac07000, 2440, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f58dac07000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libncursesw.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=453896, ...}) = 0
mmap(NULL, 453856, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58daa73000
mmap(0x7f58daa80000, 290816, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd000) = 0x7f58daa80000
mmap(0x7f58daac7000, 90112, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x54000) = 0x7f58daac7000
mmap(0x7f58daadd000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6a000) = 0x7f58daadd000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libicuuc.so.76", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=2095152, ...}) = 0
mmap(NULL, 2102320, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58da871000
mmap(0x7f58da8b9000, 1142784, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x48000) = 0x7f58da8b9000
mmap(0x7f58da9d0000, 577536, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15f000) = 0x7f58da9d0000
mmap(0x7f58daa5d000, 81920, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ec000) = 0x7f58daa5d000
mmap(0x7f58daa71000, 5168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f58daa71000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libcap.so.2", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@|\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=43064, ...}) = 0
mmap(NULL, 45128, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58da865000
mmap(0x7f58da868000, 20480, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7f58da868000
mmap(0x7f58da86d000, 8192, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8000) = 0x7f58da86d000
mmap(0x7f58da86f000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9000) = 0x7f58da86f000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libicudata.so.76", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=31859544, ...}) = 0
mmap(NULL, 31862784, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f58d8a02000
mmap(0x7f58da864000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e61000) = 0x7f58da864000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f58d8a00000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f58d89fe000
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f58d89fb000
arch_prctl(ARCH_SET_FS, 0x7f58d89fbb80) = 0
set_tid_address(0x7f58d89fbe50)         = 112
set_robust_list(0x7f58d89fbe60, 24)     = 0
rseq(0x7f58d89fb6a0, 0x20, 0, 0x53053053) = 0
mprotect(0x7f58db4c2000, 16384, PROT_READ) = 0
mprotect(0x7f58da864000, 4096, PROT_READ) = 0
mprotect(0x7f58da86f000, 4096, PROT_READ) = 0
mprotect(0x7f58dad43000, 4096, PROT_READ) = 0
mprotect(0x7f58dac35000, 4096, PROT_READ) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f58d89f9000
mprotect(0x7f58dafc3000, 69632, PROT_READ) = 0
mprotect(0x7f58daa5d000, 77824, PROT_READ) = 0
mprotect(0x7f58daadd000, 16384, PROT_READ) = 0
mprotect(0x7f58dabfd000, 36864, PROT_READ) = 0
mprotect(0x7f58e4bc4000, 4096, PROT_READ) = 0
mprotect(0x7f58db103000, 36864, PROT_READ) = 0
mprotect(0x7f58db142000, 8192, PROT_READ) = 0
mprotect(0x7f58db152000, 4096, PROT_READ) = 0
mprotect(0x7f58db1a6000, 8192, PROT_READ) = 0
mprotect(0x7f58db1c7000, 8192, PROT_READ) = 0
mprotect(0x7f58db1cf000, 4096, PROT_READ) = 0
mprotect(0x7f58db2b4000, 4096, PROT_READ) = 0
mprotect(0x7f58db2b9000, 4096, PROT_READ) = 0
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f58d89f6000
mmap(NULL, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f58d89f1000
mmap(NULL, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f58d89e8000
mmap(NULL, 69632, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f58d89d7000
mprotect(0x7f58e4868000, 2023424, PROT_READ) = 0
mprotect(0x7f58e4ba9000, 12288, PROT_READ) = 0
mprotect(0x7f58e4e20000, 4096, PROT_READ) = 0
mprotect(0x7f58e4e03000, 4096, PROT_READ) = 0
mprotect(0x55d437ac4000, 40960, PROT_READ) = 0
mprotect(0x7f58e4e66000, 8192, PROT_READ) = 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, rlim_max=RLIM64_INFINITY}) = 0
getrandom("\x0c\xeb\xed\x08\x34\xe9\x5a\x8e", 8, GRND_NONBLOCK) = 8
munmap(0x7f58e4bc6000, 234755)          = 0
prctl(PR_CAPBSET_READ, CAP_MAC_OVERRIDE) = 1
prctl(PR_CAPBSET_READ, 0x30 /* CAP_??? */) = -1 EINVAL (Invalid argument)
prctl(PR_CAPBSET_READ, CAP_CHECKPOINT_RESTORE) = 1
prctl(PR_CAPBSET_READ, 0x2c /* CAP_??? */) = -1 EINVAL (Invalid argument)
prctl(PR_CAPBSET_READ, 0x2a /* CAP_??? */) = -1 EINVAL (Invalid argument)
prctl(PR_CAPBSET_READ, 0x29 /* CAP_??? */) = -1 EINVAL (Invalid argument)
futex(0x7f58dafd56bc, FUTEX_WAKE_PRIVATE, 2147483647) = 0
brk(NULL)                               = 0x55d43c4c0000
brk(0x55d43c4f3000)                     = 0x55d43c4f3000
lseek(2, 0, SEEK_CUR)                   = -1 ESPIPE (Illegal seek)
fstat(2, {st_mode=S_IFCHR|0600, st_rdev=makedev(0xf7, 0x1), ...}) = 0
brk(0x55d43c514000)                     = 0x55d43c514000
brk(0x55d43c535000)                     = 0x55d43c535000
openat(AT_FDCWD, "/etc/lsp.exclude", O_RDONLY) = -1 ENOENT (No such file or directory)
uname({sysname="Linux", nodename="(none)", ...}) = 0
shmget(0xa5723213, 16384, IPC_CREAT|IPC_EXCL|0666) = -1 EEXIST (File exists)
shmget(0xa5723213, 16384, 000)          = 0
shmat(0, NULL, SHM_RDONLY)              = 0x7f58e4bfc000
rt_sigaction(SIGSEGV, {sa_handler=0x55d436f5045a, sa_mask=[], sa_flags=SA_RESTORER|SA_RESETHAND, sa_restorer=0x7f58db2fb540}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {sa_handler=0x7f58db3510b0, sa_mask=[], sa_flags=SA_RESTORER|SA_ONSTACK|SA_RESTART|SA_SIGINFO, sa_restorer=0x7f58db2fb540}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
mmap(NULL, 29888, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) = 0x7f58e4bf4000
madvise(0x7f58e4bf4000, 4096, MADV_GUARD_INSTALL) = 0
rt_sigprocmask(SIG_BLOCK, ~[], [], 8)   = 0
clone3({flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, child_tid=0x7f58e4bfae50, parent_tid=0x7f58e4bfae50, exit_signal=0, stack=0x7f58e4bf4000, stack_size=0x6000, tls=0x7f58e4bfab80} => {parent_tid=[113]}, 88) = 113
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
futex(0x7f58db4cd164, FUTEX_WAKE_PRIVATE, 2147483647) = 0
timer_create(CLOCK_MONOTONIC, {sigev_value={sival_int=1012017504, sival_ptr=0x55d43c522960}, sigev_signo=SIGRTMIN, sigev_notify=SIGEV_THREAD_ID, sigev_notify_thread_id=113}, [0]) = 0
add_key("asymmetric", "libbpf_session_key", "0\202\00300\202\2\30\240\3\2\1\2\2\24]HD\257\377\227\344q\271\355:E\275\231\31_\343"..., 820, KEY_SPEC_SESSION_KEYRING) = 959557055
openat(AT_FDCWD, "/proc/sys/net/core/bpf_jit_enable", O_RDONLY) = 3
read(3, "1", 1)                         = 1
close(3)                                = 0
openat(AT_FDCWD, "/sys/devices/system/cpu/possible", O_RDONLY|O_CLOEXEC) = 3
read(3, "0-1\n", 128)                   = 4
close(3)                                = 0
membarrier(MEMBARRIER_CMD_GLOBAL, 0)    = 0
delete_module("bpf_testmod", 0)         = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "bpf_testmod.ko", O_RDONLY) = 3
]3008;start=fc5e5268-1949-4e56-ab18-a0ff6c738f49;user=;hostname=(none);machineid=1cdaf5cebfab41c8bca955e04060bc11;bootid=bbdefdc8-92c6-462b-8daf-c56c9cfff90c;pid=83;type=shell;cwd=/\[?2004h[root@(none) /]# [    1.945384] bpf_testmod: loading out-of-tree module taints kernel.
[    1.945656] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
finit_module(3, "", 0)                  = 0
close(3)                                = 0
openat(AT_FDCWD, "/proc/self/ns/net", O_RDONLY) = 3
timer_settime(0, 0, {it_interval={tv_sec=0, tv_nsec=0}, it_value={tv_sec=10, tv_nsec=0}}, NULL) = 0
timer_settime(0, 0, {it_interval={tv_sec=0, tv_nsec=0}, it_value={tv_sec=10, tv_nsec=0}}, NULL) = 0
timer_settime(0, 0, {it_interval={tv_sec=0, tv_nsec=0}, it_value={tv_sec=10, tv_nsec=0}}, NULL) = 0
rt_sigprocmask(SIG_BLOCK, ~[], [], 8)   = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_DROPPABLE|MAP_ANONYMOUS, -1, 0) = 0x7f58e4e24000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f58e4e05000
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
getrandom("\x9e\x16\x03\x90\xe6\x0f\xf1\xa9\x75\xdf\xb8\xa7\x29\x72\x03\x86\xbb\x52\xd3\xd8\x95\x07\xde\xf2\xe2\x1f\x3a\xda\xd5\xa3\x42\x3e", 32, 0) = 32
openat(AT_FDCWD, "/tmp/bpf_arg_parsing_test.UK5nUq", O_RDWR|O_CREAT|O_EXCL, 0600) = 4
fcntl(4, F_GETFL)                       = 0x8002 (flags O_RDWR|O_LARGEFILE)
fstat(4, {st_mode=S_IFREG|0600, st_size=0, ...}) = 0
write(4, "# comment\n  test_with_spaces    "..., 175) = 175
fsync(4)                                = 0
openat(AT_FDCWD, "/tmp/bpf_arg_parsing_test.UK5nUq", O_RDONLY) = 5
fstat(5, {st_mode=S_IFREG|0600, st_size=175, ...}) = 0
read(5, "# comment\n  test_with_spaces    "..., 8192) = 175
read(5, "", 8192)                       = 0
close(5)                                = 0
close(4)                                = 0
unlink("/tmp/bpf_arg_parsing_test.UK5nUq") = 0
timer_settime(0, 0, {it_interval={tv_sec=0, tv_nsec=0}, it_value={tv_sec=0, tv_nsec=0}}, NULL) = 0
sched_setaffinity(0, 128, [0 1])        = 0
sched_setaffinity(112, 128, [0 1])      = 0
setns(3, CLONE_NEWNET)                  = 0
fstat(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(0xf7, 0x1), ...}) = 0
ioctl(1, TCGETS2, 0x7ffddb3d1b40)       = -1 ENOTTY (Inappropriate ioctl for device)
close(3)                                = 0
membarrier(MEMBARRIER_CMD_GLOBAL, 0)    = 0
delete_module("bpf_testmod", 0)         = 0
shmdt(0x7f58e4bfc000)                   = 0
write(1, "#7/1     arg_parsing/test_parse_"..., 160#7/1     arg_parsing/test_parse_test_list:OK
#7/2     arg_parsing/test_parse_test_list_file:OK
#7       arg_parsing:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
) = 160
exit_group(0)                           = ?
+++ exited with 0 +++


Diff with fclose:


diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index e27d66b75fb1..1317676d041b 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -141,16 +141,17 @@ static void test_parse_test_list_file(void)
 	fprintf(fp, "testC_no_eof_newline");
 	fflush(fp);
 
-	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
-		goto out_fclose;
+	if (!ASSERT_OK(ferror(fp), "prepare tmp")) {
+		fclose(fp);
+		goto out_remove;
+	}
 
-	if (!ASSERT_OK(fsync(fileno(fp)), "fsync tmp"))
-		goto out_fclose;
+	fclose(fp);
 
 	init_test_filter_set(&set);
 
 	if (!ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file"))
-		goto out_fclose;
+		goto out_remove;
 
 	if (!ASSERT_EQ(set.cnt, 4, "test  count"))
 		goto out_free_set;
@@ -166,8 +167,6 @@ static void test_parse_test_list_file(void)
 
 out_free_set:
 	free_test_filter_set(&set);
-out_fclose:
-	fclose(fp);
 out_remove:
 	remove(tmpfile);
 }


Test with fclose:

=> bzImage
===> Booting
No EFI environment detected.
early console in extract_kernel
input_data: 0x0000000003e8c2c4
input_len: 0x0000000000d59ef7
output: 0x0000000001000000
output_len: 0x0000000003156b50
kernel_total_size: 0x0000000003c30000
needed_size: 0x0000000003e00000
trampoline_32bit: 0x0000000000000000
Physical KASLR using RDRAND RDTSC...
Virtual KASLR using RDRAND RDTSC...

Decompressing Linux... Parsing ELF... Performing relocations... done.
Booting the kernel (entry_offset: 0x0000000002b46b90).
[    0.000000] Linux version 6.18.0-rc1-g1c64efcb083c (v@laptop) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Mon Oct 20 14:25:28 CST 2025
[    0.000000] Command line: rootfstype=9p rootflags=trans=virtio,cache=mmap,msize=1048576 rw earlyprintk=serial,0,115200 printk.devkmsg=on console=0,115200 loglevel=7 raid=noautodetect init=/tmp/vmtest-init4rGXk.sh panic=-1
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable
[    0.000000] printk: legacy bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
[    0.000000] DMI: Memory slots populated: 1/1
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2496.059 MHz processor
[    0.000120] last_pfn = 0x140000 max_arch_pfn = 0x400000000
[    0.000464] MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
[    0.000955] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
Memory KASLR using RDRAND RDTSC...
[    0.001575] last_pfn = 0xbffe0 max_arch_pfn = 0x400000000
[    0.005888] found SMP MP-table at [mem 0x000f66a0-0x000f66af]
[    0.006229] Using GB pages for direct mapping
[    0.006714] ACPI: Early table checksum verification disabled
[    0.007044] ACPI: RSDP 0x00000000000F64B0 000014 (v00 BOCHS )
[    0.007385] ACPI: RSDT 0x00000000BFFE2379 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.007878] ACPI: FACP 0x00000000BFFE2225 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.008374] ACPI: DSDT 0x00000000BFFE0040 0021E5 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.008870] ACPI: FACS 0x00000000BFFE0000 000040
[    0.009138] ACPI: APIC 0x00000000BFFE2299 000080 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.009635] ACPI: HPET 0x00000000BFFE2319 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.010124] ACPI: WAET 0x00000000BFFE2351 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.010621] ACPI: Reserving FACP table memory at [mem 0xbffe2225-0xbffe2298]
[    0.011034] ACPI: Reserving DSDT table memory at [mem 0xbffe0040-0xbffe2224]
[    0.011448] ACPI: Reserving FACS table memory at [mem 0xbffe0000-0xbffe003f]
[    0.011859] ACPI: Reserving APIC table memory at [mem 0xbffe2299-0xbffe2318]
[    0.012272] ACPI: Reserving HPET table memory at [mem 0xbffe2319-0xbffe2350]
[    0.012688] ACPI: Reserving WAET table memory at [mem 0xbffe2351-0xbffe2378]
[    0.013239] No NUMA configuration found
[    0.013462] Faking a node at [mem 0x0000000000000000-0x000000013fffffff]
[    0.013852] NODE_DATA(0) allocated [mem 0x13fff9e80-0x13fffdfff]
[    0.014211] Zone ranges:
[    0.014358]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.014717]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.015075]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
[    0.015432] Movable zone start for each node
[    0.015680] Early memory node ranges
[    0.015888]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.016255]   node   0: [mem 0x0000000000100000-0x00000000bffdffff]
[    0.016618]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
[    0.016980] Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
[    0.017487] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.017851] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.025771] On node 0, zone Normal: 32 pages in unavailable ranges
[    0.026352] ACPI: PM-Timer IO Port: 0x608
[    0.026593] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.026963] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.027364] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.027732] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.028124] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.028513] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.028926] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.029341] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.029756] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.030062] TSC deadline timer available
[    0.030296] CPU topo: Max. logical packages:   1
[    0.030567] CPU topo: Max. logical dies:       1
[    0.030842] CPU topo: Max. dies per package:   1
[    0.031110] CPU topo: Max. threads per core:   1
[    0.031377] CPU topo: Num. cores per package:     2
[    0.031668] CPU topo: Num. threads per package:   2
[    0.031967] CPU topo: Allowing 2 present CPUs plus 0 hotplug CPUs
[    0.032326] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[    0.032684] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.036862] setup_percpu: NR_CPUS:128 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.037628] percpu: Embedded 56 pages/cpu s191568 r8192 d29616 u1048576
[    0.038094] Kernel command line: rootfstype=9p rootflags=trans=virtio,cache=mmap,msize=1048576 rw earlyprintk=serial,0,115200 printk.devkmsg=on console=0,115200 loglevel=7 raid=noautodetect init=/tmp/vmtest-init4rGXk.sh panic=-1
[    0.039358] Unknown kernel command line parameters "raid=noautodetect", will be passed to user space.
[    0.039935] random: crng init done
[    0.040156] printk: log buffer data + meta data: 2097152 + 7340032 = 9437184 bytes
[    0.041048] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.041774] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.042326] software IO TLB: area num 2.
[    0.053663] Fallback order for Node 0: 0
[    0.053669] Built 1 zonelists, mobility grouping on.  Total pages: 1048446
[    0.054289] Policy zone: Normal
[    0.054468] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.060562] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Poking KASLR using RDRAND RDTSC...
[    0.067877] ftrace: allocating 41991 entries in 166 pages
[    0.068178] ftrace: allocated 166 pages with 4 groups
[    0.068525] Dynamic Preempt: full
[    0.068858] Running RCU self tests
[    0.069048] Running RCU synchronous self tests
[    0.069291] rcu: Preemptible hierarchical RCU implementation.
[    0.069603] rcu: 	RCU event tracing is enabled.
[    0.069853] rcu: 	RCU lockdep checking is enabled.
[    0.070116] rcu: 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=2.
[    0.070485] 	Trampoline variant of Tasks RCU enabled.
[    0.070762] 	Rude variant of Tasks RCU enabled.
[    0.071009] 	Tracing variant of Tasks RCU enabled.
[    0.071270] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.071689] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.072071] Running RCU synchronous self tests
[    0.072317] RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
[    0.072809] RCU Tasks Rude: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
[    0.073341] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
[    0.076900] NR_IRQS: 8448, nr_irqs: 440, preallocated irqs: 16
[    0.077427] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.077978] Console: colour *CGA 80x25
[    0.078225] printk: legacy console [ttyS0] enabled
[    0.078225] printk: legacy console [ttyS0] enabled
[    0.078830] printk: legacy bootconsole [earlyser0] disabled
[    0.078830] printk: legacy bootconsole [earlyser0] disabled
[    0.079510] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.079958] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.080196] ... MAX_LOCK_DEPTH:          48
[    0.080438] ... MAX_LOCKDEP_KEYS:        8192
[    0.080692] ... CLASSHASH_SIZE:          4096
[    0.080944] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.081200] ... MAX_LOCKDEP_CHAINS:      65536
[    0.081457] ... CHAINHASH_SIZE:          32768
[    0.081716]  memory used by lock dependency info: 6429 kB
[    0.082026]  memory used for stack traces: 4224 kB
[    0.082307]  per task-struct memory footprint: 1920 bytes
[    0.082638] ACPI: Core revision 20250807
[    0.082980] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.083583] APIC: Switch to symmetric I/O mode setup
[    0.084588] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.089594] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x23faaecc2a6, max_idle_ns: 440795204781 ns
[    0.090195] Calibrating delay loop (skipped), value calculated using timer frequency.. 4992.11 BogoMIPS (lpj=2496059)
[    0.091300] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.091728] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.092186] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.092547] mitigations: Enabled attack vectors: user_kernel, user_user, SMT mitigations: auto
[    0.093067] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.093187] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.093543] ITS: Mitigation: Aligned branch/return thunks
[    0.094186] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.094692] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    0.095188] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.095647] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.096186] active return thunk: its_return_thunk
[    0.096478] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.097186] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.097537] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.097888] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.098186] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.098537] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.098907] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.099186] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.099523] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.100186] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.100525] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.100868] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.101185] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
[    0.120114] Freeing SMP alternatives memory: 44K
[    0.120187] pid_max: default: 32768 minimum: 301
[    0.120492] LSM: initializing lsm=capability,selinux,bpf,ima
[    0.120836] SELinux:  Initializing.
[    0.121798] LSM support for eBPF active
[    0.122190] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.122619] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.123770] Running RCU synchronous self tests
[    0.124023] Running RCU synchronous self tests
[    0.124345] smpboot: CPU0: 11th Gen Intel(R) Core(TM) i7-11850H @ 2.50GHz (family: 0x6, model: 0x8d, stepping: 0x1)
[    0.125184] Performance Events: Icelake events, full-width counters, Intel PMU driver.
[    0.125191] ... version:                   2
[    0.125427] ... bit width:                 48
[    0.125674] ... generic counters:          8
[    0.125910] ... generic bitmap:            00000000000000ff
[    0.126186] ... fixed-purpose counters:    3
[    0.126420] ... fixed-purpose bitmap:      0000000000000007
[    0.126738] ... value mask:                0000ffffffffffff
[    0.127042] ... max period:                00007fffffffffff
[    0.127186] ... global_ctrl mask:          00000007000000ff
[    0.127666] signal: max sigframe size: 3232
[    0.127959] rcu: Hierarchical SRCU implementation.
[    0.128187] rcu: 	Max phase no-delay instances is 400.
[    0.128540] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.131118] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.132258] smp: Bringing up secondary CPUs ...
[    0.132723] smpboot: x86: Booting SMP configuration:
[    0.133009] .... node  #0, CPUs:      #1
[    0.193374] smp: Brought up 1 node, 2 CPUs
[    0.193685] smpboot: Total of 2 processors activated (10057.18 BogoMIPS)
[    0.194352] Memory: 3983100K/4193784K available (16460K kernel code, 9137K rwdata, 10296K rodata, 3224K init, 13904K bss, 200612K reserved, 0K cma-reserved)
[    0.195698] devtmpfs: initialized
[    0.196704] Running RCU synchronous self tests
[    0.196704] Running RCU synchronous self tests
[    0.197228] Running RCU Tasks wait API self tests
[    0.197643] Running RCU Tasks Rude wait API self tests
[    0.197689] Running RCU Tasks Trace wait API self tests
[    0.211197] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.211211] posixtimers hash table entries: 1024 (order: 4, 73728 bytes, linear)
[    0.211849] futex hash table entries: 512 (65536 bytes on 1 NUMA nodes, total 64 KiB, linear).
[    0.214533] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.215662] audit: initializing netlink subsys (disabled)
[    0.216211] audit: type=2000 audit(1760950062.131:1): state=initialized audit_enabled=0 res=1
[    0.216380] thermal_sys: Registered thermal governor 'step_wise'
[    0.216949] cpuidle: using governor ladder
[    0.217457] cpuidle: using governor menu
[    0.217588] PCI: Using configuration type 1 for base access
[    0.218236] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.220428] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.220813] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.221179] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.221187] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.224129] ACPI: Added _OSI(Module Device)
[    0.224187] ACPI: Added _OSI(Processor Device)
[    0.224438] ACPI: Added _OSI(Processor Aggregator Device)
[    0.227764] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.231099] ACPI: Interpreter enabled
[    0.231215] ACPI: PM: (supports S0 S3 S5)
[    0.231195] Callback from call_rcu_tasks_trace() invoked.
[    0.231448] ACPI: Using IOAPIC for interrupt routing
[    0.232208] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.232784] PCI: Using E820 reservations for host bridge windows
[    0.235241] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.239680] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.240029] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    0.240188] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.240764] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    0.241476] PCI host bridge to bus 0000:00
[    0.241709] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.242107] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.242187] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.242602] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    0.243031] pci_bus 0000:00: root bus resource [mem 0x7000000000-0x707fffffff window]
[    0.243187] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.243563] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 conventional PCI endpoint
[    0.244466] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100 conventional PCI endpoint
[    0.245279] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180 conventional PCI endpoint
[    0.246207] pci 0000:00:01.1: BAR 4 [io  0xc100-0xc10f]
[    0.246548] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
[    0.246923] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE quirk
[    0.247187] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
[    0.247574] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE quirk
[    0.248131] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000 conventional PCI endpoint
[    0.248353] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.248755] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.249441] pci 0000:00:02.0: [1af4:1003] type 00 class 0x078000 conventional PCI endpoint
[    0.250845] pci 0000:00:02.0: BAR 0 [io  0xc000-0xc03f]
[    0.251147] pci 0000:00:02.0: BAR 1 [mem 0xfebfc000-0xfebfcfff]
[    0.251201] pci 0000:00:02.0: BAR 4 [mem 0x7000000000-0x7000003fff 64bit pref]
[    0.252544] pci 0000:00:03.0: [1af4:1003] type 00 class 0x078000 conventional PCI endpoint
[    0.253673] pci 0000:00:03.0: BAR 0 [io  0xc040-0xc07f]
[    0.253992] pci 0000:00:03.0: BAR 1 [mem 0xfebfd000-0xfebfdfff]
[    0.254202] pci 0000:00:03.0: BAR 4 [mem 0x7000004000-0x7000007fff 64bit pref]
[    0.255506] pci 0000:00:04.0: [1af4:1009] type 00 class 0x000200 conventional PCI endpoint
[    0.256732] pci 0000:00:04.0: BAR 0 [io  0xc080-0xc0bf]
[    0.257044] pci 0000:00:04.0: BAR 1 [mem 0xfebfe000-0xfebfefff]
[    0.257201] pci 0000:00:04.0: BAR 4 [mem 0x7000008000-0x700000bfff 64bit pref]
[    0.258686] pci 0000:00:05.0: [1af4:1009] type 00 class 0x000200 conventional PCI endpoint
[    0.260010] pci 0000:00:05.0: BAR 0 [io  0xc0c0-0xc0ff]
[    0.260208] pci 0000:00:05.0: BAR 1 [mem 0xfebff000-0xfebfffff]
[    0.260576] pci 0000:00:05.0: BAR 4 [mem 0x700000c000-0x700000ffff 64bit pref]
[    0.262373] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.262811] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.263243] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.263659] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.264037] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.264621] iommu: Default domain type: Translated
[    0.264682] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.265210] pps_core: LinuxPPS API ver. 1 registered
[    0.265649] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.267221] PTP clock support registered
[    0.268437] NetLabel: Initializing
[    0.268742] NetLabel:  domain hash size = 128
[    0.269180] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.269235] NetLabel:  unlabeled traffic allowed by default
[    0.269785] PCI: Using ACPI for IRQ routing
[    0.270437] vgaarb: loaded
[    0.270437] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.270807] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.276306] clocksource: Switched to clocksource tsc-early
[    0.277683] pnp: PnP ACPI init
[    0.278936] pnp: PnP ACPI: found 5 devices
[    0.287520] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.288102] NET: Registered PF_INET protocol family
[    0.288471] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.296027] tcp_listen_portaddr_hash hash table entries: 2048 (order: 5, 147456 bytes, linear)
[    0.296726] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.297201] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.297729] TCP bind hash table entries: 32768 (order: 10, 4718592 bytes, vmalloc hugepage)
[    0.299043] TCP: Hash tables configured (established 32768 bind 32768)
[    0.299559] MPTCP token hash table entries: 4096 (order: 6, 360448 bytes, linear)
[    0.300049] UDP hash table entries: 2048 (order: 7, 524288 bytes, linear)
[    0.300483] UDP-Lite hash table entries: 2048 (order: 7, 524288 bytes, linear)
[    0.301126] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.301495] NET: Registered PF_XDP protocol family
[    0.301807] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.302154] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.302504] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.302914] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
[    0.303313] pci_bus 0000:00: resource 8 [mem 0x7000000000-0x707fffffff window]
[    0.303829] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.304164] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.304566] PCI: CLS 0 bytes, default 64
[    0.304904] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.305272] software IO TLB: mapped [mem 0x00000000bbfe0000-0x00000000bffe0000] (64MB)
[    0.305780] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
[    0.307386] Initialise system trusted keyrings
[    0.307740] workingset: timestamp_bits=40 max_order=20 bucket_order=0
[    0.308381] fuse: init (API version 7.45)
[    0.308712] 9p: Installing v9fs 9p2000 file system support
[    0.314985] NET: Registered PF_ALG protocol family
[    0.315288] Key type asymmetric registered
[    0.315547] Asymmetric key parser 'x509' registered
[    0.315872] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.316401] io scheduler mq-deadline registered
[    0.316686] io scheduler kyber registered
[    0.317233] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.317881] ACPI: button: Power Button [PWRF]
[    0.319310] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[    0.321055] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    0.322667] ACPI: \_SB_.LNKD: Enabled at IRQ 11
[    0.324267] ACPI: \_SB_.LNKA: Enabled at IRQ 10
[    0.344067] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.344706] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.372426] Linux agpgart interface v0.103
[    0.377776] brd: module loaded
[    0.381002] loop: module loaded
[    0.382411] tun: Universal TUN/TAP device driver, 1.6
[    0.382995] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.384016] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.384490] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.385423] Registered IR keymap rc-empty
[    0.385850] rc rc0: rc-core loopback device as /devices/virtual/rc/rc0
[    0.386424] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.387092] rc rc0: lirc_dev: driver rc-loopback registered at minor = 0, raw IR receiver, raw IR transmitter
[    0.388282] input: rc-core loopback device as /devices/virtual/rc/rc0/input2
[    0.389032] intel_powerclamp: CPU does not support MWAIT
[    0.389338] intel_pstate: CPU model not supported
[    0.390106] GACT probability NOT on
[    0.390336] Mirror/redirect action on
[    0.391220] ipip: IPv4 and MPLS over IPv4 tunneling driver
[    0.391824] gre: GRE over IPv4 demultiplexer driver
[    0.392100] ip_gre: GRE over IPv4 tunneling driver
[    0.393067] Initializing XFRM netlink socket
[    0.393368] IPsec XFRM device driver
[    0.393626] NET: Registered PF_INET6 protocol family
[    0.394389] Segment Routing with IPv6
[    0.394625] In-situ OAM (IOAM) with IPv6
[    0.394894] mip6: Mobile IPv6
[    0.395097] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.395979] ip6_gre: GRE over IPv6 tunneling driver
[    0.396591] NET: Registered PF_PACKET protocol family
[    0.396987] 8021q: 802.1Q VLAN Support v1.8
[    0.397272] 9pnet: Installing 9P2000 support
[    0.398524] Key type dns_resolver registered
[    0.398892] NET: Registered PF_VSOCK protocol family
[    0.399211] mpls_gso: MPLS GSO support
[    0.399814] IPI shorthand broadcast: enabled
[    0.404788] sched_clock: Marking stable (396843605, 7342689)->(417147439, -12961145)
[    0.405330] Callback from call_rcu_tasks() invoked.
[    0.405886] registered taskstats version 1
[    0.411442] Loading compiled-in X.509 certificates
[    0.412579] Loaded X.509 cert 'Build time autogenerated kernel key: 3cee96964ddebecf1b0b1438932e28ffced7b530'
[    0.423380] Demotion targets for Node 0: null
[    0.423858] ima: No TPM chip found, activating TPM-bypass!
[    0.424201] ima: Allocated hash algorithm: sha1
[    0.424493] ima: No architecture policies found
[    0.428121] check access for rdinit=/init failed: -2, ignoring
[    0.797822] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input4
[    0.798449] 9pnet_virtio: no channels available for device
[    0.798707] 9pnet: Limiting 'msize' to 512000 as this is the maximum supported by transport virtio
[    0.800027] VFS: Mounted root (9p filesystem) on device 0:21.
[    0.800473] devtmpfs: mounted
[    0.805289] Freeing unused kernel image (initmem) memory: 3224K
[    0.805540] Write protecting the kernel read-only data: 30720k
[    0.806365] Freeing unused kernel image (text/rodata gap) memory: 1968K
[    0.807023] Freeing unused kernel image (rodata/data gap) memory: 1992K
[    0.807315] Run /tmp/vmtest-init4rGXk.sh as init process
[    0.896407] vmtest: Mounting tmpfs at /dev/shm
[    0.953225] vmtest: Mounting tmpfs at /run
[    0.986902] vmtest: Mounting sysfs at /sys
[    0.995474] vmtest: Mounting debugfs at /sys/kernel/debug
[    1.003835] vmtest: Mounting tracefs at /sys/kernel/debug/tracing
[    1.012284] vmtest: Mounting cgroup2 at /sys/fs/cgroup
[    1.029056] vmtest: Mounting tmpfs at /mnt
[    1.037306] vmtest: Symlink /dev/fd to /proc/self/fd
[    1.042734] vmtest: Init done
[    1.116319] vmtest: Located qemu-guest-agent virtio port: /dev/vport0p1
[    1.116842] vmtest: Spawning qemu-ga in the background
===> Setting up VM
[    1.332434] tsc: Refined TSC clocksource calibration: 2495.995 MHz
[    1.332945] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x23fa72c04f7, max_idle_ns: 440795326923 ns
[    1.333540] clocksource: Switched to clocksource tsc
[    1.411775] 9pnet: Limiting 'msize' to 512000 as this is the maximum supported by transport virtio
tty: ttyname error: Inappropriate ioctl for device
===> Running command
execve("./test_progs", ["./test_progs", "-t", "arg_parsing"], 0x7ffdd5433710 /* 79 vars */) = 0
brk(NULL)                               = 0x55ee00a25000
access("/etc/ld.so.preload", R_OK)      = 0
openat(AT_FDCWD, "/etc/ld.so.preload", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=20, ...}) = 0
mmap(NULL, 20, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0x7f5646067000
close(3)                                = 0
readlinkat(AT_FDCWD, "/proc/self/exe", "/home/v/linux_work/bpf/tools/tes"..., 4096) = 61
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5646065000
openat(AT_FDCWD, "/lib/lib/liblsp.so", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P\24\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=19000, ...}) = 0
mmap(NULL, 4211528, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_DENYWRITE, -1, 0) = 0x7f5645c60000
mmap(0x7f5645e00000, 2114376, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0x7f5645e00000
munmap(0x7f5645c60000, 1703936)         = 0
munmap(0x7f5646005000, 389960)          = 0
mprotect(0x7f5645e04000, 2093056, PROT_NONE) = 0
mmap(0x7f5646003000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7f5646003000
close(3)                                = 0
munmap(0x7f5646067000, 20)              = 0
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=234755, ...}) = 0
mmap(NULL, 234755, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f564602b000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libelf.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=112728, ...}) = 0
mmap(NULL, 110616, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f564600f000
mmap(0x7f5646012000, 77824, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7f5646012000
mmap(0x7f5646025000, 16384, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x16000) = 0x7f5646025000
mmap(0x7f5646029000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1a000) = 0x7f5646029000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libz.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=100368, ...}) = 0
mmap(NULL, 98320, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f5645de7000
mmap(0x7f5645dea000, 57344, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7f5645dea000
mmap(0x7f5645df8000, 24576, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11000) = 0x7f5645df8000
mmap(0x7f5645dfe000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x17000) = 0x7f5645dfe000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libpcap.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=309600, ...}) = 0
mmap(NULL, 311712, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f5645d9a000
mmap(0x7f5645d9e000, 172032, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0x7f5645d9e000
mmap(0x7f5645dc8000, 110592, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2e000) = 0x7f5645dc8000
mmap(0x7f5645de3000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x48000) = 0x7f5645de3000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libLLVM.so.20.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=157076696, ...}) = 0
mmap(NULL, 157875224, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563c70a000
mmap(0x7f563cc51000, 90820608, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x547000) = 0x7f563cc51000
mmap(0x7f56422ee000, 58408960, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x5be4000) = 0x7f56422ee000
mmap(0x7f5645aa2000, 2318336, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9397000) = 0x7f5645aa2000
mmap(0x7f5645cd8000, 793624, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f5645cd8000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0000x\2\0\0\0\0\0"..., 832) = 832
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 896, 64) = 896
fstat(3, {st_mode=S_IFREG|0755, st_size=2149728, ...}) = 0
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 896, 64) = 896
mmap(NULL, 2174000, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563c4f7000
mmap(0x7f563c51b000, 1515520, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x24000) = 0x7f563c51b000
mmap(0x7f563c68d000, 454656, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x196000) = 0x7f563c68d000
mmap(0x7f563c6fc000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x204000) = 0x7f563c6fc000
mmap(0x7f563c702000, 31792, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f563c702000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libdl.so.2", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=14352, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f564600d000
mmap(NULL, 16400, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f5646008000
mmap(0x7f5646009000, 4096, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x7f5646009000
mmap(0x7f564600a000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x7f564600a000
mmap(0x7f564600b000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x7f564600b000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libzstd.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=935880, ...}) = 0
mmap(NULL, 933944, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563c412000
mmap(0x7f563c41e000, 811008, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc000) = 0x7f563c41e000
mmap(0x7f563c4e4000, 69632, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd2000) = 0x7f563c4e4000
mmap(0x7f563c4f5000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe3000) = 0x7f563c4f5000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libnl-genl-3.so.200", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=27576, ...}) = 0
mmap(NULL, 25432, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563c40b000
mmap(0x7f563c40d000, 8192, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x7f563c40d000
mmap(0x7f563c40f000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0x7f563c40f000
mmap(0x7f563c410000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x5000) = 0x7f563c410000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libnl-3.so.200", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=133368, ...}) = 0
mmap(NULL, 131608, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563c3ea000
mmap(0x7f563c3f1000, 61440, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0x7f563c3f1000
mmap(0x7f563c400000, 32768, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x16000) = 0x7f563c400000
mmap(0x7f563c408000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e000) = 0x7f563c408000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libdbus-1.so.3", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=334008, ...}) = 0
mmap(NULL, 336624, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563c397000
mmap(0x7f563c3a5000, 200704, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe000) = 0x7f563c3a5000
mmap(0x7f563c3d6000, 69632, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3f000) = 0x7f563c3d6000
mmap(0x7f563c3e7000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4f000) = 0x7f563c3e7000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libffi.so.8", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=47336, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5646006000
mmap(NULL, 46320, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563c38b000
mmap(0x7f563c38d000, 28672, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x7f563c38d000
mmap(0x7f563c394000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9000) = 0x7f563c394000
mmap(0x7f563c395000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa000) = 0x7f563c395000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libedit.so.0", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=223344, ...}) = 0
mmap(NULL, 236672, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563c351000
mmap(0x7f563c357000, 135168, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0x7f563c357000
mmap(0x7f563c378000, 53248, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x27000) = 0x7f563c378000
mmap(0x7f563c385000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x34000) = 0x7f563c385000
mmap(0x7f563c388000, 11392, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f563c388000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libxml2.so.16", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1260488, ...}) = 0
mmap(NULL, 1262640, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563c21c000
mmap(0x7f563c236000, 864256, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1a000) = 0x7f563c236000
mmap(0x7f563c309000, 249856, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xed000) = 0x7f563c309000
mmap(0x7f563c346000, 40960, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12a000) = 0x7f563c346000
mmap(0x7f563c350000, 1072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f563c350000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libstdc++.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=22480456, ...}) = 0
mmap(NULL, 2699336, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563bf88000
mmap(0x7f563c01f000, 1396736, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x97000) = 0x7f563c01f000
mmap(0x7f563c174000, 598016, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ec000) = 0x7f563c174000
mmap(0x7f563c206000, 73728, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x27e000) = 0x7f563c206000
mmap(0x7f563c218000, 12360, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f563c218000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libm.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1100400, ...}) = 0
mmap(NULL, 1102152, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563be7a000
mmap(0x7f563be89000, 569344, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xf000) = 0x7f563be89000
mmap(0x7f563bf14000, 466944, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9a000) = 0x7f563bf14000
mmap(0x7f563bf86000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x10b000) = 0x7f563bf86000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libgcc_s.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=906056, ...}) = 0
mmap(NULL, 180712, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563be4d000
mmap(0x7f563be51000, 143360, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0x7f563be51000
mmap(0x7f563be74000, 16384, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x27000) = 0x7f563be74000
mmap(0x7f563be78000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2a000) = 0x7f563be78000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f563be4b000
openat(AT_FDCWD, "/usr/lib/libsystemd.so.0", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1201600, ...}) = 0
mmap(NULL, 1202568, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563bd25000
mmap(0x7f563bd3a000, 798720, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15000) = 0x7f563bd3a000
mmap(0x7f563bdfd000, 274432, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd8000) = 0x7f563bdfd000
mmap(0x7f563be40000, 40960, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11b000) = 0x7f563be40000
mmap(0x7f563be4a000, 2440, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f563be4a000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libncursesw.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=453896, ...}) = 0
mmap(NULL, 453856, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563bcb6000
mmap(0x7f563bcc3000, 290816, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd000) = 0x7f563bcc3000
mmap(0x7f563bd0a000, 90112, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x54000) = 0x7f563bd0a000
mmap(0x7f563bd20000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6a000) = 0x7f563bd20000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libicuuc.so.76", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=2095152, ...}) = 0
mmap(NULL, 2102320, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563bab4000
mmap(0x7f563bafc000, 1142784, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x48000) = 0x7f563bafc000
mmap(0x7f563bc13000, 577536, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15f000) = 0x7f563bc13000
mmap(0x7f563bca0000, 81920, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ec000) = 0x7f563bca0000
mmap(0x7f563bcb4000, 5168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f563bcb4000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libcap.so.2", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@|\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=43064, ...}) = 0
mmap(NULL, 45128, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f563baa8000
mmap(0x7f563baab000, 20480, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7f563baab000
mmap(0x7f563bab0000, 8192, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8000) = 0x7f563bab0000
mmap(0x7f563bab2000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9000) = 0x7f563bab2000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libicudata.so.76", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=31859544, ...}) = 0
mmap(NULL, 31862784, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f5639c45000
mmap(0x7f563baa7000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e61000) = 0x7f563baa7000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5639c43000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5639c41000
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5639c3e000
arch_prctl(ARCH_SET_FS, 0x7f5639c3eb80) = 0
set_tid_address(0x7f5639c3ee50)         = 113
set_robust_list(0x7f5639c3ee60, 24)     = 0
rseq(0x7f5639c3e6a0, 0x20, 0, 0x53053053) = 0
mprotect(0x7f563c6fc000, 16384, PROT_READ) = 0
mprotect(0x7f563baa7000, 4096, PROT_READ) = 0
mprotect(0x7f563bab2000, 4096, PROT_READ) = 0
mprotect(0x7f563bf86000, 4096, PROT_READ) = 0
mprotect(0x7f563be78000, 4096, PROT_READ) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5639c3c000
mprotect(0x7f563c206000, 69632, PROT_READ) = 0
mprotect(0x7f563bca0000, 77824, PROT_READ) = 0
mprotect(0x7f563bd20000, 16384, PROT_READ) = 0
mprotect(0x7f563be40000, 36864, PROT_READ) = 0
mprotect(0x7f5645dfe000, 4096, PROT_READ) = 0
mprotect(0x7f563c346000, 36864, PROT_READ) = 0
mprotect(0x7f563c385000, 8192, PROT_READ) = 0
mprotect(0x7f563c395000, 4096, PROT_READ) = 0
mprotect(0x7f563c3e7000, 8192, PROT_READ) = 0
mprotect(0x7f563c408000, 8192, PROT_READ) = 0
mprotect(0x7f563c410000, 4096, PROT_READ) = 0
mprotect(0x7f563c4f5000, 4096, PROT_READ) = 0
mprotect(0x7f564600b000, 4096, PROT_READ) = 0
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5639c39000
mmap(NULL, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5639c34000
mmap(NULL, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5639c2b000
mmap(NULL, 69632, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5639c1a000
mprotect(0x7f5645aa2000, 2023424, PROT_READ) = 0
mprotect(0x7f5645de3000, 12288, PROT_READ) = 0
mprotect(0x7f5646029000, 4096, PROT_READ) = 0
mprotect(0x7f5646003000, 4096, PROT_READ) = 0
mprotect(0x55edfc029000, 40960, PROT_READ) = 0
mprotect(0x7f56460a9000, 8192, PROT_READ) = 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, rlim_max=RLIM64_INFINITY}) = 0
getrandom("\xf1\x6f\x8a\xd2\x35\x03\x92\x94", 8, GRND_NONBLOCK) = 8
munmap(0x7f564602b000, 234755)          = 0
prctl(PR_CAPBSET_READ, CAP_MAC_OVERRIDE) = 1
prctl(PR_CAPBSET_READ, 0x30 /* CAP_??? */) = -1 EINVAL (Invalid argument)
prctl(PR_CAPBSET_READ, CAP_CHECKPOINT_RESTORE) = 1
prctl(PR_CAPBSET_READ, 0x2c /* CAP_??? */) = -1 EINVAL (Invalid argument)
prctl(PR_CAPBSET_READ, 0x2a /* CAP_??? */) = -1 EINVAL (Invalid argument)
prctl(PR_CAPBSET_READ, 0x29 /* CAP_??? */) = -1 EINVAL (Invalid argument)
futex(0x7f563c2186bc, FUTEX_WAKE_PRIVATE, 2147483647) = 0
brk(NULL)                               = 0x55ee00a25000
brk(0x55ee00a58000)                     = 0x55ee00a58000
lseek(2, 0, SEEK_CUR)                   = -1 ESPIPE (Illegal seek)
fstat(2, {st_mode=S_IFCHR|0600, st_rdev=makedev(0xf7, 0x1), ...}) = 0
brk(0x55ee00a79000)                     = 0x55ee00a79000
brk(0x55ee00a9a000)                     = 0x55ee00a9a000
openat(AT_FDCWD, "/etc/lsp.exclude", O_RDONLY) = -1 ENOENT (No such file or directory)
uname({sysname="Linux", nodename="(none)", ...}) = 0
shmget(0xa5723213, 16384, IPC_CREAT|IPC_EXCL|0666) = -1 EEXIST (File exists)
shmget(0xa5723213, 16384, 000)          = 0
shmat(0, NULL, SHM_RDONLY)              = 0x7f5646061000
rt_sigaction(SIGSEGV, {sa_handler=0x55edfb4b635a, sa_mask=[], sa_flags=SA_RESTORER|SA_RESETHAND, sa_restorer=0x7f563c535540}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {sa_handler=0x7f563c58b0b0, sa_mask=[], sa_flags=SA_RESTORER|SA_ONSTACK|SA_RESTART|SA_SIGINFO, sa_restorer=0x7f563c535540}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
mmap(NULL, 29888, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) = 0x7f5646059000
madvise(0x7f5646059000, 4096, MADV_GUARD_INSTALL) = 0
rt_sigprocmask(SIG_BLOCK, ~[], [], 8)   = 0
clone3({flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, child_tid=0x7f564605fe50, parent_tid=0x7f564605fe50, exit_signal=0, stack=0x7f5646059000, stack_size=0x6000, tls=0x7f564605fb80} => {parent_tid=[114]}, 88) = 114
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
futex(0x7f563c707164, FUTEX_WAKE_PRIVATE, 2147483647) = 0
timer_create(CLOCK_MONOTONIC, {sigev_value={sival_int=11041120, sival_ptr=0x55ee00a87960}, sigev_signo=SIGRTMIN, sigev_notify=SIGEV_THREAD_ID, sigev_notify_thread_id=114}, [0]) = 0
add_key("asymmetric", "libbpf_session_key", "0\202\00300\202\2\30\240\3\2\1\2\2\24]HD\257\377\227\344q\271\355:E\275\231\31_\343"..., 820, KEY_SPEC_SESSION_KEYRING) = 840456939
openat(AT_FDCWD, "/proc/sys/net/core/bpf_jit_enable", O_RDONLY) = 3
read(3, "1", 1)                         = 1
close(3)                                = 0
openat(AT_FDCWD, "/sys/devices/system/cpu/possible", O_RDONLY|O_CLOEXEC) = 3
read(3, "0-1\n", 128)                   = 4
close(3)                                = 0
membarrier(MEMBARRIER_CMD_GLOBAL, 0)    = 0
delete_module("bpf_testmod", 0)         = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "bpf_testmod.ko", O_RDONLY) = 3
]3008;start=66cc2fa9-27d0-44b4-885c-ab497965f68c;user=;hostname=(none);machineid=1cdaf5cebfab41c8bca955e04060bc11;bootid=d21d93e5-f04d-4191-adc0-e69d392a1b19;pid=83;type=shell;cwd=/\[?2004h[root@(none) /]# [    1.923467] bpf_testmod: loading out-of-tree module taints kernel.
[    1.923753] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
finit_module(3, "", 0)                  = 0
close(3)                                = 0
openat(AT_FDCWD, "/proc/self/ns/net", O_RDONLY) = 3
timer_settime(0, 0, {it_interval={tv_sec=0, tv_nsec=0}, it_value={tv_sec=10, tv_nsec=0}}, NULL) = 0
timer_settime(0, 0, {it_interval={tv_sec=0, tv_nsec=0}, it_value={tv_sec=10, tv_nsec=0}}, NULL) = 0
timer_settime(0, 0, {it_interval={tv_sec=0, tv_nsec=0}, it_value={tv_sec=10, tv_nsec=0}}, NULL) = 0
rt_sigprocmask(SIG_BLOCK, ~[], [], 8)   = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_DROPPABLE|MAP_ANONYMOUS, -1, 0) = 0x7f5646067000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f5646058000
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
getrandom("\x71\x5a\x8a\xba\x3b\xbc\xd6\x0f\x14\x6c\x9b\xeb\x1f\xdd\xd0\xd6\x02\x72\x53\x24\x0a\x29\xbb\x69\x8f\x58\xaf\xd0\x2e\xe5\x00\xbb", 32, 0) = 32
openat(AT_FDCWD, "/tmp/bpf_arg_parsing_test.WavYEa", O_RDWR|O_CREAT|O_EXCL, 0600) = 4
fcntl(4, F_GETFL)                       = 0x8002 (flags O_RDWR|O_LARGEFILE)
fstat(4, {st_mode=S_IFREG|0600, st_size=0, ...}) = 0
write(4, "# comment\n  test_with_spaces    "..., 175) = 175
close(4)                                = 0
openat(AT_FDCWD, "/tmp/bpf_arg_parsing_test.WavYEa", O_RDONLY) = 4
fstat(4, {st_mode=S_IFREG|0600, st_size=175, ...}) = 0
read(4, "# comment\n  test_with_spaces    "..., 8192) = 175
read(4, "", 8192)                       = 0
close(4)                                = 0
unlink("/tmp/bpf_arg_parsing_test.WavYEa") = 0
timer_settime(0, 0, {it_interval={tv_sec=0, tv_nsec=0}, it_value={tv_sec=0, tv_nsec=0}}, NULL) = 0
sched_setaffinity(0, 128, [0 1])        = 0
sched_setaffinity(113, 128, [0 1])      = 0
setns(3, CLONE_NEWNET)                  = 0
fstat(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(0xf7, 0x1), ...}) = 0
ioctl(1, TCGETS2, 0x7fffb86c3830)       = -1 ENOTTY (Inappropriate ioctl for device)
close(3)                                = 0
membarrier(MEMBARRIER_CMD_GLOBAL, 0)    = 0
delete_module("bpf_testmod", 0)         = 0
shmdt(0x7f5646061000)                   = 0
write(1, "#7/1     arg_parsing/test_parse_"..., 160#7/1     arg_parsing/test_parse_test_list:OK
#7/2     arg_parsing/test_parse_test_list_file:OK
#7       arg_parsing:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
) = 160
exit_group(0)                           = ?
+++ exited with 0 +++

Diff before the fix:

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index e27d66b75fb1..fbf0d9c2f58b 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -144,9 +144,6 @@ static void test_parse_test_list_file(void)
 	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
 		goto out_fclose;
 
-	if (!ASSERT_OK(fsync(fileno(fp)), "fsync tmp"))
-		goto out_fclose;
-
 	init_test_filter_set(&set);
 
 	if (!ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file"))

Test before the fix:


=> bzImage
===> Booting
No EFI environment detected.
early console in extract_kernel
input_data: 0x0000000003e8c2c4
input_len: 0x0000000000d59ef7
output: 0x0000000001000000
output_len: 0x0000000003156b50
kernel_total_size: 0x0000000003c30000
needed_size: 0x0000000003e00000
trampoline_32bit: 0x0000000000000000
Physical KASLR using RDRAND RDTSC...
Virtual KASLR using RDRAND RDTSC...

Decompressing Linux... Parsing ELF... Performing relocations... done.
Booting the kernel (entry_offset: 0x0000000002b46b90).
[    0.000000] Linux version 6.18.0-rc1-g1c64efcb083c (v@laptop) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Mon Oct 20 14:25:28 CST 2025
[    0.000000] Command line: rootfstype=9p rootflags=trans=virtio,cache=mmap,msize=1048576 rw earlyprintk=serial,0,115200 printk.devkmsg=on console=0,115200 loglevel=7 raid=noautodetect init=/tmp/vmtest-initPXYuB.sh panic=-1
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable
[    0.000000] printk: legacy bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
[    0.000000] DMI: Memory slots populated: 1/1
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2495.840 MHz processor
[    0.000123] last_pfn = 0x140000 max_arch_pfn = 0x400000000
[    0.000481] MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
[    0.000978] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
Memory KASLR using RDRAND RDTSC...
[    0.001612] last_pfn = 0xbffe0 max_arch_pfn = 0x400000000
[    0.006021] found SMP MP-table at [mem 0x000f66a0-0x000f66af]
[    0.006369] Using GB pages for direct mapping
[    0.006717] ACPI: Early table checksum verification disabled
[    0.007056] ACPI: RSDP 0x00000000000F64B0 000014 (v00 BOCHS )
[    0.007405] ACPI: RSDT 0x00000000BFFE2379 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.007909] ACPI: FACP 0x00000000BFFE2225 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.008451] ACPI: DSDT 0x00000000BFFE0040 0021E5 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.008954] ACPI: FACS 0x00000000BFFE0000 000040
[    0.009232] ACPI: APIC 0x00000000BFFE2299 000080 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.009740] ACPI: HPET 0x00000000BFFE2319 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.010250] ACPI: WAET 0x00000000BFFE2351 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.010765] ACPI: Reserving FACP table memory at [mem 0xbffe2225-0xbffe2298]
[    0.011185] ACPI: Reserving DSDT table memory at [mem 0xbffe0040-0xbffe2224]
[    0.011621] ACPI: Reserving FACS table memory at [mem 0xbffe0000-0xbffe003f]
[    0.012039] ACPI: Reserving APIC table memory at [mem 0xbffe2299-0xbffe2318]
[    0.012477] ACPI: Reserving HPET table memory at [mem 0xbffe2319-0xbffe2350]
[    0.012909] ACPI: Reserving WAET table memory at [mem 0xbffe2351-0xbffe2378]
[    0.013531] No NUMA configuration found
[    0.013762] Faking a node at [mem 0x0000000000000000-0x000000013fffffff]
[    0.014164] NODE_DATA(0) allocated [mem 0x13fffbe80-0x13fffffff]
[    0.014643] Zone ranges:
[    0.014801]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.015163]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.015529]   Normal   [mem 0x0000000100000000-0x000000013fffffff]
[    0.015890] Movable zone start for each node
[    0.016139] Early memory node ranges
[    0.016401]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.016872]   node   0: [mem 0x0000000000100000-0x00000000bffdffff]
[    0.017374]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
[    0.017846] Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
[    0.018483] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.018956] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.027324] On node 0, zone Normal: 32 pages in unavailable ranges
[    0.028090] ACPI: PM-Timer IO Port: 0x608
[    0.028459] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.028944] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.029486] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.029962] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.030464] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.030959] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.031472] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.031984] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.032471] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.032859] TSC deadline timer available
[    0.033157] CPU topo: Max. logical packages:   1
[    0.033507] CPU topo: Max. logical dies:       1
[    0.033862] CPU topo: Max. dies per package:   1
[    0.034222] CPU topo: Max. threads per core:   1
[    0.034578] CPU topo: Num. cores per package:     2
[    0.034943] CPU topo: Num. threads per package:   2
[    0.035305] CPU topo: Allowing 2 present CPUs plus 0 hotplug CPUs
[    0.035678] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[    0.036042] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.040511] setup_percpu: NR_CPUS:128 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.041191] percpu: Embedded 56 pages/cpu s191568 r8192 d29616 u1048576
[    0.041625] Kernel command line: rootfstype=9p rootflags=trans=virtio,cache=mmap,msize=1048576 rw earlyprintk=serial,0,115200 printk.devkmsg=on console=0,115200 loglevel=7 raid=noautodetect init=/tmp/vmtest-initPXYuB.sh panic=-1
[    0.042899] Unknown kernel command line parameters "raid=noautodetect", will be passed to user space.
[    0.043556] random: crng init done
[    0.043784] printk: log buffer data + meta data: 2097152 + 7340032 = 9437184 bytes
[    0.044670] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.045377] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.045912] software IO TLB: area num 2.
[    0.058274] Fallback order for Node 0: 0
[    0.058279] Built 1 zonelists, mobility grouping on.  Total pages: 1048446
[    0.059101] Policy zone: Normal
[    0.059386] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.065932] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Poking KASLR using RDRAND RDTSC...
[    0.073724] ftrace: allocating 41991 entries in 166 pages
[    0.074211] ftrace: allocated 166 pages with 4 groups
[    0.074651] Dynamic Preempt: full
[    0.075106] Running RCU self tests
[    0.075321] Running RCU synchronous self tests
[    0.075575] rcu: Preemptible hierarchical RCU implementation.
[    0.075902] rcu: 	RCU event tracing is enabled.
[    0.076160] rcu: 	RCU lockdep checking is enabled.
[    0.076438] rcu: 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=2.
[    0.076819] 	Trampoline variant of Tasks RCU enabled.
[    0.077105] 	Rude variant of Tasks RCU enabled.
[    0.077366] 	Tracing variant of Tasks RCU enabled.
[    0.077639] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.078080] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.078487] Running RCU synchronous self tests
[    0.078736] RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
[    0.079224] RCU Tasks Rude: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
[    0.079748] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
[    0.083372] NR_IRQS: 8448, nr_irqs: 440, preallocated irqs: 16
[    0.084029] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.084606] Console: colour *CGA 80x25
[    0.084852] printk: legacy console [ttyS0] enabled
[    0.084852] printk: legacy console [ttyS0] enabled
[    0.085406] printk: legacy bootconsole [earlyser0] disabled
[    0.085406] printk: legacy bootconsole [earlyser0] disabled
[    0.086049] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.086497] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.086736] ... MAX_LOCK_DEPTH:          48
[    0.086980] ... MAX_LOCKDEP_KEYS:        8192
[    0.087238] ... CLASSHASH_SIZE:          4096
[    0.087493] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.087753] ... MAX_LOCKDEP_CHAINS:      65536
[    0.088013] ... CHAINHASH_SIZE:          32768
[    0.088276]  memory used by lock dependency info: 6429 kB
[    0.088591]  memory used for stack traces: 4224 kB
[    0.088904]  per task-struct memory footprint: 1920 bytes
[    0.089293] ACPI: Core revision 20250807
[    0.089648] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.090343] APIC: Switch to symmetric I/O mode setup
[    0.091375] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.096339] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x23f9e01fe9a, max_idle_ns: 440795324260 ns
[    0.096950] Calibrating delay loop (skipped), value calculated using timer frequency.. 4991.68 BogoMIPS (lpj=2495840)
[    0.098057] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.098493] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.098941] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.099288] mitigations: Enabled attack vectors: user_kernel, user_user, SMT mitigations: auto
[    0.099781] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.099941] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.100271] ITS: Mitigation: Aligned branch/return thunks
[    0.100941] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.101425] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    0.101943] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.102326] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.102941] active return thunk: its_return_thunk
[    0.103204] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.103610] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.103941] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.104274] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.104664] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.104941] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.105300] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.105727] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.105941] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.106271] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.106609] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.106941] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.107271] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
[    0.125819] Freeing SMP alternatives memory: 44K
[    0.125942] pid_max: default: 32768 minimum: 301
[    0.126233] LSM: initializing lsm=capability,selinux,bpf,ima
[    0.126566] SELinux:  Initializing.
[    0.127499] LSM support for eBPF active
[    0.127852] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.127947] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.129199] Running RCU synchronous self tests
[    0.129437] Running RCU synchronous self tests
[    0.129813] smpboot: CPU0: 11th Gen Intel(R) Core(TM) i7-11850H @ 2.50GHz (family: 0x6, model: 0x8d, stepping: 0x1)
[    0.129940] Performance Events: Icelake events, full-width counters, Intel PMU driver.
[    0.129948] ... version:                   2
[    0.130174] ... bit width:                 48
[    0.130405] ... generic counters:          8
[    0.130630] ... generic bitmap:            00000000000000ff
[    0.130926] ... fixed-purpose counters:    3
[    0.130942] ... fixed-purpose bitmap:      0000000000000007
[    0.131234] ... value mask:                0000ffffffffffff
[    0.131528] ... max period:                00007fffffffffff
[    0.131825] ... global_ctrl mask:          00000007000000ff
[    0.132078] signal: max sigframe size: 3232
[    0.132355] rcu: Hierarchical SRCU implementation.
[    0.132614] rcu: 	Max phase no-delay instances is 400.
[    0.132958] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.135433] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.136956] smp: Bringing up secondary CPUs ...
[    0.137402] smpboot: x86: Booting SMP configuration:
[    0.137674] .... node  #0, CPUs:      #1
[    0.198236] smp: Brought up 1 node, 2 CPUs
[    0.198439] smpboot: Total of 2 processors activated (10056.34 BogoMIPS)
[    0.199193] Memory: 3984340K/4193784K available (16460K kernel code, 9137K rwdata, 10296K rodata, 3224K init, 13904K bss, 200604K reserved, 0K cma-reserved)
[    0.200560] devtmpfs: initialized
[    0.201562] Running RCU synchronous self tests
[    0.201955] Running RCU synchronous self tests
[    0.202234] Running RCU Tasks wait API self tests
[    0.202234] Running RCU Tasks Rude wait API self tests
[    0.202235] Running RCU Tasks Trace wait API self tests
[    0.215962] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.215962] posixtimers hash table entries: 1024 (order: 4, 73728 bytes, linear)
[    0.216379] futex hash table entries: 512 (65536 bytes on 1 NUMA nodes, total 64 KiB, linear).
[    0.217883] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.218310] audit: initializing netlink subsys (disabled)
[    0.218966] audit: type=2000 audit(1760950214.127:1): state=initialized audit_enabled=0 res=1
[    0.219129] thermal_sys: Registered thermal governor 'step_wise'
[    0.219963] cpuidle: using governor ladder
[    0.220555] cpuidle: using governor menu
[    0.221062] PCI: Using configuration type 1 for base access
[    0.221439] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.222098] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.222476] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.222944] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.223309] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.224668] ACPI: Added _OSI(Module Device)
[    0.224930] ACPI: Added _OSI(Processor Device)
[    0.224943] ACPI: Added _OSI(Processor Aggregator Device)
[    0.226237] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.231186] ACPI: Interpreter enabled
[    0.231470] ACPI: PM: (supports S0 S3 S5)
[    0.231726] ACPI: Using IOAPIC for interrupt routing
[    0.231964] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.232474] PCI: Using E820 reservations for host bridge windows
[    0.234962] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.235956] Callback from call_rcu_tasks_trace() invoked.
[    0.239412] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.239847] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    0.239943] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.240494] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    0.241264] PCI host bridge to bus 0000:00
[    0.241491] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.241857] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.241943] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.242347] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    0.242790] pci_bus 0000:00: root bus resource [mem 0x7000000000-0x707fffffff window]
[    0.242942] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.243296] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 conventional PCI endpoint
[    0.244225] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100 conventional PCI endpoint
[    0.245035] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180 conventional PCI endpoint
[    0.245919] pci 0000:00:01.1: BAR 4 [io  0xc100-0xc10f]
[    0.245959] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
[    0.246335] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE quirk
[    0.246670] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
[    0.246942] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE quirk
[    0.247480] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000 conventional PCI endpoint
[    0.248145] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.248538] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.249187] pci 0000:00:02.0: [1af4:1003] type 00 class 0x078000 conventional PCI endpoint
[    0.250518] pci 0000:00:02.0: BAR 0 [io  0xc000-0xc03f]
[    0.250837] pci 0000:00:02.0: BAR 1 [mem 0xfebfc000-0xfebfcfff]
[    0.250958] pci 0000:00:02.0: BAR 4 [mem 0x7000000000-0x7000003fff 64bit pref]
[    0.252337] pci 0000:00:03.0: [1af4:1003] type 00 class 0x078000 conventional PCI endpoint
[    0.253674] pci 0000:00:03.0: BAR 0 [io  0xc040-0xc07f]
[    0.253948] pci 0000:00:03.0: BAR 1 [mem 0xfebfd000-0xfebfdfff]
[    0.254314] pci 0000:00:03.0: BAR 4 [mem 0x7000004000-0x7000007fff 64bit pref]
[    0.255855] pci 0000:00:04.0: [1af4:1009] type 00 class 0x000200 conventional PCI endpoint
[    0.256598] pci 0000:00:04.0: BAR 0 [io  0xc080-0xc0bf]
[    0.256908] pci 0000:00:04.0: BAR 1 [mem 0xfebfe000-0xfebfefff]
[    0.256956] pci 0000:00:04.0: BAR 4 [mem 0x7000008000-0x700000bfff 64bit pref]
[    0.258212] pci 0000:00:05.0: [1af4:1009] type 00 class 0x000200 conventional PCI endpoint
[    0.259261] pci 0000:00:05.0: BAR 0 [io  0xc0c0-0xc0ff]
[    0.259556] pci 0000:00:05.0: BAR 1 [mem 0xfebff000-0xfebfffff]
[    0.259892] pci 0000:00:05.0: BAR 4 [mem 0x700000c000-0x700000ffff 64bit pref]
[    0.261307] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.261738] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.262022] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.262453] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.262830] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.263330] iommu: Default domain type: Translated
[    0.263330] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.264147] pps_core: LinuxPPS API ver. 1 registered
[    0.264422] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.264949] PTP clock support registered
[    0.265631] NetLabel: Initializing
[    0.265856] NetLabel:  domain hash size = 128
[    0.265943] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.266265] NetLabel:  unlabeled traffic allowed by default
[    0.266581] PCI: Using ACPI for IRQ routing
[    0.267013] vgaarb: loaded
[    0.267128] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.267399] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.270943] clocksource: Switched to clocksource tsc-early
[    0.271758] pnp: PnP ACPI init
[    0.272379] pnp: PnP ACPI: found 5 devices
[    0.280697] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.281225] NET: Registered PF_INET protocol family
[    0.281706] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.288406] tcp_listen_portaddr_hash hash table entries: 2048 (order: 5, 147456 bytes, linear)
[    0.289035] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.289553] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.290058] TCP bind hash table entries: 32768 (order: 10, 4718592 bytes, vmalloc hugepage)
[    0.291276] TCP: Hash tables configured (established 32768 bind 32768)
[    0.291739] MPTCP token hash table entries: 4096 (order: 6, 360448 bytes, linear)
[    0.292180] UDP hash table entries: 2048 (order: 7, 524288 bytes, linear)
[    0.292603] UDP-Lite hash table entries: 2048 (order: 7, 524288 bytes, linear)
[    0.293177] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.293515] NET: Registered PF_XDP protocol family
[    0.293819] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.294183] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.294533] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.294926] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
[    0.295301] pci_bus 0000:00: resource 8 [mem 0x7000000000-0x707fffffff window]
[    0.295778] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.296106] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.296478] PCI: CLS 0 bytes, default 64
[    0.296749] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.297108] software IO TLB: mapped [mem 0x00000000bbfe0000-0x00000000bffe0000] (64MB)
[    0.297576] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
[    0.299122] Initialise system trusted keyrings
[    0.299483] workingset: timestamp_bits=40 max_order=20 bucket_order=0
[    0.300132] fuse: init (API version 7.45)
[    0.300463] 9p: Installing v9fs 9p2000 file system support
[    0.306872] NET: Registered PF_ALG protocol family
[    0.307155] Key type asymmetric registered
[    0.307387] Asymmetric key parser 'x509' registered
[    0.307706] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.308317] io scheduler mq-deadline registered
[    0.308613] io scheduler kyber registered
[    0.309143] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.313098] ACPI: button: Power Button [PWRF]
[    0.314540] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[    0.316280] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    0.317975] ACPI: \_SB_.LNKD: Enabled at IRQ 11
[    0.319706] ACPI: \_SB_.LNKA: Enabled at IRQ 10
[    0.340304] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.341063] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.371195] Linux agpgart interface v0.103
[    0.376513] brd: module loaded
[    0.379773] loop: module loaded
[    0.381245] tun: Universal TUN/TAP device driver, 1.6
[    0.381717] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.382670] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.382980] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.383913] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.384481] Registered IR keymap rc-empty
[    0.384815] rc rc0: rc-core loopback device as /devices/virtual/rc/rc0
[    0.385347] rc rc0: lirc_dev: driver rc-loopback registered at minor = 0, raw IR receiver, raw IR transmitter
[    0.386174] input: rc-core loopback device as /devices/virtual/rc/rc0/input2
[    0.386722] intel_powerclamp: CPU does not support MWAIT
[    0.387033] intel_pstate: CPU model not supported
[    0.387795] GACT probability NOT on
[    0.388018] Mirror/redirect action on
[    0.388761] ipip: IPv4 and MPLS over IPv4 tunneling driver
[    0.389322] gre: GRE over IPv4 demultiplexer driver
[    0.389617] ip_gre: GRE over IPv4 tunneling driver
[    0.390567] Initializing XFRM netlink socket
[    0.390843] IPsec XFRM device driver
[    0.391085] NET: Registered PF_INET6 protocol family
[    0.391803] Segment Routing with IPv6
[    0.392032] In-situ OAM (IOAM) with IPv6
[    0.392269] mip6: Mobile IPv6
[    0.392450] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.393263] ip6_gre: GRE over IPv6 tunneling driver
[    0.393764] NET: Registered PF_PACKET protocol family
[    0.394097] 8021q: 802.1Q VLAN Support v1.8
[    0.394360] 9pnet: Installing 9P2000 support
[    0.395521] Key type dns_resolver registered
[    0.395852] NET: Registered PF_VSOCK protocol family
[    0.396152] mpls_gso: MPLS GSO support
[    0.396697] IPI shorthand broadcast: enabled
[    0.401713] sched_clock: Marking stable (393468915, 7474116)->(415695301, -14752270)
[    0.402368] registered taskstats version 1
[    0.408127] Loading compiled-in X.509 certificates
[    0.409108] Loaded X.509 cert 'Build time autogenerated kernel key: 3cee96964ddebecf1b0b1438932e28ffced7b530'
[    0.413010] Callback from call_rcu_tasks() invoked.
[    0.419606] Demotion targets for Node 0: null
[    0.420057] ima: No TPM chip found, activating TPM-bypass!
[    0.420369] ima: Allocated hash algorithm: sha1
[    0.420640] ima: No architecture policies found
[    0.423906] check access for rdinit=/init failed: -2, ignoring
[    0.796507] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input4
[    0.797164] 9pnet_virtio: no channels available for device
[    0.797400] 9pnet: Limiting 'msize' to 512000 as this is the maximum supported by transport virtio
[    0.798480] VFS: Mounted root (9p filesystem) on device 0:21.
[    0.798885] devtmpfs: mounted
[    0.803718] Freeing unused kernel image (initmem) memory: 3224K
[    0.803974] Write protecting the kernel read-only data: 30720k
[    0.804807] Freeing unused kernel image (text/rodata gap) memory: 1968K
[    0.805443] Freeing unused kernel image (rodata/data gap) memory: 1992K
[    0.805719] Run /tmp/vmtest-initPXYuB.sh as init process
[    0.896179] vmtest: Mounting tmpfs at /dev/shm
[    0.949984] vmtest: Mounting tmpfs at /run
[    0.986155] vmtest: Mounting sysfs at /sys
[    0.996666] vmtest: Mounting debugfs at /sys/kernel/debug
[    1.006740] vmtest: Mounting tracefs at /sys/kernel/debug/tracing
[    1.015531] vmtest: Mounting cgroup2 at /sys/fs/cgroup
[    1.031896] vmtest: Mounting tmpfs at /mnt
[    1.041723] vmtest: Symlink /dev/fd to /proc/self/fd
[    1.048255] vmtest: Init done
[    1.129998] vmtest: Located qemu-guest-agent virtio port: /dev/vport0p1
[    1.130527] vmtest: Spawning qemu-ga in the background
===> Setting up VM
[    1.340553] tsc: Refined TSC clocksource calibration: 2495.994 MHz
[    1.340869] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x23fa717cb36, max_idle_ns: 440795237972 ns
[    1.341320] clocksource: Switched to clocksource tsc
[    1.429921] 9pnet: Limiting 'msize' to 512000 as this is the maximum supported by transport virtio
tty: ttyname error: Inappropriate ioctl for device
===> Running command
execve("./test_progs", ["./test_progs", "-t", "arg_parsing"], 0x7ffc2f0e97b0 /* 79 vars */) = 0
brk(NULL)                               = 0x5645b48fe000
access("/etc/ld.so.preload", R_OK)      = 0
openat(AT_FDCWD, "/etc/ld.so.preload", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=20, ...}) = 0
mmap(NULL, 20, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0x7fec414d0000
close(3)                                = 0
readlinkat(AT_FDCWD, "/proc/self/exe", "/home/v/linux_work/bpf/tools/tes"..., 4096) = 61
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fec414ce000
openat(AT_FDCWD, "/lib/lib/liblsp.so", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P\24\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=19000, ...}) = 0
mmap(NULL, 4211528, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_DENYWRITE, -1, 0) = 0x7fec410c9000
mmap(0x7fec41200000, 2114376, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0x7fec41200000
munmap(0x7fec410c9000, 1273856)         = 0
munmap(0x7fec41405000, 820040)          = 0
mprotect(0x7fec41204000, 2093056, PROT_NONE) = 0
mmap(0x7fec41403000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7fec41403000
close(3)                                = 0
munmap(0x7fec414d0000, 20)              = 0
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=234755, ...}) = 0
mmap(NULL, 234755, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fec41494000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libelf.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=112728, ...}) = 0
mmap(NULL, 110616, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec41478000
mmap(0x7fec4147b000, 77824, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7fec4147b000
mmap(0x7fec4148e000, 16384, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x16000) = 0x7fec4148e000
mmap(0x7fec41492000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1a000) = 0x7fec41492000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libz.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=100368, ...}) = 0
mmap(NULL, 98320, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec4145f000
mmap(0x7fec41462000, 57344, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7fec41462000
mmap(0x7fec41470000, 24576, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11000) = 0x7fec41470000
mmap(0x7fec41476000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x17000) = 0x7fec41476000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libpcap.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=309600, ...}) = 0
mmap(NULL, 311712, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec41412000
mmap(0x7fec41416000, 172032, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0x7fec41416000
mmap(0x7fec41440000, 110592, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2e000) = 0x7fec41440000
mmap(0x7fec4145b000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x48000) = 0x7fec4145b000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libLLVM.so.20.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=157076696, ...}) = 0
mmap(NULL, 157875224, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec37b70000
mmap(0x7fec380b7000, 90820608, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x547000) = 0x7fec380b7000
mmap(0x7fec3d754000, 58408960, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x5be4000) = 0x7fec3d754000
mmap(0x7fec40f08000, 2318336, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9397000) = 0x7fec40f08000
mmap(0x7fec4113e000, 793624, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7fec4113e000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0000x\2\0\0\0\0\0"..., 832) = 832
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 896, 64) = 896
fstat(3, {st_mode=S_IFREG|0755, st_size=2149728, ...}) = 0
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 896, 64) = 896
mmap(NULL, 2174000, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec3795d000
mmap(0x7fec37981000, 1515520, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x24000) = 0x7fec37981000
mmap(0x7fec37af3000, 454656, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x196000) = 0x7fec37af3000
mmap(0x7fec37b62000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x204000) = 0x7fec37b62000
mmap(0x7fec37b68000, 31792, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7fec37b68000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libdl.so.2", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=14352, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fec41410000
mmap(NULL, 16400, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec4140b000
mmap(0x7fec4140c000, 4096, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x7fec4140c000
mmap(0x7fec4140d000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x7fec4140d000
mmap(0x7fec4140e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x7fec4140e000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libzstd.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=935880, ...}) = 0
mmap(NULL, 933944, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec37878000
mmap(0x7fec37884000, 811008, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc000) = 0x7fec37884000
mmap(0x7fec3794a000, 69632, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd2000) = 0x7fec3794a000
mmap(0x7fec3795b000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe3000) = 0x7fec3795b000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libnl-genl-3.so.200", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=27576, ...}) = 0
mmap(NULL, 25432, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec37871000
mmap(0x7fec37873000, 8192, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x7fec37873000
mmap(0x7fec37875000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0x7fec37875000
mmap(0x7fec37876000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x5000) = 0x7fec37876000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libnl-3.so.200", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=133368, ...}) = 0
mmap(NULL, 131608, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec37850000
mmap(0x7fec37857000, 61440, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0x7fec37857000
mmap(0x7fec37866000, 32768, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x16000) = 0x7fec37866000
mmap(0x7fec3786e000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e000) = 0x7fec3786e000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libdbus-1.so.3", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=334008, ...}) = 0
mmap(NULL, 336624, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec377fd000
mmap(0x7fec3780b000, 200704, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe000) = 0x7fec3780b000
mmap(0x7fec3783c000, 69632, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3f000) = 0x7fec3783c000
mmap(0x7fec3784d000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4f000) = 0x7fec3784d000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libffi.so.8", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=47336, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fec41409000
mmap(NULL, 46320, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec377f1000
mmap(0x7fec377f3000, 28672, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x7fec377f3000
mmap(0x7fec377fa000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9000) = 0x7fec377fa000
mmap(0x7fec377fb000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa000) = 0x7fec377fb000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libedit.so.0", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=223344, ...}) = 0
mmap(NULL, 236672, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec377b7000
mmap(0x7fec377bd000, 135168, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0x7fec377bd000
mmap(0x7fec377de000, 53248, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x27000) = 0x7fec377de000
mmap(0x7fec377eb000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x34000) = 0x7fec377eb000
mmap(0x7fec377ee000, 11392, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7fec377ee000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libxml2.so.16", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1260488, ...}) = 0
mmap(NULL, 1262640, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec37682000
mmap(0x7fec3769c000, 864256, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1a000) = 0x7fec3769c000
mmap(0x7fec3776f000, 249856, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xed000) = 0x7fec3776f000
mmap(0x7fec377ac000, 40960, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12a000) = 0x7fec377ac000
mmap(0x7fec377b6000, 1072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7fec377b6000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libstdc++.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=22480456, ...}) = 0
mmap(NULL, 2699336, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec373ee000
mmap(0x7fec37485000, 1396736, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x97000) = 0x7fec37485000
mmap(0x7fec375da000, 598016, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ec000) = 0x7fec375da000
mmap(0x7fec3766c000, 73728, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x27e000) = 0x7fec3766c000
mmap(0x7fec3767e000, 12360, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7fec3767e000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libm.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1100400, ...}) = 0
mmap(NULL, 1102152, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec372e0000
mmap(0x7fec372ef000, 569344, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xf000) = 0x7fec372ef000
mmap(0x7fec3737a000, 466944, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9a000) = 0x7fec3737a000
mmap(0x7fec373ec000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x10b000) = 0x7fec373ec000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libgcc_s.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=906056, ...}) = 0
mmap(NULL, 180712, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec372b3000
mmap(0x7fec372b7000, 143360, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0x7fec372b7000
mmap(0x7fec372da000, 16384, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x27000) = 0x7fec372da000
mmap(0x7fec372de000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2a000) = 0x7fec372de000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fec41407000
openat(AT_FDCWD, "/usr/lib/libsystemd.so.0", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1201600, ...}) = 0
mmap(NULL, 1202568, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec3718d000
mmap(0x7fec371a2000, 798720, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15000) = 0x7fec371a2000
mmap(0x7fec37265000, 274432, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd8000) = 0x7fec37265000
mmap(0x7fec372a8000, 40960, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11b000) = 0x7fec372a8000
mmap(0x7fec372b2000, 2440, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7fec372b2000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libncursesw.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=453896, ...}) = 0
mmap(NULL, 453856, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec3711e000
mmap(0x7fec3712b000, 290816, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd000) = 0x7fec3712b000
mmap(0x7fec37172000, 90112, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x54000) = 0x7fec37172000
mmap(0x7fec37188000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6a000) = 0x7fec37188000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libicuuc.so.76", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=2095152, ...}) = 0
mmap(NULL, 2102320, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec36f1c000
mmap(0x7fec36f64000, 1142784, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x48000) = 0x7fec36f64000
mmap(0x7fec3707b000, 577536, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15f000) = 0x7fec3707b000
mmap(0x7fec37108000, 81920, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ec000) = 0x7fec37108000
mmap(0x7fec3711c000, 5168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7fec3711c000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libcap.so.2", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@|\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=43064, ...}) = 0
mmap(NULL, 45128, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec36f10000
mmap(0x7fec36f13000, 20480, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7fec36f13000
mmap(0x7fec36f18000, 8192, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8000) = 0x7fec36f18000
mmap(0x7fec36f1a000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9000) = 0x7fec36f1a000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libicudata.so.76", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=31859544, ...}) = 0
mmap(NULL, 31862784, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fec350ad000
mmap(0x7fec36f0f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e61000) = 0x7fec36f0f000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fec41405000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fec350ab000
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fec350a8000
arch_prctl(ARCH_SET_FS, 0x7fec350a8b80) = 0
set_tid_address(0x7fec350a8e50)         = 113
set_robust_list(0x7fec350a8e60, 24)     = 0
rseq(0x7fec350a86a0, 0x20, 0, 0x53053053) = 0
mprotect(0x7fec37b62000, 16384, PROT_READ) = 0
mprotect(0x7fec36f0f000, 4096, PROT_READ) = 0
mprotect(0x7fec36f1a000, 4096, PROT_READ) = 0
mprotect(0x7fec373ec000, 4096, PROT_READ) = 0
mprotect(0x7fec372de000, 4096, PROT_READ) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fec350a6000
mprotect(0x7fec3766c000, 69632, PROT_READ) = 0
mprotect(0x7fec37108000, 77824, PROT_READ) = 0
mprotect(0x7fec37188000, 16384, PROT_READ) = 0
mprotect(0x7fec372a8000, 36864, PROT_READ) = 0
mprotect(0x7fec41476000, 4096, PROT_READ) = 0
mprotect(0x7fec377ac000, 36864, PROT_READ) = 0
mprotect(0x7fec377eb000, 8192, PROT_READ) = 0
mprotect(0x7fec377fb000, 4096, PROT_READ) = 0
mprotect(0x7fec3784d000, 8192, PROT_READ) = 0
mprotect(0x7fec3786e000, 8192, PROT_READ) = 0
mprotect(0x7fec37876000, 4096, PROT_READ) = 0
mprotect(0x7fec3795b000, 4096, PROT_READ) = 0
mprotect(0x7fec4140e000, 4096, PROT_READ) = 0
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fec350a3000
mmap(NULL, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fec3509e000
mmap(NULL, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fec35095000
mmap(NULL, 69632, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fec35084000
mprotect(0x7fec40f08000, 2023424, PROT_READ) = 0
mprotect(0x7fec4145b000, 12288, PROT_READ) = 0
mprotect(0x7fec41492000, 4096, PROT_READ) = 0
mprotect(0x7fec41403000, 4096, PROT_READ) = 0
mprotect(0x5645aff02000, 40960, PROT_READ) = 0
mprotect(0x7fec41512000, 8192, PROT_READ) = 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, rlim_max=RLIM64_INFINITY}) = 0
getrandom("\xa3\xe5\xc9\xfe\xb3\x06\x4d\xe2", 8, GRND_NONBLOCK) = 8
munmap(0x7fec41494000, 234755)          = 0
prctl(PR_CAPBSET_READ, CAP_MAC_OVERRIDE) = 1
prctl(PR_CAPBSET_READ, 0x30 /* CAP_??? */) = -1 EINVAL (Invalid argument)
prctl(PR_CAPBSET_READ, CAP_CHECKPOINT_RESTORE) = 1
prctl(PR_CAPBSET_READ, 0x2c /* CAP_??? */) = -1 EINVAL (Invalid argument)
prctl(PR_CAPBSET_READ, 0x2a /* CAP_??? */) = -1 EINVAL (Invalid argument)
prctl(PR_CAPBSET_READ, 0x29 /* CAP_??? */) = -1 EINVAL (Invalid argument)
futex(0x7fec3767e6bc, FUTEX_WAKE_PRIVATE, 2147483647) = 0
brk(NULL)                               = 0x5645b48fe000
brk(0x5645b4931000)                     = 0x5645b4931000
lseek(2, 0, SEEK_CUR)                   = -1 ESPIPE (Illegal seek)
fstat(2, {st_mode=S_IFCHR|0600, st_rdev=makedev(0xf7, 0x1), ...}) = 0
brk(0x5645b4952000)                     = 0x5645b4952000
brk(0x5645b4973000)                     = 0x5645b4973000
openat(AT_FDCWD, "/etc/lsp.exclude", O_RDONLY) = -1 ENOENT (No such file or directory)
uname({sysname="Linux", nodename="(none)", ...}) = 0
shmget(0xa5723213, 16384, IPC_CREAT|IPC_EXCL|0666) = -1 EEXIST (File exists)
shmget(0xa5723213, 16384, 000)          = 0
shmat(0, NULL, SHM_RDONLY)              = 0x7fec414ca000
rt_sigaction(SIGSEGV, {sa_handler=0x5645af38f34a, sa_mask=[], sa_flags=SA_RESTORER|SA_RESETHAND, sa_restorer=0x7fec3799b540}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {sa_handler=0x7fec379f10b0, sa_mask=[], sa_flags=SA_RESTORER|SA_ONSTACK|SA_RESTART|SA_SIGINFO, sa_restorer=0x7fec3799b540}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
mmap(NULL, 29888, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) = 0x7fec414c2000
madvise(0x7fec414c2000, 4096, MADV_GUARD_INSTALL) = 0
rt_sigprocmask(SIG_BLOCK, ~[], [], 8)   = 0
clone3({flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, child_tid=0x7fec414c8e50, parent_tid=0x7fec414c8e50, exit_signal=0, stack=0x7fec414c2000, stack_size=0x6000, tls=0x7fec414c8b80} => {parent_tid=[114]}, 88) = 114
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
futex(0x7fec37b6d164, FUTEX_WAKE_PRIVATE, 2147483647) = 0
timer_create(CLOCK_MONOTONIC, {sigev_value={sival_int=-1265235616, sival_ptr=0x5645b4960960}, sigev_signo=SIGRTMIN, sigev_notify=SIGEV_THREAD_ID, sigev_notify_thread_id=114}, [0]) = 0
add_key("asymmetric", "libbpf_session_key", "0\202\00300\202\2\30\240\3\2\1\2\2\24]HD\257\377\227\344q\271\355:E\275\231\31_\343"..., 820, KEY_SPEC_SESSION_KEYRING) = 325994835
openat(AT_FDCWD, "/proc/sys/net/core/bpf_jit_enable", O_RDONLY) = 3
read(3, "1", 1)                         = 1
close(3)                                = 0
openat(AT_FDCWD, "/sys/devices/system/cpu/possible", O_RDONLY|O_CLOEXEC) = 3
read(3, "0-1\n", 128)                   = 4
close(3)                                = 0
membarrier(MEMBARRIER_CMD_GLOBAL, 0)    = 0
delete_module("bpf_testmod", 0)         = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "bpf_testmod.ko", O_RDONLY) = 3
]3008;start=ff126f78-0796-4dc6-956f-04398a266a4b;user=;hostname=(none);machineid=1cdaf5cebfab41c8bca955e04060bc11;bootid=8254b42e-c5c7-48f5-bc17-fa49d2399b37;pid=83;type=shell;cwd=/\[?2004h[root@(none) /]# [    1.959758] bpf_testmod: loading out-of-tree module taints kernel.
[    1.960037] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
finit_module(3, "", 0)                  = 0
close(3)                                = 0
openat(AT_FDCWD, "/proc/self/ns/net", O_RDONLY) = 3
timer_settime(0, 0, {it_interval={tv_sec=0, tv_nsec=0}, it_value={tv_sec=10, tv_nsec=0}}, NULL) = 0
timer_settime(0, 0, {it_interval={tv_sec=0, tv_nsec=0}, it_value={tv_sec=10, tv_nsec=0}}, NULL) = 0
timer_settime(0, 0, {it_interval={tv_sec=0, tv_nsec=0}, it_value={tv_sec=10, tv_nsec=0}}, NULL) = 0
rt_sigprocmask(SIG_BLOCK, ~[], [], 8)   = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_DROPPABLE|MAP_ANONYMOUS, -1, 0) = 0x7fec414d0000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fec414c1000
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
getrandom("\x22\x5c\x2f\x55\x16\xb2\xd6\xc7\x71\x94\x19\xa3\x17\xd5\x2e\x1c\xd5\xc9\xdf\x1b\xcb\xab\x01\x2d\x94\x37\x66\xb9\x88\x0a\xcd\x9c", 32, 0) = 32
openat(AT_FDCWD, "/tmp/bpf_arg_parsing_test.Pf280c", O_RDWR|O_CREAT|O_EXCL, 0600) = 4
fcntl(4, F_GETFL)                       = 0x8002 (flags O_RDWR|O_LARGEFILE)
fstat(4, {st_mode=S_IFREG|0600, st_size=0, ...}) = 0
write(4, "# comment\n  test_with_spaces    "..., 175) = 175
openat(AT_FDCWD, "/tmp/bpf_arg_parsing_test.Pf280c", O_RDONLY) = 5
fstat(5, {st_mode=S_IFREG|0600, st_size=0, ...}) = 0
read(5, "", 8192)                       = 0
close(5)                                = 0
close(4)                                = 0
unlink("/tmp/bpf_arg_parsing_test.Pf280c") = 0
timer_settime(0, 0, {it_interval={tv_sec=0, tv_nsec=0}, it_value={tv_sec=0, tv_nsec=0}}, NULL) = 0
sched_setaffinity(0, 128, [0 1])        = 0
sched_setaffinity(113, 128, [0 1])      = 0
setns(3, CLONE_NEWNET)                  = 0
fstat(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(0xf7, 0x1), ...}) = 0
ioctl(1, TCGETS2, 0x7ffd7b575a60)       = -1 ENOTTY (Inappropriate ioctl for device)
close(3)                                = 0
membarrier(MEMBARRIER_CMD_GLOBAL, 0)    = 0
delete_module("bpf_testmod", 0)         = 0
shmdt(0x7fec414ca000)                   = 0
write(1, "#7/1     arg_parsing/test_parse_"..., 833#7/1     arg_parsing/test_parse_test_list:OK
test_parse_test_list_file:PASS:create tmp 0 nsec
test_parse_test_list_file:PASS:fdopen tmp 0 nsec
test_parse_test_list_file:PASS:prepare tmp 0 nsec
test_parse_test_list_file:PASS:parse file 0 nsec
test_parse_test_list_file:FAIL:test  count unexpected test  count: actual 0 != expected 4
#7/2     arg_parsing/test_parse_test_list_file:FAIL
#7       arg_parsing:FAIL

All error logs:
test_parse_test_list_file:PASS:create tmp 0 nsec
test_parse_test_list_file:PASS:fdopen tmp 0 nsec
test_parse_test_list_file:PASS:prepare tmp 0 nsec
test_parse_test_list_file:PASS:parse file 0 nsec
test_parse_test_list_file:FAIL:test  count unexpected test  count: actual 0 != expected 4
#7/2     arg_parsing/test_parse_test_list_file:FAIL
#7       arg_parsing:FAIL
Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
) = 833
exit_group(1)                           = ?
+++ exited with 1 +++
Command failed with exit code: 1

