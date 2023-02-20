Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C76669C464
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Feb 2023 04:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBTDKo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Feb 2023 22:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBTDKn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Feb 2023 22:10:43 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61CBE075;
        Sun, 19 Feb 2023 19:10:34 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 35EB88314A;
        Mon, 20 Feb 2023 03:10:27 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1676862634;
        bh=8+ewo69UeU0rHb78uAAPEiHOOweqFJBmdi5nkVAJieo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PE01Ct8AR9GQuFjnvOQzf1W28HATJ6XpOq9xa0FIejWgb0rH9phaTu57ipNwhsMrw
         VsrIE2JWbD3UV8FNf9wHRv9pY+gHCnXBPjQlcKj/E8wWrYbnkqqhiaBtw1cl3IIAKm
         CnVIGdPKMeBBM+zxTzwpzxrpik4bvCTTM8IRwX7ycw8MdIAfhw2DnUA/WS1DQr3cRJ
         Txx8d6po9XSiNJ34BRbKMpvh/SOoVlVylAt/uJpB8yCfY9P4uBUHd0iyVkgVGxy+gJ
         1chxDMEkOGF6auqWrl/7msqsj8n++Hrcjc3pL983UEJqnNq/gdgAauPIT24CaUOT6l
         /2cPDCBbfPCgw==
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [RESEND RFC PATCH v8 3/3] selftests/x86: sysret_rip: Test SYSRET with a signal handler
Date:   Mon, 20 Feb 2023 10:09:59 +0700
Message-Id: <20230220030959.119222-4-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220030959.119222-1-ammarfaizi2@gnuweeb.org>
References: <20230220030959.119222-1-ammarfaizi2@gnuweeb.org>
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

The current test_sigreturn_to() goes to the slow-path syscall with
IRET due to non-canonical addresses. It uses the SIGUSR1 signal to
perform the test.

Add a similar test that goes to the SYSRET path instead of IRET using
the SIGUSR2 signal. There are two cases:

  A) 'syscall' in a FRED system preserves %rcx and %r11.

  B) 'syscall' in a non-FRED system sets %rcx=%rip and %r11=%rflags.

The __raise(SIGUSR2) call verifies the 'syscall' behavior consistency
when dealing with a signal handler. It must always be (A) or always be
(B). Not a mix of them.

Cc: Xin Li <xin3.li@intel.com>
Link: https://lore.kernel.org/lkml/8770815f-0f23-d0c5-e56a-d401827842c9@zytor.com
Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/testing/selftests/x86/sysret_rip.c | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index 1531593b50d02150..746801675fe77e9c 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -274,6 +274,28 @@ static void test_syscall_rcx_r11_consistent(void)
 	do_syscall(__NR_getppid, 0, 0, 0, 0, 0, 0);
 }
 
+static unsigned long usr2_rcx;
+static unsigned long usr2_r11;
+
+static void sigusr2(int sig, siginfo_t *info, void *ctx_void)
+{
+	ucontext_t *ctx = (ucontext_t*)ctx_void;
+
+	usr2_r11 = ctx->uc_mcontext.gregs[REG_R11];
+	usr2_rcx = ctx->uc_mcontext.gregs[REG_RCX];
+
+	check_regs_result(ctx->uc_mcontext.gregs[REG_R11],
+			  ctx->uc_mcontext.gregs[REG_RCX],
+			  ctx->uc_mcontext.gregs[REG_RBX]);
+}
+
+static void test_sysret_consistent(void)
+{
+	printf("[RUN]\ttest_sysret_consistent\n");
+	__raise(SIGUSR2);
+	printf("[OK]\tRCX = %#lx;  R11 = %#lx\n", usr2_rcx, usr2_r11);
+}
+
 int main()
 {
 	int i;
@@ -291,6 +313,14 @@ int main()
 	for (i = 47; i < 64; i++)
 		test_sigreturn_to(1UL<<i);
 
+	/*
+	 * test_sigreturn_to() above will test the IRET path. Now test
+	 * the SYSRET path.
+	 */
+	sethandler(SIGUSR2, sigusr2, 0);
+	for (i = 0; i < 32; i++)
+		test_sysret_consistent();
+
 	clearhandler(SIGUSR1);
 
 	sethandler(SIGSEGV, sigsegv_for_fallthrough, 0);
-- 
Ammar Faizi

