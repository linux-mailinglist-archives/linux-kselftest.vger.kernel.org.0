Return-Path: <linux-kselftest+bounces-19442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 675D0998B16
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 17:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BDC4B27A49
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0206B1E7C32;
	Thu, 10 Oct 2024 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJfgSzbL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73E1E7C2A;
	Thu, 10 Oct 2024 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570738; cv=none; b=Cnodi4Oi82n5gYyLILDqXE9QRmWUsgPQeyJosbNbzSIiURBASXKiwPdjiP4+UIvH6FsRjhrBnQsOdOiUAGaHA/exx93u9/Ezm8F/PFUM7B0WKAyGG9Y7yLECas9mKrVR3eT0OOP40gzzLe40i8dMkhDVRnjknxOq6jmi7s8GHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570738; c=relaxed/simple;
	bh=PcLiUmuIFS57SZqP5FBkB4AHmgGu1wlTTsHLIRKAx7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gv2Ppebki3RRIwmIR6iQNNjpbhd7uiUUIE01scJrMntBxux6hsnL3RrOh2AnKoDZvV1SDWpVvc/YPnx36gRfAA5q+l+rFreaQl5IMvjwfMSJBLjwg5hm8P2ar8Y70PeXr9Qud9n0tdJXwgLxmYdWtzq2OfRZS+/X62fY/kO30WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJfgSzbL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728570737; x=1760106737;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PcLiUmuIFS57SZqP5FBkB4AHmgGu1wlTTsHLIRKAx7I=;
  b=cJfgSzbLiWhBxDgYBNY+Zpm5yAz1LflulPDdQGT32LVChyoeGtjy4pMF
   mGS2jJG7vMt7fRw/aLiqwYEsZEPucZc263gtNm1sVbGxwh1SsIwXQ6Ruy
   Z0Rbcqnu9LtpH5XNZXyA68D0IVKN/fTqBfJjwO4aC82DLy0qzXWbSjBP7
   pjBv8OnLxtvfrU0ckdpRUJzdGBVh+fGf9ZU86XVStngnvV982hoYo9YOs
   L48sMShzw9qHrSOxhQfdbHw9WSTnyXMa8nUl9kY4VAqcJfq8VLhvm1wcf
   pgKo61sAUdGW9jku/Nce3crKysIuHGdSVyVFGld5dxmx+G1p19R7Fy9n1
   Q==;
X-CSE-ConnectionGUID: U++vaWOZSHOT9+mc0qgmpQ==
X-CSE-MsgGUID: 8VWZZ28LSpa0Ddo0JnlaXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28064015"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28064015"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:32:15 -0700
X-CSE-ConnectionGUID: 2swOpTqbTy+fdrh15pROEQ==
X-CSE-MsgGUID: /rWj06sdSS+ikF7a/CUKYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81188893"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.16.81])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:32:05 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	kvm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V12 00/14] perf/core: Add ability for an event to "pause" or "resume" AUX area tracing
Date: Thu, 10 Oct 2024 17:31:37 +0300
Message-ID: <20241010143152.19071-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi

Note for V12:
	There was a small conflict between the Intel PT changes in
	"KVM: x86: Fix Intel PT Host/Guest mode when host tracing" and the
	changes in this patch set, so I have put the patch sets together,
	along with outstanding fix "perf/x86/intel/pt: Fix buffer full but
	size is 0 case"

	Cover letter for KVM changes (patches 2 to 4):

	There is a long-standing problem whereby running Intel PT on host and guest
	in Host/Guest mode, causes VM-Entry failure.

	The motivation for this patch set is to provide a fix for stable kernels
	prior to the advent of the "Mediated Passthrough vPMU" patch set:

		https://lore.kernel.org/kvm/20240801045907.4010984-1-mizhang@google.com/

	which would render a large part of the fix unnecessary but likely not be
	suitable for backport to stable due to its size and complexity.

	Ideally, this patch set would be applied before "Mediated Passthrough vPMU"

	Note that the fix does not conflict with "Mediated Passthrough vPMU", it
	is just that "Mediated Passthrough vPMU" will make the code to stop and
	restart Intel PT unnecessary.

Note for V11:
	Moving aux_paused into a union within struct hw_perf_event caused
	a regression because aux_paused was being written unconditionally
	even though it is valid only for AUX (e.g. Intel PT) PMUs.
	That is fixed in V11.

Hardware traces, such as instruction traces, can produce a vast amount of
trace data, so being able to reduce tracing to more specific circumstances
can be useful.

The ability to pause or resume tracing when another event happens, can do
that.

These patches add such a facilty and show how it would work for Intel
Processor Trace.

Maintainers of other AUX area tracing implementations are requested to
consider if this is something they might employ and then whether or not
the ABI would work for them.  Note, thank you to James Clark (ARM) for
evaluating the API for Coresight.  Suzuki K Poulose (ARM) also responded
positively to the RFC.

Changes to perf tools are now (since V4) fleshed out.

Please note, Intel® Architecture Instruction Set Extensions and Future
Features Programming Reference March 2024 319433-052, currently:

	https://cdrdv2.intel.com/v1/dl/getContent/671368

introduces hardware pause / resume for Intel PT in a feature named
Intel PT Trigger Tracing.

For that more fields in perf_event_attr will be necessary.  The main
differences are:
	- it can be applied not just to overflows, but optionally to
	every event
	- a packet is emitted into the trace, optionally with IP
	information
	- no PMI
	- works with PMC and DR (breakpoint) events only

Here are the proposed additions to perf_event_attr, please comment:

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 0c557f0a17b3..05dcc43f11bb 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -369,6 +369,22 @@ enum perf_event_read_format {
 	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
+enum {
+	PERF_AUX_ACTION_START_PAUSED		=   1U << 0,
+	PERF_AUX_ACTION_PAUSE			=   1U << 1,
+	PERF_AUX_ACTION_RESUME			=   1U << 2,
+	PERF_AUX_ACTION_EMIT			=   1U << 3,
+	PERF_AUX_ACTION_NR			= 0x1f << 4,
+	PERF_AUX_ACTION_NO_IP			=   1U << 9,
+	PERF_AUX_ACTION_PAUSE_ON_EVT		=   1U << 10,
+	PERF_AUX_ACTION_RESUME_ON_EVT		=   1U << 11,
+	PERF_AUX_ACTION_EMIT_ON_EVT		=   1U << 12,
+	PERF_AUX_ACTION_NR_ON_EVT		= 0x1f << 13,
+	PERF_AUX_ACTION_NO_IP_ON_EVT		=   1U << 18,
+	PERF_AUX_ACTION_MASK			= ~PERF_AUX_ACTION_START_PAUSED,
+	PERF_AUX_PAUSE_RESUME_MASK		= PERF_AUX_ACTION_PAUSE | PERF_AUX_ACTION_RESUME,
+};
+
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
 #define PERF_ATTR_SIZE_VER1	72	/* add: config2 */
 #define PERF_ATTR_SIZE_VER2	80	/* add: branch_sample_type */
@@ -515,10 +531,19 @@ struct perf_event_attr {
 	union {
 		__u32	aux_action;
 		struct {
-			__u32	aux_start_paused :  1, /* start AUX area tracing paused */
-				aux_pause        :  1, /* on overflow, pause AUX area tracing */
-				aux_resume       :  1, /* on overflow, resume AUX area tracing */
-				__reserved_3     : 29;
+			__u32	aux_start_paused  :  1, /* start AUX area tracing paused */
+				aux_pause         :  1, /* on overflow, pause AUX area tracing */
+				aux_resume        :  1, /* on overflow, resume AUX area tracing */
+				aux_emit          :  1, /* generate AUX records instead of events */
+				aux_nr            :  5, /* AUX area tracing reference number */
+				aux_no_ip         :  1, /* suppress IP in AUX records */
+				/* Following apply to event occurrence not overflows */
+				aux_pause_on_evt  :  1, /* on event, pause AUX area tracing */
+				aux_resume_on_evt :  1, /* on event, resume AUX area tracing */
+				aux_emit_on_evt   :  1, /* generate AUX records instead of events */
+				aux_nr_on_evt     :  5, /* AUX area tracing reference number */
+				aux_no_ip_on_evt  :  1, /* suppress IP in AUX records */
+				__reserved_3      : 13;
 		};
 	};


Changes in V12:
	Add previously sent patch "perf/x86/intel/pt: Fix buffer full
	but size is 0 case"

	Add previously sent patch set "KVM: x86: Fix Intel PT Host/Guest
	mode when host tracing"

	Rebase on current tip plus patch set "KVM: x86: Fix Intel PT Host/Guest
	mode when host tracing"

Changes in V11:
      perf/core: Add aux_pause, aux_resume, aux_start_paused
	Make assignment to event->hw.aux_paused conditional on
	(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE).

      perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
	Remove definition of has_aux_action() because it has
	already been added as an inline function.

      perf/x86/intel/pt: Fix sampling synchronization
      perf tools: Enable evsel__is_aux_event() to work for ARM/ARM64
      perf tools: Enable evsel__is_aux_event() to work for S390_CPUMSF
	Dropped because they have already been applied

Changes in V10:
      perf/core: Add aux_pause, aux_resume, aux_start_paused
	Move aux_paused into a union within struct hw_perf_event.
	Additional comment wrt PERF_EF_PAUSE/PERF_EF_RESUME.
	Factor out has_aux_action() as an inline function.
	Use scoped_guard for irqsave.
	Move calls of perf_event_aux_pause() from __perf_event_output()
	to __perf_event_overflow().

Changes in V9:
      perf/x86/intel/pt: Fix sampling synchronization
	New patch

      perf/core: Add aux_pause, aux_resume, aux_start_paused
	Move aux_paused to struct hw_perf_event

      perf/x86/intel/pt: Add support for pause / resume
	Add more comments and barriers for resume_allowed and
	pause_allowed
	Always use WRITE_ONCE with resume_allowed


Changes in V8:

      perf tools: Parse aux-action
	Fix clang warning:
	     util/auxtrace.c:821:7: error: missing field 'aux_action' initializer [-Werror,-Wmissing-field-initializers]
	     821 |         {NULL},
	         |              ^

Changes in V7:

	Add Andi's Reviewed-by for patches 2-12
	Re-base

Changes in V6:

      perf/core: Add aux_pause, aux_resume, aux_start_paused
	Removed READ/WRITE_ONCE from __perf_event_aux_pause()
	Expanded comment about guarding against NMI

Changes in V5:

    perf/core: Add aux_pause, aux_resume, aux_start_paused
	Added James' Ack

    perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
	New patch

    perf tools
	Added Ian's Ack

Changes in V4:

    perf/core: Add aux_pause, aux_resume, aux_start_paused
	Rename aux_output_cfg -> aux_action
	Reorder aux_action bits from:
		aux_pause, aux_resume, aux_start_paused
	to:
		aux_start_paused, aux_pause, aux_resume
	Fix aux_action bits __u64 -> __u32

    coresight: Have a stab at support for pause / resume
	Dropped

    perf tools
	All new patches

Changes in RFC V3:

    coresight: Have a stab at support for pause / resume
	'mode' -> 'flags' so it at least compiles

Changes in RFC V2:

	Use ->stop() / ->start() instead of ->pause_resume()
	Move aux_start_paused bit into aux_output_cfg
	Tighten up when Intel PT pause / resume is allowed
	Add an example of how it might work for CoreSight


Adrian Hunter (14):
      perf/x86/intel/pt: Fix buffer full but size is 0 case
      KVM: x86: Fix Intel PT IA32_RTIT_CTL MSR validation
      KVM: x86: Fix Intel PT Host/Guest mode when host tracing also
      KVM: selftests: Add guest Intel PT test
      perf/core: Add aux_pause, aux_resume, aux_start_paused
      perf/x86/intel/pt: Add support for pause / resume
      perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
      perf tools: Add aux_start_paused, aux_pause and aux_resume
      perf tools: Add aux-action config term
      perf tools: Parse aux-action
      perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
      perf intel-pt: Improve man page format
      perf intel-pt: Add documentation for pause / resume
      perf intel-pt: Add a test for pause / resume

 arch/x86/events/intel/core.c                       |   4 +-
 arch/x86/events/intel/pt.c                         | 209 +++++++-
 arch/x86/events/intel/pt.h                         |  16 +
 arch/x86/include/asm/intel_pt.h                    |   4 +
 arch/x86/kvm/vmx/vmx.c                             |  26 +-
 arch/x86/kvm/vmx/vmx.h                             |   1 -
 include/linux/perf_event.h                         |  28 +
 include/uapi/linux/perf_event.h                    |  11 +-
 kernel/events/core.c                               |  72 ++-
 kernel/events/internal.h                           |   1 +
 tools/include/uapi/linux/perf_event.h              |  11 +-
 tools/perf/Documentation/perf-intel-pt.txt         | 596 +++++++++++++--------
 tools/perf/Documentation/perf-record.txt           |   4 +
 tools/perf/builtin-record.c                        |   4 +-
 tools/perf/tests/shell/test_intel_pt.sh            |  28 +
 tools/perf/util/auxtrace.c                         |  67 ++-
 tools/perf/util/auxtrace.h                         |   6 +-
 tools/perf/util/evsel.c                            |  13 +-
 tools/perf/util/evsel.h                            |   1 +
 tools/perf/util/evsel_config.h                     |   1 +
 tools/perf/util/parse-events.c                     |  10 +
 tools/perf/util/parse-events.h                     |   1 +
 tools/perf/util/parse-events.l                     |   1 +
 tools/perf/util/perf_event_attr_fprintf.c          |   3 +
 tools/perf/util/pmu.c                              |   1 +
 tools/testing/selftests/kvm/Makefile               |   1 +
 .../selftests/kvm/include/x86_64/processor.h       |   1 +
 tools/testing/selftests/kvm/x86_64/intel_pt.c      | 381 +++++++++++++
 28 files changed, 1238 insertions(+), 264 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/intel_pt.c


Regards
Adrian

