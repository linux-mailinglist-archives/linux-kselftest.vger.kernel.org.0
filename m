Return-Path: <linux-kselftest+bounces-8484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E28168AB78C
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EE4281A6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC15A13D896;
	Fri, 19 Apr 2024 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="c1TuaXgS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1913D88F
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570466; cv=none; b=qnRpzl0ftWwvZPIyczXygZbtJ/pkOyaz4PakScXb4ECnpO2T372CraIrBcs8wrxdwEOO2RtmJcaVzAvhD7fb9KQbAjmfSLjt2fXNwsfoFAwnhVUPfAJdUgyMsbXcJeJRupSIZCVAyQvqGMSlh6PBSfwJutcI9guZDlYJFbQqOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570466; c=relaxed/simple;
	bh=3Zn4HkEJhtgFUJ0SWlPYq1awARVTAgZxke2O0S2IZcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N+FZVXF3K8ruHzIHlm9cA9o2m24w5gXwUKj29UKsgj6xWXcP6F9ynkr4gsqKuVRLaQN1fEE+c1vr4o1TcjU1kpF73sUDiKxd4M5S4OTFps1zttNzxA6rwDYsQ6YRzvCZPE5CmHC598V9krKtxItpGEqf+/SZ5mpHu6FfynlR21E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=c1TuaXgS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e2bbc2048eso22759935ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570464; x=1714175264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IzaB9st3cascud7CCOjToOIM1+WmFI5tBLPZbxENCL0=;
        b=c1TuaXgSzvMUYhM0aQfTUKgVY+iTw30LWhw8lUEPOWK2frHtVGNVXEWFe9M3uCYnmy
         hatMErl8hUTYJftfyG+jwxqILseGWDSOIK0wImyTUpX7FW6lo/h8gRnLfRmGtkEfxWRI
         Hgbkm6Y2SQZknH5jQN+y9utsx1qYPkDbDtDh38FElr3N4DeV7/88K/JONB5acBeTPhJA
         clYotmTBEcS5sUBmcqv6fUXZcGOW2D7uAoa4e87hPNeEcIH300laUFD0LdvJVTr2zIXq
         gddc/VBLI8bNAwhdAuirsuJLnmu5DVuOPBo0oWHB2L4hDczcF5NWoQMgao0G1uRst7sM
         f1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570464; x=1714175264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzaB9st3cascud7CCOjToOIM1+WmFI5tBLPZbxENCL0=;
        b=K1+hcklWvcAlVVpVV1zyL1rLWwbfluU8uJunYDnx4+hOro9m4c+aG/KYMS4Hmf2Wm6
         l4tUWyhHUF/tIMWXfxyExvOjbsQ9Jv3j+6QROOXbastfFz6k/98W6ELZIISMy3wU7oe/
         u+cbKWQfF3RQC28PmNs6tSZp6OJEQNhFpKm/1a1shG4s4Db3/et9Ml2WmMg+1a5LexOf
         xTX5ULdj4a+3HXn1AMMi2R+iUYhR7sXQ9hy7BfDCUhWyp4ifRzMPxKBWxj1+EBFzLeCz
         TpDnUPQQbl5H7kYuf3SrvB5rSuUMfB8Kgx7goGTeFrThrc3Kfh0HKQXWKvDc9x0NQI8n
         0EWg==
X-Forwarded-Encrypted: i=1; AJvYcCXZSh1y65OzBjmfN4DFmeEbFbViyssrNyZgOczmlo8DB4tTZFGLRtomefGiIyvVXflp2Xj9Lh0cRCToDwiEW8914hUSgxDlHKxlR2VphYRB
X-Gm-Message-State: AOJu0YyDIQyv7NyJrhpKtAEHuqtml0hTvRAsZEVaFEk/D5FbBWoivFYq
	1cC9pNXCho9o8ZT4oCwlKYyIPifx5vgd+hQJ/7x1HK8Lu6WAesX6jStVolezAw0=
X-Google-Smtp-Source: AGHT+IF/y+aOm/HBwIYKFW0r+Cx1DkitScqMAK3OsUhT+f7GJ7yy/Ulu5NdR5WE9Q+D2RzAVuxG1Gg==
X-Received: by 2002:a17:902:da83:b0:1e5:4f00:3754 with SMTP id j3-20020a170902da8300b001e54f003754mr4675193plx.8.1713570464325;
        Fri, 19 Apr 2024 16:47:44 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:43 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	samuel.holland@sifive.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v8 00/24] RISC-V SBI v2.0 PMU improvements and Perf sampling in KVM guest
Date: Sat, 20 Apr 2024 08:17:16 -0700
Message-Id: <20240420151741.962500-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series implements SBI PMU improvements done in SBI v2.0[1] i.e. PMU snapshot
and fw_read_hi() functions. 

SBI v2.0 introduced PMU snapshot feature which allows the SBI implementation
to provide counter information (i.e. values/overflow status) via a shared
memory between the SBI implementation and supervisor OS. This allows to minimize
the number of traps in when perf being used inside a kvm guest as it relies on
SBI PMU + trap/emulation of the counters. 

The current set of ratified RISC-V specification also doesn't allow scountovf
to be trap/emulated by the hypervisor. The SBI PMU snapshot bridges the gap
in ISA as well and enables perf sampling in the guest. However, LCOFI in the
guest only works via IRQ filtering in AIA specification. That's why, AIA
has to be enabled in the hardware (at least the Ssaia extension) in order to
use the sampling support in the perf. 

Here are the patch wise implementation details.

PATCH 1,4,7,8,9,10,11,15 : Generic cleanups/improvements.
PATCH 2,3,14 : FW_READ_HI function implementation
PATCH 5-6: Add PMU snapshot feature in sbi pmu driver
PATCH 12-13: KVM implementation for snapshot and sampling in kvm guests
PATCH 16-17: Generic improvements for kvm selftests 
PATCH 18-22: KVM selftests for SBI PMU extension

The series is based on v6.9-rc4 and is available at:

https://github.com/atishp04/linux/tree/kvm_pmu_snapshot_v8

The kvmtool patch is also available at:
https://github.com/atishp04/kvmtool/tree/sscofpmf

It also requires Ssaia ISA extension to be present in the hardware in order to
get perf sampling support in the guest. In Qemu virt machine, it can be done
by the following config.

```
-cpu rv64,sscofpmf=true,x-ssaia=true
```

There is no other dependencies on AIA apart from that. Thus, Ssaia must be disabled
for the guest if AIA patches are not available. Here is the example command.

```
./lkvm-static run -m 256 -c2 --console serial -p "console=ttyS0 earlycon" --disable-ssaia -k ./Image --debug 
```

The series has been tested only in Qemu.
Here is the snippet of the perf running inside a kvm guest.

===================================================
$ perf record -e cycles -e instructions perf bench sched messaging -g 5
...
$ Running 'sched/messaging' benchmark:
...
[   45.928723] perf_duration_warn: 2 callbacks suppressed
[   45.929000] perf: interrupt took too long (484426 > 483186), lowering kernel.perf_event_max_sample_rate to 250
$ 20 sender and receiver processes per group
$ 5 groups == 200 processes run

     Total time: 14.220 [sec]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.117 MB perf.data (1942 samples) ]
$ perf report --stdio
$ To display the perf.data header info, please use --header/--header-only optio>
$
$
$ Total Lost Samples: 0
$
$ Samples: 943  of event 'cycles'
$ Event count (approx.): 5128976844
$
$ Overhead  Command          Shared Object                Symbol               >
$ ........  ...............  ...........................  .....................>
$
     7.59%  sched-messaging  [kernel.kallsyms]            [k] memcpy
     5.48%  sched-messaging  [kernel.kallsyms]            [k] percpu_counter_ad>
     5.24%  sched-messaging  [kernel.kallsyms]            [k] __sbi_rfence_v02_>
     4.00%  sched-messaging  [kernel.kallsyms]            [k] _raw_spin_unlock_>
     3.79%  sched-messaging  [kernel.kallsyms]            [k] set_pte_range
     3.72%  sched-messaging  [kernel.kallsyms]            [k] next_uptodate_fol>
     3.46%  sched-messaging  [kernel.kallsyms]            [k] filemap_map_pages
     3.31%  sched-messaging  [kernel.kallsyms]            [k] handle_mm_fault
     3.20%  sched-messaging  [kernel.kallsyms]            [k] finish_task_switc>
     3.16%  sched-messaging  [kernel.kallsyms]            [k] clear_page
     3.03%  sched-messaging  [kernel.kallsyms]            [k] mtree_range_walk
     2.42%  sched-messaging  [kernel.kallsyms]            [k] flush_icache_pte

===================================================

[1] https://github.com/riscv-non-isa/riscv-sbi-doc

Changes from v7->v8:
1. Updated event states so that shared memory is updated only during stop
   operations.
2. Avoid clobbering lower XLEN counter/overflow values in shared memory
   by maintaining a temporary copy for RV32.
3. Improved overflow handling in snapshot case by supporting all 64 values.
4. Minor cleanups based on suggestions on v7.

Changes from v6->v7:
1. Used SBI_SHMEM_DISABLE in the driver.
2. Added RB Tags.
3. Improved the sbi_pmu_test commandline to allow disabling multiple
   tests.

Changes from v5->v6:
1. Added a patch for command line option for the sbi pmu tests.
2. Removed redundant prints and restructure the code little bit.
3. Added a patch for computing the sbi minor version correctly.
4. Addressed all other comments on v5.  

Changes from v4->v5:
1. Moved sbi related definitions to its own header file from processor.h
2. Added few helper functions for selftests.
3. Improved firmware counter read and RV32 start/stop functions.
4. Converted all the shifting operations to use BIT macro
5. Addressed all other comments on v4.  

Changes from v3->v4:
1. Added selftests.
2. Fixed an issue to clear the interrupt pending bits.
3. Fixed the counter index in snapshot memory start function.

Changes from v2->v3:
1. Fixed a patchwork warning on patch6.
2. Fixed a comment formatting & nit fix in PATCH 3 & 5.
3. Moved the hvien update and sscofpmf enabling to PATCH 9 from PATCH 8.

Changes from v1->v2:
1. Fixed warning/errors from patchwork CI.
2. Rebased on top of kvm-next.
3. Added Acked-by tags.

Changes from RFC->v1:
1. Addressed all the comments on RFC series.
2. Removed PATCH2 and merged into later patches.
3. Added 2 more patches for minor fixes.
4. Fixed KVM boot issue without Ssaia and made sscofpmf in guest dependent on
   Ssaia in the host.

Atish Patra (24):
RISC-V: Fix the typo in Scountovf CSR name
RISC-V: Add FIRMWARE_READ_HI definition
drivers/perf: riscv: Read upper bits of a firmware counter
drivers/perf: riscv: Use BIT macro for shifting operations
RISC-V: Add SBI PMU snapshot definitions
RISC-V: KVM: Rename the SBI_STA_SHMEM_DISABLE to a generic name
RISC-V: Use the minor version mask while computing sbi version
drivers/perf: riscv: Fix counter mask iteration for RV32
drivers/perf: riscv: Implement SBI PMU snapshot function
RISC-V: KVM: Fix the initial sample period value
RISC-V: KVM: No need to update the counter value during reset
RISC-V: KVM: No need to exit to the user space if perf event failed
RISC-V: KVM: Implement SBI PMU Snapshot feature
RISC-V: KVM: Add perf sampling support for guests
RISC-V: KVM: Support 64 bit firmware counters on RV32
RISC-V: KVM: Improve firmware counter read function
KVM: riscv: selftests: Move sbi definitions to its own header file
KVM: riscv: selftests: Add helper functions for extension checks
KVM: riscv: selftests: Add Sscofpmf to get-reg-list test
KVM: riscv: selftests: Add SBI PMU extension definitions
KVM: riscv: selftests: Add SBI PMU selftest
KVM: riscv: selftests: Add a test for PMU snapshot functionality
KVM: riscv: selftests: Add a test for counter overflow
KVM: riscv: selftests: Add commandline option for SBI PMU test

arch/riscv/include/asm/csr.h                  |   5 +-
arch/riscv/include/asm/kvm_vcpu_pmu.h         |  16 +-
arch/riscv/include/asm/sbi.h                  |  38 +-
arch/riscv/include/uapi/asm/kvm.h             |   1 +
arch/riscv/kernel/paravirt.c                  |   6 +-
arch/riscv/kvm/aia.c                          |   5 +
arch/riscv/kvm/vcpu.c                         |  15 +-
arch/riscv/kvm/vcpu_onereg.c                  |   6 +
arch/riscv/kvm/vcpu_pmu.c                     | 260 ++++++-
arch/riscv/kvm/vcpu_sbi_pmu.c                 |  17 +-
arch/riscv/kvm/vcpu_sbi_sta.c                 |   4 +-
drivers/perf/riscv_pmu.c                      |   1 +
drivers/perf/riscv_pmu_sbi.c                  | 309 +++++++-
include/linux/perf/riscv_pmu.h                |   6 +
tools/testing/selftests/kvm/Makefile          |   1 +
.../selftests/kvm/include/riscv/processor.h   |  49 +-
.../testing/selftests/kvm/include/riscv/sbi.h | 141 ++++
.../selftests/kvm/include/riscv/ucall.h       |   1 +
.../selftests/kvm/lib/riscv/processor.c       |  12 +
.../testing/selftests/kvm/riscv/arch_timer.c  |   2 +-
.../selftests/kvm/riscv/get-reg-list.c        |   4 +
.../selftests/kvm/riscv/sbi_pmu_test.c        | 681 ++++++++++++++++++
tools/testing/selftests/kvm/steal_time.c      |   4 +-
23 files changed, 1467 insertions(+), 117 deletions(-)
create mode 100644 tools/testing/selftests/kvm/include/riscv/sbi.h
create mode 100644 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c

--
2.34.1


