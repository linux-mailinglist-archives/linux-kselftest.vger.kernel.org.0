Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C868D67A968
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 04:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjAYDub (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 22:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjAYDu2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 22:50:28 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C891F4FC20;
        Tue, 24 Jan 2023 19:50:23 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 60E8882EFF;
        Wed, 25 Jan 2023 03:50:17 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674618623;
        bh=24uiwiwmC/lxSl6sPnXU7b81z+lVBJdoQkn4/RYmk6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aN4OdJrwSItmrkKFjy0QM33mb8gTgrGcqIrOIk1S1Wd7qdegX41mKOdbQZHgJF0IL
         k8/8oC54Vf1PLgADpcGFuTILbuPcfAo9MAdz/i6TkpOUmxcdRG0qS37MG7b5iZgL5x
         x6/433jDrKg+UIA55+GLtgHCWM3fmS5bBUha2LGzSb0Q6YCCRAcwbLltJFBLWAS+1c
         vP3sLIngu4LWIHUFcERGavR+iWSNlaZ0hRYkzgVpSDoN0cpdbhhXioVouB1rGMpmML
         M8bEgoE2jGlEI75J1jGikBydd2qiUfqfQVazuCW+0TOCmq5o6RrmfoN32qQYY9YMuP
         prqPHUF6PENUw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v5 2/2] selftests/x86: sysret_rip: Add more syscall tests with respect to `%rcx` and `%r11`
Date:   Wed, 25 Jan 2023 10:49:58 +0700
Message-Id: <20230125034958.734527-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125034958.734527-1-ammarfaizi2@gnuweeb.org>
References: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <25b96960-a07e-a952-5c23-786b55054126@zytor.com> <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org> <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com> <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com> <20230124022729.596997-1-ammarfaizi2@gnuweeb.org> <20230124022729.596997-3-ammarfaizi2@gnuweeb.org> <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com> <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org> <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com> <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125034958.734527-1-ammarfaizi2@gnuweeb.org>
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

  - Ensure that the syscall behavior is consistent. It should be either
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
index d3dc5ec496854179..7ebfb603bf45fa0a 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -270,8 +270,24 @@ static void test_syscall_fallthrough_to(unsigned long ip)
 	printf("[OK]\tWe survived\n");
 }
 
+/*
+ * Ensure that various system calls are consistent.
+ * We should not get a mix of REGS_SAVED and REGS_SYSRET.
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
@@ -279,7 +295,7 @@ int main()
 	 * it'll crash on Intel CPUs.
 	 */
 	sethandler(SIGUSR1, sigusr1, 0);
-	for (int i = 47; i < 64; i++)
+	for (i = 47; i < 64; i++)
 		test_sigreturn_to(1UL<<i);
 
 	clearhandler(SIGUSR1);
@@ -290,7 +306,7 @@ int main()
 	test_syscall_fallthrough_to((1UL << 47) - 2*PAGE_SIZE);
 
 	/* These are the interesting cases. */
-	for (int i = 47; i < 64; i++) {
+	for (i = 47; i < 64; i++) {
 		test_syscall_fallthrough_to((1UL<<i) - PAGE_SIZE);
 		test_syscall_fallthrough_to(1UL<<i);
 	}
-- 
Ammar Faizi

