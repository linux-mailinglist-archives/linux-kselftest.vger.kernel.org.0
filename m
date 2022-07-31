Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DF058616F
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Jul 2022 22:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiGaUrX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 31 Jul 2022 16:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbiGaUrX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 31 Jul 2022 16:47:23 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC2A65B3
        for <linux-kselftest@vger.kernel.org>; Sun, 31 Jul 2022 13:47:21 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oIFqK-009crV-2m; Sun, 31 Jul 2022 22:47:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From;
        bh=OJvpmkIiGFZf9HswNPNYoGPHO87+nnPmBO1JM9Pvekc=; b=jvez0LykETh0j446Pbsa4cXgOK
        B9U/K0fIicboHZqq+3H+hsSBjBNyVV9GDumhvxRGq8mzjlf86oU5qXYTIi0tUlr1BWUyzBDAIdFmj
        YECoA5VI5X0MJKbGQ3A2xDLmSp/9EERHE48UGCgNCoBDkOqdrIHtKl33Z2R3V33108F2YhWRuzbT9
        BzUxMgeHPIy9ctBirjv3pgfCmtavNtUbZTcdf/pWJ887RkH/mfT6tFPBZG6R/BBJzI/7yuxIkR5IX
        DjR0xi+yBcgWWjNgBHDhEPCxgkW68g3Ejbkp/p1ReMBLIaK+NAtRjnxPkrEv1Guuk3EWVt1bDbdN8
        3QV1FZGw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oIFqJ-0005Eu-L7; Sun, 31 Jul 2022 22:47:19 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oIFqE-0006K8-4k; Sun, 31 Jul 2022 22:47:14 +0200
From:   Michal Luczaj <mhal@rbox.co>
To:     seanjc@google.com
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
Subject: [kvm-unit-tests PATCH v2] x86: Test illegal LEA handling
Date:   Sun, 31 Jul 2022 22:46:53 +0200
Message-Id: <20220731204653.2516-1-mhal@rbox.co>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YuQQiv862oWDpgt5@google.com>
References: <YuQQiv862oWDpgt5@google.com>
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

Check if the emulator throws #UD on illegal LEA.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
v1 -> v2: Instead of racing decoder make use of force_emulation_prefix

 x86/emulator.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/x86/emulator.c b/x86/emulator.c
index cd78e3c..c3898f2 100644
--- a/x86/emulator.c
+++ b/x86/emulator.c
@@ -895,6 +895,24 @@ static void test_mov_dr(uint64_t *mem)
 		report(rax == DR6_ACTIVE_LOW, "mov_dr6");
 }
 
+static void illegal_lea_handler(struct ex_regs *regs)
+{
+	extern char illegal_lea_cont;
+
+	++exceptions;
+	regs->rip = (ulong)&illegal_lea_cont;
+}
+
+static void test_illegal_lea(uint64_t *mem)
+{
+	exceptions = 0;
+	handle_exception(UD_VECTOR, illegal_lea_handler);
+	asm(KVM_FEP ".byte 0x48; .byte 0x8d; .byte 0xc0\n\t"
+	    "illegal_lea_cont:" : : : "rax");
+	report(exceptions == 1, "illegal lea");
+	handle_exception(UD_VECTOR, 0);
+}
+
 static void test_push16(uint64_t *mem)
 {
 	uint64_t rsp1, rsp2;
@@ -1193,6 +1211,7 @@ int main(void)
 		test_smsw_reg(mem);
 		test_nop(mem);
 		test_mov_dr(mem);
+		test_illegal_lea(mem);
 	} else {
 		report_skip("skipping register-only tests, "
 			    "use kvm.force_emulation_prefix=1 to enable");
-- 
2.32.0

