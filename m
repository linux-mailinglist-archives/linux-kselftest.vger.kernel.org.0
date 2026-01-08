Return-Path: <linux-kselftest+bounces-48502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FA5D0321E
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 14:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3910301A725
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 13:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62B34984B6;
	Thu,  8 Jan 2026 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vxy9iINF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7D544B689
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874088; cv=none; b=ckuMFG8wIFMPRGPuyzhqcMsF7o+Rlssc54Vqa7tgwXc61Ni+LyzsTZg6MZjCgDhggC+jxCscLyI0ya3UthaGHfj7fo4XRzjgxylPU8JII5alIhLzbunnvFoYSMxAotQw7qK7K/T+uM0iOK3U1wNOC6oWAeqzC8n7lF5H0yFIwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874088; c=relaxed/simple;
	bh=4P5GqCMvZaD3BLO0OIH+mp+ZHm3fwe7gjFxY82hSS80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAvR/VM3Hejjn+K9IQ20pFDdNIIGZfUB8VTE7QV8aMQmc3PTMMzBi9MQCi1hOvdxuKqN2SCRFK+jZ5Z5uUz9dBqcx3mcrgC0hzK7md8jngK44vVSD20juKCK7thiyKAYKbbZaeOhOiSHi+SSlQPVHn3zUdt+c/vURtocm8pu7CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vxy9iINF; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c1d84781bso1928462a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 04:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767874082; x=1768478882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5TcFiHrfXMEny6NppNVvqYaOPOSdC9KA+d+c6QZUArQ=;
        b=Vxy9iINFxNKTEnGFImRaZ2KpgY18x458FqoGCuVptecFg5jsg6gVqwZbJ4pnFfJG1y
         fGxFtyH7QbV9X0BBzlnRr09ksD/6OhYvekqrnfqpWZ4qLum0p5iG3JqMyV6Oua9sF60u
         l0QQP9yzyMueChITFVAgoe/Oy9xVt906nP5rh/qPiJKufO2g6+PUYV7GH3AfZeTMH3yx
         gRv7ioBOppGHkufs/a/Ev+lpRL1nJZM3qqWDqfVSVnxQjVx+YI1j5u3VvPFkR95s7L+n
         9kxBtzODUCQET/GBRNjpGCTpM9IWkdkTmKplruQL1oAuRnyisogENXGKqmbJ67w4NKKj
         l16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767874082; x=1768478882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TcFiHrfXMEny6NppNVvqYaOPOSdC9KA+d+c6QZUArQ=;
        b=HqCdqDl6c9lenkwBx/UhvEUDjH3J2lygpTiDkSvmVWRrPo7XfC/gH9d2nuhbvxuGGM
         ScbdBf4EbRVhFWROs59DFguRw4Trmctf1SD/p8Y1Wj+DF9TYVEQno6M4AwKUfjnypsZ/
         viAPfmXHKOiR7K1KPjeQyn0M3uVxyeZvytIn9aZV4RHRbaEgwqKJWqbwkf/gh01ywIiI
         Ji1dNwq6uXgDHix4rYaIL0v+cntmzAeW+T8etY5bAyYHaORWiPRnUxoGA+0ibgVrZHdL
         igjMxQVAOfg6Lt+siVc9V9nTecmhVxR75aBlRLLkEKy1dRT/2kbz+Q/vSB5r9QXCUebx
         4+3w==
X-Forwarded-Encrypted: i=1; AJvYcCW+dbU/GaZQwfYB28zskCiB5/NDRUloDEABEap/1EJAThrD8+YzdpQYMOM/7QfyudkLOCQsAhhOki0f+i6WYHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytwPF3Zi5/85TdA4pti45rZHLGy9Uiv+NzaN58lSA1d6ou9pIJ
	Xlhlu53WvuNkbwxZCHmizsczji1XWjwnnBNqxE6gwyietW9Ye+puKpG8
X-Gm-Gg: AY/fxX5tUowc9lxjCrQjJtRasyWrECdZMDDsjNwSZpDiI5GOFy5pGKfpV8okaWhTRf5
	JtWEFX+NHhSVN3EVaz4S96kHUfVyW2+BGfxM4l4NQ9MwnfxbqKqDnTPW53fWLc7rMAIn2BfXLZL
	gabiBzSppLzLnKWtV3JRh+NGvvkFWeVWO/LLDhc4brxL+nV1XjRfx8+CqIc9vOQGOL1iIYptUe6
	+e03JjCHZ6mcthzypVYmiWOus9qVmQ39UDWbZ9wrsa5rCR2haguZuEVR9QzRMlAxp2kz4aBrepO
	i+eYk8XmBTQV8FR5cPOmJIE/RPIu2C1AC1GA1o173fKpXcGpwUn4dIIGTFfODiQIjsrNl3IoAnw
	C/BM4A2eS2aH2r/TlBbyWVJ3nl0o2R+08Wu/EA8t3VvRGTGulxyNTKAMeUHXNgYwqWj+CwHtrwi
	AMPmQluki0JoJcZx5QtLwK1QKKt5ieXnwQ7T79wVSD2o4zZkpRuJ7/RdnfkN1n+JmNj2dIJABHX
	hCYU26odK23ZdkEW4dsVKA=
X-Google-Smtp-Source: AGHT+IHUfJnGzjxOefXnrIjHft52mx4DXDvs27ldkmjOG6O8zHuBY3h3Jgu5gW3Vpz6BTdtuN7jvFQ==
X-Received: by 2002:a17:90a:fc48:b0:340:5c27:a096 with SMTP id 98e67ed59e1d1-34f68c023d4mr6155780a91.6.1767874082017;
        Thu, 08 Jan 2026 04:08:02 -0800 (PST)
Received: from kirchou-macbookpro2.roam.corp.google.com (softbank126227055022.bbtec.net. [126.227.55.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b1526sm7817965a91.14.2026.01.08.04.07.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Jan 2026 04:08:01 -0800 (PST)
Sender: kir <610548@gmail.com>
From: Kir Chou <note351@hotmail.com>
To: akpm@linux-foundation.org,
	visitorckw@gmail.com
Cc: geert@linux-m68k.org,
	linux-kernel@vger.kernel.org,
	davidgow@google.com,
	brendan.higgins@linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	kirchou@google.com,
	Kir Chou <note351@hotmail.com>
Subject: [PATCH v4] lib/glob: convert selftest to KUnit
Date: Thu,  8 Jan 2026 21:07:53 +0900
Message-ID: <20260108120753.27339-1-note351@hotmail.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch converts the existing glob selftest (lib/globtest.c) to use
the KUnit framework (lib/tests/glob_kunit.c).

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
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: David Gow <davidgow@google.com>
---
v4:
 - Add missing Acked-by and Reviewed-by tags from v2/v3 feedback.
 - Change from "select GLOB" to "depends on GLOB" (suggested by Kuan-Wei)
 - Fix the SPDX-License-Identifier with "MIT OR".
 - Apply kernel style comment for glob_test_case.
 - Format fix with checkpatch.pl --strict.
v3:
 - Move lib/glob_kunit.c to lib/tests/glob_kunit.c.
 - Update Makefile accordingly.
v2:
 - Remove CONFIG_GLOB_KUNIT_TEST from defconfigs as it's implicitly enabled
   by CONFIG_KUNIT_ALL_TESTS. (Suggested by Geert)
---
 arch/m68k/configs/amiga_defconfig    |   1 -
 arch/m68k/configs/apollo_defconfig   |   1 -
 arch/m68k/configs/atari_defconfig    |   1 -
 arch/m68k/configs/bvme6000_defconfig |   1 -
 arch/m68k/configs/hp300_defconfig    |   1 -
 arch/m68k/configs/mac_defconfig      |   1 -
 arch/m68k/configs/multi_defconfig    |   1 -
 arch/m68k/configs/mvme147_defconfig  |   1 -
 arch/m68k/configs/mvme16x_defconfig  |   1 -
 arch/m68k/configs/q40_defconfig      |   1 -
 arch/m68k/configs/sun3_defconfig     |   1 -
 arch/m68k/configs/sun3x_defconfig    |   1 -
 lib/Kconfig                          |  13 ---
 lib/Kconfig.debug                    |  13 +++
 lib/Makefile                         |   1 -
 lib/globtest.c                       | 167 ---------------------------
 lib/tests/Makefile                   |   1 +
 lib/tests/glob_kunit.c               | 125 ++++++++++++++++++++
 18 files changed, 139 insertions(+), 193 deletions(-)
 delete mode 100644 lib/globtest.c
 create mode 100644 lib/tests/glob_kunit.c

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index bfc1ee7c8..b51e22dea 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -600,7 +600,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index d9d1f3c4c..bb326aabe 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -557,7 +557,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 523205adc..66af496e0 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -577,7 +577,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 7b0a4ef0b..935282b27 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -549,7 +549,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 089c5c394..31f5220be 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -559,7 +559,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 5f2484c36..99fa2286a 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -576,7 +576,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 74f0a1f6d..9332c00bc 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -663,7 +663,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 4bee18c82..e5ba3e899 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -549,7 +549,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 322c17e55..282900b7e 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -550,7 +550,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 82f9baab8..e572c7df1 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -566,7 +566,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index f94ad226c..03bd60c5b 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -547,7 +547,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index a5ecfc505..0fba766ce 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -547,7 +547,6 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC_BENCHMARK=y
 CONFIG_XZ_DEC_TEST=m
-CONFIG_GLOB_SELFTEST=m
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
index ba36939fd..f7dab0cc2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3354,6 +3354,19 @@ config PRIME_NUMBERS_KUNIT_TEST
 
 	  If unsure, say N
 
+config GLOB_KUNIT_TEST
+	tristate "Glob matching test" if !KUNIT_ALL_TESTS
+	depends on GLOB
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
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
index aaf677cf4..e24e25420 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -226,7 +226,6 @@ obj-$(CONFIG_CLOSURES) += closure.o
 obj-$(CONFIG_DQL) += dynamic_queue_limits.o
 
 obj-$(CONFIG_GLOB) += glob.o
-obj-$(CONFIG_GLOB_SELFTEST) += globtest.o
 
 obj-$(CONFIG_DIMLIB) += dim/
 obj-$(CONFIG_SIGNATURE) += digsig.o
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
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 601dba4b7..8d546b312 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -19,6 +19,7 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
+obj-$(CONFIG_GLOB_KUNIT_TEST) += glob_kunit.o
 obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
 obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
 obj-$(CONFIG_TEST_IOV_ITER) += kunit_iov_iter.o
diff --git a/lib/tests/glob_kunit.c b/lib/tests/glob_kunit.c
new file mode 100644
index 000000000..362b1eda8
--- /dev/null
+++ b/lib/tests/glob_kunit.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: MIT OR GPL-2.0
+/*
+ * Test cases for glob functions.
+ */
+
+#include <kunit/test.h>
+#include <linux/glob.h>
+#include <linux/module.h>
+
+/**
+ * struct glob_test_case - Test case for glob matching.
+ * @pat: Pattern to match.
+ * @str: String to match against.
+ * @expected: Expected glob_match result, true if matched.
+ */
+struct glob_test_case {
+	const char *pat;
+	const char *str;
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
+			    glob_match(params->pat, params->str),
+			    params->expected,
+			    "Pattern: \"%s\", String: \"%s\", Expected: %d",
+			    params->pat, params->str, params->expected);
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
-- 
2.52.0.351.gbe84eed79e-goog


