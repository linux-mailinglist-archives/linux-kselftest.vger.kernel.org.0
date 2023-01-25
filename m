Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8A967C0C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 00:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjAYXYp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 18:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjAYXYo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 18:24:44 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85524ED39;
        Wed, 25 Jan 2023 15:24:39 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 416F1824E0;
        Wed, 25 Jan 2023 23:24:32 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674689079;
        bh=hNQSW6B6+nk0aXTkdBZ0AWffDkkVWECsoP5oElAmxWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GnxtqNDQaLjQBSDWSOzBqdNlHWx1Aa9D4EZfQODUxGXItAFRLnvGrcyD1I99Qm9w4
         rkTFtv6+vDeJQzuQNwXCmN43fcAvlH/L1QVWUKjRYrQJ7fhwBs1JQRwgU0ZIZNfoQp
         eTWL9GFhmHDh83Pp58hpJAoDzsSjFUjIbpAnSYOrjGVc8iCUAECIh1poE+5ues0Uhd
         5rDUqMd8Ug1yUsMQiT+y7i0a2X0luSpLifCEWZgYsfytfg0SNz5f5xJ7qD9/YVrire
         YngYC9PBJ00lHhDHy8GLQe6FAEZgvPxc3DyBkfFDSpq0DSIiQpe/kClfgUZcqTO7BU
         qy9bjL7/4ixTA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v7 2/3] selftests/x86: sysret_rip: Add more syscall tests with respect to `%rcx` and `%r11`
Date:   Thu, 26 Jan 2023 06:24:14 +0700
Message-Id: <20230125232415.860397-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125232415.860397-1-ammarfaizi2@gnuweeb.org>
References: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <25b96960-a07e-a952-5c23-786b55054126@zytor.com> <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org> <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com> <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com> <20230124022729.596997-1-ammarfaizi2@gnuweeb.org> <20230124022729.596997-3-ammarfaizi2@gnuweeb.org> <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com> <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org> <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com> <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125232415.860397-1-ammarfaizi2@gnuweeb.org>
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

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Test that:

  - REGS_SAVED: "syscall" in a FRED system doesn't clobber %rcx and
    %r11.

  - REGS_SYSRET: "syscall" in a non-FRED system sets %rcx=%rip and
    %r11=%rflags.

Test them out with trivial system calls like __NR_getppid and friends
which are extremely likely to return with SYSRET on an IDT system.

Goals of this test:

  - Ensure that the syscall behavior is consistent. It must be either
    always REGS_SAVED or always REGS_SYSRET. Not a mix of them.

  - The kernel doesn't leak its internal data when returning to
    userspace.

Link: https://lore.kernel.org/lkml/25b96960-a07e-a952-5c23-786b55054126@zytor.com
Co-developed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/testing/selftests/x86/sysret_rip.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index ef3f492d95f6f2a1..d688cb9d5ac919eb 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -258,8 +258,24 @@ static void test_syscall_fallthrough_to(unsigned long ip)
 	printf("[OK]\tWe survived\n");
 }
 
+/*
+ * Ensure that various system calls are consistent.
+ * We must not get a mix of REGS_SAVED and REGS_SYSRET.
+ */
+static void test_syscall_rcx_r11_consistent(void)
+{
+	do_syscall(__NR_getpid, 0, 0, 0, 0, 0, 0);
+	do_syscall(__NR_gettid, 0, 0, 0, 0, 0, 0);
+	do_syscall(__NR_getppid, 0, 0, 0, 0, 0, 0);
+}
+
 int main()
 {
+	int i;
+
+	for (i = 0; i < 32; i++)
+		test_syscall_rcx_r11_consistent();
+
 	/*
 	 * When the kernel returns from a slow-path syscall, it will
 	 * detect whether SYSRET is appropriate.  If it incorrectly
@@ -267,7 +283,7 @@ int main()
 	 * it'll crash on Intel CPUs.
 	 */
 	sethandler(SIGUSR1, sigusr1, 0);
-	for (int i = 47; i < 64; i++)
+	for (i = 47; i < 64; i++)
 		test_sigreturn_to(1UL<<i);
 
 	clearhandler(SIGUSR1);
@@ -278,7 +294,7 @@ int main()
 	test_syscall_fallthrough_to((1UL << 47) - 2*PAGE_SIZE);
 
 	/* These are the interesting cases. */
-	for (int i = 47; i < 64; i++) {
+	for (i = 47; i < 64; i++) {
 		test_syscall_fallthrough_to((1UL<<i) - PAGE_SIZE);
 		test_syscall_fallthrough_to(1UL<<i);
 	}
-- 
Ammar Faizi

