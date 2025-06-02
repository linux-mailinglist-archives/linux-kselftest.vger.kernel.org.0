Return-Path: <linux-kselftest+bounces-34153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9A2ACBB83
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 21:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4002516E107
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B1C2253E9;
	Mon,  2 Jun 2025 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XDrZYzTf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E801A5B92
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892540; cv=none; b=G77N9ngEtEgqG57p7Nc2SdN+9TwBEe9iYtv9lfVwiuPIhP/ik6Iip5ijQkx7LdrhOAljdI3mpl8Axd/DjVtALG2jXvNXCY1PBqh+Pvi3GOo8BoZ9IuzXZTyPeFVgufNwTaKZn7X2PBi7TK40sQI86sucB/iGM+cG1QHSEwFa6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892540; c=relaxed/simple;
	bh=Bkp+RHmq5Zb8XC8EbWlPhlhfVe8QwDCY3ZtSkb5UPso=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aRJeMCez69I5zeC/d4R2uuUFAwXRgr3TzKGQ3La3Gc471qlVaZ0nOqahA+eDQSQfEqfKNRI5k3rbYAsCCkjt8mqkppUh+EHTWpu1JX3K/Jpe8xiAgYkA5xbnxY303d6xP5WN6qusXqOTQLEtozET2EJa5VdmPHuiDAPR7XQ12LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XDrZYzTf; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3da6fe2a552so92869435ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892537; x=1749497337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XDqE8mFNSY/ZirLnr+lInzWb5qO4cUyD2wakE3p29r0=;
        b=XDrZYzTfUvfcveiV/2SQ3WvdQeceqlug2ytLntPdDuPPTnoTrNaYRh6IRYgh70BxJn
         G47KoGTrpJjSvRjiOBFHdgUhd2vjt0cbJZdDJLl2bu+2BeTgZ8YXnWeysk8346CeYH5b
         vQnRmtDS6ZPDIjzZlunD/tSRQ6FugEnoOqSoDAMZ0D62yS4MuRJizK0IrMQZC+FtHBVB
         ZrDUQcfO+Bh4uU3OfDCioGBfoGIG9eNmFcPFxphi7Ew0KKPrZ80Wm0peBY9chO2hPaWn
         tngZne7iGzJ6LAR972Ppv7mIhuaiTUcDzRWjoobQYGtPtg3X9UccCbM5g22B86+LIphx
         iFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892537; x=1749497337;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XDqE8mFNSY/ZirLnr+lInzWb5qO4cUyD2wakE3p29r0=;
        b=JYvMKq/y8crFt+iCKxANr4k2xISNoBZUzN/aYXckh0OppdKYhqnpweQk3tskNrrp1I
         IQ2TfKOso0KNm/vZHq/PMUu11xFlPMPsOU1c3LwcTBSV7b/kRDurkmUWHZX3nsdqd9I3
         ZVDS3BBXSKBmrp44kFa7c5yWKqMua1NS1woBsRioLbzyq8VE/batDz03zjSA5GQ4VZyr
         CsKo4xOYbm4l/QE1r+pLU6rN3yIRShxp9cZln5gvkiCuG2nGUVZ8JO3St9QynMKkZqpK
         rOtxrf9/r5P22GTvwqlPSIqlc+0l+T0dJE2CimBhC6ycyoORXK3nQuu+3n8grDzI9I8H
         MVIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5E28Ueluqagcq93T3rFE0SvbeMnbscp/YHHnMm93yv4jh7BVR7xGcalIY1qqWwL2DETdN5v2sTgqlgYNKYL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuvvwNKaBUEzqGqiAdKxVpTSSYl0sVeRayxfWJ1lOvwEo6uxPe
	FE6gU7JOY98XrAZ202TcieNAFCGIfDPt7LfRmiSVfw7ScaaRhNIO0Kmo0RQ66fFQdKQsenmw4NL
	NjxA0OVY9AvhvHwFN8oEA5gTiAw==
X-Google-Smtp-Source: AGHT+IFxeHQ76hpwbia1zMeQqWVTlfaiwmMC2Ena7lOl4cpvV3skj0sAcuon/x4Imo4A5kPFT2TaGxeLGLjA5Bo9DQ==
X-Received: from ilbby12.prod.google.com ([2002:a05:6e02:260c:b0:3dd:b4dc:eb43])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:194b:b0:3dc:787f:2bc8 with SMTP id e9e14a558f8ab-3dda3363f25mr100622585ab.12.1748892537342;
 Mon, 02 Jun 2025 12:28:57 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:26:45 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-1-coltonlewis@google.com>
Subject: [PATCH 00/17] ARM64 PMU Partitioning
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Overview:

This series implements a new PMU scheme on ARM, a partitioned PMU
that exists alongside the existing emulated PMU and may be enabled by
the kernel command line kvm.reserved_host_counters or by the vcpu
ioctl KVM_ARM_PARTITION_PMU. This is a continuation of the RFC posted
earlier this year. [1]

The high level overview and reason for the name is that this
implementation takes advantage of recent CPU features to partition the
PMU counters into a host-reserved set and a guest-reserved set. Guests
are allowed untrapped hardware access to the most frequently used PMU
registers and features for the guest-reserved counters only.

This untrapped hardware access significantly reduces the overhead of
using performance monitoring capabilities such as the `perf` tool
inside a guest VM. Register accesses that aren't trapping to KVM mean
less time spent in the host kernel and more time on the workloads
guests care about. This optimization especially shines during high
`perf` sample rates or large numbers of events that require
multiplexing hardware counters.

Performance:

For example, the following tests were carried out on identical ARM
machines with 10 general purpose counters with identical guest images
run on QEMU, the only difference being my PMU implementation or the
existing one. Some arguments have been simplified here to clarify the
purpose of the test:

1) time perf record -e ${FIFTEEN_HW_EVENTS} -F 1000 -- \
   gzip -c tmpfs/random.64M.img >/dev/null

On emulated PMU this command took 4.143s real time with 0.159s system
time. On partitioned PMU this command took 3.139s real time with
0.110s system time, runtime reductions of 24.23% and 30.82%.

2) time perf stat -dd -- \
   automated_specint2017.sh

On emulated PMU this benchmark completed in 3789.16s real time with
224.45s system time and a final benchmark score of 4.28. On
partitioned PMU this benchmark completed in 3525.67s real time with
15.98s system time and a final benchmark score of 4.56. That is a
6.95% reduction in runtime, 92.88% reduction in system time, and
6.54% improvement in overall benchmark score.

Seeing these improvements on something as lightweight as perf stat is
remarkable and implies there would have been a much greater
improvement with perf record. I did not test that because I was not
confident it would even finish in a reasonable time on the emulated
PMU

Test 3 was slightly different, I ran the workload in a VM with a
single VCPU pinned to a physical CPU and analyzed from the host where
the physical CPU spent its time using mpstat.

3) perf record -e ${FIFTEEN_HW_EVENTS} -F 4000 -- \
   stress-ng --cpu 0 --timeout 30

Over a period of 30s the cpu running with the emulated PMU spent
34.96% of the time in the host kernel and 55.85% of the time in the
guest. The cpu running the partitioned PMU spent 0.97% of its time in
the host kernel and 91.06% of its time in the guest.

Taken together, these tests represent a remarkable performance
improvement for anything perf related using this new PMU
implementation.

Caveats:

Because the most consistent and performant thing to do was untrap
PMCR_EL0, the number of counters visible to the guest via PMCR_EL0.N
is always equal to the value KVM sets for MDCR_EL2.HPMN. Previously
allowed writes to PMCR_EL0.N via {GET,SET}_ONE_REG no longer affect
the guest.

These improvements come at a cost to 7-35 new registers that must be
swapped at every vcpu_load and vcpu_put if the feature is enabled. I
have been informed KVM would like to avoid paying this cost when
possible.

One solution is to make the trapping changes and context swapping lazy
such that the trapping changes and context swapping only take place
after the guest has actually accessed the PMU so guests that never
access the PMU never pay the cost.

This is not done here because it is not crucial to the primary
functionality and I thought review would be more productive as soon as
I had something complete enough for reviewers to easily play with.

However, this or any better ideas are on the table for inclusion in
future re-rolls.

[1] https://lore.kernel.org/kvmarm/20250213180317.3205285-1-coltonlewis@google.com/

Colton Lewis (16):
  arm64: cpufeature: Add cpucap for HPMN0
  arm64: Generate sign macro for sysreg Enums
  arm64: cpufeature: Add cpucap for PMICNTR
  KVM: arm64: Reorganize PMU functions
  KVM: arm64: Introduce method to partition the PMU
  perf: arm_pmuv3: Generalize counter bitmasks
  perf: arm_pmuv3: Keep out of guest counter partition
  KVM: arm64: Set up FGT for Partitioned PMU
  KVM: arm64: Writethrough trapped PMEVTYPER register
  KVM: arm64: Use physical PMSELR for PMXEVTYPER if partitioned
  KVM: arm64: Writethrough trapped PMOVS register
  KVM: arm64: Context switch Partitioned PMU guest registers
  perf: pmuv3: Handle IRQs for Partitioned PMU guest counters
  KVM: arm64: Inject recorded guest interrupts
  KVM: arm64: Add ioctl to partition the PMU when supported
  KVM: arm64: selftests: Add test case for partitioned PMU

Marc Zyngier (1):
  KVM: arm64: Cleanup PMU includes

 Documentation/virt/kvm/api.rst                |  16 +
 arch/arm/include/asm/arm_pmuv3.h              |  24 +
 arch/arm64/include/asm/arm_pmuv3.h            |  36 +-
 arch/arm64/include/asm/kvm_host.h             | 208 +++++-
 arch/arm64/include/asm/kvm_pmu.h              |  82 +++
 arch/arm64/kernel/cpufeature.c                |  15 +
 arch/arm64/kvm/Makefile                       |   2 +-
 arch/arm64/kvm/arm.c                          |  24 +-
 arch/arm64/kvm/debug.c                        |  13 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       |  65 +-
 arch/arm64/kvm/pmu-emul.c                     | 629 +----------------
 arch/arm64/kvm/pmu-part.c                     | 358 ++++++++++
 arch/arm64/kvm/pmu.c                          | 630 ++++++++++++++++++
 arch/arm64/kvm/sys_regs.c                     |  54 +-
 arch/arm64/tools/cpucaps                      |   2 +
 arch/arm64/tools/gen-sysreg.awk               |   1 +
 arch/arm64/tools/sysreg                       |   6 +-
 drivers/perf/arm_pmuv3.c                      |  55 +-
 include/kvm/arm_pmu.h                         | 199 ------
 include/linux/perf/arm_pmu.h                  |  15 +-
 include/linux/perf/arm_pmuv3.h                |  14 +-
 include/uapi/linux/kvm.h                      |   4 +
 tools/include/uapi/linux/kvm.h                |   2 +
 .../selftests/kvm/arm64/vpmu_counter_access.c |  40 +-
 virt/kvm/kvm_main.c                           |   1 +
 25 files changed, 1616 insertions(+), 879 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_pmu.h
 create mode 100644 arch/arm64/kvm/pmu-part.c
 delete mode 100644 include/kvm/arm_pmu.h


base-commit: 1b85d923ba8c9e6afaf19e26708411adde94fba8
--
2.49.0.1204.g71687c7c1d-goog

