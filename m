Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8DF58BB3D
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Aug 2022 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbiHGO3C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Aug 2022 10:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiHGO3B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Aug 2022 10:29:01 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5524763CD;
        Sun,  7 Aug 2022 07:28:59 -0700 (PDT)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oKhGz-007po6-Go; Sun, 07 Aug 2022 16:28:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From;
        bh=BNwp4N13pHNhXN8W8GMaMwTpbUSiiHRpPFgA+FJuxUE=; b=AnAO9Fl2VaoKjXPo7UrvI5KIJ9
        16Haf3pDI++HPyqDCzEr9HGgvmEB84RPdR2IGbjja/VWT6zWcU+HbmX1wsXn5rHv2KnDtlKOPYPyH
        d4hcsvzmRG7YR+DEWKy+Rsis1ZeEpiz/bXsD23x9nbNwQIhHWXU4uTYaFK6zENZoOB9enF6piGH1M
        yXB/xLlS7D7FdPSuIK0Lqb07J7uuJOXNuScEv+nfmJqPYrntaDoNxHU2WUZ6O1BlgeJDlQ20clKlX
        W5klGMldLAREgUNJe6y8VzMkWrOz8EPfAaSncGidITWjpadJWH8wNjewQJmoXxtlw1PQsz7ZROtV+
        Gz6xxE9w==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oKhGz-0005Nv-9S; Sun, 07 Aug 2022 16:28:57 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oKhGr-0002az-OH; Sun, 07 Aug 2022 16:28:49 +0200
From:   Michal Luczaj <mhal@rbox.co>
To:     seanjc@google.com
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, mhal@rbox.co
Subject: [kvm-unit-tests PATCH v2 3/5] x86: Introduce ASM_TRY_FEP() to handle exceptions thrown by FEP-triggered emulator
Date:   Sun,  7 Aug 2022 16:28:30 +0200
Message-Id: <20220807142832.1576-4-mhal@rbox.co>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807142832.1576-1-mhal@rbox.co>
References: <20220807142832.1576-1-mhal@rbox.co>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

TRY_ASM() mishandles exceptions thrown by the forced-emulation-triggered
emulator. While the faulting address stored in the exception table points
at forced emulation prefix, when an exceptions comes, RIP is 5 bytes
(size of KVM_FEP) ahead and the exception ends up unhandled.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
For the sake of completeness, I've added `prefix` to 32-bit __TRY_ASM()
as well.

 lib/x86/desc.h | 8 ++++++--
 x86/emulator.c | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/x86/desc.h b/lib/x86/desc.h
index 2a285eb..8854fcc 100644
--- a/lib/x86/desc.h
+++ b/lib/x86/desc.h
@@ -81,21 +81,25 @@ typedef struct  __attribute__((packed)) {
 } tss64_t;
 
 #ifdef __x86_64
-#define ASM_TRY(catch)			\
+#define __ASM_TRY(prefix, catch)	\
 	"movl $0, %%gs:4 \n\t"		\
 	".pushsection .data.ex \n\t"	\
 	".quad 1111f, " catch "\n\t"	\
 	".popsection \n\t"		\
+	prefix				\
 	"1111:"
 #else
-#define ASM_TRY(catch)			\
+#define __ASM_TRY(prefix, catch)	\
 	"movl $0, %%gs:4 \n\t"		\
 	".pushsection .data.ex \n\t"	\
 	".long 1111f, " catch "\n\t"	\
 	".popsection \n\t"		\
+	prefix				\
 	"1111:"
 #endif
 
+#define ASM_TRY(catch) __ASM_TRY("", catch)
+
 /*
  * selector     32-bit                        64-bit
  * 0x00         NULL descriptor               NULL descriptor
diff --git a/x86/emulator.c b/x86/emulator.c
index 96d3ccd..0eb7c1a 100644
--- a/x86/emulator.c
+++ b/x86/emulator.c
@@ -19,6 +19,7 @@ static int exceptions;
 
 /* Forced emulation prefix, used to invoke the emulator unconditionally. */
 #define KVM_FEP "ud2; .byte 'k', 'v', 'm';"
+#define ASM_TRY_FEP(catch) __ASM_TRY(KVM_FEP, catch)
 
 struct regs {
 	u64 rax, rbx, rcx, rdx;
-- 
2.37.1

