Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A0E26FADA
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 12:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIRKrr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 06:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRKrq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 06:47:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF92C06174A;
        Fri, 18 Sep 2020 03:47:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so5126626wrp.8;
        Fri, 18 Sep 2020 03:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCpwNFL5WsulLvsRaSslKFqGKBqySbME6CCaIMG6l/c=;
        b=Tkku6M8k5OZ1uFd+qd7N/NV6gdYFkCEg8b3cW2d2ah0ZE+XcsNYpG6ZkXDOxMG0xUJ
         /QrVIc8nU7+eyBFBGxo8TQ3OE8Jf80kdwk0/Fva5r5mrwvovDt7/z5LU8RrSQ4OW6nV1
         1Q/14sylBHrM/jOJaUwNzOzSoG/PM+j1tQcA8ZXwCGsNJlSUcfqz1EcQ8zpfThRq0xVM
         hLBoa6apXbEh06qRuu3mzM+AH8zKZKWEteHemPpXu2HLUJza60s9cLkwUjkCSXdLz+UZ
         +JflaaD6r9lOim5NRdWiQYonKGFGHDcU2+av3qA29lqEULOdwkiM57zQBVmzbUxaEe1o
         lq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCpwNFL5WsulLvsRaSslKFqGKBqySbME6CCaIMG6l/c=;
        b=hmmrZBnA1Sliyx1Koz/leu9D+BDLP6Vq8YlnZ24k74xNlJEDbxUUNAmCwFiPxqrDMk
         oZuJ1wfh3FYXfNWdXPxhx+7sS+wBqrGAPTyFu+dEq36eVHHzB9i6jlpToJ7t7rGImGxA
         d8kpSfKMNkrvA1ca3y+r1Ygn7wmVZX+54x8U0rqReKuivoMzU0OYZeW8Miz5vCCH7FdG
         djuinlPHASNtn8Tj01x9evhbKGSpGCQoAVSt9VS2kJedH4dWd2PT71ByK1MNf4nTAaTk
         Jt9R3SBLAArFbozM+bVzQQY6k54blFzMHcRYAyFPP264xfuwgKaPeNWMuIRDB03GXdiB
         2H6Q==
X-Gm-Message-State: AOAM532pEZPv/WgjMC+6tUdBE2pIPAqWB/Xn5qbb19NSlWMF5MHFHtaZ
        WOK4B97ewujLqxQ6YYjsMHE=
X-Google-Smtp-Source: ABdhPJxq0TC8XUB6r9vQce7URu6nHJAPnXtki1Fd7qRog7U6btUK1yicrTQGiSjkcASdaa2LbttPWQ==
X-Received: by 2002:adf:fa52:: with SMTP id y18mr37533018wrr.264.1600426064796;
        Fri, 18 Sep 2020 03:47:44 -0700 (PDT)
Received: from trantor.home (cpc153975-seac28-2-0-cust722.7-2.cable.virginm.net. [81.109.38.211])
        by smtp.gmail.com with ESMTPSA id h4sm5197846wrm.54.2020.09.18.03.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:47:44 -0700 (PDT)
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
Subject: [PATCH v3 1/4] kselftests/arm64: add a basic Pointer Authentication test
Date:   Fri, 18 Sep 2020 11:47:12 +0100
Message-Id: <20200918104715.182310-2-boian4o1@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918104715.182310-1-boian4o1@gmail.com>
References: <20200918104715.182310-1-boian4o1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Boyan Karatotev <boyan.karatotev@arm.com>

PAuth signs and verifies return addresses on the stack. It does so by
inserting a Pointer Authentication code (PAC) into some of the unused top
bits of an address. This is achieved by adding paciasp/autiasp instructions
at the beginning and end of a function.

This feature is partially backwards compatible with earlier versions of the
ARM architecture. To coerce the compiler into emitting fully backwards
compatible code the main file is compiled to target an earlier ARM version.
This allows the tests to check for the feature and print meaningful error
messages instead of crashing.

Add a test to verify that corrupting the return address results in a
SIGSEGV on return.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Reviewed-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
---
 tools/testing/selftests/arm64/Makefile        |  2 +-
 .../testing/selftests/arm64/pauth/.gitignore  |  1 +
 tools/testing/selftests/arm64/pauth/Makefile  | 32 ++++++++++++++
 tools/testing/selftests/arm64/pauth/helper.h  |  9 ++++
 tools/testing/selftests/arm64/pauth/pac.c     | 44 +++++++++++++++++++
 .../selftests/arm64/pauth/pac_corruptor.S     | 19 ++++++++
 6 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/pauth/.gitignore
 create mode 100644 tools/testing/selftests/arm64/pauth/Makefile
 create mode 100644 tools/testing/selftests/arm64/pauth/helper.h
 create mode 100644 tools/testing/selftests/arm64/pauth/pac.c
 create mode 100644 tools/testing/selftests/arm64/pauth/pac_corruptor.S

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index 93b567d23c8b..525506fd97b9 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,7 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
-ARM64_SUBTARGETS ?= tags signal
+ARM64_SUBTARGETS ?= tags signal pauth
 else
 ARM64_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/arm64/pauth/.gitignore b/tools/testing/selftests/arm64/pauth/.gitignore
new file mode 100644
index 000000000000..b557c916720a
--- /dev/null
+++ b/tools/testing/selftests/arm64/pauth/.gitignore
@@ -0,0 +1 @@
+pac
diff --git a/tools/testing/selftests/arm64/pauth/Makefile b/tools/testing/selftests/arm64/pauth/Makefile
new file mode 100644
index 000000000000..01d35aaa610a
--- /dev/null
+++ b/tools/testing/selftests/arm64/pauth/Makefile
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 ARM Limited
+
+# preserve CC value from top level Makefile
+ifeq ($(CC),cc)
+CC := $(CROSS_COMPILE)gcc
+endif
+
+CFLAGS += -mbranch-protection=pac-ret
+# check if the compiler supports ARMv8.3 and branch protection with PAuth
+pauth_cc_support := $(shell if ($(CC) $(CFLAGS) -march=armv8.3-a -E -x c /dev/null -o /dev/null 2>&1) then echo "1"; fi)
+
+ifeq ($(pauth_cc_support),1)
+TEST_GEN_PROGS := pac
+TEST_GEN_FILES := pac_corruptor.o
+endif
+
+include ../../lib.mk
+
+ifeq ($(pauth_cc_support),1)
+# pac* and aut* instructions are not available on architectures berfore
+# ARMv8.3. Therefore target ARMv8.3 wherever they are used directly
+$(OUTPUT)/pac_corruptor.o: pac_corruptor.S
+	$(CC) -c $^ -o $@ $(CFLAGS) -march=armv8.3-a
+
+# when -mbranch-protection is enabled and the target architecture is ARMv8.3 or
+# greater, gcc emits pac* instructions which are not in HINT NOP space,
+# preventing the tests from occurring at all. Compile for ARMv8.2 so tests can
+# run on earlier targets and print a meaningful error messages
+$(OUTPUT)/pac: pac.c $(OUTPUT)/pac_corruptor.o
+	$(CC) $^ -o $@ $(CFLAGS) -march=armv8.2-a
+endif
diff --git a/tools/testing/selftests/arm64/pauth/helper.h b/tools/testing/selftests/arm64/pauth/helper.h
new file mode 100644
index 000000000000..3e0a2a404bf4
--- /dev/null
+++ b/tools/testing/selftests/arm64/pauth/helper.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 ARM Limited */
+
+#ifndef _HELPER_H_
+#define _HELPER_H_
+
+void pac_corruptor(void);
+
+#endif
diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
new file mode 100644
index 000000000000..0293310ba70a
--- /dev/null
+++ b/tools/testing/selftests/arm64/pauth/pac.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 ARM Limited
+
+#include <sys/auxv.h>
+#include <signal.h>
+#include <setjmp.h>
+
+#include "../../kselftest_harness.h"
+#include "helper.h"
+
+#define ASSERT_PAUTH_ENABLED() \
+do { \
+	unsigned long hwcaps = getauxval(AT_HWCAP); \
+	/* data key instructions are not in NOP space. This prevents a SIGILL */ \
+	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled"); \
+} while (0)
+
+sigjmp_buf jmpbuf;
+void pac_signal_handler(int signum, siginfo_t *si, void *uc)
+{
+	if (signum == SIGSEGV || signum == SIGILL)
+		siglongjmp(jmpbuf, 1);
+}
+
+/* check that a corrupted PAC results in SIGSEGV or SIGILL */
+TEST(corrupt_pac)
+{
+	struct sigaction sa;
+
+	ASSERT_PAUTH_ENABLED();
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		sa.sa_sigaction = pac_signal_handler;
+		sa.sa_flags = SA_SIGINFO | SA_RESETHAND;
+		sigemptyset(&sa.sa_mask);
+
+		sigaction(SIGSEGV, &sa, NULL);
+		sigaction(SIGILL, &sa, NULL);
+
+		pac_corruptor();
+		ASSERT_TRUE(0) TH_LOG("SIGSEGV/SIGILL signal did not occur");
+	}
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/arm64/pauth/pac_corruptor.S b/tools/testing/selftests/arm64/pauth/pac_corruptor.S
new file mode 100644
index 000000000000..aa6588050752
--- /dev/null
+++ b/tools/testing/selftests/arm64/pauth/pac_corruptor.S
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 ARM Limited */
+
+.global pac_corruptor
+
+.text
+/*
+ * Corrupting a single bit of the PAC ensures the authentication will fail.  It
+ * also guarantees no possible collision. TCR_EL1.TBI0 is set by default so no
+ * top byte PAC is tested
+ */
+ pac_corruptor:
+	paciasp
+
+	/* corrupt the top bit of the PAC */
+	eor lr, lr, #1 << 53
+
+	autiasp
+	ret
-- 
2.28.0

