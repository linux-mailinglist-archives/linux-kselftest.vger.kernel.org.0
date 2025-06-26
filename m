Return-Path: <linux-kselftest+bounces-35916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357CCAEA7B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 22:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED733A22AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 20:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67B12F0E31;
	Thu, 26 Jun 2025 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S8cucvsS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17B2F0021
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968353; cv=none; b=LjrJpkyZuxplGS6oku1mF0AKYnVpnyjtD5N54FXNEqEpSvzkPmFOTF2u5BbuRuhWwTUsKC3C9+yAKwmnb3PT22155QPzq9sfYm5fJ6wrfqMwzzLheRF+psCBactR5Y/0t7xSPQLqh5idB3a8sOUG2qbLggDgoOib6yEo1N7wzLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968353; c=relaxed/simple;
	bh=Eks9aCTcXYvbdNVmdIGtwvOLNkf6fFcYgMML3qNUFtA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sT9jwJ/x9NdoiFJykIPn6ETIiZPqCGcFn8uJLykF4BJzTxgjBE/FkJMJIjDRcxQaFyI6A2h4AEJzBQN+uEZIRklfNkju9fGMQT8qum1y9TTrm/5sBsqgZRZOD9KrhBtHkINb7J3nr/YyE/gJNrGv0rx950DqnCO+BKyHaK3wm3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S8cucvsS; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddbfe1fc8fso28818585ab.2
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750968351; x=1751573151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bfd4g4oyzgO9BbMd8TfR5LoagbwDLdjqmGt8yskowpw=;
        b=S8cucvsS3+f+hdarDt4e8iTKmvhG8uwqWxETV75PJOzvNl4fziOLhk+wbXKyxcu7Nm
         chz1bOmO8W3m3/yIsCpH/WFftVfeKA3PNXuvnF/sz17RCN7w6uaYShCodcfSw51GP1j2
         RChTfVQ+XQ3QdPGlIDtYyadUMIZuFmt3bjMN2ZelGuhJIDq59oC6jwVfk4nTGPvhahpD
         aYV+iuLCKGcZm+dDVqzNNLPThvwbt6BffyRjnlDrefNexHopXrYhZxH9mB9fh8EEeMmw
         UDpywvj+oh+7rbIo2rldRv7cEYI8OQNwDH/61JLuuY6j8TUlJoPcTo25p34/gXzq0jtG
         Efmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968351; x=1751573151;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfd4g4oyzgO9BbMd8TfR5LoagbwDLdjqmGt8yskowpw=;
        b=sETeiTNEenlAK4y/5tQRTD/IknyiOmrRrT8fR6crYxL9lyjDVpClBcKjUl+Ty8NMOb
         PVv0QPP4A1WjO3DwzBnhACzY1sWs9ydRLl/DYv1/XhY0yAdlANTP6GI+aQ+NC9/MHZXp
         96WuDeiwpeJSxgfFNBDiFYxTwjsOWoHSg3f5UaDXJyCm3kqZnXhnURnLJeCg0FdNk/A4
         Gsypat/BZmGH0OxW3H3egQAX5B9hDPHloJ5wZJh4ElWI1XIbpq3zHqVAqw0UzwLCIKMO
         Q0adcmfiPwvYQEOtsHUeDazKHr1siZ/doQ3DzKHOzfZcnF6GWgqR+hxIgLUUU9r2Tnvw
         cN5w==
X-Forwarded-Encrypted: i=1; AJvYcCVZ/3zC7v22aGj5reJ9ZM01yOMGgQLFGBfGuRz/+VI6kdfgGAyklbw5J+xKG+uL8bRhzN48Qdtv0dATKOfhTK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37uNTdctBsGUfgDgmJOlk8aVjSC0RXCTHR0yZONeFkSwtqAL5
	GXFycTjHFe+ZNkv+sbxNvnsmSoAkZIRGSHrCc+iQUTrv1Z2BJhfIJpw36pK+JsfTNY5PusIrSY7
	Eek4xa9gwwiA2PShh3VL5ucQ3MQ==
X-Google-Smtp-Source: AGHT+IG6G2rFRPWkpOW41Pi9fBc/Fkgk+vgjVkKLSP9f2QAlLB5ktW9y9VyZ03BDZAOiaFnbG271ZNfhQM9Y4i+b9Q==
X-Received: from ilbed13.prod.google.com ([2002:a05:6e02:480d:b0:3dd:a3df:9d57])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:174f:b0:3dd:c04e:49af with SMTP id e9e14a558f8ab-3df4ab4eec8mr12720745ab.3.1750968351198;
 Thu, 26 Jun 2025 13:05:51 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:04:36 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626200459.1153955-1-coltonlewis@google.com>
Subject: [PATCH v3 00/22] ARM64 PMU Partitioning
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

This series creates a new PMU scheme on ARM, a partitioned PMU that
allows reserving a subset of counters for more direct guest access,
significantly reducing overhead. More details, including performance
benchmarks, can be read in the v1 cover letter linked below.

v3:

* Return to using one kernel command line parameter for reserved host
  counters, but set the default value meaning no partitioning to -1 so
  0 isn't ambiguous. Adjust checks for partitioning accordingly.

* Move the function kvm_pmu_partition_supported() back out of the
  driver to avoid subbing has_vhe in 32-bit ARM code.

* Fix the kernel test robot build failures, one with KVM and no PMU,
  and one with PMU and no KVM.

* Scan entire series to remove vestigial changes and update comments.

v2:
https://lore.kernel.org/kvm/20250620221326.1261128-1-coltonlewis@google.com/

v1:
https://lore.kernel.org/kvm/20250602192702.2125115-1-coltonlewis@google.com/

Colton Lewis (21):
  arm64: cpufeature: Add cpucap for HPMN0
  arm64: Generate sign macro for sysreg Enums
  KVM: arm64: Define PMI{CNTR,FILTR}_EL0 as undef_access
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
 arch/arm/include/asm/arm_pmuv3.h              |  38 +
 arch/arm64/include/asm/arm_pmuv3.h            |  61 +-
 arch/arm64/include/asm/kvm_host.h             |  18 +-
 arch/arm64/include/asm/kvm_pmu.h              | 100 +++
 arch/arm64/kernel/cpufeature.c                |   8 +
 arch/arm64/kvm/Makefile                       |   2 +-
 arch/arm64/kvm/arm.c                          |  22 +
 arch/arm64/kvm/debug.c                        |  24 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       | 233 ++++++
 arch/arm64/kvm/pmu-emul.c                     | 674 +----------------
 arch/arm64/kvm/pmu-part.c                     | 378 ++++++++++
 arch/arm64/kvm/pmu.c                          | 702 ++++++++++++++++++
 arch/arm64/kvm/sys_regs.c                     |  79 +-
 arch/arm64/tools/cpucaps                      |   1 +
 arch/arm64/tools/gen-sysreg.awk               |   1 +
 arch/arm64/tools/sysreg                       |   6 +-
 drivers/perf/arm_pmuv3.c                      | 123 ++-
 include/linux/perf/arm_pmu.h                  |   6 +
 include/linux/perf/arm_pmuv3.h                |  14 +-
 include/uapi/linux/kvm.h                      |   4 +
 tools/include/uapi/linux/kvm.h                |   2 +
 .../selftests/kvm/arm64/vpmu_counter_access.c |  62 +-
 virt/kvm/kvm_main.c                           |   1 +
 24 files changed, 1828 insertions(+), 752 deletions(-)
 create mode 100644 arch/arm64/kvm/pmu-part.c


base-commit: 79150772457f4d45e38b842d786240c36bb1f97f
--
2.50.0.727.gbf7dc18ff4-goog

