Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA7589152
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 19:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbiHCRZ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 13:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbiHCRZv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 13:25:51 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43FF24BD8;
        Wed,  3 Aug 2022 10:25:48 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oJI7s-00GomS-M9; Wed, 03 Aug 2022 19:25:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From;
        bh=G7GRAel2rUcKFd3vr5Cct2yOxylX+AKUPGlpk4AlbMk=; b=xB9L75GWCPyQvm+SRn0PFcFKVf
        Mb4y/sRUCC9hN3ObU4/sVR0QoFqM3IdANWX2r7EJQ2BSkjrp5TYeG4sMhzXAxqb3pjlYOisdsBKsk
        fDaePUjjqi7KdsYICy146A+u/X24GiunveAnHmwOBdw07U7SHdJod5K/7J6y0Sx7+77X5zOfgfrQo
        mKKYnoyybDMPN0IOcXkTgEtRSC9oADlr753T0bPsNhIdAjK53IgS90pPPNloxXI5KKIVWk5CKSLWX
        GuVLffzAVR9ULa7BvwYrf6MZ5+srZMNDnOxNKCT/MsnwSmfMQZNt3ApwNNnea0hpBNY37m31udscm
        MZXRcsMQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oJI7s-000846-3m; Wed, 03 Aug 2022 19:25:44 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oJI7n-0000yh-Tz; Wed, 03 Aug 2022 19:25:39 +0200
From:   Michal Luczaj <mhal@rbox.co>
To:     seanjc@google.com
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
Subject: [kvm-unit-tests PATCH 3/4] x86: Test emulator's handling of LEA with /reg
Date:   Wed,  3 Aug 2022 19:25:07 +0200
Message-Id: <20220803172508.1215-3-mhal@rbox.co>
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

LEA with a register-direct source operand is illegal. Verify that the
emulator raises #UD.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 x86/emulator.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/x86/emulator.c b/x86/emulator.c
index d4488a7..df0bc49 100644
--- a/x86/emulator.c
+++ b/x86/emulator.c
@@ -896,6 +896,20 @@ static void test_mov_dr(uint64_t *mem)
 		report(rax == DR6_ACTIVE_LOW, "mov_dr6");
 }
 
+static void test_illegal_lea(void)
+{
+	unsigned int vector;
+
+	asm volatile (ASM_TRY("1f")
+		      KVM_FEP ".byte 0x8d; .byte 0xc0\n\t"
+		      "1:"
+		      : : : "memory", "eax");
+
+	vector = exception_vector();
+	report(vector == UD_VECTOR,
+	       "Wanted #UD on LEA with /reg, got vector = %u", vector);
+}
+
 static void test_push16(uint64_t *mem)
 {
 	uint64_t rsp1, rsp2;
@@ -1187,6 +1201,7 @@ int main(void)
 		test_smsw_reg(mem);
 		test_nop(mem);
 		test_mov_dr(mem);
+		test_illegal_lea();
 	} else {
 		report_skip("skipping register-only tests, "
 			    "use kvm.force_emulation_prefix=1 to enable");
-- 
2.37.1

