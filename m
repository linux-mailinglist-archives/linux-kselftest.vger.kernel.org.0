Return-Path: <linux-kselftest+bounces-48377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EACCFC0D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 06:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE71C3016379
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 05:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C61624501B;
	Wed,  7 Jan 2026 05:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmzCSatI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614471A5B9D
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 05:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767763153; cv=none; b=CWfirM7GC9Yqq2lSsyvP4jqtLC9yN213ZkcdoDKbjMkcLkDcwjUWPSZXbM9Urzuk375N4+UzPKA8rCfX4nZ/Kj3QeVQ9pMySRMmqI0RZ4kANVvEDwlAkDfIsBEdiaoD3rNWdtuV48sJzPB9ojg4YDzSiCAgJkxB3YDQ3uTivmlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767763153; c=relaxed/simple;
	bh=xTQynpIdSHhaEEpooK3R/B0hpwJmDo4ODM2wrMxj7go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HOa1uFQs47oOnuppSnS9ZPsvOnLHfYgT2I4/DGzVDNNut5CqwH0dIiQEAO8hGJ2ovafNc33Jw2QHxEECufAABotZqwDnsfptEBpwQ27B0qYQuyJ/zwBbUiJksoPn2k99AJxf4D9+NMq16l8h1qIL+h8DByCeOuTkdpvBrXlsxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmzCSatI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7f216280242so135956b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 21:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767763150; x=1768367950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xUHzaNnewfs/y+Hs/HXNnhFsOnbBhLJEID9rgD4xGE0=;
        b=UmzCSatIjqookkDazTI6b4s+iH3/U3L9q62bmFqdDUSNQUTLE4PAxQyggnZ5+ewkaW
         7W0w2mzYxQ1FS6itJW1nVQHxJ/3/jpzS2MlgFziqT5Qrbyv/m//FhJN4/q4jgo4KKopI
         5JUT3zQi+MPYZIpPi966HlhgyYrKjk1KGafXai4gxLODf6RNqF/9kJeIDIHj8SrkQlrZ
         duGJDsYWaI7dvYZlb5wuWZq9zMIQrGLnXUu6DUH1EKdk1XrXk/ewUMuTOj7t/KnAdEbh
         Cc/s9paqA4HDkYUEtuaxeVmTd+K4sjx1BXPseoXhlrwD4IhehRtMxHDPSfD1AIDcrhWB
         BbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767763150; x=1768367950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUHzaNnewfs/y+Hs/HXNnhFsOnbBhLJEID9rgD4xGE0=;
        b=WP+SAKk9ITMYxWRX5+/KltwTqbQB82KILUwHYVAq7fVzx8UIODS6lyqWh5gdkAiN63
         hDq0Db5+/9Jd6SZ3JK0y6aJwXCbffrJsXg/gaZPsLWr9z2t3cmkYM2n9QNrwECbb7W0M
         /seMcoYYznAP3w86IZsArgiXIWxCvAJrcOPmLk+390RdO1H3EJKmnAmDBD3ZDcNo05SL
         n4EGY8SWFi+T6HLgpaDJXINtly0KpC46ZA4/QsKfDXCumu9cqBzW1Z8D20n7ldQplwkn
         UNA2VclbgWOcMykT39i3yeJUIA7xRxoO1oDTvZkAmsvGpTuCYFuT5P3Eg6NBpTk9iJBX
         8eug==
X-Forwarded-Encrypted: i=1; AJvYcCUU66c1uZXhrDl0eCRQObf9spD+s2dKtudlehmxYT/6W/9/xf+kGIJig/NQcabp4lm+G1xJFIBr7aexw+q4480=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaoAij9X2D36o3ZMyte6JtL1DeYgQ+YSrMX7wrHCiuGSXnmGF5
	CZoQpRqCWLv4c5qZywhkZGaG+U/dTsd58Yrchlicda7Ud/Xvm321eUPX
X-Gm-Gg: AY/fxX6BXN6Rze7+MvzwibVsMhS12Wn8PSe7KN1yVuPApraW/boNjbfVYKODse3X/PW
	Mlbt8FYURKu9aeabUIXVglUC/lWxh4N9M5wmRDzhrc776XqdM5P19nI2FZw5h0gcGP/y5S9HlCY
	hP/FUzHh0hwHyyuRHPoGMjKWUXsDQYIeQdEpnU7oiyGp54ry8NdOPz6wMB8Ih+Vupk3smxEgCKj
	4PUi83gmdsty9kTJx+5Ut8Ho5zGmqzSoPonaF9AfqtHHlvQXjgQBDyLUeT1KDMS7FIMW2foiYfY
	qUbh6Z73vpSh1meGow44AeFtqhbPA5wge8/gY7x9J0wV6VDKHiI8V54DPESXn02ZPQMcPfeqpTg
	ZcH8nRulYiUpP9QWHO/k4IyolD4zYK27xGo2tJeuLTExmbBQLPFBrFCfm9YDzHQcg/idzlwF0r4
	hm2WzTZUO7jX/YOu811mkJHMX52UvUNJdHncj54Gf93SNiOFtvEYs12mRzEbyPCamCdk6NXBkVo
	rsuLi6RhKuOFDIhXZxKTyM=
X-Google-Smtp-Source: AGHT+IG2+pAlkfjYhmShjhhRNMp1BKgea7EqYP/fvSn6o2mic3EZQxVFjR50cI+gz1u37Z2mAU3X8Q==
X-Received: by 2002:a05:6a20:4c27:b0:389:8e40:a133 with SMTP id adf61e73a8af0-3898e40a3ddmr1394381637.6.1767763150398;
        Tue, 06 Jan 2026 21:19:10 -0800 (PST)
Received: from kirchou-macbookpro2.roam.corp.google.com (softbank126227055022.bbtec.net. [126.227.55.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28f6cdsm3790132a12.6.2026.01.06.21.19.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Jan 2026 21:19:09 -0800 (PST)
Sender: kir <610548@gmail.com>
From: Kir Chou <note351@hotmail.com>
To: akpm@linux-foundation.org,
	geert@linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	davidgow@google.com,
	brendan.higgins@linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	kirchou@google.com,
	Kir Chou <note351@hotmail.com>
Subject: [PATCH v3] lib/glob: convert selftest to KUnit
Date: Wed,  7 Jan 2026 14:19:03 +0900
Message-ID: <20260107051903.35039-1-note351@hotmail.com>
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
---
v2:
 - Remove CONFIG_GLOB_KUNIT_TEST from defconfigs as it's implicitly enabled
   by CONFIG_KUNIT_ALL_TESTS. (Suggested by Geert)
v3:
 - Move lib/glob_kunit.c to lib/tests/glob_kunit.c.
 - Update Makefile accordingly.
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
 lib/tests/glob_kunit.c               | 122 +++++++++++++++++++
 18 files changed, 136 insertions(+), 193 deletions(-)
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
index 000000000..797e32a8c
--- /dev/null
+++ b/lib/tests/glob_kunit.c
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
-- 
2.52.0.351.gbe84eed79e-goog


