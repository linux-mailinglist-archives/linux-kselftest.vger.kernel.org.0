Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B73244A32
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Aug 2020 15:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHNNNi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Aug 2020 09:13:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:47285 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgHNNNi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Aug 2020 09:13:38 -0400
IronPort-SDR: lnzseHRKWTM+w2UH8NF6bi+Be3ArVbtESSLIJL98NLKNCTvLqs1Au+ZgxfslYVw8LMNv9sutWc
 SDVAvfbqKyjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="133923589"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="133923589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 06:13:37 -0700
IronPort-SDR: xWjFTk7XDLma05PewkOHSyABfGlM7R2wqd/t1qTTmrVMsNoFCHzqoX73HW44s4NYxvpul2Bxf1
 D3ZT/ZXgpDYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="291729778"
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2020 06:13:35 -0700
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        peterx@redhat.com, linux-kselftest@vger.kernel.org
Cc:     Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH] selftests: kvm: Fix an unexpected failure with newer gcc compiler
Date:   Fri, 14 Aug 2020 21:21:05 +0800
Message-Id: <20200814132105.5122-1-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If debug_regs.c is built with newer gcc, e.g., 8.3.1 on my side, then the generated
binary looks like over-optimized by gcc:

asm volatile("ss_start: "
             "xor %%rax,%%rax\n\t"
             "cpuid\n\t"
             "movl $0x1a0,%%ecx\n\t"
             "rdmsr\n\t"
             : : : "rax", "ecx");

is translated to :

  000000000040194e <ss_start>:
  40194e:       31 c0                   xor    %eax,%eax     <----- rax->eax?
  401950:       0f a2                   cpuid
  401952:       b9 a0 01 00 00          mov    $0x1a0,%ecx
  401957:       0f 32                   rdmsr

As you can see rax is replaced with eax in taret binary code.
But if I replace %%rax with %%r8 or any GPR from r8~15, then I get below
expected binary:

0000000000401950 <ss_start>:
  401950:       45 31 ff                xor    %r15d,%r15d
  401953:       0f a2                   cpuid
  401955:       b9 a0 01 00 00          mov    $0x1a0,%ecx
  40195a:       0f 32                   rdmsr

The difference is the length of xor instruction(2 Byte vs 3 Byte),
so this makes below hard-coded instruction length cannot pass runtime check:

        /* Instruction lengths starting at ss_start */
        int ss_size[4] = {
                3,              /* xor */   <-------- 2 or 3?
                2,              /* cpuid */
                5,              /* mov */
                2,              /* rdmsr */
        };
Note:
Use 8.2.1 or older gcc, it generates expected 3 bytes xor target code.

I use the default Makefile to build the binaries, and I cannot figure out why this
happens, so it comes this patch, maybe you have better solution to resolve the
issue. If you know how things work in this way, please let me know, thanks!

Below is the capture from my environments:
========================================================================
gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2)
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

0000000000401950 <ss_start>:
  401950:       45 31 ff                xor    %r15d,%r15d
  401953:       0f a2                   cpuid
  401955:       b9 a0 01 00 00          mov    $0x1a0,%ecx
  40195a:       0f 32                   rdmsr

  000000000040194f <ss_start>:
  40194f:       31 db                   xor    %ebx,%ebx
  401951:       0f a2                   cpuid
  401953:       b9 a0 01 00 00          mov    $0x1a0,%ecx
  401958:       0f 32                   rdmsr

  000000000040194e <ss_start>:
  40194e:       31 c0                   xor    %eax,%eax
  401950:       0f a2                   cpuid
  401952:       b9 a0 01 00 00          mov    $0x1a0,%ecx
  401957:       0f 32                   rdmsr

==========================================================================

gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3)
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

0000000000401750 <ss_start>:
  401750:       48 31 c0                xor    %rax,%rax
  401753:       0f a2                   cpuid
  401755:       b9 a0 01 00 00          mov    $0x1a0,%ecx
  40175a:       0f 32                   rdmsr

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 tools/testing/selftests/kvm/x86_64/debug_regs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
index 8162c58a1234..74641cfa8ace 100644
--- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
@@ -40,11 +40,11 @@ static void guest_code(void)
 
 	/* Single step test, covers 2 basic instructions and 2 emulated */
 	asm volatile("ss_start: "
-		     "xor %%rax,%%rax\n\t"
+		     "xor %%r15,%%r15\n\t"
 		     "cpuid\n\t"
 		     "movl $0x1a0,%%ecx\n\t"
 		     "rdmsr\n\t"
-		     : : : "rax", "ecx");
+		     : : : "r15", "ecx");
 
 	/* DR6.BD test */
 	asm volatile("bd_start: mov %%dr0, %%rax" : : : "rax");
-- 
2.17.2

