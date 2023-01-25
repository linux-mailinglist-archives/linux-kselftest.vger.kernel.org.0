Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B9567BDF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 22:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbjAYVSF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 16:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbjAYVR5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 16:17:57 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1D07D89;
        Wed, 25 Jan 2023 13:17:45 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id D6310824E0;
        Wed, 25 Jan 2023 21:17:38 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674681464;
        bh=vBWFR+xb4VVQ1ESzMMkJK66vUOBLYOX/iFxSXT2+DEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtSY8u6I6XwmtvHyIZv8YZmG7mWHsus0383CNV+Jp7r3nXQJ9z1k3IJ3IjvOk3SRe
         2DDMX8YQej538IKIthIcU7BAa9m9Zken/B6McJM4LVv+/4NVrJ3QqnGWzT7D/QhrEO
         Ayp0zzbiy4afnTWnaBFmwvZQbBbrR30BZgcHFwrBlumRSOWFadkvoMzg/fIjlqe/Ax
         whBZIJ3Sf03mwZtH9bsNH19AdLqyvO9hTnjgPAzRuRwo/cYcu4U9SW/f68kjoB/UD8
         xOoQanlpZwDn16uQlRXBcp6nN9r6g5wykAHsQMBB9vPj6fDs+sZSyK5K5weyLzRiH4
         4Rc0EZJ3lEPMQ==
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
Subject: [RFC PATCH v6 3/3] selftests/x86: sysret_rip: Test opportunistic SYSRET
Date:   Thu, 26 Jan 2023 04:17:14 +0700
Message-Id: <20230125211714.838216-4-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125211714.838216-1-ammarfaizi2@gnuweeb.org>
References: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <25b96960-a07e-a952-5c23-786b55054126@zytor.com> <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org> <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com> <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com> <20230124022729.596997-1-ammarfaizi2@gnuweeb.org> <20230124022729.596997-3-ammarfaizi2@gnuweeb.org> <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com> <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org> <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com> <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125211714.838216-1-ammarfaizi2@gnuweeb.org>
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

When run on a non-FRED system, test the opportunistic SYSRET fast-path.
Make sure the %rcx/%r11 clobbering behavior is consistent.

When run on a FRED system, test that %rcx/%r11 are preserved when
invoking syscall.

This is similar to what test_syscall_rcx_r11_consistent() is doing, but
with addition it's done via the SIGUSR2 signal handler.

Link: https://lore.kernel.org/lkml/8770815f-0f23-d0c5-e56a-d401827842c9@zytor.com
Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

On Wed, 25 Jan 2023 00:39:26 -0800, "H. Peter Anvin" wrote:
> >    /* Set IP and CX to match so that SYSRET can happen. */
> >     ctx->uc_mcontext.gregs[REG_RIP] = rip;
> >     ctx->uc_mcontext.gregs[REG_RCX] = rip;
> 
> It would be interesting to have the syscall handler try both with and 
> without this (so it would end up doing both IRET and SYSCALL on legacy.) 
> Perhaps SIGUSR1 versus SIGUSR2...


 tools/testing/selftests/x86/sysret_rip.c | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index d45b7f0147cd25ad..a1e5ec6f08bcd523 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -275,6 +275,28 @@ static void test_syscall_rcx_r11_consistent(void)
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
@@ -292,6 +314,21 @@ int main()
 	for (i = 47; i < 64; i++)
 		test_sigreturn_to(1UL<<i);
 
+	/*
+	 *
+	 * When run on a non-FRED system, test the SYSRET path. Make
+	 * sure the %rcx/%r11 clobbering behavior is consistent.
+	 *
+	 * When run on a FRED system, test that %rcx/%r11 are preserved
+	 * when invoking syscall.
+	 *
+	 * This is similar to test_syscall_rcx_r11_consistent(), but via
+	 * a signal handler.
+	 */
+	sethandler(SIGUSR2, sigusr2, 0);
+	for (i = 0; i < 32; i++)
+		test_sysret_consistent();
+
 	clearhandler(SIGUSR1);
 
 	sethandler(SIGSEGV, sigsegv_for_fallthrough, 0);
-- 
Ammar Faizi

