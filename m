Return-Path: <linux-kselftest+bounces-1566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D0E80D0BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21CA8B20DFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 16:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619664C605;
	Mon, 11 Dec 2023 16:13:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A647F3;
	Mon, 11 Dec 2023 08:13:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 782621007;
	Mon, 11 Dec 2023 08:14:39 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 053963F738;
	Mon, 11 Dec 2023 08:13:48 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	suzuki.poulose@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Cc: namhyung@gmail.com,
	James Clark <james.clark@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Zaid Al-Bassam <zalbassam@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 00/11] arm64: perf: Add support for event counting threshold
Date: Mon, 11 Dec 2023 16:13:12 +0000
Message-Id: <20231211161331.1277825-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v6:

  * Remove inlines from arm_pmuv3.c
  * Use format attribute mechanism from SPE
  * Re-arrange attributes so that threshold comes last and can
    potentially be extended
  * Emit an error if the max threshold is exceeded rather than clamping
  * Convert all register fields to GENMASK

Changes since v5:
  * Restructure the docs and add some more explanations
  * PMMIR.WIDTH -> PMMIR.THWIDTH in one comment
  * Don't write EVTYPER.TC if TH is 0. Doesn't have any functional
    effect but it might be a bit easier to understand the code.
  * Expand the format field #define names

Changes since v4:

  * Rebase onto v6.7-rc1, it no longer depends on kvmarm/next
  * Remove change that moved ARMV8_PMU_EVTYPE_MASK to the asm files.
    This actually depended on those files being included in a certain
    order with arm_pmuv3.h to avoid circular includes. Now the
    definition is done programmatically in arm_pmuv3.c instead.

Changes since v3:

  * Drop #include changes to KVM source files because since
    commit bc512d6a9b92 ("KVM: arm64: Make PMEVTYPER<n>_EL0.NSH RES0 if
    EL2 isn't advertised"), KVM doesn't use ARMV8_PMU_EVTYPE_MASK
    anymore

Changes since v2:

  * Split threshold_control attribute into two, threshold_compare and
    threshold_count so that it's easier to use
  * Add some notes to the first commit message and the cover letter
    about the behavior in KVM
  * Update the docs commit with regards to the split attribute
 
Changes since v1:

  * Fix build on aarch32 by disabling FEAT_PMUv3_TH and splitting event
    type mask between the platforms
  * Change armv8pmu_write_evtype() to take unsigned long instead of u64
    so it isn't unnecessarily wide on aarch32
  * Add UL suffix to aarch64 event type mask definition

----

FEAT_PMUv3_TH (Armv8.8) is a new feature that allows conditional
counting of PMU events depending on how much the event increments on
a single cycle. Two new config fields for perf_event_open have been
added, and a PMU cap file for reading the max_threshold. See the second
commit message and the docs in the last commit for more details.

The feature is not currently supported on KVM guests, and PMMIR is set
to read as zero, so it's not advertised as available. But it can be
added at a later time. Writes to PMEVTYPER.TC and TH from guests are
already RES0.

The change has been validated on the Arm FVP model:

  # Zero values, works as expected (as before).
  $ perf stat -e dtlb_walk/threshold=0,threshold_compare=0/ -- true

    5962      dtlb_walk/threshold=0,threshold_compare=0/

  # Threshold >= 255 causes count to be 0 because dtlb_walk doesn't
  # increase by more than 1 per cycle.
  $ perf stat -e dtlb_walk/threshold=255,threshold_compare=2/ -- true

    0      dtlb_walk/threshold=255,threshold_compare=2/
  
  # Keeping comparison as >= but lowering the threshold to 1 makes the
  # count return.
  $ perf stat -e dtlb_walk/threshold=1,threshold_compare=2/ -- true

    6329      dtlb_walk/threshold=1,threshold_compare=2/

James Clark (11):
  arm: perf: Remove inlines from arm_pmuv3.c
  arm: perf/kvm: Use GENMASK for ARMV8_PMU_PMCR_N
  arm: perf: Use GENMASK for PMMIR fields
  arm: perf: Convert remaining fields to use GENMASK
  arm64: perf: Include threshold control fields in PMEVTYPER mask
  arm: pmu: Share user ABI format mechanism with SPE
  perf/arm_dmc620: Remove duplicate format attribute #defines
  KVM: selftests: aarch64: Update tools copy of arm_pmuv3.h
  arm: pmu: Move error message and -EOPNOTSUPP to individual PMUs
  arm64: perf: Add support for event counting threshold
  Documentation: arm64: Document the PMU event counting threshold
    feature

 Documentation/arch/arm64/perf.rst             |  72 +++++++
 arch/arm/kernel/perf_event_v7.c               |   6 +-
 arch/arm64/kvm/pmu-emul.c                     |   8 +-
 arch/arm64/kvm/sys_regs.c                     |   4 +-
 drivers/perf/apple_m1_cpu_pmu.c               |   6 +-
 drivers/perf/arm_dmc620_pmu.c                 |  22 +--
 drivers/perf/arm_pmu.c                        |  11 +-
 drivers/perf/arm_pmuv3.c                      | 175 ++++++++++++++----
 drivers/perf/arm_spe_pmu.c                    |  22 ---
 include/linux/perf/arm_pmu.h                  |  22 +++
 include/linux/perf/arm_pmuv3.h                |  34 ++--
 tools/include/perf/arm_pmuv3.h                |  43 +++--
 .../kvm/aarch64/vpmu_counter_access.c         |   5 +-
 13 files changed, 296 insertions(+), 134 deletions(-)

-- 
2.34.1


