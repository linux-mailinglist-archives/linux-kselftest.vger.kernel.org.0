Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDAB589157
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 19:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiHCR0C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 13:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238120AbiHCRZ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 13:25:59 -0400
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E754C85;
        Wed,  3 Aug 2022 10:25:54 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oJI7y-00HAOF-4k; Wed, 03 Aug 2022 19:25:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From;
        bh=X3V2CjbAfz4Ipp/W+PUwPTvr/PTaWA4Be77RHOJ3lE4=; b=HxiKckirEH8ObLhYbwsgrHKyMk
        8QmTUQaQ0Xvpunz5KALvxLwymkrfXn27827J95kNOQQqmSr0ESa1qlSGZAs6YxCJAPzyWK9whOnIP
        X74ILHINQ8pjhvt1mSHzOvhKTbo7tcL+N5I2Bx+P/eWdf4cLVvZSUtlW4WcpFtAGJl1E6WgHgLPO7
        jlVglOQF2MSWuRzeyIjxD+QeSIHqOM5wsBq9ePBRcx+l7+jjc5GnzLY/yWa5Phpse0DWN91r72Yrd
        aJfEHrCdqx+6UNaPr6zkz37u3xNkOADGSroq+GffPmvkzdJ33ITp72N0icy4iFz4Tfyzgoxk2anKL
        oI3KT6OA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oJI7x-00084J-Pc; Wed, 03 Aug 2022 19:25:49 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oJI7g-0000yh-CW; Wed, 03 Aug 2022 19:25:32 +0200
From:   Michal Luczaj <mhal@rbox.co>
To:     seanjc@google.com
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
Subject: [kvm-unit-tests PATCH 2/4] x86: emulator.c cleanup: Use ASM_TRY for the UD_VECTOR cases
Date:   Wed,  3 Aug 2022 19:25:06 +0200
Message-Id: <20220803172508.1215-2-mhal@rbox.co>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220803172508.1215-1-mhal@rbox.co>
References: <Yum2LpZS9vtCaCBm@google.com>
 <20220803172508.1215-1-mhal@rbox.co>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For #UD handling use ASM_TRY() instead of handle_exception().

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
I've noticed test_illegal_movbe() does not execute with KVM_FEP.
Just making sure: is it intentional?

 x86/emulator.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/x86/emulator.c b/x86/emulator.c
index 769a049..d4488a7 100644
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
+		     KVM_FEP "mov $1, %[fep_available]\n\t"
+		     "1:"
+		     : [fep_available] "=m" (fep_available) : : "memory");
 
 	mem = alloc_vpages(2);
 	install_page((void *)read_cr3(), IORAM_BASE_PHYS, mem);
-- 
2.37.1

