Return-Path: <linux-kselftest+bounces-8224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2F28A75F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 22:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294021C2158E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 20:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4004502E;
	Tue, 16 Apr 2024 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="ZrynteBL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B80A44377
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300872; cv=none; b=ZMtGHIzMaqU3YPOcy76muY2KFsF3UEmzBF08Pz56wP/iZ/XbzeNehuV8jETuABi6gw0tgrG55SZEF0Wo3JJF8v6na0LD2VQ4Wi6HOy2OybFEPa43GQqM0YF/qqTs4ocZZ5HktGOfJ4bEaTq7ojhe4hYUp0sjXckKJAjAualakCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300872; c=relaxed/simple;
	bh=rk9/WMK6rg2PuJHP1LdCdlQ+ZmZ8HS3n1dyaptPd+9E=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=dA+FE+79UzQDcKAxVVbjTyv9fOOUsQppbLvUkuG3ssa+QpW3RCJVJ69yvR2QEt/S3UrM83s9nfyXmRfY/huzI2dS/9vJO1HniPduRjQ0T6tQlUIzSn/DiITjH1it68DOJS8wmeTVNxrovPFa9fO2hD9fntDYfMFPDeLgR6wfydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=ZrynteBL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso3392616a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1713300869; x=1713905669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSH0oKR3vMqxy1mrb/RHsaXrIsB5nauYz3qJ8CX17MI=;
        b=ZrynteBLxK9G+pqflD5Q+f4j+EeUhGNMEGX5uTAfTLQQyqagMwETyXQEflToVI518j
         QjqWNWqEBg7IlaOfYIeR7YzHUZNs9CpyF/VBopjBF5NimwRdGBSgOzR3lbkvjKHflcBt
         46mmEYkQtPELJK9+DxWgOGIsD32nquYcMM9taT9dyLa18vXkh1//yTk3RB/Y0hnqnHU1
         yz/gXGtSX3LDZ6NLcJLKWfq0Xe+EXJyzNHXkNQGMncT3EhQZs1sHOpovoyoLm0+RgUbU
         dkHWu/7HvHhcdJWDCNYIDtqoKSR9y03EvQvqHMSQed/jYLfLnjCpowbgShLTl26H6YVL
         cmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713300869; x=1713905669;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSH0oKR3vMqxy1mrb/RHsaXrIsB5nauYz3qJ8CX17MI=;
        b=HI0MQv6p/XumoZv+Ow69ImftnLJp1XfLIxJiAnfjk8Uy1Csa3Mu74oXHtssC8R1+oi
         glNjGkImA3LC8ZLIQNIctyGJd/tcukRgyB8A4ucPa1BZd0JHadXkRfYP06L0DrEg1shM
         JhuhRisEM90b19Q03ZtZiipODWiFPs1FqowIA/F+t4Wj/H2iFFiFkLc8hVcBszmZ0gw2
         qhKdAOG0MEMEFuj3XzJedjcsCMe3SU0czSon7owFwsnlR3jW7HRo6Jxc6aWg/757jQwM
         8EMI3LI4j5nnekn23Jx4KH6M5rmvZ9v9+NGvZKC4iLZGlObu+HWQoDKHei/9cyfXtkEp
         byGw==
X-Forwarded-Encrypted: i=1; AJvYcCUOcfPfv64azmC6m5Bv9FB+epha7rpQ6C2pGjYdkW5f8Y/ypNQp1RExgsIHczuIj8YJvoL2AeVtdJQJrEeR9TazgP0HNV3jYAsorl1ZOnwY
X-Gm-Message-State: AOJu0Yy3bVdwRxYktVvkp/DxwiJR3aDpnwLElDBa5hC5HBtwiC9CSK8+
	SsSIRAu38Jc7ua/ujIsHP3DwbzWeUM1sDodQOkYbQroIz5yAK9SLBJIPIrM9m4E=
X-Google-Smtp-Source: AGHT+IEaoFFX6WKh90/e6oL2zfKnlJjY8MbSC7LBgPoSZpaJ91GSoA8Wk3SBjtokrGWQGTcakUOoSA==
X-Received: by 2002:a05:6a21:3286:b0:1a9:7ad8:79f with SMTP id yt6-20020a056a21328600b001a97ad8079fmr14768410pzb.13.1713300869049;
        Tue, 16 Apr 2024 13:54:29 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id r4-20020a056a00216400b006edd05e3751sm9680856pff.176.2024.04.16.13.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 13:54:28 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:54:28 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Apr 2024 13:54:21 PDT (-0700)
Subject:     Re: [PATCH v7 00/24] RISC-V SBI v2.0 PMU improvements and Perf sampling in KVM guest
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
CC: linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
  ajay.kaher@broadcom.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com, ajones@ventanamicro.com,
  anup@brainfault.org, Conor Dooley <conor.dooley@microchip.com>, jgross@suse.com,
  kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
  linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, pbonzini@redhat.com,
  Paul Walmsley <paul.walmsley@sifive.com>, shuah@kernel.org, virtualization@lists.linux.dev,
  Will Deacon <will@kernel.org>, x86@kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Atish Patra <atishp@rivosinc.com>
Message-ID: <mhng-5383b817-4803-47fa-9076-e8a1c8044bc3@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 16 Apr 2024 11:43:57 PDT (-0700), Atish Patra wrote:
> This series implements SBI PMU improvements done in SBI v2.0[1] i.e. PMU snapshot
> and fw_read_hi() functions.
>
> SBI v2.0 introduced PMU snapshot feature which allows the SBI implementation
> to provide counter information (i.e. values/overflow status) via a shared
> memory between the SBI implementation and supervisor OS. This allows to minimize
> the number of traps in when perf being used inside a kvm guest as it relies on
> SBI PMU + trap/emulation of the counters.
>
> The current set of ratified RISC-V specification also doesn't allow scountovf
> to be trap/emulated by the hypervisor. The SBI PMU snapshot bridges the gap
> in ISA as well and enables perf sampling in the guest. However, LCOFI in the
> guest only works via IRQ filtering in AIA specification. That's why, AIA
> has to be enabled in the hardware (at least the Ssaia extension) in order to
> use the sampling support in the perf.
>
> Here are the patch wise implementation details.
>
> PATCH 1,4,7,8,9,10,11,15 : Generic cleanups/improvements.
> PATCH 2,3,14 : FW_READ_HI function implementation
> PATCH 5-6: Add PMU snapshot feature in sbi pmu driver
> PATCH 12-13: KVM implementation for snapshot and sampling in kvm guests
> PATCH 16-17: Generic improvements for kvm selftests
> PATCH 18-22: KVM selftests for SBI PMU extension
>
> The series is based on v6.9-rc4 and is available at:
>
> https://github.com/atishp04/linux/tree/kvm_pmu_snapshot_v7
>
> The kvmtool patch is also available at:
> https://github.com/atishp04/kvmtool/tree/sscofpmf
>
> It also requires Ssaia ISA extension to be present in the hardware in order to
> get perf sampling support in the guest. In Qemu virt machine, it can be done
> by the following config.
>
> ```
> -cpu rv64,sscofpmf=true,x-ssaia=true
> ```
>
> There is no other dependencies on AIA apart from that. Thus, Ssaia must be disabled
> for the guest if AIA patches are not available. Here is the example command.
>
> ```
> ./lkvm-static run -m 256 -c2 --console serial -p "console=ttyS0 earlycon" --disable-ssaia -k ./Image --debug
> ```
>
> The series has been tested only in Qemu.
> Here is the snippet of the perf running inside a kvm guest.
>
> ===================================================
> $ perf record -e cycles -e instructions perf bench sched messaging -g 5
> ...
> $ Running 'sched/messaging' benchmark:
> ...
> [   45.928723] perf_duration_warn: 2 callbacks suppressed
> [   45.929000] perf: interrupt took too long (484426 > 483186), lowering kernel.perf_event_max_sample_rate to 250
> $ 20 sender and receiver processes per group
> $ 5 groups == 200 processes run
>
>      Total time: 14.220 [sec]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.117 MB perf.data (1942 samples) ]
> $ perf report --stdio
> $ To display the perf.data header info, please use --header/--header-only optio>
> $
> $
> $ Total Lost Samples: 0
> $
> $ Samples: 943  of event 'cycles'
> $ Event count (approx.): 5128976844
> $
> $ Overhead  Command          Shared Object                Symbol               >
> $ ........  ...............  ...........................  .....................>
> $
>      7.59%  sched-messaging  [kernel.kallsyms]            [k] memcpy
>      5.48%  sched-messaging  [kernel.kallsyms]            [k] percpu_counter_ad>
>      5.24%  sched-messaging  [kernel.kallsyms]            [k] __sbi_rfence_v02_>
>      4.00%  sched-messaging  [kernel.kallsyms]            [k] _raw_spin_unlock_>
>      3.79%  sched-messaging  [kernel.kallsyms]            [k] set_pte_range
>      3.72%  sched-messaging  [kernel.kallsyms]            [k] next_uptodate_fol>
>      3.46%  sched-messaging  [kernel.kallsyms]            [k] filemap_map_pages
>      3.31%  sched-messaging  [kernel.kallsyms]            [k] handle_mm_fault
>      3.20%  sched-messaging  [kernel.kallsyms]            [k] finish_task_switc>
>      3.16%  sched-messaging  [kernel.kallsyms]            [k] clear_page
>      3.03%  sched-messaging  [kernel.kallsyms]            [k] mtree_range_walk
>      2.42%  sched-messaging  [kernel.kallsyms]            [k] flush_icache_pte
>
> ===================================================
>
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc
>
> Changes from v6->v7:
> 1. Used SBI_SHMEM_DISABLE in the driver.
> 2. Added RB Tags.
> 3. Improved the sbi_pmu_test commandline to allow disabling multiple
>    tests.
>
> Changes from v5->v6:
> 1. Added a patch for command line option for the sbi pmu tests.
> 2. Removed redundant prints and restructure the code little bit.
> 3. Added a patch for computing the sbi minor version correctly.
> 4. Addressed all other comments on v5.
>
> Changes from v4->v5:
> 1. Moved sbi related definitions to its own header file from processor.h
> 2. Added few helper functions for selftests.
> 3. Improved firmware counter read and RV32 start/stop functions.
> 4. Converted all the shifting operations to use BIT macro
> 5. Addressed all other comments on v4.
>
> Changes from v3->v4:
> 1. Added selftests.
> 2. Fixed an issue to clear the interrupt pending bits.
> 3. Fixed the counter index in snapshot memory start function.
>
> Changes from v2->v3:
> 1. Fixed a patchwork warning on patch6.
> 2. Fixed a comment formatting & nit fix in PATCH 3 & 5.
> 3. Moved the hvien update and sscofpmf enabling to PATCH 9 from PATCH 8.
>
> Changes from v1->v2:
> 1. Fixed warning/errors from patchwork CI.
> 2. Rebased on top of kvm-next.
> 3. Added Acked-by tags.
>
> Changes from RFC->v1:
> 1. Addressed all the comments on RFC series.
> 2. Removed PATCH2 and merged into later patches.
> 3. Added 2 more patches for minor fixes.
> 4. Fixed KVM boot issue without Ssaia and made sscofpmf in guest dependent on
>    Ssaia in the host.
>
> Atish Patra (24):
> RISC-V: Fix the typo in Scountovf CSR name
> RISC-V: Add FIRMWARE_READ_HI definition
> drivers/perf: riscv: Read upper bits of a firmware counter
> drivers/perf: riscv: Use BIT macro for shifting operations
> RISC-V: Add SBI PMU snapshot definitions
> RISC-V: KVM: Rename the SBI_STA_SHMEM_DISABLE to a generic name
> RISC-V: Use the minor version mask while computing sbi version
> drivers/perf: riscv: Implement SBI PMU snapshot function
> drivers/perf: riscv: Fix counter mask iteration for RV32
> RISC-V: KVM: Fix the initial sample period value
> RISC-V: KVM: No need to update the counter value during reset
> RISC-V: KVM: No need to exit to the user space if perf event failed
> RISC-V: KVM: Implement SBI PMU Snapshot feature
> RISC-V: KVM: Add perf sampling support for guests
> RISC-V: KVM: Support 64 bit firmware counters on RV32
> RISC-V: KVM: Improve firmware counter read function
> KVM: riscv: selftests: Move sbi definitions to its own header file
> KVM: riscv: selftests: Add helper functions for extension checks
> KVM: riscv: selftests: Add Sscofpmf to get-reg-list test
> KVM: riscv: selftests: Add SBI PMU extension definitions
> KVM: riscv: selftests: Add SBI PMU selftest
> KVM: riscv: selftests: Add a test for PMU snapshot functionality
> KVM: riscv: selftests: Add a test for counter overflow
> KVM: riscv: selftests: Add commandline option for SBI PMU test
>
> arch/riscv/include/asm/csr.h                  |   5 +-
> arch/riscv/include/asm/kvm_vcpu_pmu.h         |  16 +-
> arch/riscv/include/asm/sbi.h                  |  38 +-
> arch/riscv/include/uapi/asm/kvm.h             |   1 +
> arch/riscv/kernel/paravirt.c                  |   6 +-
> arch/riscv/kvm/aia.c                          |   5 +
> arch/riscv/kvm/vcpu.c                         |  15 +-
> arch/riscv/kvm/vcpu_onereg.c                  |   6 +
> arch/riscv/kvm/vcpu_pmu.c                     | 260 ++++++-
> arch/riscv/kvm/vcpu_sbi_pmu.c                 |  17 +-
> arch/riscv/kvm/vcpu_sbi_sta.c                 |   4 +-
> drivers/perf/riscv_pmu.c                      |   1 +
> drivers/perf/riscv_pmu_sbi.c                  | 272 ++++++-
> include/linux/perf/riscv_pmu.h                |   6 +
> tools/testing/selftests/kvm/Makefile          |   1 +
> .../selftests/kvm/include/riscv/processor.h   |  49 +-
> .../testing/selftests/kvm/include/riscv/sbi.h | 141 ++++
> .../selftests/kvm/include/riscv/ucall.h       |   1 +
> .../selftests/kvm/lib/riscv/processor.c       |  12 +
> .../testing/selftests/kvm/riscv/arch_timer.c  |   2 +-
> .../selftests/kvm/riscv/get-reg-list.c        |   4 +
> .../selftests/kvm/riscv/sbi_pmu_test.c        | 681 ++++++++++++++++++
> tools/testing/selftests/kvm/steal_time.c      |   4 +-
> 23 files changed, 1433 insertions(+), 114 deletions(-)
> create mode 100644 tools/testing/selftests/kvm/include/riscv/sbi.h
> create mode 100644 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

I assume you guys want to take this through the riscv-kvm tree?  That's 
fine with me, just LMK if you want to do a shared tag or something as we 
might end up with merge conflicts since it touches so many little 
things.

