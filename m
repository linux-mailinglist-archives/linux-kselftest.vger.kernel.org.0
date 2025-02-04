Return-Path: <linux-kselftest+bounces-25726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D15A27B21
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40043A2A29
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70D5218EB5;
	Tue,  4 Feb 2025 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THam5qsT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105A92147E9;
	Tue,  4 Feb 2025 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697098; cv=none; b=Gck3Tr8SItlvW1qTzDfQWJNZACB7cP3vqBa7DWCT1jqzh0EYIozsS+D8md/6mbxh3yH4xkCgtzhefR2ZfFpNjaK4qd99dFFI2U8d8Vt22Y44H2qSfxp7fUm8LcLuPvO4NbjR3M6gIZ021G++SpT/DoYP+Aoez3ywnOZZFVwnVpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697098; c=relaxed/simple;
	bh=+cGn9d4aCO9x683nwkFQtzltw1xPNmVuqYUM3PjeQV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ICauSAK1ix/fo31Zo4sODLXcj/jgtV+6rhyMB7A7zZxpl2Jepz821AYr4qirrEZJ4mMi2mwf+xSfxmLdgR1SWkcrxjDYDkgvvDf6+c9+nLs3KyOK8dMqexBi8IAr4SOapPD7oychcMRW1XWm17TxNEZO4nG0wilL3Ff+LIvt0v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THam5qsT; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6fc3e9e4aso540237885a.2;
        Tue, 04 Feb 2025 11:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738697094; x=1739301894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wT8du68cq9SACyhnoMm7tYRDIJ4d1oz6ECPh8LXpQSE=;
        b=THam5qsTnTr07ZPNZQ3Xql1YhjbWExGPjy2cmWt4TdszVgQGQJcIQwTKyDWXPjkiBd
         6LLO5lH33Rcczf0c504CcjBseqU+dibI/WOzkRrPSDYfXY5mFGw+EZGgKJUrXz24kGEW
         vxuOYfIvt7LBfUmNUJiR3dkziQdzDY9i6GN6KXaVy25JhWYXGGdoTGUr/omYJHDb6YjI
         TDb5NJYBLpbIEm2E2z2nhWjqhKJuSlT8gVZTkLAbRiyBjSlSgP+o2mNL0r5TtqP1FiKf
         BDSovIZXpu4SYa4DQ/eva1BiGFjCNTMX11LTmN9N9vuUAfspA4thRS6kCkHBelP1qYyY
         xzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738697094; x=1739301894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wT8du68cq9SACyhnoMm7tYRDIJ4d1oz6ECPh8LXpQSE=;
        b=kqk6/5jybgaETHIZc1qkW+GR7UpPNOeRnfdpDegEj6biKebH11M0cSJkxybpnIupgv
         fqnZ9JuMfBVfnMSWTZh0k6AedcmrjNriKCmXF7zVWEvIrJ1G6lSTdQQqZJyRSkW5j7lN
         BDQDcOuwljfbfgJIJmMDczeYpkAZvPJP2HGZrDjGobSwaAwHcYHsRsgU+0kwkyQfAi8m
         4egzXQFCb3MQPsMIZIyCHZYuqbrUS3HTAae1vfSETCkXsKwnUDuuZGratO8xsLjamoWX
         yJpTN1asvCpYZsD2T9wOKsf+mbWfHj8qtxfTWnnF2LH19O9CDrG5T/3gvvHc0avlJPuQ
         goig==
X-Forwarded-Encrypted: i=1; AJvYcCVWcNHCDliHhlLEmAO40xK7WIeRsqGp3cOGQzYUvwy+R9liLylKZBNCznLiJ62AXEIrAYd44HNNMIEOw1NBg94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTVR/deHQdl98APkQxR++v56O0OofJbnDWA8rjFmGn2N2Ns/dS
	jjtTP+eWgmc7CjjEzYSyks6sAkdOtplC0qu7EE7VqbaFR5vwxiCN
X-Gm-Gg: ASbGncutHmUe7poNhmFsLUNm6stiPi67zfCnl7+8Hzxj2nbvfdTlvuXZpHwPVklbuT+
	vuf4du4/4fRjz2CpjdL+Z071rYzNYDwoVWF0fAi5cfWmwZmAF2wq845lqv811Ht45yCr6cv5l7d
	59IekwKUUZm+Si9ArKD6VxRAFnq3PzfoiDMm4U/KsP517wrXMv1c+++BahJX2g/PkgZHVxFJyqe
	CmTebyfziwL6CAJ5SwsLDTziDPLsRn3oHKyfOvlKexhy0UCPnbme7VUf/VTuto9OORFO15veuT7
	3CIL6T5+OLM+J4SXjy7E2b3XpONgCKLYXs6Xz7A9z7E3trJirgPrvDUDi9bVvZxjcRLn/6qsi5J
	JUbqfKon/Sg4/DupBCNC6oZ3p
X-Google-Smtp-Source: AGHT+IFFa3xZ/VPyvqDBqIOG7lXce3BFsqCf/YrvroonGh7m+Dw5fUkVzsFmXN8lL08RjwcUQrjW/A==
X-Received: by 2002:a05:620a:31a9:b0:7be:3cf0:d712 with SMTP id af79cd13be357-7bffccea19cmr3916368585a.3.1738697093388;
        Tue, 04 Feb 2025 11:24:53 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:6ca8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8bbaf5sm671334285a.11.2025.02.04.11.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:24:52 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 04 Feb 2025 14:24:24 -0500
Subject: [PATCH v3 1/2] scanf: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-scanf-kunit-convert-v3-1-f1d662822804@gmail.com>
References: <20250204-scanf-kunit-convert-v3-0-f1d662822804@gmail.com>
In-Reply-To: <20250204-scanf-kunit-convert-v3-0-f1d662822804@gmail.com>
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: b4 0.15-dev

Convert the scanf() self-test to a KUnit test.

In the interest of keeping the patch reasonably-sized this doesn't
refactor the tests into proper parameterized tests - it's all one big
test case.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Acked-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 MAINTAINERS                          |   2 +-
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
 arch/powerpc/configs/ppc64_defconfig |   1 -
 lib/Kconfig.debug                    |  20 +-
 lib/Makefile                         |   2 +-
 lib/{test_scanf.c => scanf_kunit.c}  | 704 +++++++++++++++++------------------
 tools/testing/selftests/lib/Makefile |   2 +-
 tools/testing/selftests/lib/config   |   1 -
 tools/testing/selftests/lib/scanf.sh |   4 -
 20 files changed, 359 insertions(+), 389 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..44f9f0ee1f1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25368,8 +25368,8 @@ R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
 F:	Documentation/core-api/printk-formats.rst
+F:	lib/scanf_kunit.c
 F:	lib/test_printf.c
-F:	lib/test_scanf.c
 F:	lib/vsprintf.c
 
 VT1211 HARDWARE MONITOR DRIVER
diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index dbf2ea561c85..e85a4b3a9847 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -623,7 +623,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index b0fd199cc0a4..232b885cc26e 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -580,7 +580,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index bb5b2d3b6c10..228af5b4cd42 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -600,7 +600,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 8315a13bab73..cbc59aed3d97 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -572,7 +572,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 350370657e5f..8d3787b8fe6d 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -582,7 +582,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index f942b4755702..a68893d83361 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -599,7 +599,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index b1eaad02efab..9a17526cefd2 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -686,7 +686,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 6309a4442bb3..5cf2e2860044 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -572,7 +572,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 3feb0731f814..eb395749bc75 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -573,7 +573,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index ea04b1b0da7d..8891f12c2a18 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -589,7 +589,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index f52d9af92153..a49ff5330e5b 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -569,7 +569,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index f348447824da..3022ff492136 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -570,7 +570,6 @@ CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 465eb96c755e..819387cbbe69 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -445,7 +445,6 @@ CONFIG_STRING_SELFTEST=m
 CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..716c4ef857bb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2427,6 +2427,23 @@ config ASYNC_RAID6_TEST
 config TEST_HEXDUMP
 	tristate "Test functions located in the hexdump module at runtime"
 
+config SCANF_KUNIT_TEST
+	tristate "KUnit test scanf() family of functions at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test the scanf functions at boot.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running the KUnit test harness, and not intended for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config STRING_KUNIT_TEST
 	tristate "KUnit test string functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
@@ -2443,9 +2460,6 @@ config TEST_KSTRTOX
 config TEST_PRINTF
 	tristate "Test printf() family of functions at runtime"
 
-config TEST_SCANF
-	tristate "Test scanf() family of functions at runtime"
-
 config TEST_BITMAP
 	tristate "Test bitmap_*() family of functions at runtime"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index d5cfc7afbbb8..6bdf2287878d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -85,7 +85,7 @@ obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
-obj-$(CONFIG_TEST_SCANF) += test_scanf.o
+obj-$(CONFIG_SCANF_KUNIT_TEST) += scanf_kunit.o
 
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
diff --git a/lib/test_scanf.c b/lib/scanf_kunit.c
similarity index 30%
rename from lib/test_scanf.c
rename to lib/scanf_kunit.c
index 44f8508c9d88..70364ce20ec3 100644
--- a/lib/test_scanf.c
+++ b/lib/scanf_kunit.c
@@ -5,8 +5,8 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/test.h>
 #include <linux/bitops.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
@@ -15,148 +15,123 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
-#include "../tools/testing/selftests/kselftest_module.h"
-
 #define BUF_SIZE 1024
 
-KSTM_MODULE_GLOBALS();
-static char *test_buffer __initdata;
-static char *fmt_buffer __initdata;
-static struct rnd_state rnd_state __initdata;
+static char *test_buffer;
+static char *fmt_buffer;
+static struct rnd_state rnd_state;
 
-typedef int (*check_fn)(const void *check_data, const char *string,
+typedef void (*check_fn)(struct kunit *test, const void *check_data, const char *string,
 			const char *fmt, int n_args, va_list ap);
 
-static void __scanf(4, 6) __init
-_test(check_fn fn, const void *check_data, const char *string, const char *fmt,
+static void __scanf(5, 7)
+_test(struct kunit *test, check_fn fn, const void *check_data, const char *string, const char *fmt,
 	int n_args, ...)
 {
 	va_list ap, ap_copy;
-	int ret;
-
-	total_tests++;
 
 	va_start(ap, n_args);
 	va_copy(ap_copy, ap);
-	ret = vsscanf(string, fmt, ap_copy);
+	KUNIT_EXPECT_EQ_MSG(test, vsscanf(string, fmt, ap_copy), n_args,
+			    "vsscanf(\"%s\", \"%s\", ...)", string, fmt);
 	va_end(ap_copy);
 
-	if (ret != n_args) {
-		pr_warn("vsscanf(\"%s\", \"%s\", ...) returned %d expected %d\n",
-			string, fmt, ret, n_args);
-		goto fail;
-	}
-
-	ret = (*fn)(check_data, string, fmt, n_args, ap);
-	if (ret)
-		goto fail;
-
-	va_end(ap);
-
-	return;
-
-fail:
-	failed_tests++;
+	(*fn)(test, check_data, string, fmt, n_args, ap);
 	va_end(ap);
 }
 
-#define _check_numbers_template(arg_fmt, expect, str, fmt, n_args, ap)		\
+#define _check_numbers_template(test, arg_fmt, expect, str, fmt, n_args, ap)	\
 do {										\
 	pr_debug("\"%s\", \"%s\" ->\n", str, fmt);				\
 	for (; n_args > 0; n_args--, expect++) {				\
 		typeof(*expect) got = *va_arg(ap, typeof(expect));		\
 		pr_debug("\t" arg_fmt "\n", got);				\
-		if (got != *expect) {						\
-			pr_warn("vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt "\n", \
-				str, fmt, *expect, got);			\
-			return 1;						\
-		}								\
+		KUNIT_EXPECT_EQ_MSG(test, got, *expect, "vsscanf(\"%s\", \"%s\", ...)", str, fmt); \
 	}									\
-	return 0;								\
 } while (0)
 
-static int __init check_ull(const void *check_data, const char *string,
+static void check_ull(struct kunit *test, const void *check_data, const char *string,
 			    const char *fmt, int n_args, va_list ap)
 {
 	const unsigned long long *pval = check_data;
 
-	_check_numbers_template("%llu", pval, string, fmt, n_args, ap);
+	_check_numbers_template(test, "%llu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_ll(const void *check_data, const char *string,
+static void check_ll(struct kunit *test, const void *check_data, const char *string,
 			   const char *fmt, int n_args, va_list ap)
 {
 	const long long *pval = check_data;
 
-	_check_numbers_template("%lld", pval, string, fmt, n_args, ap);
+	_check_numbers_template(test, "%lld", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_ulong(const void *check_data, const char *string,
+static void check_ulong(struct kunit *test, const void *check_data, const char *string,
 			   const char *fmt, int n_args, va_list ap)
 {
 	const unsigned long *pval = check_data;
 
-	_check_numbers_template("%lu", pval, string, fmt, n_args, ap);
+	_check_numbers_template(test, "%lu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_long(const void *check_data, const char *string,
+static void check_long(struct kunit *test, const void *check_data, const char *string,
 			  const char *fmt, int n_args, va_list ap)
 {
 	const long *pval = check_data;
 
-	_check_numbers_template("%ld", pval, string, fmt, n_args, ap);
+	_check_numbers_template(test, "%ld", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_uint(const void *check_data, const char *string,
+static void check_uint(struct kunit *test, const void *check_data, const char *string,
 			     const char *fmt, int n_args, va_list ap)
 {
 	const unsigned int *pval = check_data;
 
-	_check_numbers_template("%u", pval, string, fmt, n_args, ap);
+	_check_numbers_template(test, "%u", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_int(const void *check_data, const char *string,
+static void check_int(struct kunit *test, const void *check_data, const char *string,
 			    const char *fmt, int n_args, va_list ap)
 {
 	const int *pval = check_data;
 
-	_check_numbers_template("%d", pval, string, fmt, n_args, ap);
+	_check_numbers_template(test, "%d", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_ushort(const void *check_data, const char *string,
+static void check_ushort(struct kunit *test, const void *check_data, const char *string,
 			       const char *fmt, int n_args, va_list ap)
 {
 	const unsigned short *pval = check_data;
 
-	_check_numbers_template("%hu", pval, string, fmt, n_args, ap);
+	_check_numbers_template(test, "%hu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_short(const void *check_data, const char *string,
+static void check_short(struct kunit *test, const void *check_data, const char *string,
 			       const char *fmt, int n_args, va_list ap)
 {
 	const short *pval = check_data;
 
-	_check_numbers_template("%hd", pval, string, fmt, n_args, ap);
+	_check_numbers_template(test, "%hd", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_uchar(const void *check_data, const char *string,
+static void check_uchar(struct kunit *test, const void *check_data, const char *string,
 			       const char *fmt, int n_args, va_list ap)
 {
 	const unsigned char *pval = check_data;
 
-	_check_numbers_template("%hhu", pval, string, fmt, n_args, ap);
+	_check_numbers_template(test, "%hhu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_char(const void *check_data, const char *string,
+static void check_char(struct kunit *test, const void *check_data, const char *string,
 			       const char *fmt, int n_args, va_list ap)
 {
 	const signed char *pval = check_data;
 
-	_check_numbers_template("%hhd", pval, string, fmt, n_args, ap);
+	_check_numbers_template(test, "%hhd", pval, string, fmt, n_args, ap);
 }
 
 /* Selection of interesting numbers to test, copied from test-kstrtox.c */
-static const unsigned long long numbers[] __initconst = {
+static const unsigned long long numbers[] = {
 	0x0ULL,
 	0x1ULL,
 	0x7fULL,
@@ -190,76 +165,76 @@ static const unsigned long long numbers[] __initconst = {
 	: ((unsigned long long)(val) <= type_max(T)))
 
 
-#define test_one_number(T, gen_fmt, scan_fmt, val, fn)			\
-do {									\
-	const T expect_val = (T)(val);					\
-	T result = ~expect_val; /* should be overwritten */		\
-									\
-	snprintf(test_buffer, BUF_SIZE, gen_fmt, expect_val);		\
-	_test(fn, &expect_val, test_buffer, "%" scan_fmt, 1, &result);	\
+#define test_one_number(test, T, gen_fmt, scan_fmt, val, fn)			\
+do {										\
+	const T expect_val = (T)(val);						\
+	T result = ~expect_val; /* should be overwritten */			\
+										\
+	snprintf(test_buffer, BUF_SIZE, gen_fmt, expect_val);			\
+	_test(test, fn, &expect_val, test_buffer, "%" scan_fmt, 1, &result);	\
 } while (0)
 
-#define simple_numbers_loop(T, gen_fmt, scan_fmt, fn)			\
+#define simple_numbers_loop(test, T, gen_fmt, scan_fmt, fn)		\
 do {									\
 	int i;								\
 									\
 	for (i = 0; i < ARRAY_SIZE(numbers); i++) {			\
 		if (value_representable_in_type(T, numbers[i]))		\
-			test_one_number(T, gen_fmt, scan_fmt,		\
+			test_one_number(test, T, gen_fmt, scan_fmt,	\
 					numbers[i], fn);		\
 									\
 		if (value_representable_in_type(T, -numbers[i]))	\
-			test_one_number(T, gen_fmt, scan_fmt,		\
+			test_one_number(test, T, gen_fmt, scan_fmt,	\
 					-numbers[i], fn);		\
 	}								\
 } while (0)
 
-static void __init numbers_simple(void)
-{
-	simple_numbers_loop(unsigned long long,	"%llu",	  "llu", check_ull);
-	simple_numbers_loop(long long,		"%lld",	  "lld", check_ll);
-	simple_numbers_loop(long long,		"%lld",	  "lli", check_ll);
-	simple_numbers_loop(unsigned long long,	"%llx",	  "llx", check_ull);
-	simple_numbers_loop(long long,		"%llx",	  "llx", check_ll);
-	simple_numbers_loop(long long,		"0x%llx", "lli", check_ll);
-	simple_numbers_loop(unsigned long long, "0x%llx", "llx", check_ull);
-	simple_numbers_loop(long long,		"0x%llx", "llx", check_ll);
-
-	simple_numbers_loop(unsigned long,	"%lu",	  "lu", check_ulong);
-	simple_numbers_loop(long,		"%ld",	  "ld", check_long);
-	simple_numbers_loop(long,		"%ld",	  "li", check_long);
-	simple_numbers_loop(unsigned long,	"%lx",	  "lx", check_ulong);
-	simple_numbers_loop(long,		"%lx",	  "lx", check_long);
-	simple_numbers_loop(long,		"0x%lx",  "li", check_long);
-	simple_numbers_loop(unsigned long,	"0x%lx",  "lx", check_ulong);
-	simple_numbers_loop(long,		"0x%lx",  "lx", check_long);
-
-	simple_numbers_loop(unsigned int,	"%u",	  "u", check_uint);
-	simple_numbers_loop(int,		"%d",	  "d", check_int);
-	simple_numbers_loop(int,		"%d",	  "i", check_int);
-	simple_numbers_loop(unsigned int,	"%x",	  "x", check_uint);
-	simple_numbers_loop(int,		"%x",	  "x", check_int);
-	simple_numbers_loop(int,		"0x%x",   "i", check_int);
-	simple_numbers_loop(unsigned int,	"0x%x",   "x", check_uint);
-	simple_numbers_loop(int,		"0x%x",   "x", check_int);
-
-	simple_numbers_loop(unsigned short,	"%hu",	  "hu", check_ushort);
-	simple_numbers_loop(short,		"%hd",	  "hd", check_short);
-	simple_numbers_loop(short,		"%hd",	  "hi", check_short);
-	simple_numbers_loop(unsigned short,	"%hx",	  "hx", check_ushort);
-	simple_numbers_loop(short,		"%hx",	  "hx", check_short);
-	simple_numbers_loop(short,		"0x%hx",  "hi", check_short);
-	simple_numbers_loop(unsigned short,	"0x%hx",  "hx", check_ushort);
-	simple_numbers_loop(short,		"0x%hx",  "hx", check_short);
-
-	simple_numbers_loop(unsigned char,	"%hhu",	  "hhu", check_uchar);
-	simple_numbers_loop(signed char,	"%hhd",	  "hhd", check_char);
-	simple_numbers_loop(signed char,	"%hhd",	  "hhi", check_char);
-	simple_numbers_loop(unsigned char,	"%hhx",	  "hhx", check_uchar);
-	simple_numbers_loop(signed char,	"%hhx",	  "hhx", check_char);
-	simple_numbers_loop(signed char,	"0x%hhx", "hhi", check_char);
-	simple_numbers_loop(unsigned char,	"0x%hhx", "hhx", check_uchar);
-	simple_numbers_loop(signed char,	"0x%hhx", "hhx", check_char);
+static void numbers_simple(struct kunit *test)
+{
+	simple_numbers_loop(test, unsigned long long,	"%llu",		"llu", check_ull);
+	simple_numbers_loop(test, long long,		"%lld",		"lld", check_ll);
+	simple_numbers_loop(test, long long,		"%lld",		"lli", check_ll);
+	simple_numbers_loop(test, unsigned long long,	"%llx",		"llx", check_ull);
+	simple_numbers_loop(test, long long,		"%llx",		"llx", check_ll);
+	simple_numbers_loop(test, long long,		"0x%llx",	"lli", check_ll);
+	simple_numbers_loop(test, unsigned long long,	"0x%llx",	"llx", check_ull);
+	simple_numbers_loop(test, long long,		"0x%llx",	"llx", check_ll);
+
+	simple_numbers_loop(test, unsigned long,	"%lu",		"lu", check_ulong);
+	simple_numbers_loop(test, long,			"%ld",		"ld", check_long);
+	simple_numbers_loop(test, long,			"%ld",		"li", check_long);
+	simple_numbers_loop(test, unsigned long,	"%lx",		"lx", check_ulong);
+	simple_numbers_loop(test, long,			"%lx",		"lx", check_long);
+	simple_numbers_loop(test, long,			"0x%lx",	"li", check_long);
+	simple_numbers_loop(test, unsigned long,	"0x%lx",	"lx", check_ulong);
+	simple_numbers_loop(test, long,			"0x%lx",	"lx", check_long);
+
+	simple_numbers_loop(test, unsigned int,		"%u",		"u", check_uint);
+	simple_numbers_loop(test, int,			"%d",		"d", check_int);
+	simple_numbers_loop(test, int,			"%d",		"i", check_int);
+	simple_numbers_loop(test, unsigned int,		"%x",		"x", check_uint);
+	simple_numbers_loop(test, int,			"%x",		"x", check_int);
+	simple_numbers_loop(test, int,			"0x%x",		"i", check_int);
+	simple_numbers_loop(test, unsigned int,		"0x%x",		"x", check_uint);
+	simple_numbers_loop(test, int,			"0x%x",		"x", check_int);
+
+	simple_numbers_loop(test, unsigned short,	"%hu",		"hu", check_ushort);
+	simple_numbers_loop(test, short,		"%hd",		"hd", check_short);
+	simple_numbers_loop(test, short,		"%hd",		"hi", check_short);
+	simple_numbers_loop(test, unsigned short,	"%hx",		"hx", check_ushort);
+	simple_numbers_loop(test, short,		"%hx",		"hx", check_short);
+	simple_numbers_loop(test, short,		"0x%hx",	"hi", check_short);
+	simple_numbers_loop(test, unsigned short,	"0x%hx",	"hx", check_ushort);
+	simple_numbers_loop(test, short,		"0x%hx",	"hx", check_short);
+
+	simple_numbers_loop(test, unsigned char,	"%hhu",		"hhu", check_uchar);
+	simple_numbers_loop(test, signed char,		"%hhd",		"hhd", check_char);
+	simple_numbers_loop(test, signed char,		"%hhd",		"hhi", check_char);
+	simple_numbers_loop(test, unsigned char,	"%hhx",		"hhx", check_uchar);
+	simple_numbers_loop(test, signed char,		"%hhx",		"hhx", check_char);
+	simple_numbers_loop(test, signed char,		"0x%hhx",	"hhi", check_char);
+	simple_numbers_loop(test, unsigned char,	"0x%hhx",	"hhx", check_uchar);
+	simple_numbers_loop(test, signed char,		"0x%hhx",	"hhx", check_char);
 }
 
 /*
@@ -267,14 +242,14 @@ static void __init numbers_simple(void)
  * the raw prandom*() functions (Not mathematically rigorous!!).
  * Variabilty of length and value is more important than perfect randomness.
  */
-static u32 __init next_test_random(u32 max_bits)
+static u32 next_test_random(u32 max_bits)
 {
 	u32 n_bits = hweight32(prandom_u32_state(&rnd_state)) % (max_bits + 1);
 
 	return prandom_u32_state(&rnd_state) & GENMASK(n_bits, 0);
 }
 
-static unsigned long long __init next_test_random_ull(void)
+static unsigned long long next_test_random_ull(void)
 {
 	u32 rand1 = prandom_u32_state(&rnd_state);
 	u32 n_bits = (hweight32(rand1) * 3) % 64;
@@ -311,7 +286,7 @@ do {										\
  * updating buf_pos and returning the number of characters appended.
  * On error buf_pos is not changed and return value is 0.
  */
-static int __init __printf(4, 5)
+static int __printf(4, 5)
 append_fmt(char *buf, int *buf_pos, int buf_len, const char *val_fmt, ...)
 {
 	va_list ap;
@@ -333,7 +308,7 @@ append_fmt(char *buf, int *buf_pos, int buf_len, const char *val_fmt, ...)
  * Convenience function to append the field delimiter string
  * to both the value string and format string buffers.
  */
-static void __init append_delim(char *str_buf, int *str_buf_pos, int str_buf_len,
+static void append_delim(char *str_buf, int *str_buf_pos, int str_buf_len,
 				char *fmt_buf, int *fmt_buf_pos, int fmt_buf_len,
 				const char *delim_str)
 {
@@ -341,15 +316,15 @@ static void __init append_delim(char *str_buf, int *str_buf_pos, int str_buf_len
 	append_fmt(fmt_buf, fmt_buf_pos, fmt_buf_len, delim_str);
 }
 
-#define test_array_8(fn, check_data, string, fmt, arr)				\
+#define test_array_8(test, fn, check_data, string, fmt, arr)			\
 do {										\
 	BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);					\
-	_test(fn, check_data, string, fmt, 8,					\
+	_test(test, fn, check_data, string, fmt, 8,				\
 		&(arr)[0], &(arr)[1], &(arr)[2], &(arr)[3],			\
 		&(arr)[4], &(arr)[5], &(arr)[6], &(arr)[7]);			\
 } while (0)
 
-#define numbers_list_8(T, gen_fmt, field_sep, scan_fmt, fn)			\
+#define numbers_list_8(test, T, gen_fmt, field_sep, scan_fmt, fn)		\
 do {										\
 	int i, pos = 0, fmt_pos = 0;						\
 	T expect[8], result[8];							\
@@ -366,18 +341,18 @@ do {										\
 		append_fmt(fmt_buffer, &fmt_pos, BUF_SIZE, "%%%s", scan_fmt);	\
 	}									\
 										\
-	test_array_8(fn, expect, test_buffer, fmt_buffer, result);		\
+	test_array_8(test, fn, expect, test_buffer, fmt_buffer, result);	\
 } while (0)
 
-#define numbers_list_fix_width(T, gen_fmt, field_sep, width, scan_fmt, fn)	\
+#define numbers_list_fix_width(test, T, gen_fmt, field_sep, width, scan_fmt, fn)\
 do {										\
 	char full_fmt[16];							\
 										\
 	snprintf(full_fmt, sizeof(full_fmt), "%u%s", width, scan_fmt);		\
-	numbers_list_8(T, gen_fmt, field_sep, full_fmt, fn);			\
+	numbers_list_8(test, T, gen_fmt, field_sep, full_fmt, fn);		\
 } while (0)
 
-#define numbers_list_val_width(T, gen_fmt, field_sep, scan_fmt, fn)		\
+#define numbers_list_val_width(test, T, gen_fmt, field_sep, scan_fmt, fn)	\
 do {										\
 	int i, val_len, pos = 0, fmt_pos = 0;					\
 	T expect[8], result[8];							\
@@ -395,201 +370,201 @@ do {										\
 			   "%%%u%s", val_len, scan_fmt);			\
 	}									\
 										\
-	test_array_8(fn, expect, test_buffer, fmt_buffer, result);		\
+	test_array_8(test, fn, expect, test_buffer, fmt_buffer, result);	\
 } while (0)
 
-static void __init numbers_list_ll(const char *delim)
+static void numbers_list_ll(struct kunit *test, const char *delim)
 {
-	numbers_list_8(unsigned long long, "%llu",   delim, "llu", check_ull);
-	numbers_list_8(long long,	   "%lld",   delim, "lld", check_ll);
-	numbers_list_8(long long,	   "%lld",   delim, "lli", check_ll);
-	numbers_list_8(unsigned long long, "%llx",   delim, "llx", check_ull);
-	numbers_list_8(unsigned long long, "0x%llx", delim, "llx", check_ull);
-	numbers_list_8(long long,	   "0x%llx", delim, "lli", check_ll);
+	numbers_list_8(test, unsigned long long,	"%llu",		delim, "llu", check_ull);
+	numbers_list_8(test, long long,			"%lld",		delim, "lld", check_ll);
+	numbers_list_8(test, long long,			"%lld",		delim, "lli", check_ll);
+	numbers_list_8(test, unsigned long long,	"%llx",		delim, "llx", check_ull);
+	numbers_list_8(test, unsigned long long,	"0x%llx",	delim, "llx", check_ull);
+	numbers_list_8(test, long long,			"0x%llx",	delim, "lli", check_ll);
 }
 
-static void __init numbers_list_l(const char *delim)
+static void numbers_list_l(struct kunit *test, const char *delim)
 {
-	numbers_list_8(unsigned long,	   "%lu",    delim, "lu", check_ulong);
-	numbers_list_8(long,		   "%ld",    delim, "ld", check_long);
-	numbers_list_8(long,		   "%ld",    delim, "li", check_long);
-	numbers_list_8(unsigned long,	   "%lx",    delim, "lx", check_ulong);
-	numbers_list_8(unsigned long,	   "0x%lx",  delim, "lx", check_ulong);
-	numbers_list_8(long,		   "0x%lx",  delim, "li", check_long);
+	numbers_list_8(test, unsigned long,	"%lu",		delim, "lu", check_ulong);
+	numbers_list_8(test, long,		"%ld",		delim, "ld", check_long);
+	numbers_list_8(test, long,		"%ld",		delim, "li", check_long);
+	numbers_list_8(test, unsigned long,	"%lx",		delim, "lx", check_ulong);
+	numbers_list_8(test, unsigned long,	"0x%lx",	delim, "lx", check_ulong);
+	numbers_list_8(test, long,		"0x%lx",	delim, "li", check_long);
 }
 
-static void __init numbers_list_d(const char *delim)
+static void numbers_list_d(struct kunit *test, const char *delim)
 {
-	numbers_list_8(unsigned int,	   "%u",     delim, "u", check_uint);
-	numbers_list_8(int,		   "%d",     delim, "d", check_int);
-	numbers_list_8(int,		   "%d",     delim, "i", check_int);
-	numbers_list_8(unsigned int,	   "%x",     delim, "x", check_uint);
-	numbers_list_8(unsigned int,	   "0x%x",   delim, "x", check_uint);
-	numbers_list_8(int,		   "0x%x",   delim, "i", check_int);
+	numbers_list_8(test, unsigned int,	"%u",	delim, "u", check_uint);
+	numbers_list_8(test, int,		"%d",	delim, "d", check_int);
+	numbers_list_8(test, int,		"%d",	delim, "i", check_int);
+	numbers_list_8(test, unsigned int,	"%x",	delim, "x", check_uint);
+	numbers_list_8(test, unsigned int,	"0x%x",	delim, "x", check_uint);
+	numbers_list_8(test, int,		"0x%x",	delim, "i", check_int);
 }
 
-static void __init numbers_list_h(const char *delim)
+static void numbers_list_h(struct kunit *test, const char *delim)
 {
-	numbers_list_8(unsigned short,	   "%hu",    delim, "hu", check_ushort);
-	numbers_list_8(short,		   "%hd",    delim, "hd", check_short);
-	numbers_list_8(short,		   "%hd",    delim, "hi", check_short);
-	numbers_list_8(unsigned short,	   "%hx",    delim, "hx", check_ushort);
-	numbers_list_8(unsigned short,	   "0x%hx",  delim, "hx", check_ushort);
-	numbers_list_8(short,		   "0x%hx",  delim, "hi", check_short);
+	numbers_list_8(test, unsigned short,	"%hu",		delim, "hu", check_ushort);
+	numbers_list_8(test, short,		"%hd",		delim, "hd", check_short);
+	numbers_list_8(test, short,		"%hd",		delim, "hi", check_short);
+	numbers_list_8(test, unsigned short,	"%hx",		delim, "hx", check_ushort);
+	numbers_list_8(test, unsigned short,	"0x%hx",	delim, "hx", check_ushort);
+	numbers_list_8(test, short,		"0x%hx",	delim, "hi", check_short);
 }
 
-static void __init numbers_list_hh(const char *delim)
+static void numbers_list_hh(struct kunit *test, const char *delim)
 {
-	numbers_list_8(unsigned char,	   "%hhu",   delim, "hhu", check_uchar);
-	numbers_list_8(signed char,	   "%hhd",   delim, "hhd", check_char);
-	numbers_list_8(signed char,	   "%hhd",   delim, "hhi", check_char);
-	numbers_list_8(unsigned char,	   "%hhx",   delim, "hhx", check_uchar);
-	numbers_list_8(unsigned char,	   "0x%hhx", delim, "hhx", check_uchar);
-	numbers_list_8(signed char,	   "0x%hhx", delim, "hhi", check_char);
+	numbers_list_8(test, unsigned char,	"%hhu",		delim, "hhu", check_uchar);
+	numbers_list_8(test, signed char,	"%hhd",		delim, "hhd", check_char);
+	numbers_list_8(test, signed char,	"%hhd",		delim, "hhi", check_char);
+	numbers_list_8(test, unsigned char,	"%hhx",		delim, "hhx", check_uchar);
+	numbers_list_8(test, unsigned char,	"0x%hhx",	delim, "hhx", check_uchar);
+	numbers_list_8(test, signed char,	"0x%hhx",	delim, "hhi", check_char);
 }
 
-static void __init numbers_list(const char *delim)
+static void numbers_list(struct kunit *test, const char *delim)
 {
-	numbers_list_ll(delim);
-	numbers_list_l(delim);
-	numbers_list_d(delim);
-	numbers_list_h(delim);
-	numbers_list_hh(delim);
+	numbers_list_ll(test, delim);
+	numbers_list_l(test, delim);
+	numbers_list_d(test, delim);
+	numbers_list_h(test, delim);
+	numbers_list_hh(test, delim);
 }
 
-static void __init numbers_list_field_width_ll(const char *delim)
+static void numbers_list_field_width_ll(struct kunit *test, const char *delim)
 {
-	numbers_list_fix_width(unsigned long long, "%llu",   delim, 20, "llu", check_ull);
-	numbers_list_fix_width(long long,	   "%lld",   delim, 20, "lld", check_ll);
-	numbers_list_fix_width(long long,	   "%lld",   delim, 20, "lli", check_ll);
-	numbers_list_fix_width(unsigned long long, "%llx",   delim, 16, "llx", check_ull);
-	numbers_list_fix_width(unsigned long long, "0x%llx", delim, 18, "llx", check_ull);
-	numbers_list_fix_width(long long,	   "0x%llx", delim, 18, "lli", check_ll);
+	numbers_list_fix_width(test, unsigned long long, "%llu",   delim, 20, "llu", check_ull);
+	numbers_list_fix_width(test, long long,		 "%lld",   delim, 20, "lld", check_ll);
+	numbers_list_fix_width(test, long long,		 "%lld",   delim, 20, "lli", check_ll);
+	numbers_list_fix_width(test, unsigned long long, "%llx",   delim, 16, "llx", check_ull);
+	numbers_list_fix_width(test, unsigned long long, "0x%llx", delim, 18, "llx", check_ull);
+	numbers_list_fix_width(test, long long,		 "0x%llx", delim, 18, "lli", check_ll);
 }
 
-static void __init numbers_list_field_width_l(const char *delim)
+static void numbers_list_field_width_l(struct kunit *test, const char *delim)
 {
 #if BITS_PER_LONG == 64
-	numbers_list_fix_width(unsigned long,	"%lu",	     delim, 20, "lu", check_ulong);
-	numbers_list_fix_width(long,		"%ld",	     delim, 20, "ld", check_long);
-	numbers_list_fix_width(long,		"%ld",	     delim, 20, "li", check_long);
-	numbers_list_fix_width(unsigned long,	"%lx",	     delim, 16, "lx", check_ulong);
-	numbers_list_fix_width(unsigned long,	"0x%lx",     delim, 18, "lx", check_ulong);
-	numbers_list_fix_width(long,		"0x%lx",     delim, 18, "li", check_long);
+	numbers_list_fix_width(test, unsigned long, "%lu",   delim, 20,	"lu", check_ulong);
+	numbers_list_fix_width(test, long,	    "%ld",   delim, 20,	"ld", check_long);
+	numbers_list_fix_width(test, long,	    "%ld",   delim, 20,	"li", check_long);
+	numbers_list_fix_width(test, unsigned long, "%lx",   delim, 16,	"lx", check_ulong);
+	numbers_list_fix_width(test, unsigned long, "0x%lx", delim, 18,	"lx", check_ulong);
+	numbers_list_fix_width(test, long,	    "0x%lx", delim, 18,	"li", check_long);
 #else
-	numbers_list_fix_width(unsigned long,	"%lu",	     delim, 10, "lu", check_ulong);
-	numbers_list_fix_width(long,		"%ld",	     delim, 11, "ld", check_long);
-	numbers_list_fix_width(long,		"%ld",	     delim, 11, "li", check_long);
-	numbers_list_fix_width(unsigned long,	"%lx",	     delim, 8,  "lx", check_ulong);
-	numbers_list_fix_width(unsigned long,	"0x%lx",     delim, 10, "lx", check_ulong);
-	numbers_list_fix_width(long,		"0x%lx",     delim, 10, "li", check_long);
+	numbers_list_fix_width(test, unsigned long, "%lu",   delim, 10,	"lu", check_ulong);
+	numbers_list_fix_width(test, long,	    "%ld",   delim, 11,	"ld", check_long);
+	numbers_list_fix_width(test, long,	    "%ld",   delim, 11,	"li", check_long);
+	numbers_list_fix_width(test, unsigned long, "%lx",   delim, 8,	"lx", check_ulong);
+	numbers_list_fix_width(test, unsigned long, "0x%lx", delim, 10,	"lx", check_ulong);
+	numbers_list_fix_width(test, long,	    "0x%lx", delim, 10,	"li", check_long);
 #endif
 }
 
-static void __init numbers_list_field_width_d(const char *delim)
+static void numbers_list_field_width_d(struct kunit *test, const char *delim)
 {
-	numbers_list_fix_width(unsigned int,	"%u",	     delim, 10, "u", check_uint);
-	numbers_list_fix_width(int,		"%d",	     delim, 11, "d", check_int);
-	numbers_list_fix_width(int,		"%d",	     delim, 11, "i", check_int);
-	numbers_list_fix_width(unsigned int,	"%x",	     delim, 8,  "x", check_uint);
-	numbers_list_fix_width(unsigned int,	"0x%x",	     delim, 10, "x", check_uint);
-	numbers_list_fix_width(int,		"0x%x",	     delim, 10, "i", check_int);
+	numbers_list_fix_width(test, unsigned int, "%u",   delim, 10, "u", check_uint);
+	numbers_list_fix_width(test, int,	   "%d",   delim, 11, "d", check_int);
+	numbers_list_fix_width(test, int,	   "%d",   delim, 11, "i", check_int);
+	numbers_list_fix_width(test, unsigned int, "%x",   delim, 8,  "x", check_uint);
+	numbers_list_fix_width(test, unsigned int, "0x%x", delim, 10, "x", check_uint);
+	numbers_list_fix_width(test, int,	   "0x%x", delim, 10, "i", check_int);
 }
 
-static void __init numbers_list_field_width_h(const char *delim)
+static void numbers_list_field_width_h(struct kunit *test, const char *delim)
 {
-	numbers_list_fix_width(unsigned short,	"%hu",	     delim, 5, "hu", check_ushort);
-	numbers_list_fix_width(short,		"%hd",	     delim, 6, "hd", check_short);
-	numbers_list_fix_width(short,		"%hd",	     delim, 6, "hi", check_short);
-	numbers_list_fix_width(unsigned short,	"%hx",	     delim, 4, "hx", check_ushort);
-	numbers_list_fix_width(unsigned short,	"0x%hx",     delim, 6, "hx", check_ushort);
-	numbers_list_fix_width(short,		"0x%hx",     delim, 6, "hi", check_short);
+	numbers_list_fix_width(test, unsigned short, "%hu",   delim, 5, "hu", check_ushort);
+	numbers_list_fix_width(test, short,	     "%hd",   delim, 6, "hd", check_short);
+	numbers_list_fix_width(test, short,	     "%hd",   delim, 6, "hi", check_short);
+	numbers_list_fix_width(test, unsigned short, "%hx",   delim, 4, "hx", check_ushort);
+	numbers_list_fix_width(test, unsigned short, "0x%hx", delim, 6, "hx", check_ushort);
+	numbers_list_fix_width(test, short,	     "0x%hx", delim, 6, "hi", check_short);
 }
 
-static void __init numbers_list_field_width_hh(const char *delim)
+static void numbers_list_field_width_hh(struct kunit *test, const char *delim)
 {
-	numbers_list_fix_width(unsigned char,	"%hhu",	     delim, 3, "hhu", check_uchar);
-	numbers_list_fix_width(signed char,	"%hhd",	     delim, 4, "hhd", check_char);
-	numbers_list_fix_width(signed char,	"%hhd",	     delim, 4, "hhi", check_char);
-	numbers_list_fix_width(unsigned char,	"%hhx",	     delim, 2, "hhx", check_uchar);
-	numbers_list_fix_width(unsigned char,	"0x%hhx",    delim, 4, "hhx", check_uchar);
-	numbers_list_fix_width(signed char,	"0x%hhx",    delim, 4, "hhi", check_char);
+	numbers_list_fix_width(test, unsigned char, "%hhu",   delim, 3, "hhu", check_uchar);
+	numbers_list_fix_width(test, signed char,   "%hhd",   delim, 4, "hhd", check_char);
+	numbers_list_fix_width(test, signed char,   "%hhd",   delim, 4, "hhi", check_char);
+	numbers_list_fix_width(test, unsigned char, "%hhx",   delim, 2, "hhx", check_uchar);
+	numbers_list_fix_width(test, unsigned char, "0x%hhx", delim, 4, "hhx", check_uchar);
+	numbers_list_fix_width(test, signed char,   "0x%hhx", delim, 4, "hhi", check_char);
 }
 
 /*
  * List of numbers separated by delim. Each field width specifier is the
  * maximum possible digits for the given type and base.
  */
-static void __init numbers_list_field_width_typemax(const char *delim)
+static void numbers_list_field_width_typemax(struct kunit *test, const char *delim)
 {
-	numbers_list_field_width_ll(delim);
-	numbers_list_field_width_l(delim);
-	numbers_list_field_width_d(delim);
-	numbers_list_field_width_h(delim);
-	numbers_list_field_width_hh(delim);
+	numbers_list_field_width_ll(test, delim);
+	numbers_list_field_width_l(test, delim);
+	numbers_list_field_width_d(test, delim);
+	numbers_list_field_width_h(test, delim);
+	numbers_list_field_width_hh(test, delim);
 }
 
-static void __init numbers_list_field_width_val_ll(const char *delim)
+static void numbers_list_field_width_val_ll(struct kunit *test, const char *delim)
 {
-	numbers_list_val_width(unsigned long long, "%llu",   delim, "llu", check_ull);
-	numbers_list_val_width(long long,	   "%lld",   delim, "lld", check_ll);
-	numbers_list_val_width(long long,	   "%lld",   delim, "lli", check_ll);
-	numbers_list_val_width(unsigned long long, "%llx",   delim, "llx", check_ull);
-	numbers_list_val_width(unsigned long long, "0x%llx", delim, "llx", check_ull);
-	numbers_list_val_width(long long,	   "0x%llx", delim, "lli", check_ll);
+	numbers_list_val_width(test, unsigned long long, "%llu",   delim, "llu", check_ull);
+	numbers_list_val_width(test, long long,		 "%lld",   delim, "lld", check_ll);
+	numbers_list_val_width(test, long long,		 "%lld",   delim, "lli", check_ll);
+	numbers_list_val_width(test, unsigned long long, "%llx",   delim, "llx", check_ull);
+	numbers_list_val_width(test, unsigned long long, "0x%llx", delim, "llx", check_ull);
+	numbers_list_val_width(test, long long,		 "0x%llx", delim, "lli", check_ll);
 }
 
-static void __init numbers_list_field_width_val_l(const char *delim)
+static void numbers_list_field_width_val_l(struct kunit *test, const char *delim)
 {
-	numbers_list_val_width(unsigned long,	"%lu",	     delim, "lu", check_ulong);
-	numbers_list_val_width(long,		"%ld",	     delim, "ld", check_long);
-	numbers_list_val_width(long,		"%ld",	     delim, "li", check_long);
-	numbers_list_val_width(unsigned long,	"%lx",	     delim, "lx", check_ulong);
-	numbers_list_val_width(unsigned long,	"0x%lx",     delim, "lx", check_ulong);
-	numbers_list_val_width(long,		"0x%lx",     delim, "li", check_long);
+	numbers_list_val_width(test, unsigned long, "%lu",   delim, "lu", check_ulong);
+	numbers_list_val_width(test, long,	    "%ld",   delim, "ld", check_long);
+	numbers_list_val_width(test, long,	    "%ld",   delim, "li", check_long);
+	numbers_list_val_width(test, unsigned long, "%lx",   delim, "lx", check_ulong);
+	numbers_list_val_width(test, unsigned long, "0x%lx", delim, "lx", check_ulong);
+	numbers_list_val_width(test, long,	    "0x%lx", delim, "li", check_long);
 }
 
-static void __init numbers_list_field_width_val_d(const char *delim)
+static void numbers_list_field_width_val_d(struct kunit *test, const char *delim)
 {
-	numbers_list_val_width(unsigned int,	"%u",	     delim, "u", check_uint);
-	numbers_list_val_width(int,		"%d",	     delim, "d", check_int);
-	numbers_list_val_width(int,		"%d",	     delim, "i", check_int);
-	numbers_list_val_width(unsigned int,	"%x",	     delim, "x", check_uint);
-	numbers_list_val_width(unsigned int,	"0x%x",	     delim, "x", check_uint);
-	numbers_list_val_width(int,		"0x%x",	     delim, "i", check_int);
+	numbers_list_val_width(test, unsigned int, "%u",   delim, "u", check_uint);
+	numbers_list_val_width(test, int,	   "%d",   delim, "d", check_int);
+	numbers_list_val_width(test, int,	   "%d",   delim, "i", check_int);
+	numbers_list_val_width(test, unsigned int, "%x",   delim, "x", check_uint);
+	numbers_list_val_width(test, unsigned int, "0x%x", delim, "x", check_uint);
+	numbers_list_val_width(test, int,	   "0x%x", delim, "i", check_int);
 }
 
-static void __init numbers_list_field_width_val_h(const char *delim)
+static void numbers_list_field_width_val_h(struct kunit *test, const char *delim)
 {
-	numbers_list_val_width(unsigned short,	"%hu",	     delim, "hu", check_ushort);
-	numbers_list_val_width(short,		"%hd",	     delim, "hd", check_short);
-	numbers_list_val_width(short,		"%hd",	     delim, "hi", check_short);
-	numbers_list_val_width(unsigned short,	"%hx",	     delim, "hx", check_ushort);
-	numbers_list_val_width(unsigned short,	"0x%hx",     delim, "hx", check_ushort);
-	numbers_list_val_width(short,		"0x%hx",     delim, "hi", check_short);
+	numbers_list_val_width(test, unsigned short, "%hu",   delim, "hu", check_ushort);
+	numbers_list_val_width(test, short,	     "%hd",   delim, "hd", check_short);
+	numbers_list_val_width(test, short,	     "%hd",   delim, "hi", check_short);
+	numbers_list_val_width(test, unsigned short, "%hx",   delim, "hx", check_ushort);
+	numbers_list_val_width(test, unsigned short, "0x%hx", delim, "hx", check_ushort);
+	numbers_list_val_width(test, short,	     "0x%hx", delim, "hi", check_short);
 }
 
-static void __init numbers_list_field_width_val_hh(const char *delim)
+static void numbers_list_field_width_val_hh(struct kunit *test, const char *delim)
 {
-	numbers_list_val_width(unsigned char,	"%hhu",	     delim, "hhu", check_uchar);
-	numbers_list_val_width(signed char,	"%hhd",	     delim, "hhd", check_char);
-	numbers_list_val_width(signed char,	"%hhd",	     delim, "hhi", check_char);
-	numbers_list_val_width(unsigned char,	"%hhx",	     delim, "hhx", check_uchar);
-	numbers_list_val_width(unsigned char,	"0x%hhx",    delim, "hhx", check_uchar);
-	numbers_list_val_width(signed char,	"0x%hhx",    delim, "hhi", check_char);
+	numbers_list_val_width(test, unsigned char, "%hhu",   delim, "hhu", check_uchar);
+	numbers_list_val_width(test, signed char,   "%hhd",   delim, "hhd", check_char);
+	numbers_list_val_width(test, signed char,   "%hhd",   delim, "hhi", check_char);
+	numbers_list_val_width(test, unsigned char, "%hhx",   delim, "hhx", check_uchar);
+	numbers_list_val_width(test, unsigned char, "0x%hhx", delim, "hhx", check_uchar);
+	numbers_list_val_width(test, signed char,   "0x%hhx", delim, "hhi", check_char);
 }
 
 /*
  * List of numbers separated by delim. Each field width specifier is the
  * exact length of the corresponding value digits in the string being scanned.
  */
-static void __init numbers_list_field_width_val_width(const char *delim)
+static void numbers_list_field_width_val_width(struct kunit *test, const char *delim)
 {
-	numbers_list_field_width_val_ll(delim);
-	numbers_list_field_width_val_l(delim);
-	numbers_list_field_width_val_d(delim);
-	numbers_list_field_width_val_h(delim);
-	numbers_list_field_width_val_hh(delim);
+	numbers_list_field_width_val_ll(test, delim);
+	numbers_list_field_width_val_l(test, delim);
+	numbers_list_field_width_val_d(test, delim);
+	numbers_list_field_width_val_h(test, delim);
+	numbers_list_field_width_val_hh(test, delim);
 }
 
 /*
@@ -598,67 +573,67 @@ static void __init numbers_list_field_width_val_width(const char *delim)
  * of digits. For example the hex values c0,3,bf01,303 would have a
  * string representation of "c03bf01303" and extracted with "%2x%1x%4x%3x".
  */
-static void __init numbers_slice(void)
+static void numbers_slice(struct kunit *test)
 {
-	numbers_list_field_width_val_width("");
+	numbers_list_field_width_val_width(test, "");
 }
 
-#define test_number_prefix(T, str, scan_fmt, expect0, expect1, n_args, fn)	\
+#define test_number_prefix(test, T, str, scan_fmt, expect0, expect1, n_args, fn)\
 do {										\
 	const T expect[2] = { expect0, expect1 };				\
 	T result[2] = { (T)~expect[0], (T)~expect[1] };				\
 										\
-	_test(fn, &expect, str, scan_fmt, n_args, &result[0], &result[1]);	\
+	_test(test, fn, &expect, str, scan_fmt, n_args, &result[0], &result[1]);\
 } while (0)
 
 /*
  * Number prefix is >= field width.
  * Expected behaviour is derived from testing userland sscanf.
  */
-static void __init numbers_prefix_overflow(void)
+static void numbers_prefix_overflow(struct kunit *test)
 {
 	/*
 	 * Negative decimal with a field of width 1, should quit scanning
 	 * and return 0.
 	 */
-	test_number_prefix(long long,	"-1 1", "%1lld %lld",	0, 0, 0, check_ll);
-	test_number_prefix(long,	"-1 1", "%1ld %ld",	0, 0, 0, check_long);
-	test_number_prefix(int,		"-1 1", "%1d %d",	0, 0, 0, check_int);
-	test_number_prefix(short,	"-1 1", "%1hd %hd",	0, 0, 0, check_short);
-	test_number_prefix(signed char,	"-1 1", "%1hhd %hhd",	0, 0, 0, check_char);
-
-	test_number_prefix(long long,	"-1 1", "%1lli %lli",	0, 0, 0, check_ll);
-	test_number_prefix(long,	"-1 1", "%1li %li",	0, 0, 0, check_long);
-	test_number_prefix(int,		"-1 1", "%1i %i",	0, 0, 0, check_int);
-	test_number_prefix(short,	"-1 1", "%1hi %hi",	0, 0, 0, check_short);
-	test_number_prefix(signed char,	"-1 1", "%1hhi %hhi",	0, 0, 0, check_char);
+	test_number_prefix(test, long long,	"-1 1", "%1lld %lld",	0, 0, 0, check_ll);
+	test_number_prefix(test, long,		"-1 1", "%1ld %ld",	0, 0, 0, check_long);
+	test_number_prefix(test, int,		"-1 1", "%1d %d",	0, 0, 0, check_int);
+	test_number_prefix(test, short,		"-1 1", "%1hd %hd",	0, 0, 0, check_short);
+	test_number_prefix(test, signed char,	"-1 1", "%1hhd %hhd",	0, 0, 0, check_char);
+
+	test_number_prefix(test, long long,	"-1 1", "%1lli %lli",	0, 0, 0, check_ll);
+	test_number_prefix(test, long,		"-1 1", "%1li %li",	0, 0, 0, check_long);
+	test_number_prefix(test, int,		"-1 1", "%1i %i",	0, 0, 0, check_int);
+	test_number_prefix(test, short,		"-1 1", "%1hi %hi",	0, 0, 0, check_short);
+	test_number_prefix(test, signed char,	"-1 1", "%1hhi %hhi",	0, 0, 0, check_char);
 
 	/*
 	 * 0x prefix in a field of width 1: 0 is a valid digit so should
 	 * convert. Next field scan starts at the 'x' which isn't a digit so
 	 * scan quits with one field converted.
 	 */
-	test_number_prefix(unsigned long long,	"0xA7", "%1llx%llx", 0, 0, 1, check_ull);
-	test_number_prefix(unsigned long,	"0xA7", "%1lx%lx",   0, 0, 1, check_ulong);
-	test_number_prefix(unsigned int,	"0xA7", "%1x%x",     0, 0, 1, check_uint);
-	test_number_prefix(unsigned short,	"0xA7", "%1hx%hx",   0, 0, 1, check_ushort);
-	test_number_prefix(unsigned char,	"0xA7", "%1hhx%hhx", 0, 0, 1, check_uchar);
-	test_number_prefix(long long,		"0xA7", "%1lli%llx", 0, 0, 1, check_ll);
-	test_number_prefix(long,		"0xA7", "%1li%lx",   0, 0, 1, check_long);
-	test_number_prefix(int,			"0xA7", "%1i%x",     0, 0, 1, check_int);
-	test_number_prefix(short,		"0xA7", "%1hi%hx",   0, 0, 1, check_short);
-	test_number_prefix(char,		"0xA7", "%1hhi%hhx", 0, 0, 1, check_char);
+	test_number_prefix(test, unsigned long long, "0xA7", "%1llx%llx", 0, 0, 1, check_ull);
+	test_number_prefix(test, unsigned long,	     "0xA7", "%1lx%lx",   0, 0, 1, check_ulong);
+	test_number_prefix(test, unsigned int,	     "0xA7", "%1x%x",     0, 0, 1, check_uint);
+	test_number_prefix(test, unsigned short,     "0xA7", "%1hx%hx",   0, 0, 1, check_ushort);
+	test_number_prefix(test, unsigned char,	     "0xA7", "%1hhx%hhx", 0, 0, 1, check_uchar);
+	test_number_prefix(test, long long,	     "0xA7", "%1lli%llx", 0, 0, 1, check_ll);
+	test_number_prefix(test, long,		     "0xA7", "%1li%lx",   0, 0, 1, check_long);
+	test_number_prefix(test, int,		     "0xA7", "%1i%x",     0, 0, 1, check_int);
+	test_number_prefix(test, short,		     "0xA7", "%1hi%hx",   0, 0, 1, check_short);
+	test_number_prefix(test, char,		     "0xA7", "%1hhi%hhx", 0, 0, 1, check_char);
 
 	/*
 	 * 0x prefix in a field of width 2 using %x conversion: first field
 	 * converts to 0. Next field scan starts at the character after "0x".
 	 * Both fields will convert.
 	 */
-	test_number_prefix(unsigned long long,	"0xA7", "%2llx%llx", 0, 0xa7, 2, check_ull);
-	test_number_prefix(unsigned long,	"0xA7", "%2lx%lx",   0, 0xa7, 2, check_ulong);
-	test_number_prefix(unsigned int,	"0xA7", "%2x%x",     0, 0xa7, 2, check_uint);
-	test_number_prefix(unsigned short,	"0xA7", "%2hx%hx",   0, 0xa7, 2, check_ushort);
-	test_number_prefix(unsigned char,	"0xA7", "%2hhx%hhx", 0, 0xa7, 2, check_uchar);
+	test_number_prefix(test, unsigned long long, "0xA7", "%2llx%llx", 0, 0xa7, 2, check_ull);
+	test_number_prefix(test, unsigned long,	     "0xA7", "%2lx%lx",	  0, 0xa7, 2, check_ulong);
+	test_number_prefix(test, unsigned int,	     "0xA7", "%2x%x",	  0, 0xa7, 2, check_uint);
+	test_number_prefix(test, unsigned short,     "0xA7", "%2hx%hx",	  0, 0xa7, 2, check_ushort);
+	test_number_prefix(test, unsigned char,	     "0xA7", "%2hhx%hhx", 0, 0xa7, 2, check_uchar);
 
 	/*
 	 * 0x prefix in a field of width 2 using %i conversion: first field
@@ -666,124 +641,112 @@ static void __init numbers_prefix_overflow(void)
 	 * which will convert if can be interpreted as decimal but will fail
 	 * if it contains any hex digits (since no 0x prefix).
 	 */
-	test_number_prefix(long long,	"0x67", "%2lli%lli", 0, 67, 2, check_ll);
-	test_number_prefix(long,	"0x67", "%2li%li",   0, 67, 2, check_long);
-	test_number_prefix(int,		"0x67", "%2i%i",     0, 67, 2, check_int);
-	test_number_prefix(short,	"0x67", "%2hi%hi",   0, 67, 2, check_short);
-	test_number_prefix(char,	"0x67", "%2hhi%hhi", 0, 67, 2, check_char);
-
-	test_number_prefix(long long,	"0xA7", "%2lli%lli", 0, 0,  1, check_ll);
-	test_number_prefix(long,	"0xA7", "%2li%li",   0, 0,  1, check_long);
-	test_number_prefix(int,		"0xA7", "%2i%i",     0, 0,  1, check_int);
-	test_number_prefix(short,	"0xA7", "%2hi%hi",   0, 0,  1, check_short);
-	test_number_prefix(char,	"0xA7", "%2hhi%hhi", 0, 0,  1, check_char);
-}
-
-#define _test_simple_strtoxx(T, fn, gen_fmt, expect, base)			\
-do {										\
-	T got;									\
-	char *endp;								\
-	int len;								\
-	bool fail = false;							\
-										\
-	total_tests++;								\
-	len = snprintf(test_buffer, BUF_SIZE, gen_fmt, expect);			\
-	got = (fn)(test_buffer, &endp, base);					\
-	pr_debug(#fn "(\"%s\", %d) -> " gen_fmt "\n", test_buffer, base, got);	\
-	if (got != (expect)) {							\
-		fail = true;							\
-		pr_warn(#fn "(\"%s\", %d): got " gen_fmt " expected " gen_fmt "\n", \
-			test_buffer, base, got, expect);			\
-	} else if (endp != test_buffer + len) {					\
-		fail = true;							\
-		pr_warn(#fn "(\"%s\", %d) startp=0x%px got endp=0x%px expected 0x%px\n", \
-			test_buffer, base, test_buffer,				\
-			test_buffer + len, endp);				\
-	}									\
-										\
-	if (fail)								\
-		failed_tests++;							\
+	test_number_prefix(test, long long,	"0x67", "%2lli%lli",	0, 67, 2, check_ll);
+	test_number_prefix(test, long,		"0x67", "%2li%li",	0, 67, 2, check_long);
+	test_number_prefix(test, int,		"0x67", "%2i%i",	0, 67, 2, check_int);
+	test_number_prefix(test, short,		"0x67", "%2hi%hi",	0, 67, 2, check_short);
+	test_number_prefix(test, char,		"0x67", "%2hhi%hhi",	0, 67, 2, check_char);
+
+	test_number_prefix(test, long long,	"0xA7", "%2lli%lli",	0, 0,  1, check_ll);
+	test_number_prefix(test, long,		"0xA7", "%2li%li",	0, 0,  1, check_long);
+	test_number_prefix(test, int,		"0xA7", "%2i%i",	0, 0,  1, check_int);
+	test_number_prefix(test, short,		"0xA7", "%2hi%hi",	0, 0,  1, check_short);
+	test_number_prefix(test, char,		"0xA7", "%2hhi%hhi",	0, 0,  1, check_char);
+}
+
+#define _test_simple_strtoxx(test, T, fn, gen_fmt, expect, base)			\
+do {											\
+	T got;										\
+	char *endp;									\
+	int len;									\
+											\
+	len = snprintf(test_buffer, BUF_SIZE, gen_fmt, expect);				\
+	got = (fn)(test_buffer, &endp, base);						\
+	pr_debug(#fn "(\"%s\", %d) -> " gen_fmt "\n", test_buffer, base, got);		\
+	KUNIT_EXPECT_EQ_MSG(test, got, expect, #fn "(\"%s\", %d)", test_buffer, base);	\
+	KUNIT_EXPECT_PTR_EQ_MSG(test, endp, test_buffer + len,				\
+				#fn "(\"%s\", %d)", test_buffer, base);			\
 } while (0)
 
-#define test_simple_strtoxx(T, fn, gen_fmt, base)				\
+#define test_simple_strtoxx(test, T, fn, gen_fmt, base)				\
 do {										\
 	int i;									\
 										\
 	for (i = 0; i < ARRAY_SIZE(numbers); i++) {				\
-		_test_simple_strtoxx(T, fn, gen_fmt, (T)numbers[i], base);	\
+		_test_simple_strtoxx(test, T, fn, gen_fmt, (T)numbers[i], base);\
 										\
 		if (is_signed_type(T))						\
-			_test_simple_strtoxx(T, fn, gen_fmt,			\
+			_test_simple_strtoxx(test, T, fn, gen_fmt,		\
 					      -(T)numbers[i], base);		\
 	}									\
 } while (0)
 
-static void __init test_simple_strtoull(void)
+static void test_simple_strtoull(struct kunit *test)
 {
-	test_simple_strtoxx(unsigned long long, simple_strtoull, "%llu",   10);
-	test_simple_strtoxx(unsigned long long, simple_strtoull, "%llu",   0);
-	test_simple_strtoxx(unsigned long long, simple_strtoull, "%llx",   16);
-	test_simple_strtoxx(unsigned long long, simple_strtoull, "0x%llx", 16);
-	test_simple_strtoxx(unsigned long long, simple_strtoull, "0x%llx", 0);
+	test_simple_strtoxx(test, unsigned long long, simple_strtoull, "%llu",		10);
+	test_simple_strtoxx(test, unsigned long long, simple_strtoull, "%llu",		0);
+	test_simple_strtoxx(test, unsigned long long, simple_strtoull, "%llx",		16);
+	test_simple_strtoxx(test, unsigned long long, simple_strtoull, "0x%llx",	16);
+	test_simple_strtoxx(test, unsigned long long, simple_strtoull, "0x%llx",	0);
 }
 
-static void __init test_simple_strtoll(void)
+static void test_simple_strtoll(struct kunit *test)
 {
-	test_simple_strtoxx(long long, simple_strtoll, "%lld",	 10);
-	test_simple_strtoxx(long long, simple_strtoll, "%lld",	 0);
-	test_simple_strtoxx(long long, simple_strtoll, "%llx",	 16);
-	test_simple_strtoxx(long long, simple_strtoll, "0x%llx", 16);
-	test_simple_strtoxx(long long, simple_strtoll, "0x%llx", 0);
+	test_simple_strtoxx(test, long long, simple_strtoll, "%lld",	10);
+	test_simple_strtoxx(test, long long, simple_strtoll, "%lld",	0);
+	test_simple_strtoxx(test, long long, simple_strtoll, "%llx",	16);
+	test_simple_strtoxx(test, long long, simple_strtoll, "0x%llx",	16);
+	test_simple_strtoxx(test, long long, simple_strtoll, "0x%llx",	0);
 }
 
-static void __init test_simple_strtoul(void)
+static void test_simple_strtoul(struct kunit *test)
 {
-	test_simple_strtoxx(unsigned long, simple_strtoul, "%lu",   10);
-	test_simple_strtoxx(unsigned long, simple_strtoul, "%lu",   0);
-	test_simple_strtoxx(unsigned long, simple_strtoul, "%lx",   16);
-	test_simple_strtoxx(unsigned long, simple_strtoul, "0x%lx", 16);
-	test_simple_strtoxx(unsigned long, simple_strtoul, "0x%lx", 0);
+	test_simple_strtoxx(test, unsigned long, simple_strtoul, "%lu",		10);
+	test_simple_strtoxx(test, unsigned long, simple_strtoul, "%lu",		0);
+	test_simple_strtoxx(test, unsigned long, simple_strtoul, "%lx",		16);
+	test_simple_strtoxx(test, unsigned long, simple_strtoul, "0x%lx",	16);
+	test_simple_strtoxx(test, unsigned long, simple_strtoul, "0x%lx",	0);
 }
 
-static void __init test_simple_strtol(void)
+static void test_simple_strtol(struct kunit *test)
 {
-	test_simple_strtoxx(long, simple_strtol, "%ld",   10);
-	test_simple_strtoxx(long, simple_strtol, "%ld",   0);
-	test_simple_strtoxx(long, simple_strtol, "%lx",   16);
-	test_simple_strtoxx(long, simple_strtol, "0x%lx", 16);
-	test_simple_strtoxx(long, simple_strtol, "0x%lx", 0);
+	test_simple_strtoxx(test, long, simple_strtol, "%ld",	10);
+	test_simple_strtoxx(test, long, simple_strtol, "%ld",	0);
+	test_simple_strtoxx(test, long, simple_strtol, "%lx",	16);
+	test_simple_strtoxx(test, long, simple_strtol, "0x%lx",	16);
+	test_simple_strtoxx(test, long, simple_strtol, "0x%lx",	0);
 }
 
 /* Selection of common delimiters/separators between numbers in a string. */
-static const char * const number_delimiters[] __initconst = {
+static const char * const number_delimiters[] = {
 	" ", ":", ",", "-", "/",
 };
 
-static void __init test_numbers(void)
+static void test_numbers(struct kunit *test)
 {
 	int i;
 
 	/* String containing only one number. */
-	numbers_simple();
+	numbers_simple(test);
 
 	/* String with multiple numbers separated by delimiter. */
 	for (i = 0; i < ARRAY_SIZE(number_delimiters); i++) {
-		numbers_list(number_delimiters[i]);
+		numbers_list(test, number_delimiters[i]);
 
 		/* Field width may be longer than actual field digits. */
-		numbers_list_field_width_typemax(number_delimiters[i]);
+		numbers_list_field_width_typemax(test, number_delimiters[i]);
 
 		/* Each field width exactly length of actual field digits. */
-		numbers_list_field_width_val_width(number_delimiters[i]);
+		numbers_list_field_width_val_width(test, number_delimiters[i]);
 	}
 
 	/* Slice continuous sequence of digits using field widths. */
-	numbers_slice();
+	numbers_slice(test);
 
-	numbers_prefix_overflow();
+	numbers_prefix_overflow(test);
 }
 
-static void __init selftest(void)
+static void scanf_test(struct kunit *test)
 {
 	test_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
 	if (!test_buffer)
@@ -797,18 +760,29 @@ static void __init selftest(void)
 
 	prandom_seed_state(&rnd_state, 3141592653589793238ULL);
 
-	test_numbers();
+	test_numbers(test);
 
-	test_simple_strtoull();
-	test_simple_strtoll();
-	test_simple_strtoul();
-	test_simple_strtol();
+	test_simple_strtoull(test);
+	test_simple_strtoll(test);
+	test_simple_strtoul(test);
+	test_simple_strtol(test);
 
 	kfree(fmt_buffer);
 	kfree(test_buffer);
 }
 
-KSTM_MODULE_LOADERS(test_scanf);
+static struct kunit_case scanf_test_cases[] = {
+	KUNIT_CASE(scanf_test),
+	{}
+};
+
+static struct kunit_suite scanf_test_suite = {
+	.name = "scanf",
+	.test_cases = scanf_test_cases,
+};
+
+kunit_test_suite(scanf_test_suite);
+
 MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
 MODULE_DESCRIPTION("Test cases for sscanf facility");
 MODULE_LICENSE("GPL v2");
diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index c52fe3ad8e98..4afda556151f 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -4,5 +4,5 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh scanf.sh
+TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh
 include ../lib.mk
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index dc15aba8d0a3..80b55a504868 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -1,5 +1,4 @@
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_TEST_BITOPS=m
diff --git a/tools/testing/selftests/lib/scanf.sh b/tools/testing/selftests/lib/scanf.sh
deleted file mode 100755
index b59b8ba561c3..000000000000
--- a/tools/testing/selftests/lib/scanf.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# Tests the scanf infrastructure using test_scanf kernel module.
-$(dirname $0)/../kselftest/module.sh "scanf" test_scanf

-- 
2.48.1


