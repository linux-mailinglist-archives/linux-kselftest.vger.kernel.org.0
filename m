Return-Path: <linux-kselftest+bounces-9111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4636F8B6A11
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 07:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE591F233C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 05:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69110182BD;
	Tue, 30 Apr 2024 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Ey0ovduN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA81802E
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456473; cv=none; b=L9cRZNuIVXnvMuLcJYKBx4mH6qkt1yBPqEGQPBU62DrFZIPYv7zC7nYTWNj9WtcaP0OFMuDmKAJBuLH+HsCjpaRmb+b2ELQeO0WcACoelviJsBDrZ7GLr14iQMA21Vbg9T4Jo+A2HMaX5wi+1iR6EhFc+otrhQx/NvefpAU8Pcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456473; c=relaxed/simple;
	bh=4ormgU5gRbjFfeCyZHl/xfsEA8SHC0/csNz0Eg6y+Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDCfAeUtNmQ4Ufz8LpsfR94dnESlE+4AiWnb5nVBakerLW/3D32KnZj0YZpoNo5ckNWIyaBwTaT4mWdIRSBHd9ewWLGJGBMivBRGlQb6JAVXmu+SkNUIWTF/41SwJoD8gHEv0EVT58MXC6dMCWmUiDEaAuCJdX8V1Dwo0tTTSjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Ey0ovduN; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7da3ec3e044so252224539f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 22:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1714456471; x=1715061271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgTxcx9ZuiedpoJWoMPW/EsQBUGbgFOMOL6LuYVdEPA=;
        b=Ey0ovduNOwUQp4+T+Gdq7pC5cPLZQxZEhVjTcTa5BNBzT+FT2h+FANXyYnqv4NT58U
         tOjHwyeqb8HVIcUo/bP26G/oxphQ68khj1puzVpuwz3CIjr2LTPc0BCJaQj6ItvLxm0x
         L7ELIH3gpKrZGjubp2oWzQAjz8YYlL4ST0n6Fr/RtrOi2iXdPiwNrvJVItpoVXsuTYwE
         zt46KJ0mIygXVOy+3C91OohZ7eMmQDHOq+HSmy6sIfNkgN6kdtgbaBoGwiuXHXH5l7ln
         JJVoMllD8pjXF6h6QGyB8kzHQaqrr5BvmWTrUCAeeKWDTSuC2XLwxGB4JndZhDwSJDVo
         aDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714456471; x=1715061271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgTxcx9ZuiedpoJWoMPW/EsQBUGbgFOMOL6LuYVdEPA=;
        b=kTs8YtHTOixZLFET+kFLDFWj7Sg53mrp/6flHFfdhuO3wTZYh+G6o05tF/sc5mt95Z
         kwZRoevvkCoI3JAySEVR9syg0ABZjBsb7NjVprKjAdAtO1fbDwcpQEUoyQej/1DKcQ4n
         FxFM+sgHjZGB6H9Iw+wo0zccp2q4ywjW0CibIsxqC4JfGxOXNkUzif0liPGTk5CflVBA
         CHR5+Wlmz2+WrLR40lL7+DMzaLdAVoVBgzU86zk3ukcOWJx03GUoNcBb7KZhmGj3838E
         Kc2qdJWygou3VOYuBwXkIpXYlaPyMuB+9rE1pkS0OmxfhfG71VStb2ySx2rfM4+8Ok+S
         IU7w==
X-Forwarded-Encrypted: i=1; AJvYcCVBPplyczzzS6BkdE7mJ1fbiCbqydHNrGJKo7Ne+tpRnqaeU9JlGW7cdt75ggUnrAVoUwUM/+s7C6UCuxeG0gZpYZewYCEPRcUh4LI7Mzws
X-Gm-Message-State: AOJu0YzVJ2H164zBJeQTFs9k88FazUMT0xwnGuQ/CdwjcySxR3v5DbMo
	IeTvzeH1jhzJvAwPfcGBOzRpRi919nTy1388Db1RLepN+3+3E52LLAgaUzTVZVznx6rd7KFiuI1
	7R0umIe4ZNfuOtdqj36pV+oEjVv1m+hDYO6/R0Q==
X-Google-Smtp-Source: AGHT+IFzDPOTOshjs6n8hlxADpVsyKAst/CkvRNs5CXh+XL91zPfrAcVl3nwVgj9JUDgt2EzlBYTb+9OXt6iCR7L114=
X-Received: by 2002:a92:cda5:0:b0:36c:50c5:a5fc with SMTP id
 g5-20020a92cda5000000b0036c50c5a5fcmr2078590ild.12.1714456470665; Mon, 29 Apr
 2024 22:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <CAAhSdy2tw1vy-vS3u8-Eq92d=TS_wFENTTrAFG7ked1aEfpkGA@mail.gmail.com>
In-Reply-To: <CAAhSdy2tw1vy-vS3u8-Eq92d=TS_wFENTTrAFG7ked1aEfpkGA@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 30 Apr 2024 11:24:18 +0530
Message-ID: <CAAhSdy0k=-wtge-iA-rckQrd_ziNtWDnf4J-yCKP0OooZCaPzA@mail.gmail.com>
Subject: Re: [PATCH v8 00/24] RISC-V SBI v2.0 PMU improvements and Perf
 sampling in KVM guest
To: Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, samuel.holland@sifive.com, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra <atishp@rivosinc.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	Will Deacon <will@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

On Mon, Apr 22, 2024 at 3:29=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Sat, Apr 20, 2024 at 5:17=E2=80=AFAM Atish Patra <atishp@rivosinc.com>=
 wrote:
> >
> > This series implements SBI PMU improvements done in SBI v2.0[1] i.e. PM=
U snapshot
> > and fw_read_hi() functions.
> >
> > SBI v2.0 introduced PMU snapshot feature which allows the SBI implement=
ation
> > to provide counter information (i.e. values/overflow status) via a shar=
ed
> > memory between the SBI implementation and supervisor OS. This allows to=
 minimize
> > the number of traps in when perf being used inside a kvm guest as it re=
lies on
> > SBI PMU + trap/emulation of the counters.
> >
> > The current set of ratified RISC-V specification also doesn't allow sco=
untovf
> > to be trap/emulated by the hypervisor. The SBI PMU snapshot bridges the=
 gap
> > in ISA as well and enables perf sampling in the guest. However, LCOFI i=
n the
> > guest only works via IRQ filtering in AIA specification. That's why, AI=
A
> > has to be enabled in the hardware (at least the Ssaia extension) in ord=
er to
> > use the sampling support in the perf.
> >
> > Here are the patch wise implementation details.
> >
> > PATCH 1,4,7,8,9,10,11,15 : Generic cleanups/improvements.
> > PATCH 2,3,14 : FW_READ_HI function implementation
> > PATCH 5-6: Add PMU snapshot feature in sbi pmu driver
> > PATCH 12-13: KVM implementation for snapshot and sampling in kvm guests
> > PATCH 16-17: Generic improvements for kvm selftests
> > PATCH 18-22: KVM selftests for SBI PMU extension
> >
> > The series is based on v6.9-rc4 and is available at:
> >
> > https://github.com/atishp04/linux/tree/kvm_pmu_snapshot_v8
> >
> > The kvmtool patch is also available at:
> > https://github.com/atishp04/kvmtool/tree/sscofpmf
> >
> > It also requires Ssaia ISA extension to be present in the hardware in o=
rder to
> > get perf sampling support in the guest. In Qemu virt machine, it can be=
 done
> > by the following config.
> >
> > ```
> > -cpu rv64,sscofpmf=3Dtrue,x-ssaia=3Dtrue
> > ```
> >
> > There is no other dependencies on AIA apart from that. Thus, Ssaia must=
 be disabled
> > for the guest if AIA patches are not available. Here is the example com=
mand.
> >
> > ```
> > ./lkvm-static run -m 256 -c2 --console serial -p "console=3DttyS0 early=
con" --disable-ssaia -k ./Image --debug
> > ```
> >
> > The series has been tested only in Qemu.
> > Here is the snippet of the perf running inside a kvm guest.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > $ perf record -e cycles -e instructions perf bench sched messaging -g 5
> > ...
> > $ Running 'sched/messaging' benchmark:
> > ...
> > [   45.928723] perf_duration_warn: 2 callbacks suppressed
> > [   45.929000] perf: interrupt took too long (484426 > 483186), lowerin=
g kernel.perf_event_max_sample_rate to 250
> > $ 20 sender and receiver processes per group
> > $ 5 groups =3D=3D 200 processes run
> >
> >      Total time: 14.220 [sec]
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.117 MB perf.data (1942 samples) ]
> > $ perf report --stdio
> > $ To display the perf.data header info, please use --header/--header-on=
ly optio>
> > $
> > $
> > $ Total Lost Samples: 0
> > $
> > $ Samples: 943  of event 'cycles'
> > $ Event count (approx.): 5128976844
> > $
> > $ Overhead  Command          Shared Object                Symbol       =
        >
> > $ ........  ...............  ...........................  .............=
........>
> > $
> >      7.59%  sched-messaging  [kernel.kallsyms]            [k] memcpy
> >      5.48%  sched-messaging  [kernel.kallsyms]            [k] percpu_co=
unter_ad>
> >      5.24%  sched-messaging  [kernel.kallsyms]            [k] __sbi_rfe=
nce_v02_>
> >      4.00%  sched-messaging  [kernel.kallsyms]            [k] _raw_spin=
_unlock_>
> >      3.79%  sched-messaging  [kernel.kallsyms]            [k] set_pte_r=
ange
> >      3.72%  sched-messaging  [kernel.kallsyms]            [k] next_upto=
date_fol>
> >      3.46%  sched-messaging  [kernel.kallsyms]            [k] filemap_m=
ap_pages
> >      3.31%  sched-messaging  [kernel.kallsyms]            [k] handle_mm=
_fault
> >      3.20%  sched-messaging  [kernel.kallsyms]            [k] finish_ta=
sk_switc>
> >      3.16%  sched-messaging  [kernel.kallsyms]            [k] clear_pag=
e
> >      3.03%  sched-messaging  [kernel.kallsyms]            [k] mtree_ran=
ge_walk
> >      2.42%  sched-messaging  [kernel.kallsyms]            [k] flush_ica=
che_pte
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >
> > [1] https://github.com/riscv-non-isa/riscv-sbi-doc
> >
> > Changes from v7->v8:
> > 1. Updated event states so that shared memory is updated only during st=
op
> >    operations.
> > 2. Avoid clobbering lower XLEN counter/overflow values in shared memory
> >    by maintaining a temporary copy for RV32.
> > 3. Improved overflow handling in snapshot case by supporting all 64 val=
ues.
> > 4. Minor cleanups based on suggestions on v7.
> >
> > Changes from v6->v7:
> > 1. Used SBI_SHMEM_DISABLE in the driver.
> > 2. Added RB Tags.
> > 3. Improved the sbi_pmu_test commandline to allow disabling multiple
> >    tests.
> >
> > Changes from v5->v6:
> > 1. Added a patch for command line option for the sbi pmu tests.
> > 2. Removed redundant prints and restructure the code little bit.
> > 3. Added a patch for computing the sbi minor version correctly.
> > 4. Addressed all other comments on v5.
> >
> > Changes from v4->v5:
> > 1. Moved sbi related definitions to its own header file from processor.=
h
> > 2. Added few helper functions for selftests.
> > 3. Improved firmware counter read and RV32 start/stop functions.
> > 4. Converted all the shifting operations to use BIT macro
> > 5. Addressed all other comments on v4.
> >
> > Changes from v3->v4:
> > 1. Added selftests.
> > 2. Fixed an issue to clear the interrupt pending bits.
> > 3. Fixed the counter index in snapshot memory start function.
> >
> > Changes from v2->v3:
> > 1. Fixed a patchwork warning on patch6.
> > 2. Fixed a comment formatting & nit fix in PATCH 3 & 5.
> > 3. Moved the hvien update and sscofpmf enabling to PATCH 9 from PATCH 8=
.
> >
> > Changes from v1->v2:
> > 1. Fixed warning/errors from patchwork CI.
> > 2. Rebased on top of kvm-next.
> > 3. Added Acked-by tags.
> >
> > Changes from RFC->v1:
> > 1. Addressed all the comments on RFC series.
> > 2. Removed PATCH2 and merged into later patches.
> > 3. Added 2 more patches for minor fixes.
> > 4. Fixed KVM boot issue without Ssaia and made sscofpmf in guest depend=
ent on
> >    Ssaia in the host.
> >
> > Atish Patra (24):
> > RISC-V: Fix the typo in Scountovf CSR name
> > RISC-V: Add FIRMWARE_READ_HI definition
> > drivers/perf: riscv: Read upper bits of a firmware counter
> > drivers/perf: riscv: Use BIT macro for shifting operations
> > RISC-V: Add SBI PMU snapshot definitions
> > RISC-V: KVM: Rename the SBI_STA_SHMEM_DISABLE to a generic name
> > RISC-V: Use the minor version mask while computing sbi version
> > drivers/perf: riscv: Fix counter mask iteration for RV32
> > drivers/perf: riscv: Implement SBI PMU snapshot function
> > RISC-V: KVM: Fix the initial sample period value
> > RISC-V: KVM: No need to update the counter value during reset
> > RISC-V: KVM: No need to exit to the user space if perf event failed
> > RISC-V: KVM: Implement SBI PMU Snapshot feature
> > RISC-V: KVM: Add perf sampling support for guests
> > RISC-V: KVM: Support 64 bit firmware counters on RV32
> > RISC-V: KVM: Improve firmware counter read function
> > KVM: riscv: selftests: Move sbi definitions to its own header file
> > KVM: riscv: selftests: Add helper functions for extension checks
> > KVM: riscv: selftests: Add Sscofpmf to get-reg-list test
> > KVM: riscv: selftests: Add SBI PMU extension definitions
> > KVM: riscv: selftests: Add SBI PMU selftest
> > KVM: riscv: selftests: Add a test for PMU snapshot functionality
> > KVM: riscv: selftests: Add a test for counter overflow
> > KVM: riscv: selftests: Add commandline option for SBI PMU test
>
> Queued this series for Linux-6.10
>
> If new issues are discovered then send patches based on
> the KVM riscv queue.

Please use the kvm-riscv-for-palmer-6.10 tag in the KVM RISC-V
repo (https://github.com/kvm-riscv/linux.git) as a shared tag for
the upcoming Linux-6.10 merge window.

This tag is based on Linux-6.9-rc3.

Regards,
Anup

>
> Thanks,
> Anup
>
> >
> > arch/riscv/include/asm/csr.h                  |   5 +-
> > arch/riscv/include/asm/kvm_vcpu_pmu.h         |  16 +-
> > arch/riscv/include/asm/sbi.h                  |  38 +-
> > arch/riscv/include/uapi/asm/kvm.h             |   1 +
> > arch/riscv/kernel/paravirt.c                  |   6 +-
> > arch/riscv/kvm/aia.c                          |   5 +
> > arch/riscv/kvm/vcpu.c                         |  15 +-
> > arch/riscv/kvm/vcpu_onereg.c                  |   6 +
> > arch/riscv/kvm/vcpu_pmu.c                     | 260 ++++++-
> > arch/riscv/kvm/vcpu_sbi_pmu.c                 |  17 +-
> > arch/riscv/kvm/vcpu_sbi_sta.c                 |   4 +-
> > drivers/perf/riscv_pmu.c                      |   1 +
> > drivers/perf/riscv_pmu_sbi.c                  | 309 +++++++-
> > include/linux/perf/riscv_pmu.h                |   6 +
> > tools/testing/selftests/kvm/Makefile          |   1 +
> > .../selftests/kvm/include/riscv/processor.h   |  49 +-
> > .../testing/selftests/kvm/include/riscv/sbi.h | 141 ++++
> > .../selftests/kvm/include/riscv/ucall.h       |   1 +
> > .../selftests/kvm/lib/riscv/processor.c       |  12 +
> > .../testing/selftests/kvm/riscv/arch_timer.c  |   2 +-
> > .../selftests/kvm/riscv/get-reg-list.c        |   4 +
> > .../selftests/kvm/riscv/sbi_pmu_test.c        | 681 ++++++++++++++++++
> > tools/testing/selftests/kvm/steal_time.c      |   4 +-
> > 23 files changed, 1467 insertions(+), 117 deletions(-)
> > create mode 100644 tools/testing/selftests/kvm/include/riscv/sbi.h
> > create mode 100644 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> >
> > --
> > 2.34.1
> >

