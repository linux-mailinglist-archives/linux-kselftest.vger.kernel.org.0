Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DEC362AE2
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Apr 2021 00:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhDPWP0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Apr 2021 18:15:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:50456 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhDPWP0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Apr 2021 18:15:26 -0400
IronPort-SDR: C48M1iKeuQV0RIEgXcfUqcfeLeE5Eh7o3VFWnGIkLFinszD6G2HL35z/z1XYUfdTWpxfoeHeh6
 UPTtanm5xI0Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="256436124"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="256436124"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 15:14:57 -0700
IronPort-SDR: /+GCyxQt3pjtMCM8P9E6cHbfH37hm/aB5hO0UTt+OVbgSQRSJ+waHBjGCC/Ie+PTiaTacUirLx
 zpzaRoGfcCaQ==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="616077041"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 15:14:56 -0700
Date:   Fri, 16 Apr 2021 15:14:56 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V6 00/10] PKS: Add Protection Key Supervisor support
Message-ID: <20210416220950.GE1904484@iweiny-DESK2.sc.intel.com>
References: <20210401225833.566238-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401225833.566238-1-ira.weiny@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 01, 2021 at 03:58:23PM -0700, 'Ira Weiny' wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Introduce a new page protection mechanism for supervisor pages, Protection Key
> Supervisor (PKS).

Is there any feedback on this series?

Perhaps I should ping for specific feedback or an ack?  Maybe an ack from
x86/mm?

Ira

> 
> Generally PKS enables protections on 'domains' of supervisor pages to limit
> supervisor mode access to pages beyond the normal paging protections.  PKS
> works in a similar fashion to user space pkeys, PKU.  As with PKU, supervisor
> pkeys are checked in addition to normal paging protections and Access or Writes
> can be disabled via a MSR update without TLB flushes when permissions change.
> 
> Also like PKU, a page mapping is assigned to a domain by setting pkey bits in
> the page table entry for that mapping.
> 
> Access is controlled through a PKRS register which is updated via WRMSR/RDMSR.
> 
> XSAVE is not supported for the PKRS MSR.  Therefore the implementation
> saves/restores the MSR across context switches and during exceptions.  Nested
> exceptions are supported by each exception getting a new PKS state.
> 
> For consistent behavior with current paging protections, pkey 0 is reserved and
> configured to allow full access via the pkey mechanism, thus preserving the
> default paging protections on mappings with the default pkey value of 0.
> 
> Other keys, (1-15) are allocated by an allocator which prepares us for key
> contention from day one.  Kernel users should be prepared for the allocator to
> fail either because of key exhaustion or due to PKS not being supported on the
> CPU instance.
> 
> The following are key attributes of PKS.
> 
> 	1) Fast switching of permissions
> 		1a) Prevents access without page table manipulations
> 		1b) No TLB flushes required
> 	2) Works on a per thread basis
> 
> PKS is available with 4 and 5 level paging.  Like PKRU it consumes 4 bits from
> the PTE to store the pkey within the entry.
> 
> All code to support PKS is configured via ARCH_ENABLE_SUPERVISOR_PKEYS which
> is designed to only be turned on when a user is configured on in the kernel.
> Those users must depend on ARCH_HAS_SUPERVISOR_PKEYS to properly work with
> other architectures which do not yet support PKS.
> 
> Originally this series was submitted as part of a large patch set which
> converted the kmap call sites.[1]
> 
> Many follow on discussions revealed a few problems.  The first of which was
> that some callers leak a kmap mapping across threads rather than containing it
> to a critical section.  Attempts were made to see if these 'global kmaps' could
> be supported.[2]  However, supporting global kmaps had many problems.  Work is
> being done in parallel on converting as many kmap calls to the new
> kmap_local_page().[3]
> 
> 
> Changes from V5 [6]
> 	From Dave Hansen
> 		Remove 'we' from comments
> 
> Changes from V4 [5]
> 	From kernel test robot <lkp@intel.com>
> 		Fix i386 build: pks_init_task not found
> 	Move MSR_IA32_PKRS and INIT_PKRS_VALUE into patch 5 where they are
> 		first 'used'.  (Technically nothing is 'used' until the final
> 		test patch.  But review wise this is much cleaner.)
> 	From Sean Christoperson
> 		Add documentation details on what happens if the pkey is violated
> 		Change cpu_feature_enabled to be in WARN_ON check
> 		Clean up commit message of patch 6
> 
> 
> [1] https://lore.kernel.org/lkml/20201009195033.3208459-1-ira.weiny@intel.com/
> 
> [2] https://lore.kernel.org/lkml/87mtycqcjf.fsf@nanos.tec.linutronix.de/
> 
> [3] https://lore.kernel.org/lkml/20210128061503.1496847-1-ira.weiny@intel.com/
>     https://lore.kernel.org/lkml/20210210062221.3023586-1-ira.weiny@intel.com/
>     https://lore.kernel.org/lkml/20210205170030.856723-1-ira.weiny@intel.com/
>     https://lore.kernel.org/lkml/20210217024826.3466046-1-ira.weiny@intel.com/
> 
> [4] https://lore.kernel.org/lkml/20201106232908.364581-1-ira.weiny@intel.com/
> 
> [5] https://lore.kernel.org/lkml/20210322053020.2287058-1-ira.weiny@intel.com/
> 
> [6] https://lore.kernel.org/lkml/20210331191405.341999-1-ira.weiny@intel.com/
> 
> 
> Fenghua Yu (1):
>   x86/pks: Add PKS kernel API
> 
> Ira Weiny (9):
>   x86/pkeys: Create pkeys_common.h
>   x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
>   x86/pks: Add additional PKEY helper macros
>   x86/pks: Add PKS defines and Kconfig options
>   x86/pks: Add PKS setup code
>   x86/fault: Adjust WARN_ON for PKey fault
>   x86/pks: Preserve the PKRS MSR on context switch
>   x86/entry: Preserve PKRS MSR across exceptions
>   x86/pks: Add PKS test code
> 
>  Documentation/core-api/protection-keys.rst  | 112 +++-
>  arch/x86/Kconfig                            |   1 +
>  arch/x86/entry/calling.h                    |  26 +
>  arch/x86/entry/common.c                     |  57 ++
>  arch/x86/entry/entry_64.S                   |  22 +-
>  arch/x86/entry/entry_64_compat.S            |   6 +-
>  arch/x86/include/asm/cpufeatures.h          |   1 +
>  arch/x86/include/asm/disabled-features.h    |   8 +-
>  arch/x86/include/asm/msr-index.h            |   1 +
>  arch/x86/include/asm/pgtable.h              |  15 +-
>  arch/x86/include/asm/pgtable_types.h        |  12 +
>  arch/x86/include/asm/pkeys.h                |   4 +
>  arch/x86/include/asm/pkeys_common.h         |  34 +
>  arch/x86/include/asm/pks.h                  |  54 ++
>  arch/x86/include/asm/processor-flags.h      |   2 +
>  arch/x86/include/asm/processor.h            |  47 +-
>  arch/x86/include/uapi/asm/processor-flags.h |   2 +
>  arch/x86/kernel/cpu/common.c                |   2 +
>  arch/x86/kernel/fpu/xstate.c                |  22 +-
>  arch/x86/kernel/head_64.S                   |   7 +-
>  arch/x86/kernel/process.c                   |   3 +
>  arch/x86/kernel/process_64.c                |   2 +
>  arch/x86/mm/fault.c                         |  30 +-
>  arch/x86/mm/pkeys.c                         | 218 +++++-
>  include/linux/pgtable.h                     |   4 +
>  include/linux/pkeys.h                       |  34 +
>  kernel/entry/common.c                       |  14 +-
>  lib/Kconfig.debug                           |  11 +
>  lib/Makefile                                |   3 +
>  lib/pks/Makefile                            |   3 +
>  lib/pks/pks_test.c                          | 694 ++++++++++++++++++++
>  mm/Kconfig                                  |   5 +
>  tools/testing/selftests/x86/Makefile        |   3 +-
>  tools/testing/selftests/x86/test_pks.c      | 149 +++++
>  34 files changed, 1527 insertions(+), 81 deletions(-)
>  create mode 100644 arch/x86/include/asm/pkeys_common.h
>  create mode 100644 arch/x86/include/asm/pks.h
>  create mode 100644 lib/pks/Makefile
>  create mode 100644 lib/pks/pks_test.c
>  create mode 100644 tools/testing/selftests/x86/test_pks.c
> 
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 
