Return-Path: <linux-kselftest+bounces-29651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E59A6E0DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962F118921F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EF3262815;
	Mon, 24 Mar 2025 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHbEn9wx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A311264627
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837573; cv=none; b=ADScyHlCSoAMnRq/5U/YNkrUWO706eTU04q5Zuu3dsQQXa3FLdurg0SAZ5gyQTIfljvfDovgzFZzUYsZp54rLngWlsAMFqO3JnKeALS7NQ69ezzFMmqkfOd+EDhiMCFkaPb8I2KMIIlnFeu11PRdFL0Xv3uUkbAIsXmnxoo2lOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837573; c=relaxed/simple;
	bh=ns6IVR+9eS1Ct7L+hYF/H0j1VWw1/j+2M8bSahnNIo0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FAB3usEUJslSfp3RO+pMXmc9sYGNjj/2AGPhEIg1QqRH0Mz6v3/YWXsUWwzhuyDTNO/qeS50jZrZPM8zrHuO1W1sznnUVOJAAcvc8QBilS45TT7Sf2PASW/GKgoI5Aa8CiKawmnFFWOxGPY+Th2N7CafjyOmXALH+ox0N2DXsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHbEn9wx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so7703718a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837571; x=1743442371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfMLH3rqgleI/aBZTARPJu5z53tR8J9ShVcEnY7ciB4=;
        b=IHbEn9wxtHYYyNrU5sinD9c546/hY+hfOYBlXJFwHW68nifrlW5SwuLO8oENutyiha
         QLpx2n3jU7fIwpKQup384plT/C/0ENtmgOp3V8VSQTV4thQji7eh1RMcDp5gyRzIQhvv
         T9TmNglJFsBPJZbwBquR+krxv1usUD5OEhYhJBwmyBVzteDzkmC3PAFOAG8ROzJQmyNX
         riSq67NAsUlfI+hDNR0jKvwIdWC+4HKkJX3wlgVPusXo+JH/gpuiVO3r0OD0GO7U5/9r
         vlcnXlmI+f1azEtKIX1UO+Db3ydkl207KpNLh0RrcyjG6njziXpz0PTYWpzlE+2PggdV
         hqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837571; x=1743442371;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfMLH3rqgleI/aBZTARPJu5z53tR8J9ShVcEnY7ciB4=;
        b=Q2uzoSui3DKnSaF2fpX75YFHGuSAr2DGqz+QL36btQVgMHHspl3rdfdB7eMOsUYkIA
         3FIt2uK2g3ILt225HnTliaPUF9wVcNV+zG7LfF11r3Vdc6gtShQeaInlTbVAiyWau1Tt
         /Alu+U9g69/YQoix2cLRhJL4A8XZSgAo82tXD+xHJXKsPFmRc4m4MxbQBwKucbU4xXG6
         4OqPJYt8cKVZyUDPa71ddxBM3OEO2y1dyPUlzxbboQmaVxyrCuKzdObNXGlx9T2PxRWW
         BBcRfm59cBKacRSDhGex2hdtODcMsKOMMmicfoMcDVIXLV/2QDIiYpL3jGzHmwiHrlNg
         lZcg==
X-Forwarded-Encrypted: i=1; AJvYcCWIcKn3vtsUB5m44JI9YbSZ26EvYE22v8zriqKwV1eTkkNjqnCWROetWv2Gsm3vAWu4TVvdRMhiWfwvYyZf8MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzglbFddKz6I9gs2GsjjU3C0eUlBHomUjTdp+OxXj3gI34nlIgX
	PpMMAxARWdafR94ikBL3hkbstNZl5iiUeHwCUa24uvzkqmME8tBb6MhTIIxdHDxFMDTkfvGEQa5
	iRqz/+w==
X-Google-Smtp-Source: AGHT+IEn90T9acZBPXafH0WAWPaP+EENE+9xcIlkfTKHALEEiO8S7Jq+19E4fERk3XoFCcctM65dSpY6ReuU
X-Received: from pgbcr9.prod.google.com ([2002:a05:6a02:4109:b0:af2:5c9b:c55d])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1707:b0:1f5:889c:3cdb
 with SMTP id adf61e73a8af0-1fe42f2a1fbmr24139144637.8.1742837571368; Mon, 24
 Mar 2025 10:32:51 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:40 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-1-mizhang@google.com>
Subject: [PATCH v4 00/38] Mediated vPMU 4.0 for x86
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

With joint effort from the upstream KVM community, we come up with the
4th version of mediated vPMU for x86. We have made the following changes
on top of the previous RFC v3.

v3 -> v4
 - Rebase whole patchset on 6.14-rc3 base.
 - Address Peter's comments on Perf part.
 - Address Sean's comments on KVM part.
   * Change key word "passthrough" to "mediated" in all patches
   * Change static enabling to user space dynamic enabling via KVM_CAP_PMU_CAPABILITY.
   * Only support GLOBAL_CTRL save/restore with VMCS exec_ctrl, drop the MSR
     save/retore list support for GLOBAL_CTRL, thus the support of mediated
     vPMU is constrained to SapphireRapids and later CPUs on Intel side.
   * Merge some small changes into a single patch.
 - Address Sandipan's comment on invalid pmu pointer.
 - Add back "eventsel_hw" and "fixed_ctr_ctrl_hw" to avoid to directly
   manipulate pmc->eventsel and pmu->fixed_ctr_ctrl.


Testing (Intel side):
 - Perf-based legacy vPMU (force emulation on/off)
   * Kselftests pmu_counters_test, pmu_event_filter_test and
     vmx_pmu_caps_test pass.
   * KUT PMU tests pmu, pmu_lbr, pmu_pebs pass.
   * Basic perf counting/sampling tests in 3 scenarios, guest-only,
     host-only and host-guest coexistence all pass.

 - Mediated vPMU (force emulation on/off)
   * Kselftests pmu_counters_test, pmu_event_filter_test and
     vmx_pmu_caps_test pass.
   * KUT PMU tests pmu, pmu_lbr, pmu_pebs pass.
   * Basic perf counting/sampling tests in 3 scenarios, guest-only,
     host-only and host-guest coexistence all pass.

 - Failures. All above tests passed on Intel Granite Rapids as well
   except a failure on KUT/pmu_pebs.
   * GP counter 0 (0xfffffffffffe): PEBS record (written seq 0)
     is verified (including size, counters and cfg).
   * The pebs_data_cfg (0xb500000000) doesn't match with the
     effective MSR_PEBS_DATA_CFG (0x0).
   * This failure has nothing to do with this mediated vPMU patch set. The
     failure is caused by Granite Rapids supported timed PEBS which needs
     extra support on Qemu and KUT/pmu_pebs. These extra support would be
     sent in separate patches later.


Testing (AMD side):
 - Kselftests pmu_counters_test, pmu_event_filter_test and
   vmx_pmu_caps_test all pass

 - legacy guest with KUT/pmu:
   * qmeu option: -cpu host, -perfctr-core
   * when set force_emulation_prefix=1, passes
   * when set force_emulation_prefix=0, passes
 - perfmon-v1 guest with KUT/pmu:
   * qmeu option: -cpu host, -perfmon-v2
   * when set force_emulation_prefix=1, passes
   * when set force_emulation_prefix=0, passes
 - perfmon-v2 guest with KUT/pmu:
   * qmeu option: -cpu host
   * when set force_emulation_prefix=1, passes
   * when set force_emulation_prefix=0, passes

 - perf_fuzzer (perfmon-v2):
   * fails with soft lockup in guest in current version.
   * culprit could be between 6.13 ~ 6.14-rc3 within KVM
   * Series tested on 6.12 and 6.13 without issue.

Note: a QEMU series is needed to run mediated vPMU v4:
 - https://lore.kernel.org/all/20250324123712.34096-1-dapeng1.mi@linux.intel.com/

History:
 - RFC v3: https://lore.kernel.org/all/20240801045907.4010984-1-mizhang@google.com/
 - RFC v2: https://lore.kernel.org/all/20240506053020.3911940-1-mizhang@google.com/
 - RFC v1: https://lore.kernel.org/all/20240126085444.324918-1-xiong.y.zhang@linux.intel.com/


Dapeng Mi (18):
  KVM: x86/pmu: Introduce enable_mediated_pmu global parameter
  KVM: x86/pmu: Check PMU cpuid configuration from user space
  KVM: x86: Rename vmx_vmentry/vmexit_ctrl() helpers
  KVM: x86/pmu: Add perf_capabilities field in struct kvm_host_values{}
  KVM: x86/pmu: Move PMU_CAP_{FW_WRITES,LBR_FMT} into msr-index.h header
  KVM: VMX: Add macros to wrap around
    {secondary,tertiary}_exec_controls_changebit()
  KVM: x86/pmu: Check if mediated vPMU can intercept rdpmc
  KVM: x86/pmu/vmx: Save/load guest IA32_PERF_GLOBAL_CTRL with
    vm_exit/entry_ctrl
  KVM: x86/pmu: Optimize intel/amd_pmu_refresh() helpers
  KVM: x86/pmu: Setup PMU MSRs' interception mode
  KVM: x86/pmu: Handle PMU MSRs interception and event filtering
  KVM: x86/pmu: Switch host/guest PMU context at vm-exit/vm-entry
  KVM: x86/pmu: Handle emulated instruction for mediated vPMU
  KVM: nVMX: Add macros to simplify nested MSR interception setting
  KVM: selftests: Add mediated vPMU supported for pmu tests
  KVM: Selftests: Support mediated vPMU for vmx_pmu_caps_test
  KVM: Selftests: Fix pmu_counters_test error for mediated vPMU
  KVM: x86/pmu: Expose enable_mediated_pmu parameter to user space

Kan Liang (8):
  perf: Support get/put mediated PMU interfaces
  perf: Skip pmu_ctx based on event_type
  perf: Clean up perf ctx time
  perf: Add a EVENT_GUEST flag
  perf: Add generic exclude_guest support
  perf: Add switch_guest_ctx() interface
  perf/x86: Support switch_guest_ctx interface
  perf/x86/intel: Support PERF_PMU_CAP_MEDIATED_VPMU

Mingwei Zhang (5):
  perf/x86: Forbid PMI handler when guest own PMU
  perf/x86/core: Plumb mediated PMU capability from x86_pmu to
    x86_pmu_cap
  KVM: x86/pmu: Exclude PMU MSRs in vmx_get_passthrough_msr_slot()
  KVM: x86/pmu: introduce eventsel_hw to prepare for pmu event filtering
  KVM: nVMX: Add nested virtualization support for mediated PMU

Sandipan Das (4):
  perf/x86/core: Do not set bit width for unavailable counters
  KVM: x86/pmu: Add AMD PMU registers to direct access list
  KVM: x86/pmu/svm: Set GuestOnly bit and clear HostOnly bit when guest
    write to event selectors
  perf/x86/amd: Support PERF_PMU_CAP_MEDIATED_VPMU for AMD host

Xiong Zhang (3):
  x86/irq: Factor out common code for installing kvm irq handler
  perf: core/x86: Register a new vector for KVM GUEST PMI
  KVM: x86/pmu: Register KVM_GUEST_PMI_VECTOR handler

 arch/x86/events/amd/core.c                    |   2 +
 arch/x86/events/core.c                        |  40 +-
 arch/x86/events/intel/core.c                  |   5 +
 arch/x86/include/asm/hardirq.h                |   1 +
 arch/x86/include/asm/idtentry.h               |   1 +
 arch/x86/include/asm/irq.h                    |   2 +-
 arch/x86/include/asm/irq_vectors.h            |   5 +-
 arch/x86/include/asm/kvm-x86-pmu-ops.h        |   2 +
 arch/x86/include/asm/kvm_host.h               |  10 +
 arch/x86/include/asm/msr-index.h              |  18 +-
 arch/x86/include/asm/perf_event.h             |   1 +
 arch/x86/include/asm/vmx.h                    |   1 +
 arch/x86/kernel/idt.c                         |   1 +
 arch/x86/kernel/irq.c                         |  39 +-
 arch/x86/kvm/cpuid.c                          |  15 +
 arch/x86/kvm/pmu.c                            | 254 ++++++++-
 arch/x86/kvm/pmu.h                            |  45 ++
 arch/x86/kvm/svm/pmu.c                        | 148 ++++-
 arch/x86/kvm/svm/svm.c                        |  26 +
 arch/x86/kvm/svm/svm.h                        |   2 +-
 arch/x86/kvm/vmx/capabilities.h               |  11 +-
 arch/x86/kvm/vmx/nested.c                     |  68 ++-
 arch/x86/kvm/vmx/pmu_intel.c                  | 224 ++++++--
 arch/x86/kvm/vmx/vmx.c                        |  89 +--
 arch/x86/kvm/vmx/vmx.h                        |  11 +-
 arch/x86/kvm/x86.c                            |  63 ++-
 arch/x86/kvm/x86.h                            |   2 +
 include/linux/perf_event.h                    |  47 +-
 kernel/events/core.c                          | 519 ++++++++++++++----
 .../beauty/arch/x86/include/asm/irq_vectors.h |   5 +-
 .../selftests/kvm/include/kvm_test_harness.h  |  13 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/include/x86/processor.h     |   8 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  23 +
 .../selftests/kvm/x86/pmu_counters_test.c     |  24 +-
 .../selftests/kvm/x86/pmu_event_filter_test.c |   8 +-
 .../selftests/kvm/x86/vmx_pmu_caps_test.c     |   2 +-
 37 files changed, 1480 insertions(+), 258 deletions(-)


base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
-- 
2.49.0.395.g12beb8f557-goog


