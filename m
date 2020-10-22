Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5AB296728
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 00:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372782AbgJVW1M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 18:27:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:46660 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506456AbgJVW1L (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 18:27:11 -0400
IronPort-SDR: n2ied6eatsNx+OZQxEzyjaEJ4SfKl1hdMZgb19mtmfFD7PU7co1kP1G8doHkrvc8OoPPQAs/J5
 fhiNmIYPKWeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="231796588"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="231796588"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 15:27:10 -0700
IronPort-SDR: ajFcb+gyyUgb/qN6sFCQOFqRRTyQjlYHaUH1S6vKLAzqcAflp0GMoD6tBlYClDXDVt+XH0LrFG
 0rtkUkmAg1FA==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="534154343"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 15:27:09 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 00/10] PKS: Add Protection Keys Supervisor (PKS) support
Date:   Thu, 22 Oct 2020 15:26:51 -0700
Message-Id: <20201022222701.887660-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes from RFC V3[3]
	Rebase to TIP master
	Update test error output
	Standardize on 'irq_state' for state variables
	From Dave Hansen
		Update commit messages
		Add/clean up comments
		Add X86_FEATURE_PKS to disabled-features.h and remove some
			explicit CONFIG checks
		Move saved_pkrs member of thread_struct
		Remove superfluous preempt_disable()
		s/irq_save_pks/irq_save_set_pks/
		Ensure PKRS is not seen in faults if not configured or not
			supported
		s/pks_mknoaccess/pks_mk_noaccess/
		s/pks_mkread/pks_mk_readonly/
		s/pks_mkrdwr/pks_mk_readwrite/
		Change pks_key_alloc return to -EOPNOTSUPP when not supported
	From Peter Zijlstra
		Clean up Attribution
		Remove superfluous preempt_disable()
		Add union to differentiate exit_rcu/lockdep use in
			irqentry_state_t
	From Thomas Gleixner
		Add preliminary clean up patch and adjust series as needed


Introduce a new page protection mechanism for supervisor pages, Protection Key
Supervisor (PKS).

2 use cases for PKS are being developed, trusted keys and PMEM.  Trusted keys
is a newer use case which is still being explored.  PMEM was submitted as part
of the RFC (v2) series[1].  However, since then it was found that some callers
of kmap() require a global implementation of PKS.  Specifically some users of
kmap() expect mappings to be available to all kernel threads.  While global use
of PKS is rare it needs to be included for correctness.  Unfortunately the
kmap() updates required a large patch series to make the needed changes at the
various kmap() call sites so that patch set has been split out.  Because the
global PKS feature is only required for that use case it will be deferred to
that set as well.[2]  This patch set is being submitted as a precursor to both
of the use cases.

For an overview of the entire PKS ecosystem, a git tree including this series
and 2 proposed use cases can be found here:

	https://lore.kernel.org/lkml/20201009195033.3208459-1-ira.weiny@intel.com/
	https://lore.kernel.org/lkml/20201009201410.3209180-1-ira.weiny@intel.com/


PKS enables protections on 'domains' of supervisor pages to limit supervisor
mode access to those pages beyond the normal paging protections.  PKS works in
a similar fashion to user space pkeys, PKU.  As with PKU, supervisor pkeys are
checked in addition to normal paging protections and Access or Writes can be
disabled via a MSR update without TLB flushes when permissions change.  Also
like PKU, a page mapping is assigned to a domain by setting pkey bits in the
page table entry for that mapping.

Access is controlled through a PKRS register which is updated via WRMSR/RDMSR.

XSAVE is not supported for the PKRS MSR.  Therefore the implementation
saves/restores the MSR across context switches and during exceptions.  Nested
exceptions are supported by each exception getting a new PKS state.

For consistent behavior with current paging protections, pkey 0 is reserved and
configured to allow full access via the pkey mechanism, thus preserving the
default paging protections on mappings with the default pkey value of 0.

Other keys, (1-15) are allocated by an allocator which prepares us for key
contention from day one.  Kernel users should be prepared for the allocator to
fail either because of key exhaustion or due to PKS not being supported on the
arch and/or CPU instance.

The following are key attributes of PKS.

   1) Fast switching of permissions
	1a) Prevents access without page table manipulations
	1b) No TLB flushes required
   2) Works on a per thread basis

PKS is available with 4 and 5 level paging.  Like PKRU it consumes 4 bits from
the PTE to store the pkey within the entry.


[1] https://lore.kernel.org/lkml/20200717072056.73134-1-ira.weiny@intel.com/
[2] https://lore.kernel.org/lkml/20201009195033.3208459-2-ira.weiny@intel.com/
[3] https://lore.kernel.org/lkml/20201009194258.3207172-1-ira.weiny@intel.com/


Fenghua Yu (2):
  x86/pks: Enable Protection Keys Supervisor (PKS)
  x86/pks: Add PKS kernel API

Ira Weiny (7):
  x86/pkeys: Create pkeys_common.h
  x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
  x86/pks: Preserve the PKRS MSR on context switch
  x86/entry: Pass irqentry_state_t by reference
  x86/entry: Preserve PKRS MSR across exceptions
  x86/fault: Report the PKRS state on fault
  x86/pks: Add PKS test code

Thomas Gleixner (1):
  x86/entry: Move nmi entry/exit into common code

 Documentation/core-api/protection-keys.rst  | 102 ++-
 arch/x86/Kconfig                            |   1 +
 arch/x86/entry/common.c                     |  65 +-
 arch/x86/include/asm/cpufeatures.h          |   1 +
 arch/x86/include/asm/disabled-features.h    |   8 +-
 arch/x86/include/asm/idtentry.h             |  28 +-
 arch/x86/include/asm/msr-index.h            |   1 +
 arch/x86/include/asm/pgtable.h              |  13 +-
 arch/x86/include/asm/pgtable_types.h        |  12 +
 arch/x86/include/asm/pkeys.h                |  15 +
 arch/x86/include/asm/pkeys_common.h         |  40 ++
 arch/x86/include/asm/processor.h            |  14 +
 arch/x86/include/uapi/asm/processor-flags.h |   2 +
 arch/x86/kernel/cpu/common.c                |  15 +
 arch/x86/kernel/cpu/mce/core.c              |   6 +-
 arch/x86/kernel/fpu/xstate.c                |  22 +-
 arch/x86/kernel/kvm.c                       |   6 +-
 arch/x86/kernel/nmi.c                       |   6 +-
 arch/x86/kernel/process.c                   |  26 +
 arch/x86/kernel/traps.c                     |  24 +-
 arch/x86/mm/fault.c                         |  87 ++-
 arch/x86/mm/pkeys.c                         | 191 +++++-
 include/linux/entry-common.h                |  46 +-
 include/linux/pgtable.h                     |   4 +
 include/linux/pkeys.h                       |  22 +
 kernel/entry/common.c                       |  62 +-
 lib/Kconfig.debug                           |  12 +
 lib/Makefile                                |   3 +
 lib/pks/Makefile                            |   3 +
 lib/pks/pks_test.c                          | 691 ++++++++++++++++++++
 mm/Kconfig                                  |   2 +
 tools/testing/selftests/x86/Makefile        |   3 +-
 tools/testing/selftests/x86/test_pks.c      |  66 ++
 33 files changed, 1441 insertions(+), 158 deletions(-)
 create mode 100644 arch/x86/include/asm/pkeys_common.h
 create mode 100644 lib/pks/Makefile
 create mode 100644 lib/pks/pks_test.c
 create mode 100644 tools/testing/selftests/x86/test_pks.c

-- 
2.28.0.rc0.12.gb6a658bd00c9

