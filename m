Return-Path: <linux-kselftest+bounces-8606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24F78ACA14
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 12:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7956F2837B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEAA13C3F4;
	Mon, 22 Apr 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="t0SRX/yL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8CA502B3
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780014; cv=none; b=byk2Xn7dxl1MgQ2Q5u0ReviFaLQaDBjBXt2HNo/3/vdUfMy+28t8iNRR48Rx49qoq5egqQqtb+eZkeVbOqfflbuWa3vrUvwoWv4UoFLbIScz36623A4wthBtOlIW+W8Uv2TvxZto7Bo7rHSEK+uq7sCucHqeg8v137AI6dbAkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780014; c=relaxed/simple;
	bh=NFexd1u1uO+WfIG7yqJtZ7HrUS6ZJnEfH04BiOdzLyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RF1B14AQT80ISdJ2W3u3zfharySB1Tvn6VnwZyM9bkBf/URfXQ6hJzMC957mT610ShJ2Dx3n210tPYxpm5d2KtpCu1zhTrIPjE8qNZTjh8P96ST9IdzHVJFOkxBhbTHDoKfFutLRVwgtdATUNiG/ilWt9Cc/DyNJUMTf86VWV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=t0SRX/yL; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36a0f64f5e0so17161145ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713780011; x=1714384811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LugDwOC1uyIQuTcuiObmKZIYdWbI8Ojo+Itov+Dc6WE=;
        b=t0SRX/yLuQh7dXaVage/6/CnIOVEXBi/yRpA4G+ZE8Z4K7ZcrE3oZg58d33U7yPlD6
         F20ypvp4jppB7nNMPvw5bqS320YehLEKxM/XCang1Fmicl800ob4d8raTBdDNAxogU0z
         7YJ+gDgJTZ9ADZe3bmgvUTHsaUdwg2cTf8iSNQWZ7Nx0bnlZpWfrVXxU1xAFfVTxdMaf
         bRts8x5fbEEv8Enf0e0YtgLA9NxhOzYxBeaG8oJGE16Ww5oJ/ioikS79+YchxMNfeLOf
         lKbA9Ic285uasJ3JRYc6G1h8Irxt7S6+EvSu++ZRAQ58THrJpyxwH3x5+E19TncEG13e
         nl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713780011; x=1714384811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LugDwOC1uyIQuTcuiObmKZIYdWbI8Ojo+Itov+Dc6WE=;
        b=suNms822oT5GBU7/OtKQlY/9BasZ54xXo2vHcrSSDq09ALHR1qpk1hC6ENeEeNXou1
         /LgUqDuh2rkAyq1nKiKCGWkpGk6b6e6c3z/6/q3sHa/k+/BHpnh1tImakkqk4Uzmgr9J
         /zjXb38Z5FJJFrrktsF8IsVc1fGdp5LZ6aJD+fT0NS5JeOi3XGR/c7t9mKMYB2UUxr/o
         ogO9yv1BJTXqm2K75diHt60O9AXdhZTZOO2nWK4bh647mpRVjg6oCAo5k9lgRmKyMBDD
         3qpnFAYBzE9oRD9cOpqKt5EUt8kxxvM6mS3m9TGp1+nalIxLER/k3B1uZcE+O8QTaSLG
         DVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhsmdMy8BvxtkfBqqpCT2N02vX5g5ChF3Tf6S3G7FF0xpNW0QLycKMMbI1R9H0XEg2Gv/vNLTXhRMrmEQg3/jXEJosyQftKFSeOyjACwlT
X-Gm-Message-State: AOJu0Ywl7OQS8hEiQC8H31PY9MI6iCsohH9y9CsGHr3sRsBDPhJLvdG4
	8bXNTDM04gv4jt0RHsteSmh41Vcq+OfSf3NnFb8DpKrlWITpTMtr2JE0edaqqNejGLLI6YxPy7y
	ATSY0f0zPH4ODgXU2ZQ4a391DLJcWMQAIy1FQig==
X-Google-Smtp-Source: AGHT+IHkuU6rJ/XqGm7fmDmDW8HzxQBFeytzbeGNvhXipCnXDJjhdmK6Os8B+uvQNQCUQx6sc3Q3gngW5RZcF3ztM1I=
X-Received: by 2002:a05:6e02:1384:b0:36a:f9e8:5e4a with SMTP id
 d4-20020a056e02138400b0036af9e85e4amr14406107ilo.15.1713780011455; Mon, 22
 Apr 2024 03:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com>
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Apr 2024 15:29:58 +0530
Message-ID: <CAAhSdy2tw1vy-vS3u8-Eq92d=TS_wFENTTrAFG7ked1aEfpkGA@mail.gmail.com>
Subject: Re: [PATCH v8 00/24] RISC-V SBI v2.0 PMU improvements and Perf
 sampling in KVM guest
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, samuel.holland@sifive.com, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	Will Deacon <will@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 5:17=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> This series implements SBI PMU improvements done in SBI v2.0[1] i.e. PMU =
snapshot
> and fw_read_hi() functions.
>
> SBI v2.0 introduced PMU snapshot feature which allows the SBI implementat=
ion
> to provide counter information (i.e. values/overflow status) via a shared
> memory between the SBI implementation and supervisor OS. This allows to m=
inimize
> the number of traps in when perf being used inside a kvm guest as it reli=
es on
> SBI PMU + trap/emulation of the counters.
>
> The current set of ratified RISC-V specification also doesn't allow scoun=
tovf
> to be trap/emulated by the hypervisor. The SBI PMU snapshot bridges the g=
ap
> in ISA as well and enables perf sampling in the guest. However, LCOFI in =
the
> guest only works via IRQ filtering in AIA specification. That's why, AIA
> has to be enabled in the hardware (at least the Ssaia extension) in order=
 to
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
> https://github.com/atishp04/linux/tree/kvm_pmu_snapshot_v8
>
> The kvmtool patch is also available at:
> https://github.com/atishp04/kvmtool/tree/sscofpmf
>
> It also requires Ssaia ISA extension to be present in the hardware in ord=
er to
> get perf sampling support in the guest. In Qemu virt machine, it can be d=
one
> by the following config.
>
> ```
> -cpu rv64,sscofpmf=3Dtrue,x-ssaia=3Dtrue
> ```
>
> There is no other dependencies on AIA apart from that. Thus, Ssaia must b=
e disabled
> for the guest if AIA patches are not available. Here is the example comma=
nd.
>
> ```
> ./lkvm-static run -m 256 -c2 --console serial -p "console=3DttyS0 earlyco=
n" --disable-ssaia -k ./Image --debug
> ```
>
> The series has been tested only in Qemu.
> Here is the snippet of the perf running inside a kvm guest.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> $ perf record -e cycles -e instructions perf bench sched messaging -g 5
> ...
> $ Running 'sched/messaging' benchmark:
> ...
> [   45.928723] perf_duration_warn: 2 callbacks suppressed
> [   45.929000] perf: interrupt took too long (484426 > 483186), lowering =
kernel.perf_event_max_sample_rate to 250
> $ 20 sender and receiver processes per group
> $ 5 groups =3D=3D 200 processes run
>
>      Total time: 14.220 [sec]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.117 MB perf.data (1942 samples) ]
> $ perf report --stdio
> $ To display the perf.data header info, please use --header/--header-only=
 optio>
> $
> $
> $ Total Lost Samples: 0
> $
> $ Samples: 943  of event 'cycles'
> $ Event count (approx.): 5128976844
> $
> $ Overhead  Command          Shared Object                Symbol         =
      >
> $ ........  ...............  ...........................  ...............=
......>
> $
>      7.59%  sched-messaging  [kernel.kallsyms]            [k] memcpy
>      5.48%  sched-messaging  [kernel.kallsyms]            [k] percpu_coun=
ter_ad>
>      5.24%  sched-messaging  [kernel.kallsyms]            [k] __sbi_rfenc=
e_v02_>
>      4.00%  sched-messaging  [kernel.kallsyms]            [k] _raw_spin_u=
nlock_>
>      3.79%  sched-messaging  [kernel.kallsyms]            [k] set_pte_ran=
ge
>      3.72%  sched-messaging  [kernel.kallsyms]            [k] next_uptoda=
te_fol>
>      3.46%  sched-messaging  [kernel.kallsyms]            [k] filemap_map=
_pages
>      3.31%  sched-messaging  [kernel.kallsyms]            [k] handle_mm_f=
ault
>      3.20%  sched-messaging  [kernel.kallsyms]            [k] finish_task=
_switc>
>      3.16%  sched-messaging  [kernel.kallsyms]            [k] clear_page
>      3.03%  sched-messaging  [kernel.kallsyms]            [k] mtree_range=
_walk
>      2.42%  sched-messaging  [kernel.kallsyms]            [k] flush_icach=
e_pte
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc
>
> Changes from v7->v8:
> 1. Updated event states so that shared memory is updated only during stop
>    operations.
> 2. Avoid clobbering lower XLEN counter/overflow values in shared memory
>    by maintaining a temporary copy for RV32.
> 3. Improved overflow handling in snapshot case by supporting all 64 value=
s.
> 4. Minor cleanups based on suggestions on v7.
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
> 4. Fixed KVM boot issue without Ssaia and made sscofpmf in guest dependen=
t on
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
> drivers/perf: riscv: Fix counter mask iteration for RV32
> drivers/perf: riscv: Implement SBI PMU snapshot function
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

Queued this series for Linux-6.10

If new issues are discovered then send patches based on
the KVM riscv queue.

Thanks,
Anup

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
> drivers/perf/riscv_pmu_sbi.c                  | 309 +++++++-
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
> 23 files changed, 1467 insertions(+), 117 deletions(-)
> create mode 100644 tools/testing/selftests/kvm/include/riscv/sbi.h
> create mode 100644 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>
> --
> 2.34.1
>

