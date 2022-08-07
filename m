Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4679958BB3C
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Aug 2022 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiHGO3C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Aug 2022 10:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiHGO3B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Aug 2022 10:29:01 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552DD63CF;
        Sun,  7 Aug 2022 07:28:59 -0700 (PDT)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oKhGy-007pnx-Di; Sun, 07 Aug 2022 16:28:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From;
        bh=vW0skxzzr6i2Gd196B0hHDou57V5BdI+dFA4selfauQ=; b=EJTjvkZDsxTlToBRR34s7xt0PB
        K3lp/sNWUaBN0GZlgWJ6j7I/rwZqT+mOO2LdJScCIt2yKQNR4xEzO8BEr+MQACETh/C8Y9ybKtLr+
        zUZGTJxsXnRedNAPYMneuL+GncYNyIekEWaXavyyLl51l7JR+gJZytNsW8vsOeResEJFtwxfDGdhM
        0w122uYNhVQCPwXrOYTD++J8rX02iJxyph/9z1QDXlWQv4lIHjqqEgTN8imSRx49od3+uB9YoUBoT
        eMGiUtjKT1ZMZXXiNLznbulLZ0c7T4VSvtVo3HWXQj9Z1vmRZSAB/u2Ley9Bqr6uDmSLq9Vtm/OjS
        cX6Mz51A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oKhGy-0005Np-10; Sun, 07 Aug 2022 16:28:56 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oKhGu-0002az-2f; Sun, 07 Aug 2022 16:28:52 +0200
From:   Michal Luczaj <mhal@rbox.co>
To:     seanjc@google.com
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, mhal@rbox.co
Subject: [kvm-unit-tests PATCH v2 4/5] x86: Dedup 32-bit vs. 64-bit ASM_TRY() by stealing kernel's __ASM_SEL()
Date:   Sun,  7 Aug 2022 16:28:31 +0200
Message-Id: <20220807142832.1576-5-mhal@rbox.co>
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

From: Sean Christopherson <seanjc@google.com>

Steal the kernel's __ASM_SEL() implementation and use it to consolidate
ASM_TRY().  The only difference between the 32-bit and 64-bit versions is
the size of the address stored in the table.

No functional change intended.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 lib/x86/desc.h      | 22 ++++++----------------
 lib/x86/processor.h | 12 ++++++++++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/lib/x86/desc.h b/lib/x86/desc.h
index 8854fcc..5bb6fcb 100644
--- a/lib/x86/desc.h
+++ b/lib/x86/desc.h
@@ -80,23 +80,13 @@ typedef struct  __attribute__((packed)) {
 	u16 iomap_base;
 } tss64_t;
 
-#ifdef __x86_64
-#define __ASM_TRY(prefix, catch)	\
-	"movl $0, %%gs:4 \n\t"		\
-	".pushsection .data.ex \n\t"	\
-	".quad 1111f, " catch "\n\t"	\
-	".popsection \n\t"		\
-	prefix				\
+#define __ASM_TRY(prefix, catch)				\
+	"movl $0, %%gs:4 \n\t"					\
+	".pushsection .data.ex \n\t"				\
+	__ASM_SEL(.long, .quad) " 1111f,  " catch "\n\t"	\
+	".popsection \n\t"					\
+	prefix							\
 	"1111:"
-#else
-#define __ASM_TRY(prefix, catch)	\
-	"movl $0, %%gs:4 \n\t"		\
-	".pushsection .data.ex \n\t"	\
-	".long 1111f, " catch "\n\t"	\
-	".popsection \n\t"		\
-	prefix				\
-	"1111:"
-#endif
 
 #define ASM_TRY(catch) __ASM_TRY("", catch)
 
diff --git a/lib/x86/processor.h b/lib/x86/processor.h
index 0324220..30e2de8 100644
--- a/lib/x86/processor.h
+++ b/lib/x86/processor.h
@@ -19,6 +19,18 @@
 #  define S "4"
 #endif
 
+#ifdef __ASSEMBLY__
+#define __ASM_FORM(x, ...)	x,## __VA_ARGS__
+#else
+#define __ASM_FORM(x, ...)	" " xstr(x,##__VA_ARGS__) " "
+#endif
+
+#ifndef __x86_64__
+#define __ASM_SEL(a,b)		__ASM_FORM(a)
+#else
+#define __ASM_SEL(a,b)		__ASM_FORM(b)
+#endif
+
 #define DB_VECTOR 1
 #define BP_VECTOR 3
 #define UD_VECTOR 6
-- 
2.37.1

