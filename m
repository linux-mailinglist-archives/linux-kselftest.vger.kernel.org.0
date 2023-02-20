Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B302C69C44F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Feb 2023 04:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBTDDo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Feb 2023 22:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjBTDDn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Feb 2023 22:03:43 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1317ABDEB;
        Sun, 19 Feb 2023 19:03:35 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id E8A3583130;
        Mon, 20 Feb 2023 03:03:27 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1676862214;
        bh=Hke7N4a3CN0c5boF6cakkDs3zb+KxALxVpws4FxKUhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZLrDE/2AZQbdHvSmD8pEes8Vh7voDhgqtC0DzC6HiRiw11GaF62rZWZ3CAZMKDOk
         7P8adfTgqrfGksaa/jT/4Rf9QzSzL2XeEglEtoeMrArF9Qa40+pXkDFI2EJBSvt3k1
         yXKt0b1sIERSVr04IH7huzS232xTMaEMA7f3qMoVjVgOkrvlIDKPphQ/EP5BBv1c8Q
         NwCTaHHhh25uVPxjKGlT83SESgmGbTy/TEsyj70+bPhbxpfJqg526dYSsXcv6LhFYw
         5JK2bbXmdRewCJ6hasUjhstFl8Y7uzKpqoQyFeCwjkGWgjr49c7WyMN7gfvAhEJtq/
         P6A+ZEcyclQeQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, Xin Li <xin3.li@intel.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86 Mailing List <x86@kernel.org>,
        Linux x86-64 Mailing List <linux-x86_64@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [RFC PATCH v8 2/3] selftests/x86: sysret_rip: Add more tests to verify the 'syscall' behavior
Date:   Mon, 20 Feb 2023 10:02:43 +0700
Message-Id: <20230220030244.115808-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220030244.115808-1-ammarfaizi2@gnuweeb.org>
References: <20230220030244.115808-1-ammarfaizi2@gnuweeb.org>
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

There are two cases:

  A) 'syscall' in a FRED system preserves %rcx and %r11.

  B) 'syscall' in a non-FRED system sets %rcx=%rip and %r11=%rflags.

When the do_syscall() function is called for the first time, it will
memorize the behavior, either (A) or (B). Then, the next do_syscall()
call will verify that the 'syscall' behavior is the same.

Test them with trivial system calls like __NR_getppid and friends, which
are highly likely to return with SYSRET on an IDT system.

The purposes of this test are:

  - Ensure that the syscall behavior is consistent. It must always be
    (A) or always be (B). Not a mix of them.

  - Ensure that the kernel doesn't leak its internal data when returning
    to userspace.

Cc: Xin Li <xin3.li@intel.com>
Link: https://lore.kernel.org/lkml/25b96960-a07e-a952-5c23-786b55054126@zytor.com
Co-developed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/testing/selftests/x86/sysret_rip.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index 300104900192d396..1531593b50d02150 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -266,8 +266,21 @@ static void test_syscall_fallthrough_to(unsigned long ip)
 	printf("[OK]\tWe survived\n");
 }
 
+/* See the comment in do_syscall(). */
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
@@ -275,7 +288,7 @@ int main()
 	 * it'll crash on Intel CPUs.
 	 */
 	sethandler(SIGUSR1, sigusr1, 0);
-	for (int i = 47; i < 64; i++)
+	for (i = 47; i < 64; i++)
 		test_sigreturn_to(1UL<<i);
 
 	clearhandler(SIGUSR1);
@@ -286,7 +299,7 @@ int main()
 	test_syscall_fallthrough_to((1UL << 47) - 2*PAGE_SIZE);
 
 	/* These are the interesting cases. */
-	for (int i = 47; i < 64; i++) {
+	for (i = 47; i < 64; i++) {
 		test_syscall_fallthrough_to((1UL<<i) - PAGE_SIZE);
 		test_syscall_fallthrough_to(1UL<<i);
 	}
-- 
Ammar Faizi

