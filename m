Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB216D3C95
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 06:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDCEzk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 00:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjDCEzj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 00:55:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0C18A5E;
        Sun,  2 Apr 2023 21:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680497738; x=1712033738;
  h=from:to:cc:subject:date:message-id;
  bh=1OSTKI3yBXEYfZimWNNa4GWltj4cjgdQ0bHGtSCpFcc=;
  b=hiu79L/gBVhPNTwTdrxWDKObXjC8KbRhnPxFJ9dv1WiovkdQ9bnBWMUT
   PjXwOL8pFHI84874tBpUPILdBnX4nLsSyJ7q5OAIYKkBh8x8O3VE2PoeW
   gS57VUzLhy+0YzN4OtbmyO/01iMdvdyzEbMKxiC+OtnjCbc7sZw2DpnBh
   2RTR7JLO31R62q+DNkreekA9C0BPuBTBnNnXF2mvStWkieXsZuVJsZpBJ
   UWJ8KqoWItmD0Uqz1qmO0VrssBEKwD9i18qU2ZT6NKRkwNNX+3trIPkQl
   I23lLIXZLQLRTz4MhFA4ubib9KGduIXEgxWdMI2xWMKYRkJvdUru9OM6t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="344362539"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="344362539"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 21:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="829421514"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="829421514"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2023 21:55:37 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, luto@kernel.org, dave.hansen@intel.com,
        tglx@linutronix.de, bp@suse.de, jun.miao@windriver.com,
        chang.seok.bae@intel.com
Subject: [PATCH v1 0/4] selftests/x86: Improve signal test code
Date:   Sun,  2 Apr 2023 21:43:36 -0700
Message-Id: <20230403044340.1312-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=0.5 required=5.0 tests=AC_FROM_MANY_DOTS,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

This is a cleanup series to consolidate a common signal setup code.
Right now quite a bit of duplicated code is there in an unorganized
way. Here is a rework of that signal-related code:

(1) Consolidate the signal handler helpers

  They have been exactly copied everywhere. Place them in the shared
  code. Then, remove those duplicates.

(2) Simplify altstack code

  Most cases require just a usable alternate stack. So, there is a
  chance to simplify them all. Abstract the entire setup code to one
  setup call. Then, it can reduce the amount of code there.

  For testing sigaltstack() specifically, another helper is provided
  that excludes the syscall part.

The series also includes some preparatory changes for them:

* Along with the rework, some existing problem was uncovered. A couple
  of tests look to free the altstack memory even before the signal
  delivery. Adjust the memory cleanup to resolve this issue.

* Also resolve a define conflict separately before including the
  refactored header.

Then, there is another selftest fix that I posted:
  https://lore.kernel.org/lkml/20230330233520.21937-1-chang.seok.bae@intel.com/
which has a conflict with this. As the fix should go first, this
cleanup series is based on it.

FWIW, at the moment, the new x86 selftest cases -- lam and
test_shadow_stack do not conflict with this.

Here is the repository where this series can be found:
  git://github.com/intel/amx-linux.git selftest-signal

Thanks,
Chang

Chang S. Bae (4):
  selftests/x86: Fix the altstack free
  selftests/x86/mov_ss_trap: Include processor-flags.h
  selftests/x86: Consolidate signal handler helpers
  selftests/x86: Refactor altstack setup code

 tools/testing/selftests/x86/Makefile          |  16 ++-
 tools/testing/selftests/x86/amx.c             |  67 +++--------
 .../selftests/x86/corrupt_xstate_header.c     |  15 +--
 tools/testing/selftests/x86/entry_from_vm86.c |  25 +---
 tools/testing/selftests/x86/fsgsbase.c        |  25 +---
 tools/testing/selftests/x86/helpers.c         | 110 ++++++++++++++++++
 tools/testing/selftests/x86/helpers.h         |  10 ++
 tools/testing/selftests/x86/ioperm.c          |  26 +----
 tools/testing/selftests/x86/iopl.c            |  26 +----
 tools/testing/selftests/x86/ldt_gdt.c         |  19 +--
 tools/testing/selftests/x86/mov_ss_trap.c     |  26 +----
 tools/testing/selftests/x86/ptrace_syscall.c  |  24 +---
 tools/testing/selftests/x86/sigaltstack.c     |  67 +++--------
 tools/testing/selftests/x86/sigreturn.c       |  35 +-----
 .../selftests/x86/single_step_syscall.c       |  36 +-----
 .../testing/selftests/x86/syscall_arg_fault.c |  24 +---
 tools/testing/selftests/x86/syscall_nt.c      |  13 ---
 tools/testing/selftests/x86/sysret_rip.c      |  24 +---
 tools/testing/selftests/x86/test_vsyscall.c   |  13 ---
 tools/testing/selftests/x86/unwind_vdso.c     |  13 ---
 20 files changed, 205 insertions(+), 409 deletions(-)
 create mode 100644 tools/testing/selftests/x86/helpers.c

-- 
2.17.1

