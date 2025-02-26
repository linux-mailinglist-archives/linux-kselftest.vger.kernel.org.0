Return-Path: <linux-kselftest+bounces-27541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8F1A451E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 02:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CF03A9FE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 01:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BED153BE8;
	Wed, 26 Feb 2025 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFCiMIFa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D16563CF;
	Wed, 26 Feb 2025 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532056; cv=none; b=OHozBbikioVRc2h3gBZs7XAESn9YJ9RMb1qWh3hhg6cZ/wt63ivo3yjADzFdPF/cVvIxll7Qbuj5KD38MOA2UE9FlE5pn99LKs0SDxx3wpl4I2+X/1sieHweHhPC4CeLusyIrRGiL6j3jmAFveKgBQvMSyXwP61L1cTcDySJsQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532056; c=relaxed/simple;
	bh=eYDNCmtkmFlzVyVO7qge4AhwAqruXRUwlcg/pjbp2b4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XAVO2/A/pVeBLUPwLt3ZOgSuiCTmLT90eXbTA/+kXgJqYHgIA5dRreNfhYwCx0hwksM3Ggkbv3UG61stY8BPo15ItDLzftIP3+WUgmZmiXv0CSLgL0n2XB1UCJe/zNIoBoid+8rGJrWZ9wSjuzsxByuZ46v1RPzX7wIwyMYiE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFCiMIFa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532054; x=1772068054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eYDNCmtkmFlzVyVO7qge4AhwAqruXRUwlcg/pjbp2b4=;
  b=iFCiMIFarUoyBXD+g4WCE0ky9fCA1JAUpzaz7VidaMfWHVr3ittB4Jkx
   XDQh960hkHc/NvoKLa2fv+/FHisqeY8a0wcCqboJUaopqQSPt2YAnEMt4
   0PujsQrffOTOJdmi0B+0cMGHDFuv85W7BQFmaTJgUKTnxIXVcfk4yG7wU
   tCfrKnciI5LOpYWPfcsYgK5rGDXNDwxGL4j9S8NnM1Ner4PIXFDYUAWN6
   cu7f4K2QvCC8LuYHDzyVVC9+0fppXPYU1fEzhiJVKegWGenpY7yvwKen1
   Bmo4is3pDV+Mna5kh6RHN3TRNfaqBUozFN7Ik/t99jNwgrAeJ6qRlQgQt
   Q==;
X-CSE-ConnectionGUID: RU3XitX4TsukX3KPi21Bgw==
X-CSE-MsgGUID: aj632BOzRtSxW4sQ6ZJifA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52362176"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52362176"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:07:33 -0800
X-CSE-ConnectionGUID: AWdVZjqZR/K77cmw8oo8yg==
X-CSE-MsgGUID: br/EYFkMRsKS4R3Drrb/NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147467330"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.166.169])
  by fmviesa001.fm.intel.com with ESMTP; 25 Feb 2025 17:07:32 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	shuah@kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH 0/9] selftests/x86/xstate: Introduce common code for testing extended states
Date: Tue, 25 Feb 2025 17:07:20 -0800
Message-ID: <20250226010731.2456-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This series proposes a rework of xstate-related tests to improve
maintainability and expand test coverage.

== Motivation: Addressing Missing and New XSTATE Tests ==

With the introduction of AMX, a new test suite [1] was created to verify
dynamic state handling by the kernel as observed from userspace. However,
previous tests for non-dynamic states like AVX lacked ABI validation,
leaving gaps in coverage. While these states currently function without
major issues (following the alternate sigstack fix [2]), xstate testing
in the x86 selftest suite has been largely overlooked.

Now, with Intel introducing another extended state, Advanced Performance
Extensions (APX) [3], a correspondent test case is need. The APX enabling
series will follow shortly and will leverage this refactored selftest
framework.

== Selftest Code Rework ==

To ensure ABI validation and core functionality across various xstates,
refactoring the test code is necessary. Without this, existing code from
amx.c would need to be duplicated, compromising the structural quality of
xstate tests.

This series introduces a shared test framework for extended state
validation, applicable to both existing and new xstates. The test cases
cover:
* Context switching
* ABI compatibility for signal handling
* ABI compatibility for ptrace interactions

== Patch Organization ==

The patchset is structured as follows:

* PATCH1: Preparatory cleanup — removing redundant signal handler
  registration code.
* PATCH2/3: Introduce low-level XSAVE helpers and xstate component
  enumeration.
* PATCH4/5: Refactor existing test code.
* PATCH6: Introduce a new signal test case.
* PATCH7/8: Consolidate test invocations and clarify the list of
  supported features.
* PATCH9: Add test coverage for AVX.

== Coverage and Future Work Considerations ==

Currently, these tests are aligned with 64-bit mode only. Support for
32-bit cases will be considered when necessary, but only after this phase
of rework is finalized.

FWIW, the AMX TILECFG state is trivial, requiring almost constant values.
Additionally, various PKRU tests are already established in
tools/selftests/mm.

This series is based on the tip/master branch. You can also find it in
the following repository:
    git://github.com/intel/apx.git selftest-xstate_v1

Thanks,
Chang

[1] https://lore.kernel.org/all/20211026122523.AFB99C1F@davehans-spike.ostc.intel.com/
[2] https://lore.kernel.org/lkml/20210518200320.17239-1-chang.seok.bae@intel.com/
[3] https://www.intel.com/content/www/us/en/developer/articles/technical/advanced-performance-extensions-apx.html

Chang S. Bae (9):
  selftests/x86: Consolidate redundant signal helper functions
  selftests/x86/xstate: Refactor XSAVE helpers for general use
  selftests/x86/xstate: Enumerate and name xstate components
  selftests/x86/xstate: Refactor context switching test
  selftests/x86/xstate: Refactor ptrace ABI test
  selftests/x86/xstate: Introduce signal ABI test
  selftests/x86/xstate: Consolidate test invocations into a single entry
  selftests/x86/xstate: Clarify supported xstates
  selftests/x86/avx: Add AVX test

 tools/testing/selftests/x86/Makefile          |   6 +-
 tools/testing/selftests/x86/amx.c             | 442 +---------------
 tools/testing/selftests/x86/avx.c             |  12 +
 .../selftests/x86/corrupt_xstate_header.c     |  14 +-
 tools/testing/selftests/x86/entry_from_vm86.c |  24 +-
 tools/testing/selftests/x86/fsgsbase.c        |  24 +-
 tools/testing/selftests/x86/helpers.h         |  28 +
 tools/testing/selftests/x86/ioperm.c          |  25 +-
 tools/testing/selftests/x86/iopl.c            |  25 +-
 tools/testing/selftests/x86/ldt_gdt.c         |  18 +-
 tools/testing/selftests/x86/mov_ss_trap.c     |  14 +-
 tools/testing/selftests/x86/ptrace_syscall.c  |  24 +-
 tools/testing/selftests/x86/sigaltstack.c     |  26 +-
 tools/testing/selftests/x86/sigreturn.c       |  24 +-
 .../selftests/x86/single_step_syscall.c       |  22 -
 .../testing/selftests/x86/syscall_arg_fault.c |  12 -
 tools/testing/selftests/x86/syscall_nt.c      |  12 -
 tools/testing/selftests/x86/sysret_rip.c      |  24 +-
 tools/testing/selftests/x86/test_vsyscall.c   |  13 -
 tools/testing/selftests/x86/unwind_vdso.c     |  12 -
 tools/testing/selftests/x86/xstate.c          | 477 ++++++++++++++++++
 tools/testing/selftests/x86/xstate.h          | 195 +++++++
 22 files changed, 753 insertions(+), 720 deletions(-)
 create mode 100644 tools/testing/selftests/x86/avx.c
 create mode 100644 tools/testing/selftests/x86/xstate.c
 create mode 100644 tools/testing/selftests/x86/xstate.h


base-commit: 5bff053d066ba892464995ae4a7246f7a78fce2d
-- 
2.45.2


