Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF9589154
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 19:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbiHCRZ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 13:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbiHCRZ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 13:25:58 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF3B20BDF
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Aug 2022 10:25:51 -0700 (PDT)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oJI7x-00Gomk-8l; Wed, 03 Aug 2022 19:25:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From;
        bh=Cx0Wbu9tyWYXwdm9srrl7Da37mHrI+iH5dMu+ikSwWw=; b=h+P/lTGz3ka57OzpXgCr0uqp46
        6Zb2FVw64ncpK4nMyMH4jpz/PD4ScjWWaoe7yiF6QZ8fqJodpeioCW0qKrKAEzBYGAq+qcMfBLwlp
        ZNaI9lahhpHv2Ay3tjAULdfhROirXJnq3lpDURwrVa3D1+WJINmNtsR0yWa6+EKtCfW3MwoPgGeWR
        GClOLlizfRXKMv1HnTnaiQfkvbGL5QRg0r+/sO3KKS+1+k3/BkcYiahd2csDGJI++cb7AbdyT4JAv
        qvL3I4I/AQmHoOe9kgBCM30RbZH7qS7JvqKy6X9cEwlPR3W/mxgGElGOC7eYCyCxB77xTtmEd8y/a
        lEohw0iw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oJI7t-0004o7-4l; Wed, 03 Aug 2022 19:25:49 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oJI7p-0000yh-Oq; Wed, 03 Aug 2022 19:25:41 +0200
From:   Michal Luczaj <mhal@rbox.co>
To:     seanjc@google.com
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
Subject: [kvm-unit-tests PATCH 4/4] x86: Extend ASM_TRY to handle #UD thrown by FEP-triggered emulator
Date:   Wed,  3 Aug 2022 19:25:08 +0200
Message-Id: <20220803172508.1215-4-mhal@rbox.co>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220803172508.1215-1-mhal@rbox.co>
References: <Yum2LpZS9vtCaCBm@google.com>
 <20220803172508.1215-1-mhal@rbox.co>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

TRY_ASM() mishandles #UD thrown by the forced-emulation-triggered emulator.
While the faulting address stored in the exception table points at forced
emulation prefix, when #UD comes, RIP is 5 bytes (size of KVM_FEP) ahead
and the exception ends up unhandled.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
While here, I've also took the opportunity to merge both 32 and 64-bit
versions of ASM_TRY() (.dc.a for .long and .quad), but perhaps there
were some reasons for not using .dc.a?

 lib/x86/desc.h | 11 +++++------
 x86/emulator.c |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/x86/desc.h b/lib/x86/desc.h
index 2a285eb..99cc224 100644
--- a/lib/x86/desc.h
+++ b/lib/x86/desc.h
@@ -80,21 +80,20 @@ typedef struct  __attribute__((packed)) {
 	u16 iomap_base;
 } tss64_t;
 
-#ifdef __x86_64
 #define ASM_TRY(catch)			\
 	"movl $0, %%gs:4 \n\t"		\
 	".pushsection .data.ex \n\t"	\
-	".quad 1111f, " catch "\n\t"	\
+	".dc.a 1111f, " catch "\n\t"	\
 	".popsection \n\t"		\
 	"1111:"
-#else
-#define ASM_TRY(catch)			\
+
+#define ASM_TRY_PREFIXED(prefix, catch)	\
 	"movl $0, %%gs:4 \n\t"		\
 	".pushsection .data.ex \n\t"	\
-	".long 1111f, " catch "\n\t"	\
+	".dc.a 1111f, " catch "\n\t"	\
 	".popsection \n\t"		\
+	prefix "\n\t"			\
 	"1111:"
-#endif
 
 /*
  * selector     32-bit                        64-bit
diff --git a/x86/emulator.c b/x86/emulator.c
index df0bc49..d2a5302 100644
--- a/x86/emulator.c
+++ b/x86/emulator.c
@@ -900,8 +900,8 @@ static void test_illegal_lea(void)
 {
 	unsigned int vector;
 
-	asm volatile (ASM_TRY("1f")
-		      KVM_FEP ".byte 0x8d; .byte 0xc0\n\t"
+	asm volatile (ASM_TRY_PREFIXED(KVM_FEP, "1f")
+		      ".byte 0x8d; .byte 0xc0\n\t"
 		      "1:"
 		      : : : "memory", "eax");
 
-- 
2.37.1

