Return-Path: <linux-kselftest+bounces-48164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DFFCF1C43
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 04:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C41E3003494
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 03:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4862EBBB7;
	Mon,  5 Jan 2026 03:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhYLDpXq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A718C2C
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 03:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767584936; cv=none; b=IiwAH6IXnQWKlhL0wmxFgpzjhHxHoDSwcHlH7yIj7Ht0ilueYMVNQTL4wssmbXETgxlcy3WQ3WvZUGgmMNV5FBNwTOnlLckD0p8lOsep0ud7zFCLS12WgzbhRGJEhYJR8E+K9Sevrb9ZVngCl9ItxYDG3R5ZBZlpnx/r61zhqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767584936; c=relaxed/simple;
	bh=CFwHI9SQUanxgBckfTrMHmLp6+/nsLnuGglVEBCMf+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Td/rUBtLTtIVPItsDYZWNfM9CAmaT4yA90TP6boSjlbwEVR/jP9vrpmcE9H96dg7XUAaZQNJMyTbEfRDHKz1TIdlwxbf+t/NQ3S6suje33gCFprgfFf4hGF3H6Wz88mdZnX4SAoayBG6WL+IjUumwEK8nDgyF7TJ4qZQnO6UZk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhYLDpXq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ba55660769so10315846b3a.1
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 19:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767584934; x=1768189734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dU8uqx7lAkWpKUf21x9wzTdxfGPbd2c4rnDv2WGwCsQ=;
        b=WhYLDpXqV9TvNzYs1Tfc/6ogl8hop6qBRV6JuUTnyu4oNBY3MglmNbb+YhkqiIUzWN
         ViyixqJzE06Q9QSbr+/HEbl1w/OWoNeRPdNGgyDBwtpr5oEmKSZA5A6faskudvPa7Rnz
         Jc66PPDJ7BZndPf5RLkyDKSeZSU/JGUmwvPyfd5YOdmaWtpWbvyBSnI3BG2GUof/g1+Y
         p5CdktKjnB3fFlZZ02mZjzjXNjni5AluyVv+rl5ccdVS6wiaCCrUS8Qht+dB4gRYvyhP
         XMxq52PvtNoIQOEUe6YUs6dREAaBFPFjYzOv57334D6fjf0CtpsvVEzqW8O9bj1zAF7q
         JxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767584934; x=1768189734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU8uqx7lAkWpKUf21x9wzTdxfGPbd2c4rnDv2WGwCsQ=;
        b=FQhmoHD0K7PnIojKcHAy8UBqZCZyT5JvdwFsQO2TTOhKYubutVfLLr1XPSOEFXcGC9
         ZMmBFzdkm+1ad3xaz33gJpaO1NIQIfVJIVyEuH205p2Vrv+6FH4OyBldusbQL5nSRC7z
         BSv4fxgT+hqMjy3f5CrKdOUenkJHNlX/56M/NO8jlGiq5hBDdLVEHvlttaixb7bFI+h/
         BfQVCPsvilHSsxfPJymWjVI6P1TMTTFmWfmstxqXXNFTTM/NNC030gHAgR5hbtSwH8S0
         YrxntFJRJNh2ZIYOOM0o6BwKB2pbbngxWTBEfFIgNB+Vad/xPqAWY3BRwwTHl6zO0k5S
         h1og==
X-Forwarded-Encrypted: i=1; AJvYcCUVRVqcTyC5ABDR6gSn2YI83niZQBTf8WCdGlkVeLFDFOr2fUNf7MgnpEVMO8BVNRNAkLtYDmNZHMz4Yuy6qz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhEpW7vQP6n60SooHKuZZ3Tes134lishRLm8WvX7lvBIVh61Ka
	DEFMbnT3jhf+1Zgpu8i5IQKNN0ANP8HNvwp9V7B0ojEXdJWmB0FJrvkk
X-Gm-Gg: AY/fxX7w8KVtTH6K/NVyhPfBTgdR0VxWeWjap4KvNDUXg2o5HDF3FnJbtvzV1dTq6o6
	G9P6TcOFKFX9Ug0wGomgOLD48tFf1CuXmdPnPDxZiSak5Cn3EsShTsKkZfv3MxaBR7ig1l3+Iw2
	IVMxiKPt5IPRI35g4+lDquIBWzr9MffblBho4SIzvcCVOLZGKkD/ySHARUlnQasSvavU7AHZfup
	OcVCldpDT7ScFzJ33YVi3lJEvhbAOJWX+xyinAB0mm5DKn8lrh03VxLasnImtXw4hO22K3yrUp5
	pAuVf9jWsITIsJKULI14j5J83vxvaODVL+z6OkxZs7O51YRLaXbG/ZE4d2sjA253YL+JcGO06Cy
	dsb9zU6+a8VatU6VDG2SNQn7iHJzrcYP5iY5R3eSfDrHOVKByMKepuMY23Qfv+/9eJmg7aaobh4
	iEEantDi8KKWcVBBcOw8TWU/X9HTXrWnoOlNP3LppsN4M20qTKJBKbYppNZneaA2sMmBZzyrG0y
	CN6yhWGo7ZL7yTELaqN2U4=
X-Google-Smtp-Source: AGHT+IFt/mjJqzTHsOWj7yyIt8Im8JTxuOqFrslgzZnxXDx5FstzUnJMl7SEfwEQAOItVJriJ4tMZg==
X-Received: by 2002:a05:6a20:3d87:b0:350:7238:7e32 with SMTP id adf61e73a8af0-376a7cf4eb2mr41542816637.22.1767584933755;
        Sun, 04 Jan 2026 19:48:53 -0800 (PST)
Received: from kirchou-macbookpro2.roam.corp.google.com (softbank126227055022.bbtec.net. [126.227.55.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79620bd3sm40029556a12.4.2026.01.04.19.48.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 04 Jan 2026 19:48:53 -0800 (PST)
Sender: kir <610548@gmail.com>
From: Kir Chou <note351@hotmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	davidgow@google.com,
	brendan.higgins@linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	kirchou@google.com,
	Kir Chou <note351@hotmail.com>
Subject: [PATCH] lib/glob: convert selftest to KUnit
Date: Mon,  5 Jan 2026 12:48:36 +0900
Message-ID: <20260105034836.59442-1-note351@hotmail.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch converts the existing glob selftest (lib/globtest.c) to use
the KUnit framework (lib/glob_kunit.c).

The new test:

- Migrates all 64 test cases from the original test to the KUnit suite.
- Removes the custom 'verbose' module parameter as KUnit handles logging.
- Updates Kconfig.debug and Makefile to support the new KUnit test.
- Updates Kconfig and Makefile to remove the original selftest.
- Updates GLOB_SELFTEST to GLOB_KUNIT_TEST for arch/m68k/configs.

This commit is verified by `./tools/testing/kunit/kunit.py run`
with the .kunit/.kunitconfig:

```
CONFIG_KUNIT=y
CONFIG_GLOB_KUNIT_TEST=y
```

Signed-off-by: Kir Chou <note351@hotmail.com>
---
 arch/m68k/configs/amiga_defconfig    |   2 +-
 arch/m68k/configs/apollo_defconfig   |   2 +-
 arch/m68k/configs/atari_defconfig    |   2 +-
 arch/m68k/configs/bvme6000_defconfig |   2 +-
 arch/m68k/configs/hp300_defconfig    |   2 +-
 arch/m68k/configs/mac_defconfig      |   2 +-
 arch/m68k/configs/multi_defconfig    |   2 +-
 arch/m68k/configs/mvme147_defconfig  |   2 +-
 arch/m68k/configs/mvme16x_defconfig  |   2 +-
 arch/m68k/configs/q40_defconfig      |   2 +-
 arch/m68k/configs/sun3_defconfig     |   2 +-
 arch/m68k/configs/sun3x_defconfig    |   2 +-
 lib/Kconfig                          |  13 ---
 lib/Kconfig.debug                    |  13 +++
 lib/Makefile                         |   2 +-
 lib/glob_kunit.c                     | 122 +++++++++++++++++++
 lib/globtest.c                       | 167 ---------------------------
 17 files changed, 148 insertions(+), 193 deletions(-)
 create mode 100644 lib/glob_kunit.c
 delete mode 100644 lib/globtest.c

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index bfc1ee7c8..aba96f98b 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -600,7 +600,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
+CONFIG_GLOB_KUNIT_TEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index d9d1f3c4c..8fb7b2dfb 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -557,7 +557,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
+CONFIG_GLOB_KUNIT_TEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 523205adc..09766b692 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -577,7 +577,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
+CONFIG_GLOB_KUNIT_TEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 7b0a4ef0b..882c01e8c 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -549,7 +549,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
+CONFIG_GLOB_KUNIT_TEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 089c5c394..64bdd9c8a 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -559,7 +559,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
+CONFIG_GLOB_KUNIT_TEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 5f2484c36..e017cdfbb 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -576,7 +576,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
+CONFIG_GLOB_KUNIT_TEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 74f0a1f6d..4a450bce0 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -663,7 +663,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
+CONFIG_GLOB_KUNIT_TEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 4bee18c82..c2413bf6c 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -549,7 +549,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
+CONFIG_GLOB_KUNIT_TEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 322c17e55..1186aafbc 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -550,7 +550,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
+CONFIG_GLOB_KUNIT_TEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 82f9baab8..7ecb99bfa 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -566,7 +566,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
+CONFIG_GLOB_KUNIT_TEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index f94ad226c..3ff8ac06d 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -547,7 +547,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
+CONFIG_GLOB_KUNIT_TEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index a5ecfc505..e6999f78e 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -547,7 +547,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
+CONFIG_GLOB_KUNIT_TEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/lib/Kconfig b/lib/Kconfig
index 2923924be..0f2fb9610 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -430,19 +430,6 @@ config GLOB
 	  are compiling an out-of tree driver which tells you that it
 	  depends on this.
 
-config GLOB_SELFTEST
-	tristate "glob self-test on init"
-	depends on GLOB
-	help
-	  This option enables a simple self-test of the glob_match
-	  function on startup.	It is primarily useful for people
-	  working on the code to ensure they haven't introduced any
-	  regressions.
-
-	  It only adds a little bit of code and slows kernel boot (or
-	  module load) by a small amount, so you're welcome to play with
-	  it, but you probably don't need it.
-
 #
 # Netlink attribute parsing support is select'ed if needed
 #
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939fd..e4347e145 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3354,6 +3354,19 @@ config PRIME_NUMBERS_KUNIT_TEST
 
 	  If unsure, say N
 
+config GLOB_KUNIT_TEST
+	tristate "Glob matching test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	select GLOB
+	help
+	  Enable this option to test the glob functions at runtime.
+
+	  This test suite verifies the correctness of glob_match() across various
+	  scenarios, including edge cases.
+
+	  If unsure, say N
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
diff --git a/lib/Makefile b/lib/Makefile
index aaf677cf4..78d7deabe 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -226,7 +226,7 @@ obj-$(CONFIG_CLOSURES) += closure.o
 obj-$(CONFIG_DQL) += dynamic_queue_limits.o
 
 obj-$(CONFIG_GLOB) += glob.o
-obj-$(CONFIG_GLOB_SELFTEST) += globtest.o
+obj-$(CONFIG_GLOB_KUNIT_TEST) += glob_kunit.o
 
 obj-$(CONFIG_DIMLIB) += dim/
 obj-$(CONFIG_SIGNATURE) += digsig.o
diff --git a/lib/glob_kunit.c b/lib/glob_kunit.c
new file mode 100644
index 000000000..797e32a8c
--- /dev/null
+++ b/lib/glob_kunit.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for glob functions.
+ */
+
+#include <kunit/test.h>
+#include <linux/glob.h>
+#include <linux/module.h>
+
+struct glob_test_case {
+	// Pattern to match.
+	const char *pat;
+	// String to match against.
+	const char *str;
+	// Expected glob_match result, true is matched.
+	bool expected;
+};
+
+static const struct glob_test_case glob_test_cases[] = {
+	/* Some basic tests */
+	{ .pat = "a", .str = "a", .expected = true },
+	{ .pat = "a", .str = "b", .expected = false },
+	{ .pat = "a", .str = "aa", .expected = false },
+	{ .pat = "a", .str = "", .expected = false },
+	{ .pat = "", .str = "", .expected = true },
+	{ .pat = "", .str = "a", .expected = false },
+	/* Simple character class tests */
+	{ .pat = "[a]", .str = "a", .expected = true },
+	{ .pat = "[a]", .str = "b", .expected = false },
+	{ .pat = "[!a]", .str = "a", .expected = false },
+	{ .pat = "[!a]", .str = "b", .expected = true },
+	{ .pat = "[ab]", .str = "a", .expected = true },
+	{ .pat = "[ab]", .str = "b", .expected = true },
+	{ .pat = "[ab]", .str = "c", .expected = false },
+	{ .pat = "[!ab]", .str = "c", .expected = true },
+	{ .pat = "[a-c]", .str = "b", .expected = true },
+	{ .pat = "[a-c]", .str = "d", .expected = false },
+	/* Corner cases in character class parsing */
+	{ .pat = "[a-c-e-g]", .str = "-", .expected = true },
+	{ .pat = "[a-c-e-g]", .str = "d", .expected = false },
+	{ .pat = "[a-c-e-g]", .str = "f", .expected = true },
+	{ .pat = "[]a-ceg-ik[]", .str = "a", .expected = true },
+	{ .pat = "[]a-ceg-ik[]", .str = "]", .expected = true },
+	{ .pat = "[]a-ceg-ik[]", .str = "[", .expected = true },
+	{ .pat = "[]a-ceg-ik[]", .str = "h", .expected = true },
+	{ .pat = "[]a-ceg-ik[]", .str = "f", .expected = false },
+	{ .pat = "[!]a-ceg-ik[]", .str = "h", .expected = false },
+	{ .pat = "[!]a-ceg-ik[]", .str = "]", .expected = false },
+	{ .pat = "[!]a-ceg-ik[]", .str = "f", .expected = true },
+	/* Simple wild cards */
+	{ .pat = "?", .str = "a", .expected = true },
+	{ .pat = "?", .str = "aa", .expected = false },
+	{ .pat = "??", .str = "a", .expected = false },
+	{ .pat = "?x?", .str = "axb", .expected = true },
+	{ .pat = "?x?", .str = "abx", .expected = false },
+	{ .pat = "?x?", .str = "xab", .expected = false },
+	/* Asterisk wild cards (backtracking) */
+	{ .pat = "*??", .str = "a", .expected = false },
+	{ .pat = "*??", .str = "ab", .expected = true },
+	{ .pat = "*??", .str = "abc", .expected = true },
+	{ .pat = "*??", .str = "abcd", .expected = true },
+	{ .pat = "??*", .str = "a", .expected = false },
+	{ .pat = "??*", .str = "ab", .expected = true },
+	{ .pat = "??*", .str = "abc", .expected = true },
+	{ .pat = "??*", .str = "abcd", .expected = true },
+	{ .pat = "?*?", .str = "a", .expected = false },
+	{ .pat = "?*?", .str = "ab", .expected = true },
+	{ .pat = "?*?", .str = "abc", .expected = true },
+	{ .pat = "?*?", .str = "abcd", .expected = true },
+	{ .pat = "*b", .str = "b", .expected = true },
+	{ .pat = "*b", .str = "ab", .expected = true },
+	{ .pat = "*b", .str = "ba", .expected = false },
+	{ .pat = "*b", .str = "bb", .expected = true },
+	{ .pat = "*b", .str = "abb", .expected = true },
+	{ .pat = "*b", .str = "bab", .expected = true },
+	{ .pat = "*bc", .str = "abbc", .expected = true },
+	{ .pat = "*bc", .str = "bc", .expected = true },
+	{ .pat = "*bc", .str = "bbc", .expected = true },
+	{ .pat = "*bc", .str = "bcbc", .expected = true },
+	/* Multiple asterisks (complex backtracking) */
+	{ .pat = "*ac*", .str = "abacadaeafag", .expected = true },
+	{ .pat = "*ac*ae*ag*", .str = "abacadaeafag", .expected = true },
+	{ .pat = "*a*b*[bc]*[ef]*g*", .str = "abacadaeafag", .expected = true },
+	{ .pat = "*a*b*[ef]*[cd]*g*", .str = "abacadaeafag", .expected = false },
+	{ .pat = "*abcd*", .str = "abcabcabcabcdefg", .expected = true },
+	{ .pat = "*ab*cd*", .str = "abcabcabcabcdefg", .expected = true },
+	{ .pat = "*abcd*abcdef*", .str = "abcabcdabcdeabcdefg", .expected = true },
+	{ .pat = "*abcd*", .str = "abcabcabcabcefg", .expected = false },
+	{ .pat = "*ab*cd*", .str = "abcabcabcabcefg", .expected = false },
+};
+
+static void glob_case_to_desc(const struct glob_test_case *t, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "pat:\"%s\" str:\"%s\"", t->pat, t->str);
+}
+
+KUNIT_ARRAY_PARAM(glob, glob_test_cases, glob_case_to_desc);
+
+static void glob_test_match(struct kunit *test)
+{
+	const struct glob_test_case *params = test->param_value;
+
+	KUNIT_EXPECT_EQ_MSG(test,
+		glob_match(params->pat, params->str),
+		params->expected,
+		"Pattern: \"%s\", String: \"%s\", Expected: %d",
+		params->pat, params->str, params->expected);
+}
+
+static struct kunit_case glob_kunit_test_cases[] = {
+	KUNIT_CASE_PARAM(glob_test_match, glob_gen_params),
+	{}
+};
+
+static struct kunit_suite glob_test_suite = {
+	.name = "glob",
+	.test_cases = glob_kunit_test_cases,
+};
+
+kunit_test_suite(glob_test_suite);
+MODULE_DESCRIPTION("Test cases for glob functions");
+MODULE_LICENSE("Dual MIT/GPL");
diff --git a/lib/globtest.c b/lib/globtest.c
deleted file mode 100644
index d8e97d43b..000000000
--- a/lib/globtest.c
+++ /dev/null
@@ -1,167 +0,0 @@
-/*
- * Extracted fronm glob.c
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/glob.h>
-#include <linux/printk.h>
-
-/* Boot with "glob.verbose=1" to show successful tests, too */
-static bool verbose = false;
-module_param(verbose, bool, 0);
-
-struct glob_test {
-	char const *pat, *str;
-	bool expected;
-};
-
-static bool __pure __init test(char const *pat, char const *str, bool expected)
-{
-	bool match = glob_match(pat, str);
-	bool success = match == expected;
-
-	/* Can't get string literals into a particular section, so... */
-	static char const msg_error[] __initconst =
-		KERN_ERR "glob: \"%s\" vs. \"%s\": %s *** ERROR ***\n";
-	static char const msg_ok[] __initconst =
-		KERN_DEBUG "glob: \"%s\" vs. \"%s\": %s OK\n";
-	static char const mismatch[] __initconst = "mismatch";
-	char const *message;
-
-	if (!success)
-		message = msg_error;
-	else if (verbose)
-		message = msg_ok;
-	else
-		return success;
-
-	printk(message, pat, str, mismatch + 3*match);
-	return success;
-}
-
-/*
- * The tests are all jammed together in one array to make it simpler
- * to place that array in the .init.rodata section.  The obvious
- * "array of structures containing char *" has no way to force the
- * pointed-to strings to be in a particular section.
- *
- * Anyway, a test consists of:
- * 1. Expected glob_match result: '1' or '0'.
- * 2. Pattern to match: null-terminated string
- * 3. String to match against: null-terminated string
- *
- * The list of tests is terminated with a final '\0' instead of
- * a glob_match result character.
- */
-static char const glob_tests[] __initconst =
-	/* Some basic tests */
-	"1" "a\0" "a\0"
-	"0" "a\0" "b\0"
-	"0" "a\0" "aa\0"
-	"0" "a\0" "\0"
-	"1" "\0" "\0"
-	"0" "\0" "a\0"
-	/* Simple character class tests */
-	"1" "[a]\0" "a\0"
-	"0" "[a]\0" "b\0"
-	"0" "[!a]\0" "a\0"
-	"1" "[!a]\0" "b\0"
-	"1" "[ab]\0" "a\0"
-	"1" "[ab]\0" "b\0"
-	"0" "[ab]\0" "c\0"
-	"1" "[!ab]\0" "c\0"
-	"1" "[a-c]\0" "b\0"
-	"0" "[a-c]\0" "d\0"
-	/* Corner cases in character class parsing */
-	"1" "[a-c-e-g]\0" "-\0"
-	"0" "[a-c-e-g]\0" "d\0"
-	"1" "[a-c-e-g]\0" "f\0"
-	"1" "[]a-ceg-ik[]\0" "a\0"
-	"1" "[]a-ceg-ik[]\0" "]\0"
-	"1" "[]a-ceg-ik[]\0" "[\0"
-	"1" "[]a-ceg-ik[]\0" "h\0"
-	"0" "[]a-ceg-ik[]\0" "f\0"
-	"0" "[!]a-ceg-ik[]\0" "h\0"
-	"0" "[!]a-ceg-ik[]\0" "]\0"
-	"1" "[!]a-ceg-ik[]\0" "f\0"
-	/* Simple wild cards */
-	"1" "?\0" "a\0"
-	"0" "?\0" "aa\0"
-	"0" "??\0" "a\0"
-	"1" "?x?\0" "axb\0"
-	"0" "?x?\0" "abx\0"
-	"0" "?x?\0" "xab\0"
-	/* Asterisk wild cards (backtracking) */
-	"0" "*??\0" "a\0"
-	"1" "*??\0" "ab\0"
-	"1" "*??\0" "abc\0"
-	"1" "*??\0" "abcd\0"
-	"0" "??*\0" "a\0"
-	"1" "??*\0" "ab\0"
-	"1" "??*\0" "abc\0"
-	"1" "??*\0" "abcd\0"
-	"0" "?*?\0" "a\0"
-	"1" "?*?\0" "ab\0"
-	"1" "?*?\0" "abc\0"
-	"1" "?*?\0" "abcd\0"
-	"1" "*b\0" "b\0"
-	"1" "*b\0" "ab\0"
-	"0" "*b\0" "ba\0"
-	"1" "*b\0" "bb\0"
-	"1" "*b\0" "abb\0"
-	"1" "*b\0" "bab\0"
-	"1" "*bc\0" "abbc\0"
-	"1" "*bc\0" "bc\0"
-	"1" "*bc\0" "bbc\0"
-	"1" "*bc\0" "bcbc\0"
-	/* Multiple asterisks (complex backtracking) */
-	"1" "*ac*\0" "abacadaeafag\0"
-	"1" "*ac*ae*ag*\0" "abacadaeafag\0"
-	"1" "*a*b*[bc]*[ef]*g*\0" "abacadaeafag\0"
-	"0" "*a*b*[ef]*[cd]*g*\0" "abacadaeafag\0"
-	"1" "*abcd*\0" "abcabcabcabcdefg\0"
-	"1" "*ab*cd*\0" "abcabcabcabcdefg\0"
-	"1" "*abcd*abcdef*\0" "abcabcdabcdeabcdefg\0"
-	"0" "*abcd*\0" "abcabcabcabcefg\0"
-	"0" "*ab*cd*\0" "abcabcabcabcefg\0";
-
-static int __init glob_init(void)
-{
-	unsigned successes = 0;
-	unsigned n = 0;
-	char const *p = glob_tests;
-	static char const message[] __initconst =
-		KERN_INFO "glob: %u self-tests passed, %u failed\n";
-
-	/*
-	 * Tests are jammed together in a string.  The first byte is '1'
-	 * or '0' to indicate the expected outcome, or '\0' to indicate the
-	 * end of the tests.  Then come two null-terminated strings: the
-	 * pattern and the string to match it against.
-	 */
-	while (*p) {
-		bool expected = *p++ & 1;
-		char const *pat = p;
-
-		p += strlen(p) + 1;
-		successes += test(pat, p, expected);
-		p += strlen(p) + 1;
-		n++;
-	}
-
-	n -= successes;
-	printk(message, successes, n);
-
-	/* What's the errno for "kernel bug detected"?  Guess... */
-	return n ? -ECANCELED : 0;
-}
-
-/* We need a dummy exit function to allow unload */
-static void __exit glob_fini(void) { }
-
-module_init(glob_init);
-module_exit(glob_fini);
-
-MODULE_DESCRIPTION("glob(7) matching tests");
-MODULE_LICENSE("Dual MIT/GPL");
-- 
2.52.0.351.gbe84eed79e-goog


