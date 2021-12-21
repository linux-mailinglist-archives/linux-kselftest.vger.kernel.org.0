Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9917247B8F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 04:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhLUDWF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Dec 2021 22:22:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:27636 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhLUDWF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Dec 2021 22:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640056925; x=1671592925;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d/hAJotgr0kn3fn9wA/P+PPcRYso6X4ths0azjp0t+M=;
  b=DMABW5m6vEaZOGomZuVS7MILe5NhmzWuOCaHN9LWMYvx6jYFIfhxOjaN
   0SdXW/xa8pOr2pR2zHUA6Uvjp6dTXXqcBexd8Zsbrw/wIVR2qwP6SG2g+
   lEodXWLE552qAOwymRVNzrugMvj+TkewrF6zh2yfTovMcLM/MPvRHWDJw
   yFv5LOCAZXtqDqL4B0nb2VzQQCrcMLGxR0vGjCwtdOhNQlLGyS3Aigs7s
   X8b8fQIiyYm4BC6CfMyiW1u6gAJ3QytvYnJ6hdKxNOemdOntUSyd3dWV4
   wMVM0fOAD+7FbJNBGicY6FVx1XWdwg6sNW+Q8lrXhaPTmkbTHyDxkLQ4Y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240269552"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="240269552"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 19:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="484277873"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga002.jf.intel.com with ESMTP; 20 Dec 2021 19:21:52 -0800
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
Subject: [RFC PATCH v6 0/2] Introduce XSAVE feature self-test
Date:   Tue, 21 Dec 2021 11:22:48 +0800
Message-Id: <cover.1640052713.git.pengfei.xu@intel.com>
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
- Change from v5 to v6:
  - In order to prevent GCC from generating any FP code by mistake,
    "-mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku" compiler parameter was
    added, it referred to the parameters for compiling the x86 kernel. Thanks
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
    change xstate. Thanks Chatre Reinette, Shuah.
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
 tools/testing/selftests/x86/xsave_common.h    | 380 ++++++++++++++++++
 tools/testing/selftests/x86/xsave_fork_test.c | 117 ++++++
 .../selftests/x86/xsave_signal_handle.c       | 151 +++++++
 4 files changed, 651 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/xsave_common.h
 create mode 100644 tools/testing/selftests/x86/xsave_fork_test.c
 create mode 100644 tools/testing/selftests/x86/xsave_signal_handle.c

-- 
2.31.1

