Return-Path: <linux-kselftest+bounces-5578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C83D386BDD6
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC19B22D0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C082722098;
	Thu, 29 Feb 2024 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="os+zqjld"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2A2D042
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168504; cv=none; b=CrIlkD6k/2MKGpiELmnzXZKMeYWNAch+OBPhorxKQKqzzDlcozqbsrsHentz+vxLxXyKVkw3mb17Wr3+zFAkMnz6Oxt1jgCFGn8e/McaBAPqPqM0oABbhNJfoRQQjPt/FJzeLm393no7uT/aya2pXzseA/dzLO6VEXGT3ueOOKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168504; c=relaxed/simple;
	bh=QXNusurNjKAKL54cG15b5W5oqhi9D6TV7hcIlIsoqqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GLYpFIEvEAuNI/9eIkCh1lCeGKs2TAHT0LhN9yT7xFc27eGIZgTvCnJiUbPkfwjeXoUs/yhcI5kga+QKUHfoa4mjFZyRWzbW6UhUfRieO4Nbx5fvNbxU6lLRWoeuVuZxxDSTMdTHhfj3LB941F2o7+qVcOFwDGBX9Ka4fnl8+oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=os+zqjld; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d94b222a3aso4444755ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 17:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709168502; x=1709773302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HblTcnp394YnoDG8K1yJz0F3T1kb+qA3LFW6mA061oQ=;
        b=os+zqjldsSWwiU/24w3iL9Kv+XZUSTIw6tMb2C2rgbD1GMqL4JtjdZb79536ZYR3Ll
         2AbbI04WWZ2Whjktolo8nufQmh9BP4+/Uo7hAyTaVRdruVan77OWeR69oxfISFllxFfp
         IzRuNLJY0c6kus7frOTCwKzj5JHV/iVLZba4Zv8MYd8J5HqI/qhJd9RKAojxS42SmK5I
         Ae2FbVsBABoi0R4y8cEB6qQIEjKBQFqRbS+jdPxjmkWK+OllkeIsimV8J36mUqkdNDZW
         g1V5KpTzH40etgeWeLmgTLcqo7ZhlG4Ct8ZYxCxKst4hPkmu/VyFkmmkxZrJy5eoXtVo
         aZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168502; x=1709773302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HblTcnp394YnoDG8K1yJz0F3T1kb+qA3LFW6mA061oQ=;
        b=rctB225Q8deNILsYo6frcKK9CmwN4j6fx/XCTPjEEBIBk8bETeVE0jJohawpSAOgB+
         YiGe1ZWJlogu2VzmgdmNbpKG/q+bz8uFarcYUpGj8+xdxTsojFtblvLUgTzpxIfHsSDM
         CEn70bfhsFcePCZfdyBNgN9VBHhefrhnjv63Dt3bs8OgV+OSQ/2Mwywq61V9OYU9m9gH
         chzRY66JrWY3ONMSIwHSnUGu2FwYzUe6uSXukPqQRRpMwRpm2cYubZQ75TWB53gohXdN
         +4xCnAy0aB9Rm1/XWivVfUQBMl7UFOnsQFaeCHxq9VKrw44N1jXhv5zmYfWsdgr4yC80
         pMgw==
X-Forwarded-Encrypted: i=1; AJvYcCV/t8IAtIOWb/j21GRvoWJ/TmMJ92sb4T2ZF9jqhvuPz5//KXsa/2UonTXUJYJ/673ABwgIESDKYdpUwp8EKISj2mJ5jSHoHVVl5khlEPmJ
X-Gm-Message-State: AOJu0YzmdzoBGSvX9Pm6VElEnOehEcJ8El0S8h9Tm+fYl1WJJCrOkPn1
	Dx9f60YAaYAZuixpYhxYPdit0wLc24aAhxDxGsRJMjR/NqB3qNHzKmHWLv0g/k8=
X-Google-Smtp-Source: AGHT+IE3EoPGsdFclFvRDWfRYVZWWLAH0J8AC7cApC27AtlADtRH/eNCGj/wCsz/QpBzKLXQlYW82g==
X-Received: by 2002:a17:902:b717:b0:1da:eed:f25b with SMTP id d23-20020a170902b71700b001da0eedf25bmr501419pls.46.1709168501873;
        Wed, 28 Feb 2024 17:01:41 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001dc8d6a9d40sm78043plx.144.2024.02.28.17.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:01:41 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Icenowy Zheng <uwu@icenowy.me>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v4 00/15] RISC-V SBI v2.0 PMU improvements and Perf sampling in KVM guest
Date: Wed, 28 Feb 2024 17:01:15 -0800
Message-Id: <20240229010130.1380926-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

PATCH 1,6,7 : Generic cleanups/improvements.
PATCH 2,3,10 : FW_READ_HI function implementation
PATCH 4-5: Add PMU snapshot feature in sbi pmu driver
PATCH 6-7: KVM implementation for snapshot and sampling in kvm guests
PATCH 11-15: KVM selftests for SBI PMU extension

The series is based on kvm-next and is available at:

https://github.com/atishp04/linux/tree/kvm_pmu_snapshot_v4

The series is based on kvm-riscv/queue branch + fixes suggested on the following
series
https://patchwork.kernel.org/project/kvm/cover/cover.1705916069.git.haibo1.xu@intel.com/

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

Atish Patra (15):
RISC-V: Fix the typo in Scountovf CSR name
RISC-V: Add FIRMWARE_READ_HI definition
drivers/perf: riscv: Read upper bits of a firmware counter
RISC-V: Add SBI PMU snapshot definitions
drivers/perf: riscv: Implement SBI PMU snapshot function
RISC-V: KVM: No need to update the counter value during reset
RISC-V: KVM: No need to exit to the user space if perf event failed
RISC-V: KVM: Implement SBI PMU Snapshot feature
RISC-V: KVM: Add perf sampling support for guests
RISC-V: KVM: Support 64 bit firmware counters on RV32
KVM: riscv: selftests: Add Sscofpmf to get-reg-list test
KVM: riscv: selftests: Add SBI PMU extension definitions
KVM: riscv: selftests: Add SBI PMU selftest
KVM: riscv: selftests: Add a test for PMU snapshot functionality
KVM: riscv: selftests: Add a test for counter overflow

arch/riscv/include/asm/csr.h                  |   5 +-
arch/riscv/include/asm/errata_list.h          |   2 +-
arch/riscv/include/asm/kvm_vcpu_pmu.h         |  14 +-
arch/riscv/include/asm/sbi.h                  |  12 +
arch/riscv/include/uapi/asm/kvm.h             |   1 +
arch/riscv/kvm/aia.c                          |   5 +
arch/riscv/kvm/vcpu.c                         |  14 +-
arch/riscv/kvm/vcpu_onereg.c                  |   9 +-
arch/riscv/kvm/vcpu_pmu.c                     | 247 +++++++-
arch/riscv/kvm/vcpu_sbi_pmu.c                 |  15 +-
drivers/perf/riscv_pmu.c                      |   1 +
drivers/perf/riscv_pmu_sbi.c                  | 229 ++++++-
include/linux/perf/riscv_pmu.h                |   6 +
tools/testing/selftests/kvm/Makefile          |   1 +
.../selftests/kvm/include/riscv/processor.h   |  92 +++
.../selftests/kvm/lib/riscv/processor.c       |  12 +
.../selftests/kvm/riscv/get-reg-list.c        |   4 +
tools/testing/selftests/kvm/riscv/sbi_pmu.c   | 588 ++++++++++++++++++
18 files changed, 1212 insertions(+), 45 deletions(-)
create mode 100644 tools/testing/selftests/kvm/riscv/sbi_pmu.c

--
2.34.1


