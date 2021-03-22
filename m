Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7257334388F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 06:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCVFam (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 01:30:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:39465 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhCVFa3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 01:30:29 -0400
IronPort-SDR: wu6sgsl0feGFhWZuOjqo67CPSwyXtilvEmyLohTA6kpy52aPpMILK4rd9tCtuhjyTNbwmpKckL
 +BpCi7E6e1Mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="210268981"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="210268981"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 22:30:28 -0700
IronPort-SDR: vua1iuQv0xQomTn+IqFstN87l1bST0a1k/HBecwFbUPrrVZoV2xUI+M63k8vZTxog/zbWAisIv
 MFJ4Hoq5yeSg==
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="414339804"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 22:30:28 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH V4 00/10] PKS Add Protection Key Supervisor support
Date:   Sun, 21 Mar 2021 22:30:10 -0700
Message-Id: <20210322053020.2287058-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Introduce a new page protection mechanism for supervisor pages, Protection Key
Supervisor (PKS).

Generally PKS enables protections on 'domains' of supervisor pages to limit
supervisor mode access to pages beyond the normal paging protections.  PKS
works in a similar fashion to user space pkeys, PKU.  As with PKU, supervisor
pkeys are checked in addition to normal paging protections and Access or Writes
can be disabled via a MSR update without TLB flushes when permissions change.

Also like PKU, a page mapping is assigned to a domain by setting pkey bits in
the page table entry for that mapping.

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
CPU instance.

The following are key attributes of PKS.

   1) Fast switching of permissions
	1a) Prevents access without page table manipulations
	1b) No TLB flushes required
   2) Works on a per thread basis

PKS is available with 4 and 5 level paging.  Like PKRU it consumes 4 bits from
the PTE to store the pkey within the entry.

All code to support PKS is configured via ARCH_ENABLE_SUPERVISOR_PKEYS which
is designed to only be turned on when a user is configured on in the kernel.
Those users must depend on ARCH_HAS_SUPERVISOR_PKEYS to properly work with
other architectures which do not yet support PKS.

Originally this series was submitted as part of a large patch set which
converted the kmap call sites.[1]

Many follow on discussions revealed a few problems.  The first of which was
that some callers leak a kmap mapping across threads rather than containing it
to a critical section.  Attempts were made to see if these 'global kmaps' could
be supported.[2]  However, supporting global kmaps had many problems.  Work is
being done in parallel on converting as many kmap calls to the new
kmap_local_page().[3]


Changes from V3 [4]
	Add ARCH_ENABLE_SUPERVISOR_PKEYS config which is selected by kernel
	users to add the functionality to the core.  However, they should only
	select this if ARCH_HAS_SUPERVISOR_PKEYS is available.
	Clean up test code for context switching
		Adjust for extended_pt_regs
		Reduce output unless --debug is specified
        Address internal review comments from Dan Williams and Dave Hansen
		Help with macros and assembly coding
		Change names of various functions
                Clean up documentation
                Move all #ifdefery into header files.
                Clean up cover letter.
		Make extended_pt_regs handling a macro rather than coding
			around every call to C
                Add macross for PKS shift/mask
                        New patch : x86/pks: Add additional PKEY helper macros
		Preserve pkrs_cache as static when PKS_TEST is not configured
		Remove unnecessary pr_* prints
		Clarify pks_key_alloc flags parameter
		Change CONFIG_PKS_TESTING to CONFIG_PKS_TEST
		Clean up test code separation from main code in fault.c
		Remove module boilerplate from test code
		Clean up all commit messages
	Address comments from Thomas Gleixner
		Provide a warning and fallback to no protection if a global
		mapping is requested.
		Fix context switch.  Fix where pks_sched_in() is called.
		Fix test to actually do a context switch
		Remove unecessary noinstr's
	From Andy Lutomirski
		Use extended_pt_regs idea to stash pks values on the stack
		Drop patches 5/10 and 7/10
			And use extended_pt_regs to print pkey info on fault
		Adjust tests
	Comments from Randy Dunlap:
		Fix gramatical errors in doc
	Clean up kernel docs
	Rebase to 5.12


[1] https://lore.kernel.org/lkml/20201009195033.3208459-1-ira.weiny@intel.com/

[2] https://lore.kernel.org/lkml/87mtycqcjf.fsf@nanos.tec.linutronix.de/

[3] https://lore.kernel.org/lkml/20210128061503.1496847-1-ira.weiny@intel.com/
    https://lore.kernel.org/lkml/20210210062221.3023586-1-ira.weiny@intel.com/
    https://lore.kernel.org/lkml/20210205170030.856723-1-ira.weiny@intel.com/
    https://lore.kernel.org/lkml/20210217024826.3466046-1-ira.weiny@intel.com/

[4] https://lore.kernel.org/lkml/20201106232908.364581-1-ira.weiny@intel.com/

</proposed cover letter>


Fenghua Yu (1):
  x86/pks: Add PKS kernel API

Ira Weiny (9):
  x86/pkeys: Create pkeys_common.h
  x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
  x86/pks: Add additional PKEY helper macros
  x86/pks: Add PKS defines and Kconfig options
  x86/pks: Add PKS setup code
  x86/fault: Adjust WARN_ON for PKey fault
  x86/pks: Preserve the PKRS MSR on context switch
  x86/entry: Preserve PKRS MSR across exceptions
  x86/pks: Add PKS test code

 Documentation/core-api/protection-keys.rst  | 111 +++-
 arch/x86/Kconfig                            |   1 +
 arch/x86/entry/calling.h                    |  26 +
 arch/x86/entry/common.c                     |  58 ++
 arch/x86/entry/entry_64.S                   |  22 +-
 arch/x86/entry/entry_64_compat.S            |   6 +-
 arch/x86/include/asm/cpufeatures.h          |   1 +
 arch/x86/include/asm/disabled-features.h    |   8 +-
 arch/x86/include/asm/msr-index.h            |   1 +
 arch/x86/include/asm/pgtable.h              |  10 +-
 arch/x86/include/asm/pgtable_types.h        |  12 +
 arch/x86/include/asm/pkeys.h                |   4 +
 arch/x86/include/asm/pkeys_common.h         |  34 +
 arch/x86/include/asm/pks.h                  |  54 ++
 arch/x86/include/asm/processor-flags.h      |   2 +
 arch/x86/include/asm/processor.h            |  43 +-
 arch/x86/include/uapi/asm/processor-flags.h |   2 +
 arch/x86/kernel/cpu/common.c                |   2 +
 arch/x86/kernel/fpu/xstate.c                |  22 +-
 arch/x86/kernel/head_64.S                   |   7 +-
 arch/x86/kernel/process.c                   |   3 +
 arch/x86/kernel/process_64.c                |   2 +
 arch/x86/mm/fault.c                         |  27 +-
 arch/x86/mm/pkeys.c                         | 218 +++++-
 include/linux/pgtable.h                     |   4 +
 include/linux/pkeys.h                       |  34 +
 kernel/entry/common.c                       |  14 +-
 lib/Kconfig.debug                           |  11 +
 lib/Makefile                                |   3 +
 lib/pks/Makefile                            |   3 +
 lib/pks/pks_test.c                          | 693 ++++++++++++++++++++
 mm/Kconfig                                  |   5 +
 tools/testing/selftests/x86/Makefile        |   3 +-
 tools/testing/selftests/x86/test_pks.c      | 150 +++++
 34 files changed, 1519 insertions(+), 77 deletions(-)
 create mode 100644 arch/x86/include/asm/pkeys_common.h
 create mode 100644 arch/x86/include/asm/pks.h
 create mode 100644 lib/pks/Makefile
 create mode 100644 lib/pks/pks_test.c
 create mode 100644 tools/testing/selftests/x86/test_pks.c

-- 
2.28.0.rc0.12.gb6a658bd00c9

