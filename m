Return-Path: <linux-kselftest+bounces-7048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BD589677F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 10:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B641C25397
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 08:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEA76CDCE;
	Wed,  3 Apr 2024 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="T7Epe/YM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C535D8F8
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131515; cv=none; b=kc33XS+OOQM1cxMb44WteN2BQ624FEk2r1ptDB97DxBKMje1lscL3a17XmxV+oDzVTKUn+vTEqf4E/hrcwV5fOe2YnfFvoafE+76wrGHbHexgNFaE0jPBfwofLpy09sREGlAIUullhFm7QKVBmXiTIc9DMnFvTY+tmxF9n4ahCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131515; c=relaxed/simple;
	bh=V6pWE+96UO493TiPghyBvZcvg04rmp3y2LRzhDXgmRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SCTSCKrxOBpPdHqrHCvERderaWIWLDhNEgNneWXHL2F6GBVM5xXj2uKpuXtJ9ArHeRkh27T51S9Dw2XK8VBFn8dn5Gd/F6Edxmrn/ToO/0s8NRyc9SmEa7gVIWSvTzSUMBSv45z67ZERvcpacIOD+A24Ua9sS0MDy8/7wRYnxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=T7Epe/YM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1def89f0cfdso5304475ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131512; x=1712736312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BAQb6AgU0TNkegozu248Es6j4yjx/+ZT77t1PbS0odQ=;
        b=T7Epe/YM1vsa6vWpkmUTav7NJe9CTysK/mV9L5R0sQ3HK0CV1t2Ryt9H3izNg8MvGu
         FDhz5oUavXuypxCdcWWVjGztYeXb5mlT2REsqNCcjjl6eHlqslHEcS7BUNLmnqRsKi5b
         GL1JLxkekfTmdbYtBxfwKqq/mUJGqCXtuWxlR89Wdgkwla9ofqWEUtM0Gp8JUyas2MrM
         rzuk3ZLGxAvErZqTHFooOkFeUvH0+hXFXfSvSzPxlBB9fitqdiHfwyUo855XlaqhyNdy
         d6gxBEZc05x6RWBZq7w/FowO4FhbqkLKtT5hPs/Pb11a7frH76/jQtKRNpobjSWtF48+
         fQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131512; x=1712736312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAQb6AgU0TNkegozu248Es6j4yjx/+ZT77t1PbS0odQ=;
        b=EgNnLp8w+fymiy79FSdfjWYgGE6ukwfk/5hqfs64tGiWzVfwd/3fszX8xOM/vtXdrz
         b8FEERmeWdkrbvgv/TS66HQ1zP6gRJxgAGIvc372QCRnNHCQySCDdjO9U9sXdanxJ6te
         odhMWHCX/BThFdwOFIPyZoWLIyLbPoUljjfYZB66yuo7G2dOvSc+V7t67w8AdEb2mCgA
         BE+6TGiC0cvTaeiAlh6M3TqDG5ITLLhmJrAET2h5BRSjHeDmPOJBXFPc3nTbOQducTRy
         6RBwpsV2VCvYZAgmbPKVcGPLpoLZtZj1fhGvzzJM4AKc4daCogGGwC0e0TBdIpziFycD
         +nFg==
X-Forwarded-Encrypted: i=1; AJvYcCUCPIZYexB/kcrCP3OQdl2mU+N02FhM9KDK7qJDgnOL0pnobWDpPxFqb7oQefbvcULCk6Fv7dIgymhjZF8GTRQUcharQt9VF1Fm0QLz0Wnb
X-Gm-Message-State: AOJu0YymYa523wHqBUFdK8/iMbOqgBLLKZwJsScrpCoPN1xA7gn2QsZA
	iLpnFs2W0pwg1uTmajw5VNTpLpUtKAr3jWkqpUb1u5OdoOM7u+OdTpmyqP+XUvM=
X-Google-Smtp-Source: AGHT+IH1ObGbJnOylUIYtPaKxPQX/e31jRX6757UC1CCyrEGxin9M/CZPd6LYiKaCl4kIApu3re5ig==
X-Received: by 2002:a17:902:d48d:b0:1de:f571:837c with SMTP id c13-20020a170902d48d00b001def571837cmr2453328plg.28.1712131512011;
        Wed, 03 Apr 2024 01:05:12 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:11 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
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
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v5 00/22] RISC-V SBI v2.0 PMU improvements and Perf sampling in KVM guest
Date: Wed,  3 Apr 2024 01:04:29 -0700
Message-Id: <20240403080452.1007601-1-atishp@rivosinc.com>
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

The series is based on v6.9-rc1 and is available at:

https://github.com/atishp04/linux/tree/kvm_pmu_snapshot_v5

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

Atish Patra (22):
RISC-V: Fix the typo in Scountovf CSR name
RISC-V: Add FIRMWARE_READ_HI definition
drivers/perf: riscv: Read upper bits of a firmware counter
drivers/perf: riscv: Use BIT macro for shifting operations
RISC-V: Add SBI PMU snapshot definitions
drivers/perf: riscv: Implement SBI PMU snapshot function
drivers/perf: riscv: Fix counter mask iteration for RV32
RISC-V: KVM: Fix the initial sample period value
RISC-V: KVM: Rename the SBI_STA_SHMEM_DISABLE to a generic name
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

arch/riscv/include/asm/csr.h                  |   5 +-
arch/riscv/include/asm/kvm_vcpu_pmu.h         |  16 +-
arch/riscv/include/asm/sbi.h                  |  34 +-
arch/riscv/include/uapi/asm/kvm.h             |   1 +
arch/riscv/kernel/paravirt.c                  |   6 +-
arch/riscv/kvm/aia.c                          |   5 +
arch/riscv/kvm/vcpu.c                         |  15 +-
arch/riscv/kvm/vcpu_onereg.c                  |   5 +
arch/riscv/kvm/vcpu_pmu.c                     | 260 +++++++-
arch/riscv/kvm/vcpu_sbi_pmu.c                 |  17 +-
arch/riscv/kvm/vcpu_sbi_sta.c                 |   4 +-
drivers/perf/riscv_pmu.c                      |   1 +
drivers/perf/riscv_pmu_sbi.c                  | 264 +++++++-
include/linux/perf/riscv_pmu.h                |   6 +
tools/testing/selftests/kvm/Makefile          |   1 +
.../selftests/kvm/include/riscv/processor.h   |  49 +-
.../testing/selftests/kvm/include/riscv/sbi.h | 141 +++++
.../selftests/kvm/include/riscv/ucall.h       |   1 +
.../selftests/kvm/lib/riscv/processor.c       |  12 +
.../testing/selftests/kvm/riscv/arch_timer.c  |   2 +-
.../selftests/kvm/riscv/get-reg-list.c        |   4 +
.../selftests/kvm/riscv/sbi_pmu_test.c        | 581 ++++++++++++++++++
tools/testing/selftests/kvm/steal_time.c      |   4 +-
23 files changed, 1322 insertions(+), 112 deletions(-)
create mode 100644 tools/testing/selftests/kvm/include/riscv/sbi.h
create mode 100644 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c

--
2.34.1


