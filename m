Return-Path: <linux-kselftest+bounces-25989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A52A2C18F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 12:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7D41887BDA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CA91DF733;
	Fri,  7 Feb 2025 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLnADAb4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B31DF26E;
	Fri,  7 Feb 2025 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738927857; cv=none; b=Xg/gtaCIMNGClSD6Ea4PYiFizKt1BtdukgJiYraJI4orCUU2PAttAwYv8RAdORt9g7k88R9Cha+x4gbMO/ufRlzzwfMBz+Ex3z/5n5SwNj+pMAmEFpRirSD7Wasun9PIR+80yldjEVD7p5nA1V05UtChoCLVABWplQXY7LMwmuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738927857; c=relaxed/simple;
	bh=3RESUxNL2ovZBe2ovLbvmmW0GKblRCAZ39pzYRZrCT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fkmwdugKjERvvNqYDqqbHq7qiqgNpEx1vxi9sXxj4WYQmOddhTo1O3j3baYIN104YJwORB6quCWQDHss4DKs2SpYmjKrRecxfSfYbYzDIsjbYC5rTpAAUbeX1zejwwtCD9lPrEjbj3VSUZgTf+kJzwvIXfCMQzAi+IYf2JeU15c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLnADAb4; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6f0afda3fso227994085a.2;
        Fri, 07 Feb 2025 03:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738927854; x=1739532654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeWDH3aXmQAHpWsKn+4tlQJMRNB++S6mPaLYKG9YXUY=;
        b=fLnADAb4m62nPi2y7mtmRbt4Jie8pz+B172HTsAH2Fq4NBDE9K+dUsQsqk2ksDvUgO
         VD9y8AxiXEIwcgWyWvvaTrHfYBOckgpmatWRlPYarLsZDYO8KOBE2fOIR1VJMYt9SC7e
         DN/INgNqLDX8UJre+mv3/gcR2K70UTarPYFO6rn3CW3gh/8W6J4LxABy4qBXRzXkl0+z
         GNKIMcDszkuUJ+6xpzgiWnV6zWJX+970MsUvSpE1jCLBlKJVSJK8Gg4ON+yIhgj2co9z
         xmVEzQiTJ+oA+2mqeMAL58YnVJ+lf5KgAE7AWayfA5+AKUTR84aLFPujX6oP9ZaYDiNd
         OLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738927854; x=1739532654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeWDH3aXmQAHpWsKn+4tlQJMRNB++S6mPaLYKG9YXUY=;
        b=hatiee7LUNooHgq+mMGKWnVvHpzZVXZbPP9kWgVF3GABfKJ8z1OOd9gJ1YImW/6iyz
         A+jnER3uHGP5m8mzop+STaD9Z8CFPtLubmzB1ZP+gCrSZLPRDp0ULow0pM/XEJV+y7cf
         rpS8pLvvM/j9Gm7omwWgJXHcG+WZXt6cc5NY39cWHj241YYjHvpxxRfo61G4HmLjz9Df
         lkqQgFkktjizmdsSxfcM7cB6QO8uEn8XfTUPWNgmZc26S7gnRmAWRukU+jFxLMfauGkd
         V/t4m1Q9MyDbZiKeHHm/q+NRpkKg3faBqnf2RZQu5E96yqjz8wz5un5UkMQflc3tv6V+
         a9ng==
X-Forwarded-Encrypted: i=1; AJvYcCUq/RdFA92g9uRICgvBPkRMcg2FhvU79K5W32iZa2z5w/gAM2V6nmO0bWAKNm6iteqzy0xDUKik+Nptcv2h4/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxurxba9YxRO80LZdvHWJSv2ag0rlpifhpW9vBHguGBQZuSe22z
	nMQB6UbU0IWOnarFSkHjqtjPSR6hhbcjEQqhHJrwk/Am/xasvrnG
X-Gm-Gg: ASbGncsBswWbNPn6yDssKYw1Giqs4R7YSn6ZftYhuT7Uft8oFiOeNQ6SbFZRtOqRrIO
	7pZsseQ5ebx32Z994rXPNFqd5CNZmcmKDGIaUllOC8LIwyxKJ0N6W7N2EhsNi+6BLr6qoiYZZko
	++th2Dl5sRaDJ7FfbD/VuDxp4+DwviTbtKgsr9VTD/aoR9vRx1TaM9RnZFVng8geLWErT29HPEI
	4f8rpmRCu0pQTGle4z/+qspBBptasx/SgnYtWjgyAgbS1wJYFgvFRCAPOHu0EdSFNkoU+0lO9/P
	qibc2m0QmCYfNlmeSOdfbCGbkK1VikL93JwA
X-Google-Smtp-Source: AGHT+IHDsjqM9xR0IEaEM7yTKil9sZqSz7Y1CbY7rQfOnCjoBW6sROLN5y6/n0BfFzZ754h5UEZJ5A==
X-Received: by 2002:a05:620a:1a10:b0:7b6:dac1:cb80 with SMTP id af79cd13be357-7c047ca804amr460919885a.58.1738927852923;
        Fri, 07 Feb 2025 03:30:52 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:fb:aded:686f:8a03])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041ded0e7sm178507685a.8.2025.02.07.03.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 03:30:51 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Feb 2025 06:30:44 -0500
Subject: [PATCH v2 1/2] printf: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-printf-kunit-convert-v2-1-057b23860823@gmail.com>
References: <20250207-printf-kunit-convert-v2-0-057b23860823@gmail.com>
In-Reply-To: <20250207-printf-kunit-convert-v2-0-057b23860823@gmail.com>
To: Arpitha Raghunandan <98.arpi@gmail.com>, 
 David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: b4 0.15-dev

Convert the printf() self-test to a KUnit test.

In the interest of keeping the patch reasonably-sized this doesn't
refactor the tests into proper parameterized tests - it's all one big
test case.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Documentation/core-api/printk-formats.rst |   2 +-
 MAINTAINERS                               |   2 +-
 arch/m68k/configs/amiga_defconfig         |   1 -
 arch/m68k/configs/apollo_defconfig        |   1 -
 arch/m68k/configs/atari_defconfig         |   1 -
 arch/m68k/configs/bvme6000_defconfig      |   1 -
 arch/m68k/configs/hp300_defconfig         |   1 -
 arch/m68k/configs/mac_defconfig           |   1 -
 arch/m68k/configs/multi_defconfig         |   1 -
 arch/m68k/configs/mvme147_defconfig       |   1 -
 arch/m68k/configs/mvme16x_defconfig       |   1 -
 arch/m68k/configs/q40_defconfig           |   1 -
 arch/m68k/configs/sun3_defconfig          |   1 -
 arch/m68k/configs/sun3x_defconfig         |   1 -
 arch/powerpc/configs/ppc64_defconfig      |   1 -
 lib/Kconfig.debug                         |  20 +++-
 lib/Makefile                              |   2 +-
 lib/{test_printf.c => printf_kunit.c}     | 164 +++++++++++++++---------------
 tools/testing/selftests/lib/config        |   1 -
 tools/testing/selftests/lib/printf.sh     |   4 -
 20 files changed, 104 insertions(+), 104 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index ecccc0473da9..0d9461bd6964 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -661,7 +661,7 @@ Do *not* use it from C.
 Thanks
 ======
 
-If you add other %p extensions, please extend <lib/test_printf.c> with
+If you add other %p extensions, please extend <lib/printf_kunit.c> with
 one or more test cases, if at all feasible.
 
 Thank you for your cooperation and attention.
diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..57e366d356bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25368,7 +25368,7 @@ R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
 F:	Documentation/core-api/printk-formats.rst
-F:	lib/test_printf.c
+F:	lib/printf_kunit.c
 F:	lib/test_scanf.c
 F:	lib/vsprintf.c
 
diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index dbf2ea561c85..e8c5e08fb6ec 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -622,7 +622,6 @@ CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index b0fd199cc0a4..dcaddfc675de 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -579,7 +579,6 @@ CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index bb5b2d3b6c10..53a91c62d415 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -599,7 +599,6 @@ CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 8315a13bab73..ea2f84907c4e 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -571,7 +571,6 @@ CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 350370657e5f..7b1cc9f597bf 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -581,7 +581,6 @@ CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index f942b4755702..831695e766a8 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -598,7 +598,6 @@ CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index b1eaad02efab..901d8d357218 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -685,7 +685,6 @@ CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 6309a4442bb3..2212bb7877e2 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -571,7 +571,6 @@ CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 3feb0731f814..a87b455049e8 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -572,7 +572,6 @@ CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index ea04b1b0da7d..411e555c7e07 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -588,7 +588,6 @@ CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index f52d9af92153..e095fa159d05 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -568,7 +568,6 @@ CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index f348447824da..11eb37864ac6 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -569,7 +569,6 @@ CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
 CONFIG_TEST_HEXDUMP=m
 CONFIG_TEST_KSTRTOX=m
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 465eb96c755e..05018898d282 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -444,7 +444,6 @@ CONFIG_TEST_HEXDUMP=m
 CONFIG_STRING_SELFTEST=m
 CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_KSTRTOX=m
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..4834cac1eb8f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2427,6 +2427,23 @@ config ASYNC_RAID6_TEST
 config TEST_HEXDUMP
 	tristate "Test functions located in the hexdump module at runtime"
 
+config PRINTF_KUNIT_TEST
+	tristate "KUnit test printf() family of functions at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test the printf functions at boot.
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
@@ -2440,9 +2457,6 @@ config STRING_HELPERS_KUNIT_TEST
 config TEST_KSTRTOX
 	tristate "Test kstrto*() family of functions at runtime"
 
-config TEST_PRINTF
-	tristate "Test printf() family of functions at runtime"
-
 config TEST_SCANF
 	tristate "Test scanf() family of functions at runtime"
 
diff --git a/lib/Makefile b/lib/Makefile
index d5cfc7afbbb8..844665b1f0e7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -84,7 +84,7 @@ obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
-obj-$(CONFIG_TEST_PRINTF) += test_printf.o
+obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
 obj-$(CONFIG_TEST_SCANF) += test_scanf.o
 
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
diff --git a/lib/test_printf.c b/lib/printf_kunit.c
similarity index 89%
rename from lib/test_printf.c
rename to lib/printf_kunit.c
index 59dbe4f9a4cb..fe6f4df92dd5 100644
--- a/lib/test_printf.c
+++ b/lib/printf_kunit.c
@@ -5,7 +5,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/init.h>
+#include <kunit/test.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/printk.h>
@@ -25,8 +25,6 @@
 
 #include <linux/property.h>
 
-#include "../tools/testing/selftests/kselftest_module.h"
-
 #define BUF_SIZE 256
 #define PAD_SIZE 16
 #define FILL_CHAR '$'
@@ -37,72 +35,71 @@
 	block \
 	__diag_pop();
 
-KSTM_MODULE_GLOBALS();
+static char *test_buffer;
+static char *alloced_buffer;
+
+static struct kunit *kunittest;
 
-static char *test_buffer __initdata;
-static char *alloced_buffer __initdata;
+#define tc_fail(fmt, ...) \
+	KUNIT_FAIL(kunittest, fmt, ##__VA_ARGS__)
 
-static int __printf(4, 0) __init
+static void __printf(4, 0)
 do_test(int bufsize, const char *expect, int elen,
 	const char *fmt, va_list ap)
 {
 	va_list aq;
 	int ret, written;
 
-	total_tests++;
-
 	memset(alloced_buffer, FILL_CHAR, BUF_SIZE + 2*PAD_SIZE);
 	va_copy(aq, ap);
 	ret = vsnprintf(test_buffer, bufsize, fmt, aq);
 	va_end(aq);
 
 	if (ret != elen) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
+		tc_fail("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
 			bufsize, fmt, ret, elen);
-		return 1;
+		return;
 	}
 
 	if (memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE)) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote before buffer\n", bufsize, fmt);
-		return 1;
+		tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote before buffer\n", bufsize, fmt);
+		return;
 	}
 
 	if (!bufsize) {
 		if (memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE)) {
-			pr_warn("vsnprintf(buf, 0, \"%s\", ...) wrote to buffer\n",
+			tc_fail("vsnprintf(buf, 0, \"%s\", ...) wrote to buffer\n",
 				fmt);
-			return 1;
 		}
-		return 0;
+		return;
 	}
 
 	written = min(bufsize-1, elen);
 	if (test_buffer[written]) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer\n",
+		tc_fail("vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer\n",
 			bufsize, fmt);
-		return 1;
+		return;
 	}
 
 	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
+		tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
 			bufsize, fmt);
-		return 1;
+		return;
 	}
 
 	if (memchr_inv(test_buffer + bufsize, FILL_CHAR, BUF_SIZE + PAD_SIZE - bufsize)) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer\n", bufsize, fmt);
-		return 1;
+		tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer\n", bufsize, fmt);
+		return;
 	}
 
 	if (memcmp(test_buffer, expect, written)) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
+		tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
 			bufsize, fmt, test_buffer, written, expect);
-		return 1;
+		return;
 	}
-	return 0;
 }
 
-static void __printf(3, 4) __init
+static void __printf(3, 4)
 __test(const char *expect, int elen, const char *fmt, ...)
 {
 	va_list ap;
@@ -110,9 +107,8 @@ __test(const char *expect, int elen, const char *fmt, ...)
 	char *p;
 
 	if (elen >= BUF_SIZE) {
-		pr_err("error in test suite: expected output length %d too long. Format was '%s'.\n",
-		       elen, fmt);
-		failed_tests++;
+		tc_fail("error in test suite: expected output length %d too long. Format was '%s'.\n",
+			elen, fmt);
 		return;
 	}
 
@@ -124,19 +120,17 @@ __test(const char *expect, int elen, const char *fmt, ...)
 	 * enough and 0), and then we also test that kvasprintf would
 	 * be able to print it as expected.
 	 */
-	failed_tests += do_test(BUF_SIZE, expect, elen, fmt, ap);
+	do_test(BUF_SIZE, expect, elen, fmt, ap);
 	rand = get_random_u32_inclusive(1, elen + 1);
 	/* Since elen < BUF_SIZE, we have 1 <= rand <= BUF_SIZE. */
-	failed_tests += do_test(rand, expect, elen, fmt, ap);
-	failed_tests += do_test(0, expect, elen, fmt, ap);
+	do_test(rand, expect, elen, fmt, ap);
+	do_test(0, expect, elen, fmt, ap);
 
 	p = kvasprintf(GFP_KERNEL, fmt, ap);
 	if (p) {
-		total_tests++;
 		if (memcmp(p, expect, elen+1)) {
-			pr_warn("kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'\n",
+			tc_fail("kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'\n",
 				fmt, p, expect);
-			failed_tests++;
 		}
 		kfree(p);
 	}
@@ -146,7 +140,7 @@ __test(const char *expect, int elen, const char *fmt, ...)
 #define test(expect, fmt, ...)					\
 	__test(expect, strlen(expect), fmt, ##__VA_ARGS__)
 
-static void __init
+static void
 test_basic(void)
 {
 	/* Work around annoying "warning: zero-length gnu_printf format string". */
@@ -158,7 +152,7 @@ test_basic(void)
 	__test("xxx\0yyy", 7, "xxx%cyyy", '\0');
 }
 
-static void __init
+static void
 test_number(void)
 {
 	test("0x1234abcd  ", "%#-12x", 0x1234abcd);
@@ -180,7 +174,7 @@ test_number(void)
 	test("00|0|0|0|0", "%.2d|%.1d|%.0d|%.*d|%1.0d", 0, 0, 0, 0, 0, 0);
 }
 
-static void __init
+static void
 test_string(void)
 {
 	test("", "%s%.0s", "", "123");
@@ -218,7 +212,7 @@ test_string(void)
 #define ZEROS "00000000"	/* hex 32 zero bits */
 #define ONES "ffffffff"		/* hex 32 one bits */
 
-static int __init
+static int
 plain_format(void)
 {
 	char buf[PLAIN_BUF_SIZE];
@@ -250,7 +244,7 @@ plain_format(void)
 #define ZEROS ""
 #define ONES ""
 
-static int __init
+static int
 plain_format(void)
 {
 	/* Format is implicitly tested for 32 bit machines by plain_hash() */
@@ -259,7 +253,7 @@ plain_format(void)
 
 #endif	/* BITS_PER_LONG == 64 */
 
-static int __init
+static int
 plain_hash_to_buffer(const void *p, char *buf, size_t len)
 {
 	int nchars;
@@ -278,7 +272,7 @@ plain_hash_to_buffer(const void *p, char *buf, size_t len)
 	return 0;
 }
 
-static int __init
+static int
 plain_hash(void)
 {
 	char buf[PLAIN_BUF_SIZE];
@@ -298,32 +292,29 @@ plain_hash(void)
  * We can't use test() to test %p because we don't know what output to expect
  * after an address is hashed.
  */
-static void __init
+static void
 plain(void)
 {
 	int err;
 
 	if (no_hash_pointers) {
 		pr_warn("skipping plain 'p' tests");
-		skipped_tests += 2;
 		return;
 	}
 
 	err = plain_hash();
 	if (err) {
-		pr_warn("plain 'p' does not appear to be hashed\n");
-		failed_tests++;
+		tc_fail("plain 'p' does not appear to be hashed\n");
 		return;
 	}
 
 	err = plain_format();
 	if (err) {
-		pr_warn("hashing plain 'p' has unexpected format\n");
-		failed_tests++;
+		tc_fail("hashing plain 'p' has unexpected format\n");
 	}
 }
 
-static void __init
+static void
 test_hashed(const char *fmt, const void *p)
 {
 	char buf[PLAIN_BUF_SIZE];
@@ -343,7 +334,7 @@ test_hashed(const char *fmt, const void *p)
 /*
  * NULL pointers aren't hashed.
  */
-static void __init
+static void
 null_pointer(void)
 {
 	test(ZEROS "00000000", "%p", NULL);
@@ -354,7 +345,7 @@ null_pointer(void)
 /*
  * Error pointers aren't hashed.
  */
-static void __init
+static void
 error_pointer(void)
 {
 	test(ONES "fffffff5", "%p", ERR_PTR(-11));
@@ -364,7 +355,7 @@ error_pointer(void)
 
 #define PTR_INVALID ((void *)0x000000ab)
 
-static void __init
+static void
 invalid_pointer(void)
 {
 	test_hashed("%p", PTR_INVALID);
@@ -372,18 +363,18 @@ invalid_pointer(void)
 	test("(efault)", "%pE", PTR_INVALID);
 }
 
-static void __init
+static void
 symbol_ptr(void)
 {
 }
 
-static void __init
+static void
 kernel_ptr(void)
 {
 	/* We can't test this without access to kptr_restrict. */
 }
 
-static void __init
+static void
 struct_resource(void)
 {
 	struct resource test_resource = {
@@ -432,7 +423,7 @@ struct_resource(void)
 	     "%pR", &test_resource);
 }
 
-static void __init
+static void
 struct_range(void)
 {
 	struct range test_range = DEFINE_RANGE(0xc0ffee00ba5eba11,
@@ -448,17 +439,17 @@ struct_range(void)
 	     "%pra", &test_range);
 }
 
-static void __init
+static void
 addr(void)
 {
 }
 
-static void __init
+static void
 escaped_str(void)
 {
 }
 
-static void __init
+static void
 hex_string(void)
 {
 	const char buf[3] = {0xc0, 0xff, 0xee};
@@ -469,7 +460,7 @@ hex_string(void)
 	     "%*ph|%*phC|%*phD|%*phN", 3, buf, 3, buf, 3, buf, 3, buf);
 }
 
-static void __init
+static void
 mac(void)
 {
 	const u8 addr[6] = {0x2d, 0x48, 0xd6, 0xfc, 0x7a, 0x05};
@@ -481,7 +472,7 @@ mac(void)
 	test("057afcd6482d", "%pmR", addr);
 }
 
-static void __init
+static void
 ip4(void)
 {
 	struct sockaddr_in sa;
@@ -496,19 +487,19 @@ ip4(void)
 	test("001.002.003.004:12345|1.2.3.4:12345", "%piSp|%pISp", &sa, &sa);
 }
 
-static void __init
+static void
 ip6(void)
 {
 }
 
-static void __init
+static void
 ip(void)
 {
 	ip4();
 	ip6();
 }
 
-static void __init
+static void
 uuid(void)
 {
 	const char uuid[16] = {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
@@ -520,7 +511,7 @@ uuid(void)
 	test("03020100-0504-0706-0809-0A0B0C0D0E0F", "%pUL", uuid);
 }
 
-static struct dentry test_dentry[4] __initdata = {
+static struct dentry test_dentry[4] = {
 	{ .d_parent = &test_dentry[0],
 	  .d_name = QSTR_INIT(test_dentry[0].d_iname, 3),
 	  .d_iname = "foo" },
@@ -535,7 +526,7 @@ static struct dentry test_dentry[4] __initdata = {
 	  .d_iname = "romeo" },
 };
 
-static void __init
+static void
 dentry(void)
 {
 	test("foo", "%pd", &test_dentry[0]);
@@ -556,12 +547,12 @@ dentry(void)
 	test("  bravo/alfa|  bravo/alfa", "%12pd2|%*pd2", &test_dentry[2], 12, &test_dentry[2]);
 }
 
-static void __init
+static void
 struct_va_format(void)
 {
 }
 
-static void __init
+static void
 time_and_date(void)
 {
 	/* 1543210543 */
@@ -595,12 +586,12 @@ time_and_date(void)
 	test("15:32:23|0119-00-04", "%ptTtrs|%ptTdrs", &t, &t);
 }
 
-static void __init
+static void
 struct_clk(void)
 {
 }
 
-static void __init
+static void
 large_bitmap(void)
 {
 	const int nbits = 1 << 16;
@@ -614,7 +605,7 @@ large_bitmap(void)
 	bitmap_free(bits);
 }
 
-static void __init
+static void
 bitmap(void)
 {
 	DECLARE_BITMAP(bits, 20);
@@ -637,7 +628,7 @@ bitmap(void)
 	large_bitmap();
 }
 
-static void __init
+static void
 netdev_features(void)
 {
 }
@@ -663,7 +654,7 @@ static const struct page_flags_test pft[] = {
 	 "%#x", "kasantag"},
 };
 
-static void __init
+static void
 page_flags_test(int section, int node, int zone, int last_cpupid,
 		int kasan_tag, unsigned long flags, const char *name,
 		char *cmp_buf)
@@ -701,7 +692,7 @@ page_flags_test(int section, int node, int zone, int last_cpupid,
 	test(cmp_buf, "%pGp", &flags);
 }
 
-static void __init
+static void
 flags(void)
 {
 	unsigned long flags;
@@ -749,7 +740,7 @@ flags(void)
 	kfree(cmp_buffer);
 }
 
-static void __init fwnode_pointer(void)
+static void fwnode_pointer(void)
 {
 	const struct software_node first = { .name = "first" };
 	const struct software_node second = { .name = "second", .parent = &first };
@@ -776,7 +767,7 @@ static void __init fwnode_pointer(void)
 	software_node_unregister_node_group(group);
 }
 
-static void __init fourcc_pointer(void)
+static void fourcc_pointer(void)
 {
 	struct {
 		u32 code;
@@ -793,7 +784,7 @@ static void __init fourcc_pointer(void)
 		test(try[i].str, "%p4cc", &try[i].code);
 }
 
-static void __init
+static void
 errptr(void)
 {
 	test("-1234", "%pe", ERR_PTR(-1234));
@@ -813,7 +804,7 @@ errptr(void)
 #endif
 }
 
-static void __init
+static void
 test_pointer(void)
 {
 	plain();
@@ -842,13 +833,15 @@ test_pointer(void)
 	fourcc_pointer();
 }
 
-static void __init selftest(void)
+static void printf_test(struct kunit *test)
 {
 	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
 	if (!alloced_buffer)
 		return;
 	test_buffer = alloced_buffer + PAD_SIZE;
 
+	kunittest = test;
+
 	test_basic();
 	test_number();
 	test_string();
@@ -857,7 +850,18 @@ static void __init selftest(void)
 	kfree(alloced_buffer);
 }
 
-KSTM_MODULE_LOADERS(test_printf);
+static struct kunit_case printf_test_cases[] = {
+	KUNIT_CASE(printf_test),
+	{}
+};
+
+static struct kunit_suite printf_test_suite = {
+	.name = "printf",
+	.test_cases = printf_test_cases,
+};
+
+kunit_test_suite(printf_test_suite);
+
 MODULE_AUTHOR("Rasmus Villemoes <linux@rasmusvillemoes.dk>");
 MODULE_DESCRIPTION("Test cases for printf facility");
 MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index dc15aba8d0a3..0a63594177c2 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -1,4 +1,3 @@
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
diff --git a/tools/testing/selftests/lib/printf.sh b/tools/testing/selftests/lib/printf.sh
deleted file mode 100755
index 05f4544e87f9..000000000000
--- a/tools/testing/selftests/lib/printf.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# Tests the printf infrastructure using test_printf kernel module.
-$(dirname $0)/../kselftest/module.sh "printf" test_printf

-- 
2.48.1


