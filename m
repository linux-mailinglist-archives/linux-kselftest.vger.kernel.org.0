Return-Path: <linux-kselftest+bounces-30936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AAFA8B1E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F76F19012E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 07:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545F2227B94;
	Wed, 16 Apr 2025 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBqV5T7C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEAB1DE3C4;
	Wed, 16 Apr 2025 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788135; cv=none; b=uPEug8BF0f4AaCsOVQlPwYWWOuQYsW1c5t+2cpebukT64obAs6GVJkBQ7FAUsNzZR8b8HYBYWuQEqyhgt6WitRqN6Mvx4PRAWax+peT5b0bWvT0Z4zyC/FIKTUlG0/WnmUWMspNxRqtk2FiCQgKpyrxA1Zvv2ChwjEPXfZQatPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788135; c=relaxed/simple;
	bh=Yjz8JsYe32EI3Zt2DAC8/MNOPU+2dMfZe8dcMdGp8vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrkhHQzqXt/bxmkplwTmy3qTgbo5k43yyXz33FA1LXLVzjZJ5lSCypO5K1LUF+s2CoXTCQVjRsWZjhUOftXE3gxzzgW5xRs00FbYBNKIQJU/rO5/XXfnOZelh+pO5oJEIAra62cRHkzlfzYUnLR0VHCGPFsBXR4ZtUcreTPczYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBqV5T7C; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744788133; x=1776324133;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yjz8JsYe32EI3Zt2DAC8/MNOPU+2dMfZe8dcMdGp8vM=;
  b=BBqV5T7CNXLfgm7fwSZOu4id02RaIjgVm0psgN/L8fWATCjH6zQrndvV
   mTXK/Yxpc6612aHs8FNtadGkDYJVgrh6Kc/3irs8OfPbGif2c8QKgbTaP
   9mi4Gx2fJVmN2taNSPWnT7hUtvRI8GsQCY8pboMJ//ZD33JBpR6HNR+kh
   opkRF2tvFoir/uh87DrgcNdt3gkl7NrQoQ4rDo75EBIyy1z3IIaH4VzM2
   ryxyfb6yUXHgAIJZ3km06tbZ2WjzBprVDkYW/jY/kpvVOklWo3VLxbOcO
   qhOOwlNpG+ZQx1TI8xk2Yge1Bq2VrKefAHSI2ENu8DMGcidwci3/RTL+s
   Q==;
X-CSE-ConnectionGUID: yo8y/3TGQ4GMvIew8vKtlQ==
X-CSE-MsgGUID: rgR5ds9uQ3q+v2uXzLeSyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="56957176"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="56957176"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:22:12 -0700
X-CSE-ConnectionGUID: qvnogiapSim7Oj08XxbWEw==
X-CSE-MsgGUID: WWYODVADTzS5gFpT58uSoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="135199152"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:22:05 -0700
Message-ID: <16d8265b-750d-4e3c-aeb1-772d28b6c79c@linux.intel.com>
Date: Wed, 16 Apr 2025 15:22:02 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/38] Mediated vPMU 4.0 for x86
To: Mingwei Zhang <mizhang@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
 Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>,
 Xiong Zhang <xiong.y.zhang@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>,
 Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>,
 Shukla Manali <Manali.Shukla@amd.com>,
 Nikunj Dadhania <nikunj.dadhania@amd.com>
References: <20250324173121.1275209-1-mizhang@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kindly ping... Any comments on this patch series? Thanks.

On 3/25/2025 1:30 AM, Mingwei Zhang wrote:
> With joint effort from the upstream KVM community, we come up with the
> 4th version of mediated vPMU for x86. We have made the following changes
> on top of the previous RFC v3.
>
> v3 -> v4
>  - Rebase whole patchset on 6.14-rc3 base.
>  - Address Peter's comments on Perf part.
>  - Address Sean's comments on KVM part.
>    * Change key word "passthrough" to "mediated" in all patches
>    * Change static enabling to user space dynamic enabling via KVM_CAP_PMU_CAPABILITY.
>    * Only support GLOBAL_CTRL save/restore with VMCS exec_ctrl, drop the MSR
>      save/retore list support for GLOBAL_CTRL, thus the support of mediated
>      vPMU is constrained to SapphireRapids and later CPUs on Intel side.
>    * Merge some small changes into a single patch.
>  - Address Sandipan's comment on invalid pmu pointer.
>  - Add back "eventsel_hw" and "fixed_ctr_ctrl_hw" to avoid to directly
>    manipulate pmc->eventsel and pmu->fixed_ctr_ctrl.
>
>
> Testing (Intel side):
>  - Perf-based legacy vPMU (force emulation on/off)
>    * Kselftests pmu_counters_test, pmu_event_filter_test and
>      vmx_pmu_caps_test pass.
>    * KUT PMU tests pmu, pmu_lbr, pmu_pebs pass.
>    * Basic perf counting/sampling tests in 3 scenarios, guest-only,
>      host-only and host-guest coexistence all pass.
>
>  - Mediated vPMU (force emulation on/off)
>    * Kselftests pmu_counters_test, pmu_event_filter_test and
>      vmx_pmu_caps_test pass.
>    * KUT PMU tests pmu, pmu_lbr, pmu_pebs pass.
>    * Basic perf counting/sampling tests in 3 scenarios, guest-only,
>      host-only and host-guest coexistence all pass.
>
>  - Failures. All above tests passed on Intel Granite Rapids as well
>    except a failure on KUT/pmu_pebs.
>    * GP counter 0 (0xfffffffffffe): PEBS record (written seq 0)
>      is verified (including size, counters and cfg).
>    * The pebs_data_cfg (0xb500000000) doesn't match with the
>      effective MSR_PEBS_DATA_CFG (0x0).
>    * This failure has nothing to do with this mediated vPMU patch set. The
>      failure is caused by Granite Rapids supported timed PEBS which needs
>      extra support on Qemu and KUT/pmu_pebs. These extra support would be
>      sent in separate patches later.
>
>
> Testing (AMD side):
>  - Kselftests pmu_counters_test, pmu_event_filter_test and
>    vmx_pmu_caps_test all pass
>
>  - legacy guest with KUT/pmu:
>    * qmeu option: -cpu host, -perfctr-core
>    * when set force_emulation_prefix=1, passes
>    * when set force_emulation_prefix=0, passes
>  - perfmon-v1 guest with KUT/pmu:
>    * qmeu option: -cpu host, -perfmon-v2
>    * when set force_emulation_prefix=1, passes
>    * when set force_emulation_prefix=0, passes
>  - perfmon-v2 guest with KUT/pmu:
>    * qmeu option: -cpu host
>    * when set force_emulation_prefix=1, passes
>    * when set force_emulation_prefix=0, passes
>
>  - perf_fuzzer (perfmon-v2):
>    * fails with soft lockup in guest in current version.
>    * culprit could be between 6.13 ~ 6.14-rc3 within KVM
>    * Series tested on 6.12 and 6.13 without issue.
>
> Note: a QEMU series is needed to run mediated vPMU v4:
>  - https://lore.kernel.org/all/20250324123712.34096-1-dapeng1.mi@linux.intel.com/
>
> History:
>  - RFC v3: https://lore.kernel.org/all/20240801045907.4010984-1-mizhang@google.com/
>  - RFC v2: https://lore.kernel.org/all/20240506053020.3911940-1-mizhang@google.com/
>  - RFC v1: https://lore.kernel.org/all/20240126085444.324918-1-xiong.y.zhang@linux.intel.com/
>
>
> Dapeng Mi (18):
>   KVM: x86/pmu: Introduce enable_mediated_pmu global parameter
>   KVM: x86/pmu: Check PMU cpuid configuration from user space
>   KVM: x86: Rename vmx_vmentry/vmexit_ctrl() helpers
>   KVM: x86/pmu: Add perf_capabilities field in struct kvm_host_values{}
>   KVM: x86/pmu: Move PMU_CAP_{FW_WRITES,LBR_FMT} into msr-index.h header
>   KVM: VMX: Add macros to wrap around
>     {secondary,tertiary}_exec_controls_changebit()
>   KVM: x86/pmu: Check if mediated vPMU can intercept rdpmc
>   KVM: x86/pmu/vmx: Save/load guest IA32_PERF_GLOBAL_CTRL with
>     vm_exit/entry_ctrl
>   KVM: x86/pmu: Optimize intel/amd_pmu_refresh() helpers
>   KVM: x86/pmu: Setup PMU MSRs' interception mode
>   KVM: x86/pmu: Handle PMU MSRs interception and event filtering
>   KVM: x86/pmu: Switch host/guest PMU context at vm-exit/vm-entry
>   KVM: x86/pmu: Handle emulated instruction for mediated vPMU
>   KVM: nVMX: Add macros to simplify nested MSR interception setting
>   KVM: selftests: Add mediated vPMU supported for pmu tests
>   KVM: Selftests: Support mediated vPMU for vmx_pmu_caps_test
>   KVM: Selftests: Fix pmu_counters_test error for mediated vPMU
>   KVM: x86/pmu: Expose enable_mediated_pmu parameter to user space
>
> Kan Liang (8):
>   perf: Support get/put mediated PMU interfaces
>   perf: Skip pmu_ctx based on event_type
>   perf: Clean up perf ctx time
>   perf: Add a EVENT_GUEST flag
>   perf: Add generic exclude_guest support
>   perf: Add switch_guest_ctx() interface
>   perf/x86: Support switch_guest_ctx interface
>   perf/x86/intel: Support PERF_PMU_CAP_MEDIATED_VPMU
>
> Mingwei Zhang (5):
>   perf/x86: Forbid PMI handler when guest own PMU
>   perf/x86/core: Plumb mediated PMU capability from x86_pmu to
>     x86_pmu_cap
>   KVM: x86/pmu: Exclude PMU MSRs in vmx_get_passthrough_msr_slot()
>   KVM: x86/pmu: introduce eventsel_hw to prepare for pmu event filtering
>   KVM: nVMX: Add nested virtualization support for mediated PMU
>
> Sandipan Das (4):
>   perf/x86/core: Do not set bit width for unavailable counters
>   KVM: x86/pmu: Add AMD PMU registers to direct access list
>   KVM: x86/pmu/svm: Set GuestOnly bit and clear HostOnly bit when guest
>     write to event selectors
>   perf/x86/amd: Support PERF_PMU_CAP_MEDIATED_VPMU for AMD host
>
> Xiong Zhang (3):
>   x86/irq: Factor out common code for installing kvm irq handler
>   perf: core/x86: Register a new vector for KVM GUEST PMI
>   KVM: x86/pmu: Register KVM_GUEST_PMI_VECTOR handler
>
>  arch/x86/events/amd/core.c                    |   2 +
>  arch/x86/events/core.c                        |  40 +-
>  arch/x86/events/intel/core.c                  |   5 +
>  arch/x86/include/asm/hardirq.h                |   1 +
>  arch/x86/include/asm/idtentry.h               |   1 +
>  arch/x86/include/asm/irq.h                    |   2 +-
>  arch/x86/include/asm/irq_vectors.h            |   5 +-
>  arch/x86/include/asm/kvm-x86-pmu-ops.h        |   2 +
>  arch/x86/include/asm/kvm_host.h               |  10 +
>  arch/x86/include/asm/msr-index.h              |  18 +-
>  arch/x86/include/asm/perf_event.h             |   1 +
>  arch/x86/include/asm/vmx.h                    |   1 +
>  arch/x86/kernel/idt.c                         |   1 +
>  arch/x86/kernel/irq.c                         |  39 +-
>  arch/x86/kvm/cpuid.c                          |  15 +
>  arch/x86/kvm/pmu.c                            | 254 ++++++++-
>  arch/x86/kvm/pmu.h                            |  45 ++
>  arch/x86/kvm/svm/pmu.c                        | 148 ++++-
>  arch/x86/kvm/svm/svm.c                        |  26 +
>  arch/x86/kvm/svm/svm.h                        |   2 +-
>  arch/x86/kvm/vmx/capabilities.h               |  11 +-
>  arch/x86/kvm/vmx/nested.c                     |  68 ++-
>  arch/x86/kvm/vmx/pmu_intel.c                  | 224 ++++++--
>  arch/x86/kvm/vmx/vmx.c                        |  89 +--
>  arch/x86/kvm/vmx/vmx.h                        |  11 +-
>  arch/x86/kvm/x86.c                            |  63 ++-
>  arch/x86/kvm/x86.h                            |   2 +
>  include/linux/perf_event.h                    |  47 +-
>  kernel/events/core.c                          | 519 ++++++++++++++----
>  .../beauty/arch/x86/include/asm/irq_vectors.h |   5 +-
>  .../selftests/kvm/include/kvm_test_harness.h  |  13 +
>  .../testing/selftests/kvm/include/kvm_util.h  |   3 +
>  .../selftests/kvm/include/x86/processor.h     |   8 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  23 +
>  .../selftests/kvm/x86/pmu_counters_test.c     |  24 +-
>  .../selftests/kvm/x86/pmu_event_filter_test.c |   8 +-
>  .../selftests/kvm/x86/vmx_pmu_caps_test.c     |   2 +-
>  37 files changed, 1480 insertions(+), 258 deletions(-)
>
>
> base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319

