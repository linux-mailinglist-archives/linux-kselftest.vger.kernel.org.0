Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9AD26FAE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 12:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgIRKry (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 06:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgIRKrr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 06:47:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62867C06174A;
        Fri, 18 Sep 2020 03:47:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so4868815wmj.2;
        Fri, 18 Sep 2020 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7f3R/YrvQ9iFIR/7ACD20Akwt7csQcsSAaA3rblwrRI=;
        b=Tn8eW1Rjz007/784pM3YefcDbmG4YjwpGGbcJ1/DxH1X0k0lmKZ+f68oJXbODQOPLe
         xawP1m2IQElO5OutuocP6IHxPtSki+dKI8XsMCO8NAmKXM6GMrG7F6tGi5key6gsSP95
         pRxIHzXILPWBmP+AhKh9jmu9iF2qn3msRShdcf+pjHQP+soRtqvwR0Kx2oAwpW/ue/tR
         8sDYgA+fMKoGpQkwC0TATYNfiga/iOFI3H/ChypeV3PdObuWBePGcsXSKHkpVWefvKme
         GwITjI1YHlkucw12HeVA20pU3TxBwPe+oyKgCrXiMK1fEKYLmcjb0LEcX8PACGSlTk2Y
         Qr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7f3R/YrvQ9iFIR/7ACD20Akwt7csQcsSAaA3rblwrRI=;
        b=VHswDuX/24QQ9F6hfi20V54/FYl1kdtmE2YiU6XJXpEuIpfXJtRN8WODMkyDlw1qmG
         o42w70qehf17aO5viZhy+YxP+0UzqNzRj/1KutO/ClccJOIrNyrHC+x5rpRo7hhC16s9
         DWXacBtnxH9TbVcOsmzVBxhOBWPwYeYey3U3aH/lj72mZmwmtDo/rjLHWXmNTvh9ft4Y
         nmpBfAIL1t0xf0WlEujeckd1mc5fbOkUE7NW/8AFOGj/kVSqbvRHZAG0CpSWVfRx+Z2A
         AsdC2dRCeZGBebSLCx9mKWiTigAc+Tgm1QUK7woBqk+Bd7MyEzo+JDryYjvmvveuAAu3
         +wtQ==
X-Gm-Message-State: AOAM5337zkCGUJaAN2ilU1wYmJsgyPXk+TTUQPLc41EzogEHAVRLvM30
        7ZHlB4tZRj/fEtXmB+72OxM=
X-Google-Smtp-Source: ABdhPJz08Z6EApZk2T6twKvkYavHoMZs2cp6r9bDJj8jGscZ0eIBYB4qzH/kgB82N+X/a8j3srrAPA==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr15770441wmc.154.1600426065931;
        Fri, 18 Sep 2020 03:47:45 -0700 (PDT)
Received: from trantor.home (cpc153975-seac28-2-0-cust722.7-2.cable.virginm.net. [81.109.38.211])
        by smtp.gmail.com with ESMTPSA id h4sm5197846wrm.54.2020.09.18.03.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:47:45 -0700 (PDT)
From:   Boyan Karatotev <boian4o1@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Boyan Karatotev <boian4o1@gmail.com>,
        Boyan Karatotev <boyan.karatotev@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 2/4] kselftests/arm64: add nop checks for PAuth tests
Date:   Fri, 18 Sep 2020 11:47:13 +0100
Message-Id: <20200918104715.182310-3-boian4o1@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918104715.182310-1-boian4o1@gmail.com>
References: <20200918104715.182310-1-boian4o1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Boyan Karatotev <boyan.karatotev@arm.com>

PAuth adds sign/verify controls to enable and disable groups of
instructions in hardware for compatibility with libraries that do not
implement PAuth. The kernel always enables them if it detects PAuth.

Add a test that checks that each group of instructions is enabled, if the
kernel reports PAuth as detected.

Note: For groups, for the purpose of this patch, we intend instructions
that use a certain key.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Reviewed-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
---
 .../testing/selftests/arm64/pauth/.gitignore  |  1 +
 tools/testing/selftests/arm64/pauth/Makefile  |  7 ++-
 tools/testing/selftests/arm64/pauth/helper.c  | 39 ++++++++++++++
 tools/testing/selftests/arm64/pauth/helper.h  |  9 ++++
 tools/testing/selftests/arm64/pauth/pac.c     | 51 +++++++++++++++++++
 5 files changed, 105 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/pauth/helper.c

diff --git a/tools/testing/selftests/arm64/pauth/.gitignore b/tools/testing/selftests/arm64/pauth/.gitignore
index b557c916720a..155137d92722 100644
--- a/tools/testing/selftests/arm64/pauth/.gitignore
+++ b/tools/testing/selftests/arm64/pauth/.gitignore
@@ -1 +1,2 @@
+exec_target
 pac
diff --git a/tools/testing/selftests/arm64/pauth/Makefile b/tools/testing/selftests/arm64/pauth/Makefile
index 01d35aaa610a..5c0dd129562f 100644
--- a/tools/testing/selftests/arm64/pauth/Makefile
+++ b/tools/testing/selftests/arm64/pauth/Makefile
@@ -12,7 +12,7 @@ pauth_cc_support := $(shell if ($(CC) $(CFLAGS) -march=armv8.3-a -E -x c /dev/nu
 
 ifeq ($(pauth_cc_support),1)
 TEST_GEN_PROGS := pac
-TEST_GEN_FILES := pac_corruptor.o
+TEST_GEN_FILES := pac_corruptor.o helper.o
 endif
 
 include ../../lib.mk
@@ -23,10 +23,13 @@ ifeq ($(pauth_cc_support),1)
 $(OUTPUT)/pac_corruptor.o: pac_corruptor.S
 	$(CC) -c $^ -o $@ $(CFLAGS) -march=armv8.3-a
 
+$(OUTPUT)/helper.o: helper.c
+	$(CC) -c $^ -o $@ $(CFLAGS) -march=armv8.3-a
+
 # when -mbranch-protection is enabled and the target architecture is ARMv8.3 or
 # greater, gcc emits pac* instructions which are not in HINT NOP space,
 # preventing the tests from occurring at all. Compile for ARMv8.2 so tests can
 # run on earlier targets and print a meaningful error messages
-$(OUTPUT)/pac: pac.c $(OUTPUT)/pac_corruptor.o
+$(OUTPUT)/pac: pac.c $(OUTPUT)/pac_corruptor.o $(OUTPUT)/helper.o
 	$(CC) $^ -o $@ $(CFLAGS) -march=armv8.2-a
 endif
diff --git a/tools/testing/selftests/arm64/pauth/helper.c b/tools/testing/selftests/arm64/pauth/helper.c
new file mode 100644
index 000000000000..2c201e7d0d50
--- /dev/null
+++ b/tools/testing/selftests/arm64/pauth/helper.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 ARM Limited
+
+#include "helper.h"
+
+size_t keyia_sign(size_t ptr)
+{
+	asm volatile("paciza %0" : "+r" (ptr));
+	return ptr;
+}
+
+size_t keyib_sign(size_t ptr)
+{
+	asm volatile("pacizb %0" : "+r" (ptr));
+	return ptr;
+}
+
+size_t keyda_sign(size_t ptr)
+{
+	asm volatile("pacdza %0" : "+r" (ptr));
+	return ptr;
+}
+
+size_t keydb_sign(size_t ptr)
+{
+	asm volatile("pacdzb %0" : "+r" (ptr));
+	return ptr;
+}
+
+size_t keyg_sign(size_t ptr)
+{
+	/* output is encoded in the upper 32 bits */
+	size_t dest = 0;
+	size_t modifier = 0;
+
+	asm volatile("pacga %0, %1, %2" : "=r" (dest) : "r" (ptr), "r" (modifier));
+
+	return dest;
+}
diff --git a/tools/testing/selftests/arm64/pauth/helper.h b/tools/testing/selftests/arm64/pauth/helper.h
index 3e0a2a404bf4..35c4f3357ae3 100644
--- a/tools/testing/selftests/arm64/pauth/helper.h
+++ b/tools/testing/selftests/arm64/pauth/helper.h
@@ -4,6 +4,15 @@
 #ifndef _HELPER_H_
 #define _HELPER_H_
 
+#include <stdlib.h>
+
 void pac_corruptor(void);
 
+/* PAuth sign a value with key ia and modifier value 0 */
+size_t keyia_sign(size_t val);
+size_t keyib_sign(size_t val);
+size_t keyda_sign(size_t val);
+size_t keydb_sign(size_t val);
+size_t keyg_sign(size_t val);
+
 #endif
diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
index 0293310ba70a..bd3d4c0eca9d 100644
--- a/tools/testing/selftests/arm64/pauth/pac.c
+++ b/tools/testing/selftests/arm64/pauth/pac.c
@@ -8,12 +8,25 @@
 #include "../../kselftest_harness.h"
 #include "helper.h"
 
+#define PAC_COLLISION_ATTEMPTS 10
+/*
+ * The kernel sets TBID by default. So bits 55 and above should remain
+ * untouched no matter what.
+ * The VA space size is 48 bits. Bigger is opt-in.
+ */
+#define PAC_MASK (~0xff80ffffffffffff)
 #define ASSERT_PAUTH_ENABLED() \
 do { \
 	unsigned long hwcaps = getauxval(AT_HWCAP); \
 	/* data key instructions are not in NOP space. This prevents a SIGILL */ \
 	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled"); \
 } while (0)
+#define ASSERT_GENERIC_PAUTH_ENABLED() \
+do { \
+	unsigned long hwcaps = getauxval(AT_HWCAP); \
+	/* generic key instructions are not in NOP space. This prevents a SIGILL */ \
+	ASSERT_NE(0, hwcaps & HWCAP_PACG) TH_LOG("Generic PAUTH not enabled"); \
+} while (0)
 
 sigjmp_buf jmpbuf;
 void pac_signal_handler(int signum, siginfo_t *si, void *uc)
@@ -41,4 +54,42 @@ TEST(corrupt_pac)
 	}
 }
 
+/*
+ * There are no separate pac* and aut* controls so checking only the pac*
+ * instructions is sufficient
+ */
+TEST(pac_instructions_not_nop)
+{
+	size_t keyia = 0;
+	size_t keyib = 0;
+	size_t keyda = 0;
+	size_t keydb = 0;
+
+	ASSERT_PAUTH_ENABLED();
+
+	for (int i = 0; i < PAC_COLLISION_ATTEMPTS; i++) {
+		keyia |= keyia_sign(i) & PAC_MASK;
+		keyib |= keyib_sign(i) & PAC_MASK;
+		keyda |= keyda_sign(i) & PAC_MASK;
+		keydb |= keydb_sign(i) & PAC_MASK;
+	}
+
+	ASSERT_NE(0, keyia) TH_LOG("keyia instructions did nothing");
+	ASSERT_NE(0, keyib) TH_LOG("keyib instructions did nothing");
+	ASSERT_NE(0, keyda) TH_LOG("keyda instructions did nothing");
+	ASSERT_NE(0, keydb) TH_LOG("keydb instructions did nothing");
+}
+
+TEST(pac_instructions_not_nop_generic)
+{
+	size_t keyg = 0;
+
+	ASSERT_GENERIC_PAUTH_ENABLED();
+
+	for (int i = 0; i < PAC_COLLISION_ATTEMPTS; i++)
+		keyg |= keyg_sign(i) & PAC_MASK;
+
+	ASSERT_NE(0, keyg)  TH_LOG("keyg instructions did nothing");
+}
+
 TEST_HARNESS_MAIN
-- 
2.28.0

