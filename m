Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2294E58BB48
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Aug 2022 16:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiHGO3H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Aug 2022 10:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiHGO3F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Aug 2022 10:29:05 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A8F6413
        for <linux-kselftest@vger.kernel.org>; Sun,  7 Aug 2022 07:29:03 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oKhH2-007poN-2w; Sun, 07 Aug 2022 16:29:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From;
        bh=u4vadCSfYEZ1a+HytCJ3n6FqiT6eRdseH7TkDVqEX7k=; b=D6RBJ7lBe7x13pmoXGQZAahHNU
        Pa9p90H66OaKA6/kJEj/3hcbk+5q/MwF0dRbF71qKU0JPBfCzBvF09oozM99X5BaTg8sAjHq/oVt8
        vGttvUO5M3LsmSeeWvVALUou3gGh9qmb0Q6P2GO1TG8yQPwhuWojQoF0aTdXf5H3cGAP4gyahCCx0
        zRF5j9Uu3cJ486sm47W8Dc7uAfIkUBNAYfZHhSducCCDUTt3Gq6B+pnFelU7AgvGiJ8HeV2XWuD63
        3rXKHBM9Hky4vRznmIXrUDTyGntZDET8nv0eK2hr6WSd5qOt76VpkUkS55wZGPhQ76k13dQzlbnB+
        /PbCVZJw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oKhH1-0007kL-Mb; Sun, 07 Aug 2022 16:28:59 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oKhGp-0002az-Dg; Sun, 07 Aug 2022 16:28:47 +0200
From:   Michal Luczaj <mhal@rbox.co>
To:     seanjc@google.com
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, mhal@rbox.co
Subject: [kvm-unit-tests PATCH v2 2/5] x86: emulator.c cleanup: Use ASM_TRY() for the UD_VECTOR cases
Date:   Sun,  7 Aug 2022 16:28:29 +0200
Message-Id: <20220807142832.1576-3-mhal@rbox.co>
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

For #UD handling use ASM_TRY() instead of handle_exception().

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
v1 -> v2: Change `mov` to `movl` to silence the compiler warning

 x86/emulator.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/x86/emulator.c b/x86/emulator.c
index 769a049..96d3ccd 100644
--- a/x86/emulator.c
+++ b/x86/emulator.c
@@ -17,10 +17,8 @@
 
 static int exceptions;
 
-/* Forced emulation prefix, used to invoke the emulator unconditionally.  */
+/* Forced emulation prefix, used to invoke the emulator unconditionally. */
 #define KVM_FEP "ud2; .byte 'k', 'v', 'm';"
-#define KVM_FEP_LENGTH 5
-static int fep_available = 1;
 
 struct regs {
 	u64 rax, rbx, rcx, rdx;
@@ -1099,33 +1097,23 @@ static void test_simplealu(u32 *mem)
     report(*mem == 0x8400, "test");
 }
 
-static void illegal_movbe_handler(struct ex_regs *regs)
-{
-	extern char bad_movbe_cont;
-
-	++exceptions;
-	regs->rip = (ulong)&bad_movbe_cont;
-}
-
 static void test_illegal_movbe(void)
 {
+	unsigned int vector;
+
 	if (!this_cpu_has(X86_FEATURE_MOVBE)) {
-		report_skip("illegal movbe");
+		report_skip("MOVBE unsupported by CPU");
 		return;
 	}
 
-	exceptions = 0;
-	handle_exception(UD_VECTOR, illegal_movbe_handler);
-	asm volatile(".byte 0x0f; .byte 0x38; .byte 0xf0; .byte 0xc0;\n\t"
-		     " bad_movbe_cont:" : : : "rax");
-	report(exceptions == 1, "illegal movbe");
-	handle_exception(UD_VECTOR, 0);
-}
+	asm volatile(ASM_TRY("1f")
+		     ".byte 0x0f; .byte 0x38; .byte 0xf0; .byte 0xc0;\n\t"
+		     "1:"
+		     : : : "memory", "rax");
 
-static void record_no_fep(struct ex_regs *regs)
-{
-	fep_available = 0;
-	regs->rip += KVM_FEP_LENGTH;
+	vector = exception_vector();
+	report(vector == UD_VECTOR,
+	       "Wanted #UD on MOVBE with /reg, got vector = %u", vector);
 }
 
 int main(void)
@@ -1135,11 +1123,13 @@ int main(void)
 	void *insn_ram;
 	void *cross_mem;
 	unsigned long t1, t2;
+	int fep_available = 0;
 
 	setup_vm();
-	handle_exception(UD_VECTOR, record_no_fep);
-	asm(KVM_FEP "nop");
-	handle_exception(UD_VECTOR, 0);
+	asm volatile(ASM_TRY("1f")
+		     KVM_FEP "movl $1, %[fep_available]\n\t"
+		     "1:"
+		     : [fep_available] "=m" (fep_available) : : "memory");
 
 	mem = alloc_vpages(2);
 	install_page((void *)read_cr3(), IORAM_BASE_PHYS, mem);
-- 
2.37.1

