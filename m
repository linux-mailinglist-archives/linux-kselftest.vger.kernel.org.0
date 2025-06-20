Return-Path: <linux-kselftest+bounces-35468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CD1AE24EF
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5625816DB4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1ED23C51B;
	Fri, 20 Jun 2025 22:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQqPZw7d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E0239E91
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457918; cv=none; b=f2XUKoJpbLEehjhomigiy1rjSG16ZKe4arrTcoq97GM7KrAAm0brpUBEtEgk9MSIdk5t/0qbuIoQBsZUtstvR1y35L8WStkbpLIp9fYmg7zNqDVcWMpdW6q/QjmLvdKBGLm6JLexUxwyGFvEKodPibKRn744ee7kNR4y4I1wzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457918; c=relaxed/simple;
	bh=7pulN/OkGjkY7Bx65ebnOL221hHWSP3hgKF52P74crE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LQrB0T6arBVqdPtfA0Nm66vPKrK4icAZeq+3a+5LffmVvGydFkqtszLJyKhgDGVJCRbr0xgV8lWGhtjfgO+JKCqCVpFzBMn0djiD9VfueBrVeiQZXLiS83NQpEwEceL+DwSBgdo2Ji2thjnMBFpw0kHTDNgO2Cvba1pzenNGuHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NQqPZw7d; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddbd339f3dso24613185ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457915; x=1751062715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yU/fLL+92RLO71Pe+syN2lmq3wCTn8ghsMcg6jKW0VU=;
        b=NQqPZw7ddC9TwDH1GR9skDkJdD3LdMbUCfSqeXg1HGoU57dozRflSqncZw3faeE0k4
         F68i57FGDCunExzdtVAY4FuoXTNVhdg4FUk/jHACTUe1mexujKyel2rIGXdtX3FT0XCZ
         OjHcZMSOZg1OjyFKgT9eLdZHFYNlkFBV3ebIG5Utl4+CsvW+PSBKyleDqzbsA+gH1X3D
         e5USNEl0nG2qvOR+SAqdX2vLyiEZwKc0bawXTbBwKP5/txfYSUoan9/V6G7Og1x9ML52
         kvYVaRwg0zjNerS9kp6XiBpZ47+rjrdPsyZW+UJ7td9cQAIY0tk6ew5zZY3lpqMQyEWl
         84zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457915; x=1751062715;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yU/fLL+92RLO71Pe+syN2lmq3wCTn8ghsMcg6jKW0VU=;
        b=m5/cvqh4I7vLemktyE4KRzQQry3LKgIu7W7/VmgfYPqDbs97nV4ayQUYMhPsQggy40
         waaESLYmC+zr2j6CDD/LrHI5ZDZw/BdS75bciQXIrWFI21FTHr/aputWT3idNH2FU+VD
         TU8rZapnyawiCd+FuOHTDP0rMW26BHfsKw9s0TLEQL5m0CxN70osAMjLrUlbb8omKhcX
         PRS6zOgsPRdMH9l52OZXUuZX+2ZKA/D6EhGvs/cznfcdIjS9e3IWsoznz+MFdvOO7p6J
         NMecA4bOegGvVvKRCItCTk4/+zSkdNrTAkueLFX5ilKbEla6BAhLRMCQzQvquQNYst8I
         XxVg==
X-Forwarded-Encrypted: i=1; AJvYcCVc0sfyx75pHEp047MzRfeMaIUuX0naRMOCuQkBeVGuSRCalh94J2aCrUTISbyGmcYQWZlelnxblFHnPVbmwZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyv6MhL00jz1QrJ9H3hzCNh08qzLqLcEC5zsZRJpW2PBd/xX5C
	cu5DeYG6p0lUS1taBj72YYNIY5nFlF/oBcJh46Jne+4Yf5PQWulwGVuLhpVO84oPtfutSHSQiZj
	GDiX+9YYW9cHJXI5avXy3bK+1ow==
X-Google-Smtp-Source: AGHT+IFQfd+HFEgJUFIDJKFNT2FwvsKl4Qb5d6oW09ns3YI6iz4RavO8zz9nyubEwG4dIvHgjtj9BKcQ+WfnlUpyug==
X-Received: from ilbbb11.prod.google.com ([2002:a05:6e02:b:b0:3de:11fe:800c])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:16ce:b0:3dd:d653:5a05 with SMTP id e9e14a558f8ab-3de38c1bec3mr55832985ab.3.1750457915390;
 Fri, 20 Jun 2025 15:18:35 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:00 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-1-coltonlewis@google.com>
Subject: [PATCH v2 00/23] ARM64 PMU Partitioning
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

This series creates a new PMU scheme on ARM, a partitioned PMU that
allows reserving a subset of counters for more direct guest access,
significantly reducing overhead. More details, including performance
benchmarks, can be read in the v1 cover letter linked below.

v2:

* Rebased on top of kvm/queue to pick up Sean's patch [1] that
  reorganizes some of the same headers and would otherwise conflict.

* Changed the semantics of the command line parameters and the
  ioctl. It was pointed out in the comments last time that it doesn't
  work to repartition at runtime because the perf subsystem assumes
  the number of counters it gets will not change after the PMU is
  probed. Now the PMUv3 command line parameters are the sole thing
  that divides up guest and host counters and the ioctl just toggles a
  flag for whether a vcpu should use the partitioned PMU. I've also
  moved from one to two parameters: partition_pmu=[y/n] and
  reserved_guest_counters=[0-N]. This makes it possible to
  unambiguously express configurations like a partitioned PMU with 0
  general purpose counters exposed to the guest (which still exposes
  the cycle counter.

* Moved the partitioning code into the PMUv3 driver itself so KVM code
  isn't modifying fields that are otherwise internal to the driver.

* Define PMI{CNTR,FILTR} as undef_access since KVM isn't ready to
  support that counter. It is, however, still handled in the
  partitioning because the driver recognizes it.

* Take out the dependency on FEAT_FGT since it is not widely available
  on hardware yet. Instead, define a fast path in switch.h for
  handling accesses to the registers that would otherwise be
  untrapped.

* During MDCR_EL2 setup for guests, ensure the computed HPMN value is
  always below the number of guest counters allocated by the driver at
  boot and always below the number of counters on the current
  CPU. This accounts for the possibiliy of heterogeneous hardware
  where I guest might be able to use the partitioned PMU on one CPU
  but not another.

* The KVM PMU event filter API says that counters must not count while
  the event is filtered. To ensure this, enforce the filter on every
  vcpu_load into the guest.

* Settable PMCR_EL0.N with a partitioned PMU now works and the
  vcpu_counter_access selftest changes reflect that.

v1:
https://lore.kernel.org/kvm/20250602192702.2125115-1-coltonlewis@google.com/

Colton Lewis (22):
  arm64: cpufeature: Add cpucap for HPMN0
  arm64: Generate sign macro for sysreg Enums
  arm64: cpufeature: Add cpucap for PMICNTR
  arm64: Define PMI{CNTR,FILTR}_EL0 as undef_access
  KVM: arm64: Reorganize PMU functions
  perf: arm_pmuv3: Introduce method to partition the PMU
  perf: arm_pmuv3: Generalize counter bitmasks
  perf: arm_pmuv3: Keep out of guest counter partition
  KVM: arm64: Correct kvm_arm_pmu_get_max_counters()
  KVM: arm64: Set up FGT for Partitioned PMU
  KVM: arm64: Writethrough trapped PMEVTYPER register
  KVM: arm64: Use physical PMSELR for PMXEVTYPER if partitioned
  KVM: arm64: Writethrough trapped PMOVS register
  KVM: arm64: Write fast path PMU register handlers
  KVM: arm64: Setup MDCR_EL2 to handle a partitioned PMU
  KVM: arm64: Account for partitioning in PMCR_EL0 access
  KVM: arm64: Context swap Partitioned PMU guest registers
  KVM: arm64: Enforce PMU event filter at vcpu_load()
  perf: arm_pmuv3: Handle IRQs for Partitioned PMU guest counters
  KVM: arm64: Inject recorded guest interrupts
  KVM: arm64: Add ioctl to partition the PMU when supported
  KVM: arm64: selftests: Add test case for partitioned PMU

Marc Zyngier (1):
  KVM: arm64: Cleanup PMU includes

 Documentation/virt/kvm/api.rst                |  21 +
 arch/arm/include/asm/arm_pmuv3.h              |  34 +
 arch/arm64/include/asm/arm_pmuv3.h            |  61 +-
 arch/arm64/include/asm/kvm_host.h             |  20 +-
 arch/arm64/include/asm/kvm_pmu.h              |  61 ++
 arch/arm64/kernel/cpufeature.c                |  15 +
 arch/arm64/kvm/Makefile                       |   2 +-
 arch/arm64/kvm/arm.c                          |  22 +
 arch/arm64/kvm/debug.c                        |  24 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       | 233 ++++++
 arch/arm64/kvm/pmu-emul.c                     | 676 +----------------
 arch/arm64/kvm/pmu-part.c                     | 359 +++++++++
 arch/arm64/kvm/pmu.c                          | 687 ++++++++++++++++++
 arch/arm64/kvm/sys_regs.c                     |  66 +-
 arch/arm64/tools/cpucaps                      |   2 +
 arch/arm64/tools/gen-sysreg.awk               |   1 +
 arch/arm64/tools/sysreg                       |   6 +-
 drivers/perf/arm_pmuv3.c                      | 150 +++-
 include/linux/perf/arm_pmu.h                  |  15 +-
 include/linux/perf/arm_pmuv3.h                |  14 +-
 include/uapi/linux/kvm.h                      |   4 +
 tools/include/uapi/linux/kvm.h                |   2 +
 .../selftests/kvm/arm64/vpmu_counter_access.c |  63 +-
 virt/kvm/kvm_main.c                           |   1 +
 24 files changed, 1791 insertions(+), 748 deletions(-)
 create mode 100644 arch/arm64/kvm/pmu-part.c


base-commit: 79150772457f4d45e38b842d786240c36bb1f97f
--
2.50.0.714.g196bf9f422-goog

