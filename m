Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D5658BB45
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Aug 2022 16:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiHGO3G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Aug 2022 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiHGO3E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Aug 2022 10:29:04 -0400
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7B563CD
        for <linux-kselftest@vger.kernel.org>; Sun,  7 Aug 2022 07:29:03 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oKhH0-007tOi-Px; Sun, 07 Aug 2022 16:28:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From;
        bh=UkcKvMcTp4LxHIs2u3g0+weq+MmQInuNd7XSB7FVqP8=; b=RO6mo4seTlJ4OUeqVQMZIPopJj
        F0I/bEXWT9n9t1phCwessKLGvHuuOsNgWxXZxsgi8fbuHWJEw8ks6Nl/JE1LKOKfiJtXIAzJWmmIz
        XXsF9dFUJ8xgSAE6r0eAiAB/lrEejlDT26vfOhO1OvAxCTd6GynoGXookyxD3yNhamyNs+jxDzlU+
        EncODtffpehucaSiqxdIFr4PJgGdlsxI0f4sJdocf+Z6rKUN3Zk11PtgmXaUF118QEgMt63mx9X33
        AJJlUxFuetATvxOaL4X65rQJ8rAeN7tKlLSBgfCbxJiQ9y9iUh8vkbTrXM9IJ8PL4fPn6vf5Bf+TV
        aw2p6l0w==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oKhH0-0007jO-C4; Sun, 07 Aug 2022 16:28:58 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oKhGn-0002az-0S; Sun, 07 Aug 2022 16:28:45 +0200
From:   Michal Luczaj <mhal@rbox.co>
To:     seanjc@google.com
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, mhal@rbox.co
Subject: [kvm-unit-tests PATCH v2 1/5] x86: emulator.c cleanup: Save and restore exception handlers
Date:   Sun,  7 Aug 2022 16:28:28 +0200
Message-Id: <20220807142832.1576-2-mhal@rbox.co>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807142832.1576-1-mhal@rbox.co>
References: <20220807142832.1576-1-mhal@rbox.co>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Users of handle_exception() should always save and restore the handlers.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
v1 -> v2: No changes

 x86/emulator.c | 78 ++++++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/x86/emulator.c b/x86/emulator.c
index cd78e3c..769a049 100644
--- a/x86/emulator.c
+++ b/x86/emulator.c
@@ -710,6 +710,7 @@ static __attribute__((target("sse2"))) void test_sse_exceptions(void *cross_mem)
 	void *page2 = (void *)(&bytes[4096]);
 	struct pte_search search;
 	pteval_t orig_pte;
+	handler old;
 
 	// setup memory for unaligned access
 	mem = (uint32_t *)(&bytes[8]);
@@ -725,10 +726,10 @@ static __attribute__((target("sse2"))) void test_sse_exceptions(void *cross_mem)
 	asm("movupd %1, %0" : "=m"(*mem) : "x"(vv) : "memory");
 	report(sseeq(v, mem), "movupd unaligned");
 	exceptions = 0;
-	handle_exception(GP_VECTOR, unaligned_movaps_handler);
+	old = handle_exception(GP_VECTOR, unaligned_movaps_handler);
 	asm("movaps %1, %0\n\t unaligned_movaps_cont:"
 			: "=m"(*mem) : "x"(vv));
-	handle_exception(GP_VECTOR, 0);
+	handle_exception(GP_VECTOR, old);
 	report(exceptions == 1, "unaligned movaps exception");
 
 	// setup memory for cross page access
@@ -746,10 +747,10 @@ static __attribute__((target("sse2"))) void test_sse_exceptions(void *cross_mem)
 	invlpg(page2);
 
 	exceptions = 0;
-	handle_exception(PF_VECTOR, cross_movups_handler);
+	old = handle_exception(PF_VECTOR, cross_movups_handler);
 	asm("movups %1, %0\n\t cross_movups_cont:" : "=m"(*mem) : "x"(vv) :
 			"memory");
-	handle_exception(PF_VECTOR, 0);
+	handle_exception(PF_VECTOR, old);
 	report(exceptions == 1, "movups crosspage exception");
 
 	// restore invalidated page
@@ -817,36 +818,38 @@ static void advance_rip_and_note_exception(struct ex_regs *regs)
 
 static void test_mmx_movq_mf(uint64_t *mem)
 {
-    /* movq %mm0, (%rax) */
-    extern char movq_start, movq_end;
-
-    uint16_t fcw = 0;  /* all exceptions unmasked */
-    write_cr0(read_cr0() & ~6);  /* TS, EM */
-    exceptions = 0;
-    handle_exception(MF_VECTOR, advance_rip_and_note_exception);
-    asm volatile("fninit; fldcw %0" : : "m"(fcw));
-    asm volatile("fldz; fldz; fdivp"); /* generate exception */
-
-    rip_advance = &movq_end - &movq_start;
-    asm(KVM_FEP "movq_start: movq %mm0, (%rax); movq_end:");
-    /* exit MMX mode */
-    asm volatile("fnclex; emms");
-    report(exceptions == 1, "movq mmx generates #MF");
-    handle_exception(MF_VECTOR, 0);
+	/* movq %mm0, (%rax) */
+	extern char movq_start, movq_end;
+	handler old;
+
+	uint16_t fcw = 0;  /* all exceptions unmasked */
+	write_cr0(read_cr0() & ~6);  /* TS, EM */
+	exceptions = 0;
+	old = handle_exception(MF_VECTOR, advance_rip_and_note_exception);
+	asm volatile("fninit; fldcw %0" : : "m"(fcw));
+	asm volatile("fldz; fldz; fdivp"); /* generate exception */
+
+	rip_advance = &movq_end - &movq_start;
+	asm(KVM_FEP "movq_start: movq %mm0, (%rax); movq_end:");
+	/* exit MMX mode */
+	asm volatile("fnclex; emms");
+	report(exceptions == 1, "movq mmx generates #MF");
+	handle_exception(MF_VECTOR, old);
 }
 
 static void test_jmp_noncanonical(uint64_t *mem)
 {
 	extern char nc_jmp_start, nc_jmp_end;
+	handler old;
 
 	*mem = 0x1111111111111111ul;
 
 	exceptions = 0;
 	rip_advance = &nc_jmp_end - &nc_jmp_start;
-	handle_exception(GP_VECTOR, advance_rip_and_note_exception);
+	old = handle_exception(GP_VECTOR, advance_rip_and_note_exception);
 	asm volatile ("nc_jmp_start: jmp *%0; nc_jmp_end:" : : "m"(*mem));
 	report(exceptions == 1, "jump to non-canonical address");
-	handle_exception(GP_VECTOR, 0);
+	handle_exception(GP_VECTOR, old);
 }
 
 static void test_movabs(uint64_t *mem)
@@ -979,22 +982,23 @@ static void ss_bad_rpl(struct ex_regs *regs)
 
 static void test_sreg(volatile uint16_t *mem)
 {
-    u16 ss = read_ss();
+	u16 ss = read_ss();
+	handler old;
 
-    // check for null segment load
-    *mem = 0;
-    asm volatile("mov %0, %%ss" : : "m"(*mem));
-    report(read_ss() == 0, "mov null, %%ss");
-
-    // check for exception when ss.rpl != cpl on null segment load
-    exceptions = 0;
-    handle_exception(GP_VECTOR, ss_bad_rpl);
-    *mem = 3;
-    asm volatile("mov %0, %%ss; ss_bad_rpl_cont:" : : "m"(*mem));
-    report(exceptions == 1 && read_ss() == 0,
-           "mov null, %%ss (with ss.rpl != cpl)");
-    handle_exception(GP_VECTOR, 0);
-    write_ss(ss);
+	// check for null segment load
+	*mem = 0;
+	asm volatile("mov %0, %%ss" : : "m"(*mem));
+	report(read_ss() == 0, "mov null, %%ss");
+
+	// check for exception when ss.rpl != cpl on null segment load
+	exceptions = 0;
+	old = handle_exception(GP_VECTOR, ss_bad_rpl);
+	*mem = 3;
+	asm volatile("mov %0, %%ss; ss_bad_rpl_cont:" : : "m"(*mem));
+	report(exceptions == 1 && read_ss() == 0,
+	       "mov null, %%ss (with ss.rpl != cpl)");
+	handle_exception(GP_VECTOR, old);
+	write_ss(ss);
 }
 
 static uint64_t usr_gs_mov(void)
-- 
2.37.1

