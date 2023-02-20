Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ED169C45E
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Feb 2023 04:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjBTDKQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Feb 2023 22:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBTDKP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Feb 2023 22:10:15 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0149DC147;
        Sun, 19 Feb 2023 19:10:13 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 3571083127;
        Mon, 20 Feb 2023 03:10:06 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1676862613;
        bh=uMnGCk1LjhkcOqlZi4n4FjfUb/hJZvPJ4KZ7CjBby/I=;
        h=From:To:Cc:Subject:Date:From;
        b=N9q5INGfCoqCLCKsHeKuDGThktG/Hs3zHpS8j6zfmGOR77mjZc5EvTQP8jWeLS9BO
         uPIZZSHE2i/IUE2q0JskLOavL9/reZUTlU8Z0tplePRkSif4zVXNJww+HcOhwjreUz
         5v9Zx9Bx7u5d/G7pFcRmmv8XidlYujD2164t+08JMbCHuUGdRnZkX9FH7Y7FMWI+V8
         wwWrChIGALo3JqZcrCzk52t5Hdy5X+KYdWnO6iKFATOBqwamI8D3T4FdU6JNzbn5I4
         WPtyiAawbE9B9SoJXZ8ZngQBnTUeijKXdIy2dOWZTgvoId4NvKILw5smEKmgBua2pq
         Hn0y0w/Cl6/nw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Dave Hansen <dave.hansen@intel.com>, Xin Li <xin3.li@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86 Mailing List <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [RESEND RFC PATCH v8 0/3] Intel FRED architecture support for the sysret_rip selftest
Date:   Mon, 20 Feb 2023 10:09:56 +0700
Message-Id: <20230220030959.119222-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[ 
   RESEND, get rid of: Linux x86-64 Mailing List <linux-x86_64@vger.kernel.org>
   from the CC list. It bounces and makes noise. Sorry for the wrong address.
]

Hi,

This is an RFC v8. Based on the x86/cpu branch in the tip tree.

The 'syscall' instruction on the Intel FRED architecture does not
clobber %rcx and %r11. This behavior leads to an assertion failure in
the sysret_rip selftest because it asserts %r11 = %rflags.

In the previous discussion, we agreed that there are two cases for
'syscall':

  A) 'syscall' in a FRED system preserves %rcx and %r11.

  B) 'syscall' in a non-FRED system sets %rcx=%rip and %r11=%rflags.

This series fixes the selftest. Make it work on the Intel FRED
architecture. Also, add more tests to ensure the syscall behavior is
consistent. It must always be (A) or always be (B). Not a mix of them.

See the previous discussion here:
https://lore.kernel.org/lkml/5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com

## Changelog revision

v8:
  - Stop using "+r"(rsp) to avoid the red zone problem because it
    generates the wrong Assembly code (Ammar).
    See: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108799

  - Update commit message (Ammar).

v7:
  - Fix comment, REGS_ERROR no longer exists in the enum (Ammar).

  - Update commit message (Ammar).

v6:
  - Move the check-regs assertion in sigusr1() to check_regs_result() (HPA).

  - Add a new test just like sigusr1(), but don't modify REG_RCX and
    REG_R11. This is used to test SYSRET behavior consistency (HPA).

v5:
  - Fix do_syscall() return value (Ammar).

v4:
  - Fix the assertion condition inside the SIGUSR1 handler (Xin Li).

  - Explain the purpose of patch #2 in the commit message (HPA).

  - Update commit message (Ammar).

  - Repeat test_syscall_rcx_r11_consistent() 32 times to be more sure
    that the result is really consistent (Ammar).

v3:
  - Test that we don't get a mix of REGS_SAVED and REGS_SYSRET, which
    is a major part of the point (HPA).

v2:
  - Use "+r"(rsp) as the right way to avoid redzone problems per
    Andrew's comment (HPA).

Co-developed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (3):
  selftests/x86: sysret_rip: Handle syscall on the Intel FRED architecture
  selftests/x86: sysret_rip: Add more tests to verify the 'syscall' behavior
  selftests/x86: sysret_rip: Test SYSRET with a signal handler

 tools/testing/selftests/x86/sysret_rip.c | 169 +++++++++++++++++++++--
 1 file changed, 160 insertions(+), 9 deletions(-)


base-commit: e067248949e3de7fbeae812b0ccbbee7a401e7aa
-- 
Ammar Faizi

