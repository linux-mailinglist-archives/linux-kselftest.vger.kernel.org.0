Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F64447ED6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Dec 2021 09:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbhLXIw1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Dec 2021 03:52:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:47099 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238133AbhLXIw1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Dec 2021 03:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640335947; x=1671871947;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qA+zfjEgOwaKhEpN7lGheIslmdVy2kCLauDcjxQjG+s=;
  b=dc3fP5wH5RWJv0Xbnk5HAiVBf4F0SdS8kCDOT+SGAcFCpYMzzapN0xLp
   VvOOAmFuUumSeF7ZyMKXwy99eWJGV+HwMt9cRgk/1FaRWfEn1LoTAd8BY
   lXK1Tenm1dqj5h1fGG5oO3IuuE/kl+ZHNQbFU4zYDc4iPtbsjcGUi7cDv
   ya9c0gT+UIAkyt7wz3jP8ccCNfztpOV8vA411QPAZ/MzeGgXyPHO65hFV
   2IfsaNRAjkK4wQhoZPNNRjANiPcFtXRHcjMb+KLZWxmaC92xxzFBN2aoN
   93biaOb4a/jObOy+Xyvp/k9IrLY1Shy65IMcGhQeUxXXu+cYhynjYFtOO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="227796969"
X-IronPort-AV: E=Sophos;i="5.88,232,1635231600"; 
   d="scan'208";a="227796969"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 00:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,232,1635231600"; 
   d="scan'208";a="509107169"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga007.jf.intel.com with ESMTP; 24 Dec 2021 00:52:23 -0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>, Heng Su <heng.su@intel.com>,
        Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH v7 0/2] Introduce XSAVE feature self-test
Date:   Fri, 24 Dec 2021 16:53:21 +0800
Message-Id: <cover.1640327326.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The XSAVE feature set supports the saving and restoring of xstate components,
which is used for process context switching. The state components include
x87 state for FPU execution environment, SSE state, AVX state and so on.
In order to ensure that XSAVE works correctly, add XSAVE basic test for XSAVE
architecture functionality.

This patch set tests and verifies the basic functions of XSAVE in user
space; it tests "FPU, SSE(XMM), AVX2(YMM), AVX512 opmask and PKRU parts"
xstates with following cases:
1. In nested signal processing, the signal handling will use each signal's own
   xstates, and the xstates of the signal handling under test should not be
   changed after another nested signal handling is completed; and these xstates
   content in the process should not change after the nested signal handling
   is complete.
2. The xstates content of the child process should be the same as that of the
   parent process. The xstates content of the process should be the same across
   process switching.

This is the xstates position for FP, XMM, Header, YMM, AVX512 opmask and PKRU:
It could be saved by xsave instruction, and mask could control which part will
be saved(Header will be saved as mandatory):
FP              (0 - 159 bytes)
XMM             (160-415 bytes)
Reserved        (416-511 bytes  SDM vol1 13.4.1)
Header_used     (512-527 bytes)
Headed_reserved (528-575 bytes must 00, otherwise xrstor will #GP)
YMM             (Offset:CPUID.(EAX=0D,ECX=2).EBX  Size:CPUID(EAX=0D,ECX=2).EAX)
AVX512 opmask   (Offset:CPUID.(EAX=0D,ECX=5).EBX  Size:CPUID(EAX=0D,ECX=5).EAX)
PKRU            (Offset:CPUID.(EAX=0D,ECX=9).EBX  Size:CPUID(EAX=0D,ECX=9).EAX)

It uses syscall function instead of fork() function, becasue syscall libc
function will resume xstates after syscall if there is some xstates change
in syscall libc function.
And populate the xstates will try not to use libc, and every key test action
will try not to use libc except syscall until it's failed or done.
In order to prevent GCC from generating any FP code by mistake,
"-mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku" compiler parameter is added to
avoid fake failure. Thanks Dave Hansen's suggestion.

This series introduces only the most basic XSAVE tests. In the future, the
intention is to continue expanding the scope of these selftests to include
more xstates and kernel XSAVE-related functionality tests.

========
- Change from v6 to v7:
  - Added the error number and error description of the reason for the
    failure, thanks Shuah Khan's suggestion.
  - Added a description of what these tests are doing in the head comments.
  - Added changes update in the head comments.
  - Added description of the purpose of the function. thanks Shuah Khan.

- Change from v5 to v6:
  - In order to prevent GCC from generating any FP code by mistake,
    "-mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku" compiler parameter was
    added, it's referred to the parameters for compiling the x86 kernel. Thanks
    Dave Hansen's suggestion.
  - Removed the use of "kselftest.h", because kselftest.h included <stdlib.h>,
    and "stdlib.h" would use sse instructions in it's libc, and this *XSAVE*
    test needed to be compiled without libc sse instructions(-mno-sse).
  - Improved the description in commit header, thanks Chen Yu's suggestion.
  - Becasue test code could not use buildin xsave64 in libc without sse, added
    xsave function by instruction way.
  - Every key test action would not use libc(like printf) except syscall until
    it's failed or done. If it's failed, then it would print the failed reason.
  - Used __cpuid_count() instead of native_cpuid(), becasue __cpuid_count()
    was a macro definition function with one instruction in libc and did not
    change xstate. Thanks Chatre Reinette, Shuah Khan.
    https://lore.kernel.org/linux-sgx/8b7c98f4-f050-bc1c-5699-fa598ecc66a2@linuxfoundation.org/

- Change from v4 to v5:
  - Moved code files into tools/testing/selftests/x86.
  - Delete xsave instruction test, becaue it's not related to kernel.
  - Improved case description.
  - Added AVX512 opmask change and related XSAVE content verification.
  - Added PKRU part xstate test into instruction and signal handling test.
  - Added XSAVE process swich test for FPU, AVX2, AVX512 opmask and PKRU part.

- Change from v3 to v4:
  - Improve the comment in patch 1.

- Change from v2 to v3:
  - Improve the description of patch 2 git log.

- Change from v1 to v2:
  - Improve the cover-letter. Thanks Dave Hansen's suggestion.

Pengfei Xu (2):
  selftests/x86: add xsave test related to nested signal handling
  selftests/x86: add xsave test related to process switching

 tools/testing/selftests/x86/Makefile          |   4 +-
 tools/testing/selftests/x86/xsave_common.h    | 397 ++++++++++++++++++
 tools/testing/selftests/x86/xsave_fork_test.c | 148 +++++++
 .../selftests/x86/xsave_signal_handle.c       | 189 +++++++++
 4 files changed, 737 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/xsave_common.h
 create mode 100644 tools/testing/selftests/x86/xsave_fork_test.c
 create mode 100644 tools/testing/selftests/x86/xsave_signal_handle.c

-- 
2.31.1

