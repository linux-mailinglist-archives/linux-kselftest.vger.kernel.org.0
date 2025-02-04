Return-Path: <linux-kselftest+bounces-25735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140D8A27B64
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7458A3A2356
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4B7217704;
	Tue,  4 Feb 2025 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhekyjAH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B42E204F6C;
	Tue,  4 Feb 2025 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697818; cv=none; b=mHKr8GMROZJ5chWJPqSnJA6wy4fT+fz8jKPFryKkK1reCi6fSv5I1wKOMjzY4SA1zqEQScXgl9kH2amODoFw4h03P5PxakmN9WXTp968pQMEc+519rA37DVRoH4Z6sYufuxRThJbG8UmEjpZWs2yRZITMweZs6ZZi27of4jl5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697818; c=relaxed/simple;
	bh=sVW206k0Mjc7/bHHa0UZovmMRqx+BMaqirpAmbE4lbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kdhJzDas/ogDRz36A9tF6HcwrmjqT0kmwk98Ci9pKRukZU5iIEM7IIyRVmuuvFHavsNX028S5ru1fZV+fDTU79MPnj+d63j/7xWcr3vMP+qS8Vfi5+lfapjy13AQ+IJk8K1C6in5J6t7wR1Vg/OOAlqmiEoxpRhJbASokNe1Ftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhekyjAH; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46c8474d8daso42583221cf.3;
        Tue, 04 Feb 2025 11:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738697813; x=1739302613; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTuQ49A42JTCpH7JxEC65J0Z6TaQQ9Xr/byZvHGCPeg=;
        b=BhekyjAH2QroFP0Xu2Ctd/AKHUy5uEHQjoVO8NF7pMCS0qR1aqxdtFJDnduPkfvqE/
         pVsudYPhRgaPy2uWKNseh2WWUTyid+jobw3b/PIs1ZeulYADWrJUWVgt9oSDd5pFkOsN
         J/qPVgf0FACpa1maTVmyY57PgFrB0dBj3NmUw4JaCTLjn1+os/fSj4XUL4Oyz3Dayw8f
         kYDIiZD8nTwn6DZDMSQIsvHwIoF797DlY7YPpV6GRCiLnjclfVHG+1RZ9+2IjPeTQHLA
         OkF/mXyNAhPPKmgYCxAYFyYPaLu9ryOl2UdVrfugyjjFlRAauOyL4VYG9HDboQgUs71h
         7YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738697813; x=1739302613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTuQ49A42JTCpH7JxEC65J0Z6TaQQ9Xr/byZvHGCPeg=;
        b=oYF4rSo7tqLdzy6M2odEVhrn5vcog1f+qXlunPuZrvftO9HMZx5d64a/LK55ahp2yM
         H02D/wHEE8A4ZsCdw//xQGfLqgYar47vHAgTkZBsVEseflqlhJ/96elO/bbKcaAFv4Ny
         PdN+1WXi2mFYfh7+6nwEjEM2llS4/hh5WiTZSbeyvXgdgf/lcRHpLXAd+HQNgcRrLdzN
         i/hSZ/EkKEWRpP7P2QMgRBy93ZPeqww0DV8sU6xgsX9q9atUQwR2JO2Pawb6/aKm1L6p
         nva4Apu2lYaLKtMpGyPsJv2OM9YBHznWVbuhqlwyvO26Ko/oQ1YlTR36JgU1e8TFIQB0
         uLjA==
X-Forwarded-Encrypted: i=1; AJvYcCVvmr0hNbMqNT7/5yBEBMgJyb4W+dBvnsrL+z6WXsVsep9yU5eLt5kdA+Nm0HWhrdDkNp2FzV0oIE4u/DGzEuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylB353Tvz6VCE4wL+7Nejcp6of4rYnD/K2q0rP+vWnXGhZuSFR
	UsGBBHn4oTZnKyMcZgrW5MHczUMAhtEertborF7sQ0OF94FiV0Je
X-Gm-Gg: ASbGnctOhND2azzOKlrC3uKxZDWNrqlHbj5OvGy3tVLTAzVft17PleghOOZ60ulDHEO
	FrquG+06iY/cuEronAVh5uLkpj4zoeIjwggLR4GcINiqAwpmTu+Hk2Z8eOHwdFqz8GGdJy8pJDH
	ejdE8rbirpMWpS8NMWqaJ941WI2S6dvVQXlKPpBFV7QPJDhIySovicDhwv3L+Q3lDFuKP5Rn51R
	gxEiFTS8m2W5SUwuetpY03mgzKXrqcG0NwHK+tlUKdBdacRnWji6LoX+7QO7Htch3/ShZ4y68BS
	kNLVphq5rgWNaMyZHpssun3wf3ft8pRkXnvjBe2oqNFEkCr4BphzKuA+iNgFsjPWFsN5zhnPmRR
	hjQtVIGGx74xkZKoSXdMZusip
X-Google-Smtp-Source: AGHT+IFoFNx7YN5Cqh8BV69lfyXlUvSxxcWakuB8Iq/1uMfmvu64iFxwUQ609F5kNbXWgD65CosyBQ==
X-Received: by 2002:ac8:59d0:0:b0:467:5c17:e28a with SMTP id d75a77b69052e-46fd0b9102fmr388902921cf.46.1738697812208;
        Tue, 04 Feb 2025 11:36:52 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:6ca8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf18a420sm62121031cf.77.2025.02.04.11.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:36:50 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 04 Feb 2025 14:36:37 -0500
Subject: [PATCH 1/2] printf: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250204-printf-kunit-convert-v1-1-ecf1b846a4de@gmail.com>
References: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
In-Reply-To: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Convert the printf() self-test to a KUnit test.

In the interest of keeping the patch reasonably-sized this doesn't
refactor the tests into proper parameterized tests - it's all one big
test case.

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
 lib/Kconfig.debug                         |  20 +-
 lib/Makefile                              |   2 +-
 lib/{test_printf.c => printf_kunit.c}     | 522 ++++++++++++++----------------
 tools/testing/selftests/lib/config        |   1 -
 tools/testing/selftests/lib/printf.sh     |   4 -
 20 files changed, 261 insertions(+), 305 deletions(-)

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
similarity index 53%
rename from lib/test_printf.c
rename to lib/printf_kunit.c
index 59dbe4f9a4cb..e889aca69eba 100644
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
@@ -37,84 +35,53 @@
 	block \
 	__diag_pop();
 
-KSTM_MODULE_GLOBALS();
-
-static char *test_buffer __initdata;
-static char *alloced_buffer __initdata;
+static char *test_buffer;
+static char *alloced_buffer;
 
-static int __printf(4, 0) __init
-do_test(int bufsize, const char *expect, int elen,
+static void __printf(5, 0)
+do_test(struct kunit *test, int bufsize, const char *expect, int elen,
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
 
-	if (ret != elen) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
-			bufsize, fmt, ret, elen);
-		return 1;
-	}
-
-	if (memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE)) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote before buffer\n", bufsize, fmt);
-		return 1;
-	}
+	KUNIT_EXPECT_EQ_MSG(test, ret, elen, "vsnprintf(buf, %d, \"%s\", ...)", bufsize, fmt);
+	KUNIT_EXPECT_FALSE_MSG(test, memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE),
+		"vsnprintf(buf, %d, \"%s\", ...) wrote before buffer", bufsize, fmt);
 
 	if (!bufsize) {
-		if (memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE)) {
-			pr_warn("vsnprintf(buf, 0, \"%s\", ...) wrote to buffer\n",
-				fmt);
-			return 1;
-		}
-		return 0;
+		KUNIT_EXPECT_FALSE_MSG(test,
+			memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE),
+			"vsnprintf(buf, 0, \"%s\", ...) wrote to buffer", fmt);
+		return;
 	}
 
 	written = min(bufsize-1, elen);
-	if (test_buffer[written]) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer\n",
-			bufsize, fmt);
-		return 1;
-	}
-
-	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
-			bufsize, fmt);
-		return 1;
-	}
-
-	if (memchr_inv(test_buffer + bufsize, FILL_CHAR, BUF_SIZE + PAD_SIZE - bufsize)) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer\n", bufsize, fmt);
-		return 1;
-	}
-
-	if (memcmp(test_buffer, expect, written)) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
-			bufsize, fmt, test_buffer, written, expect);
-		return 1;
-	}
-	return 0;
+	KUNIT_EXPECT_FALSE_MSG(test, test_buffer[written],
+		"vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer", bufsize, fmt);
+	KUNIT_EXPECT_FALSE_MSG(test,
+		memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1)),
+		"vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator", bufsize, fmt);
+	KUNIT_EXPECT_FALSE_MSG(test,
+		memchr_inv(test_buffer + bufsize, FILL_CHAR, BUF_SIZE + PAD_SIZE - bufsize),
+		"vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer", bufsize, fmt);
+	KUNIT_EXPECT_MEMEQ_MSG(test, test_buffer, expect, written,
+		"vsnprintf(buf, %d, \"%s\", ...)", bufsize, fmt);
 }
 
-static void __printf(3, 4) __init
-__test(const char *expect, int elen, const char *fmt, ...)
+static void __printf(4, 5)
+__test(struct kunit *test, const char *expect, int elen, const char *fmt, ...)
 {
 	va_list ap;
 	int rand;
 	char *p;
 
-	if (elen >= BUF_SIZE) {
-		pr_err("error in test suite: expected output length %d too long. Format was '%s'.\n",
-		       elen, fmt);
-		failed_tests++;
-		return;
-	}
+	KUNIT_EXPECT_LE_MSG(test, elen, BUF_SIZE, "format was '%s'", fmt);
 
 	va_start(ap, fmt);
 
@@ -124,50 +91,45 @@ __test(const char *expect, int elen, const char *fmt, ...)
 	 * enough and 0), and then we also test that kvasprintf would
 	 * be able to print it as expected.
 	 */
-	failed_tests += do_test(BUF_SIZE, expect, elen, fmt, ap);
+	do_test(test, BUF_SIZE, expect, elen, fmt, ap);
 	rand = get_random_u32_inclusive(1, elen + 1);
 	/* Since elen < BUF_SIZE, we have 1 <= rand <= BUF_SIZE. */
-	failed_tests += do_test(rand, expect, elen, fmt, ap);
-	failed_tests += do_test(0, expect, elen, fmt, ap);
+	do_test(test, rand, expect, elen, fmt, ap);
+	do_test(test, 0, expect, elen, fmt, ap);
 
 	p = kvasprintf(GFP_KERNEL, fmt, ap);
 	if (p) {
-		total_tests++;
-		if (memcmp(p, expect, elen+1)) {
-			pr_warn("kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'\n",
-				fmt, p, expect);
-			failed_tests++;
-		}
+		KUNIT_EXPECT_MEMEQ_MSG(test, p, expect, elen+1, "kvasprintf(\"%s\", ...)", fmt);
 		kfree(p);
 	}
 	va_end(ap);
 }
 
-#define test(expect, fmt, ...)					\
-	__test(expect, strlen(expect), fmt, ##__VA_ARGS__)
+#define tc(test, expect, fmt, ...)					\
+	__test(test, expect, strlen(expect), fmt, ##__VA_ARGS__)
 
-static void __init
-test_basic(void)
+static void
+test_basic(struct kunit *test)
 {
 	/* Work around annoying "warning: zero-length gnu_printf format string". */
 	char nul = '\0';
 
-	test("", &nul);
-	test("100%", "100%%");
-	test("xxx%yyy", "xxx%cyyy", '%');
-	__test("xxx\0yyy", 7, "xxx%cyyy", '\0');
+	tc(test, "", &nul);
+	tc(test, "100%", "100%%");
+	tc(test, "xxx%yyy", "xxx%cyyy", '%');
+	__test(test, "xxx\0yyy", 7, "xxx%cyyy", '\0');
 }
 
-static void __init
-test_number(void)
+static void
+test_number(struct kunit *test)
 {
-	test("0x1234abcd  ", "%#-12x", 0x1234abcd);
-	test("  0x1234abcd", "%#12x", 0x1234abcd);
-	test("0|001| 12|+123| 1234|-123|-1234", "%d|%03d|%3d|%+d|% d|%+d|% d", 0, 1, 12, 123, 1234, -123, -1234);
+	tc(test, "0x1234abcd  ", "%#-12x", 0x1234abcd);
+	tc(test, "  0x1234abcd", "%#12x", 0x1234abcd);
+	tc(test, "0|001| 12|+123| 1234|-123|-1234", "%d|%03d|%3d|%+d|% d|%+d|% d", 0, 1, 12, 123, 1234, -123, -1234);
 	NOWARN(-Wformat, "Intentionally test narrowing conversion specifiers.", {
-		test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
-		test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
-		test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
+		tc(test, "0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
+		tc(test, "0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
+		tc(test, "2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
 	})
 	/*
 	 * POSIX/C99: »The result of converting zero with an explicit
@@ -177,17 +139,17 @@ test_number(void)
 	 * case. This test case simply documents the current
 	 * behaviour.
 	 */
-	test("00|0|0|0|0", "%.2d|%.1d|%.0d|%.*d|%1.0d", 0, 0, 0, 0, 0, 0);
+	tc(test, "00|0|0|0|0", "%.2d|%.1d|%.0d|%.*d|%1.0d", 0, 0, 0, 0, 0, 0);
 }
 
-static void __init
-test_string(void)
+static void
+test_string(struct kunit *test)
 {
-	test("", "%s%.0s", "", "123");
-	test("ABCD|abc|123", "%s|%.3s|%.*s", "ABCD", "abcdef", 3, "123456");
-	test("1  |  2|3  |  4|5  ", "%-3s|%3s|%-*s|%*s|%*s", "1", "2", 3, "3", 3, "4", -3, "5");
-	test("1234      ", "%-10.4s", "123456");
-	test("      1234", "%10.4s", "123456");
+	tc(test, "", "%s%.0s", "", "123");
+	tc(test, "ABCD|abc|123", "%s|%.3s|%.*s", "ABCD", "abcdef", 3, "123456");
+	tc(test, "1  |  2|3  |  4|5  ", "%-3s|%3s|%-*s|%*s|%*s", "1", "2", 3, "3", 3, "4", -3, "5");
+	tc(test, "1234      ", "%-10.4s", "123456");
+	tc(test, "      1234", "%10.4s", "123456");
 	/*
 	 * POSIX and C99 say that a negative precision (which is only
 	 * possible to pass via a * argument) should be treated as if
@@ -201,10 +163,10 @@ test_string(void)
 	 * anyone ever feel the need to follow the standards more
 	 * closely, this can be revisited.
 	 */
-	test("    ", "%4.*s", -5, "123456");
-	test("123456", "%.s", "123456");
-	test("a||", "%.s|%.0s|%.*s", "a", "b", 0, "c");
-	test("a  |   |   ", "%-3.s|%-3.0s|%-3.*s", "a", "b", 0, "c");
+	tc(test, "    ", "%4.*s", -5, "123456");
+	tc(test, "123456", "%.s", "123456");
+	tc(test, "a||", "%.s|%.0s|%.*s", "a", "b", 0, "c");
+	tc(test, "a  |   |   ", "%-3.s|%-3.0s|%-3.*s", "a", "b", 0, "c");
 }
 
 #define PLAIN_BUF_SIZE 64	/* leave some space so we don't oops */
@@ -218,7 +180,7 @@ test_string(void)
 #define ZEROS "00000000"	/* hex 32 zero bits */
 #define ONES "ffffffff"		/* hex 32 one bits */
 
-static int __init
+static int
 plain_format(void)
 {
 	char buf[PLAIN_BUF_SIZE];
@@ -250,7 +212,7 @@ plain_format(void)
 #define ZEROS ""
 #define ONES ""
 
-static int __init
+static int
 plain_format(void)
 {
 	/* Format is implicitly tested for 32 bit machines by plain_hash() */
@@ -259,7 +221,7 @@ plain_format(void)
 
 #endif	/* BITS_PER_LONG == 64 */
 
-static int __init
+static int
 plain_hash_to_buffer(const void *p, char *buf, size_t len)
 {
 	int nchars;
@@ -278,7 +240,7 @@ plain_hash_to_buffer(const void *p, char *buf, size_t len)
 	return 0;
 }
 
-static int __init
+static int
 plain_hash(void)
 {
 	char buf[PLAIN_BUF_SIZE];
@@ -298,33 +260,20 @@ plain_hash(void)
  * We can't use test() to test %p because we don't know what output to expect
  * after an address is hashed.
  */
-static void __init
-plain(void)
+static void
+plain(struct kunit *test)
 {
-	int err;
-
 	if (no_hash_pointers) {
 		pr_warn("skipping plain 'p' tests");
-		skipped_tests += 2;
-		return;
-	}
-
-	err = plain_hash();
-	if (err) {
-		pr_warn("plain 'p' does not appear to be hashed\n");
-		failed_tests++;
 		return;
 	}
 
-	err = plain_format();
-	if (err) {
-		pr_warn("hashing plain 'p' has unexpected format\n");
-		failed_tests++;
-	}
+	KUNIT_EXPECT_FALSE(test, plain_hash());
+	KUNIT_EXPECT_FALSE(test, plain_format());
 }
 
-static void __init
-test_hashed(const char *fmt, const void *p)
+static void
+test_hashed(struct kunit *test, const char *fmt, const void *p)
 {
 	char buf[PLAIN_BUF_SIZE];
 	int ret;
@@ -337,54 +286,54 @@ test_hashed(const char *fmt, const void *p)
 	if (ret)
 		return;
 
-	test(buf, fmt, p);
+	tc(test, buf, fmt, p);
 }
 
 /*
  * NULL pointers aren't hashed.
  */
-static void __init
-null_pointer(void)
+static void
+null_pointer(struct kunit *test)
 {
-	test(ZEROS "00000000", "%p", NULL);
-	test(ZEROS "00000000", "%px", NULL);
-	test("(null)", "%pE", NULL);
+	tc(test, ZEROS "00000000", "%p", NULL);
+	tc(test, ZEROS "00000000", "%px", NULL);
+	tc(test, "(null)", "%pE", NULL);
 }
 
 /*
  * Error pointers aren't hashed.
  */
-static void __init
-error_pointer(void)
+static void
+error_pointer(struct kunit *test)
 {
-	test(ONES "fffffff5", "%p", ERR_PTR(-11));
-	test(ONES "fffffff5", "%px", ERR_PTR(-11));
-	test("(efault)", "%pE", ERR_PTR(-11));
+	tc(test, ONES "fffffff5", "%p", ERR_PTR(-11));
+	tc(test, ONES "fffffff5", "%px", ERR_PTR(-11));
+	tc(test, "(efault)", "%pE", ERR_PTR(-11));
 }
 
 #define PTR_INVALID ((void *)0x000000ab)
 
-static void __init
-invalid_pointer(void)
+static void
+invalid_pointer(struct kunit *test)
 {
-	test_hashed("%p", PTR_INVALID);
-	test(ZEROS "000000ab", "%px", PTR_INVALID);
-	test("(efault)", "%pE", PTR_INVALID);
+	test_hashed(test, "%p", PTR_INVALID);
+	tc(test, ZEROS "000000ab", "%px", PTR_INVALID);
+	tc(test, "(efault)", "%pE", PTR_INVALID);
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
-struct_resource(void)
+static void
+struct_resource(struct kunit *test)
 {
 	struct resource test_resource = {
 		.start = 0xc0ffee00,
@@ -392,7 +341,7 @@ struct_resource(void)
 		.flags = IORESOURCE_MEM,
 	};
 
-	test("[mem 0xc0ffee00 flags 0x200]",
+	tc(test, "[mem 0xc0ffee00 flags 0x200]",
 	     "%pr", &test_resource);
 
 	test_resource = (struct resource) {
@@ -400,7 +349,7 @@ struct_resource(void)
 		.end = 0xba5eba11,
 		.flags = IORESOURCE_MEM,
 	};
-	test("[mem 0x00c0ffee-0xba5eba11 flags 0x200]",
+	tc(test, "[mem 0x00c0ffee-0xba5eba11 flags 0x200]",
 	     "%pr", &test_resource);
 
 	test_resource = (struct resource) {
@@ -408,7 +357,7 @@ struct_resource(void)
 		.end = 0xc0ffee,
 		.flags = IORESOURCE_MEM,
 	};
-	test("[mem 0xba5eba11-0x00c0ffee flags 0x200]",
+	tc(test, "[mem 0xba5eba11-0x00c0ffee flags 0x200]",
 	     "%pr", &test_resource);
 
 	test_resource = (struct resource) {
@@ -417,7 +366,7 @@ struct_resource(void)
 		.flags = IORESOURCE_MEM,
 	};
 
-	test("[mem 0xba5eba11-0xba5eca11 flags 0x200]",
+	tc(test, "[mem 0xba5eba11-0xba5eca11 flags 0x200]",
 	     "%pr", &test_resource);
 
 	test_resource = (struct resource) {
@@ -428,61 +377,61 @@ struct_resource(void)
 			 IORESOURCE_UNSET,
 	};
 
-	test("[io  size 0x1000 disabled]",
+	tc(test, "[io  size 0x1000 disabled]",
 	     "%pR", &test_resource);
 }
 
-static void __init
-struct_range(void)
+static void
+struct_range(struct kunit *test)
 {
 	struct range test_range = DEFINE_RANGE(0xc0ffee00ba5eba11,
 					       0xc0ffee00ba5eba11);
-	test("[range 0xc0ffee00ba5eba11]", "%pra", &test_range);
+	tc(test, "[range 0xc0ffee00ba5eba11]", "%pra", &test_range);
 
 	test_range = DEFINE_RANGE(0xc0ffee, 0xba5eba11);
-	test("[range 0x0000000000c0ffee-0x00000000ba5eba11]",
+	tc(test, "[range 0x0000000000c0ffee-0x00000000ba5eba11]",
 	     "%pra", &test_range);
 
 	test_range = DEFINE_RANGE(0xba5eba11, 0xc0ffee);
-	test("[range 0x00000000ba5eba11-0x0000000000c0ffee]",
+	tc(test, "[range 0x00000000ba5eba11-0x0000000000c0ffee]",
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
-hex_string(void)
+static void
+hex_string(struct kunit *test)
 {
 	const char buf[3] = {0xc0, 0xff, 0xee};
 
-	test("c0 ff ee|c0:ff:ee|c0-ff-ee|c0ffee",
+	tc(test, "c0 ff ee|c0:ff:ee|c0-ff-ee|c0ffee",
 	     "%3ph|%3phC|%3phD|%3phN", buf, buf, buf, buf);
-	test("c0 ff ee|c0:ff:ee|c0-ff-ee|c0ffee",
+	tc(test, "c0 ff ee|c0:ff:ee|c0-ff-ee|c0ffee",
 	     "%*ph|%*phC|%*phD|%*phN", 3, buf, 3, buf, 3, buf, 3, buf);
 }
 
-static void __init
-mac(void)
+static void
+mac(struct kunit *test)
 {
 	const u8 addr[6] = {0x2d, 0x48, 0xd6, 0xfc, 0x7a, 0x05};
 
-	test("2d:48:d6:fc:7a:05", "%pM", addr);
-	test("05:7a:fc:d6:48:2d", "%pMR", addr);
-	test("2d-48-d6-fc-7a-05", "%pMF", addr);
-	test("2d48d6fc7a05", "%pm", addr);
-	test("057afcd6482d", "%pmR", addr);
+	tc(test, "2d:48:d6:fc:7a:05", "%pM", addr);
+	tc(test, "05:7a:fc:d6:48:2d", "%pMR", addr);
+	tc(test, "2d-48-d6-fc-7a-05", "%pMF", addr);
+	tc(test, "2d48d6fc7a05", "%pm", addr);
+	tc(test, "057afcd6482d", "%pmR", addr);
 }
 
-static void __init
-ip4(void)
+static void
+ip4(struct kunit *test)
 {
 	struct sockaddr_in sa;
 
@@ -490,37 +439,37 @@ ip4(void)
 	sa.sin_port = cpu_to_be16(12345);
 	sa.sin_addr.s_addr = cpu_to_be32(0x7f000001);
 
-	test("127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
-	test("127.000.000.001|127.0.0.1", "%piS|%pIS", &sa, &sa);
+	tc(test, "127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
+	tc(test, "127.000.000.001|127.0.0.1", "%piS|%pIS", &sa, &sa);
 	sa.sin_addr.s_addr = cpu_to_be32(0x01020304);
-	test("001.002.003.004:12345|1.2.3.4:12345", "%piSp|%pISp", &sa, &sa);
+	tc(test, "001.002.003.004:12345|1.2.3.4:12345", "%piSp|%pISp", &sa, &sa);
 }
 
-static void __init
+static void
 ip6(void)
 {
 }
 
-static void __init
-ip(void)
+static void
+ip(struct kunit *test)
 {
-	ip4();
+	ip4(test);
 	ip6();
 }
 
-static void __init
-uuid(void)
+static void
+uuid(struct kunit *test)
 {
 	const char uuid[16] = {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
 			       0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf};
 
-	test("00010203-0405-0607-0809-0a0b0c0d0e0f", "%pUb", uuid);
-	test("00010203-0405-0607-0809-0A0B0C0D0E0F", "%pUB", uuid);
-	test("03020100-0504-0706-0809-0a0b0c0d0e0f", "%pUl", uuid);
-	test("03020100-0504-0706-0809-0A0B0C0D0E0F", "%pUL", uuid);
+	tc(test, "00010203-0405-0607-0809-0a0b0c0d0e0f", "%pUb", uuid);
+	tc(test, "00010203-0405-0607-0809-0A0B0C0D0E0F", "%pUB", uuid);
+	tc(test, "03020100-0504-0706-0809-0a0b0c0d0e0f", "%pUl", uuid);
+	tc(test, "03020100-0504-0706-0809-0A0B0C0D0E0F", "%pUL", uuid);
 }
 
-static struct dentry test_dentry[4] __initdata = {
+static struct dentry test_dentry[4] = {
 	{ .d_parent = &test_dentry[0],
 	  .d_name = QSTR_INIT(test_dentry[0].d_iname, 3),
 	  .d_iname = "foo" },
@@ -535,34 +484,34 @@ static struct dentry test_dentry[4] __initdata = {
 	  .d_iname = "romeo" },
 };
 
-static void __init
-dentry(void)
+static void
+dentry(struct kunit *test)
 {
-	test("foo", "%pd", &test_dentry[0]);
-	test("foo", "%pd2", &test_dentry[0]);
+	tc(test, "foo", "%pd", &test_dentry[0]);
+	tc(test, "foo", "%pd2", &test_dentry[0]);
 
-	test("(null)", "%pd", NULL);
-	test("(efault)", "%pd", PTR_INVALID);
-	test("(null)", "%pD", NULL);
-	test("(efault)", "%pD", PTR_INVALID);
+	tc(test, "(null)", "%pd", NULL);
+	tc(test, "(efault)", "%pd", PTR_INVALID);
+	tc(test, "(null)", "%pD", NULL);
+	tc(test, "(efault)", "%pD", PTR_INVALID);
 
-	test("romeo", "%pd", &test_dentry[3]);
-	test("alfa/romeo", "%pd2", &test_dentry[3]);
-	test("bravo/alfa/romeo", "%pd3", &test_dentry[3]);
-	test("/bravo/alfa/romeo", "%pd4", &test_dentry[3]);
-	test("/bravo/alfa", "%pd4", &test_dentry[2]);
+	tc(test, "romeo", "%pd", &test_dentry[3]);
+	tc(test, "alfa/romeo", "%pd2", &test_dentry[3]);
+	tc(test, "bravo/alfa/romeo", "%pd3", &test_dentry[3]);
+	tc(test, "/bravo/alfa/romeo", "%pd4", &test_dentry[3]);
+	tc(test, "/bravo/alfa", "%pd4", &test_dentry[2]);
 
-	test("bravo/alfa  |bravo/alfa  ", "%-12pd2|%*pd2", &test_dentry[2], -12, &test_dentry[2]);
-	test("  bravo/alfa|  bravo/alfa", "%12pd2|%*pd2", &test_dentry[2], 12, &test_dentry[2]);
+	tc(test, "bravo/alfa  |bravo/alfa  ", "%-12pd2|%*pd2", &test_dentry[2], -12, &test_dentry[2]);
+	tc(test, "  bravo/alfa|  bravo/alfa", "%12pd2|%*pd2", &test_dentry[2], 12, &test_dentry[2]);
 }
 
-static void __init
+static void
 struct_va_format(void)
 {
 }
 
-static void __init
-time_and_date(void)
+static void
+time_and_date(struct kunit *test)
 {
 	/* 1543210543 */
 	const struct rtc_time tm = {
@@ -576,32 +525,32 @@ time_and_date(void)
 	/* 2019-01-04T15:32:23 */
 	time64_t t = 1546615943;
 
-	test("(%pt?)", "%pt", &tm);
-	test("2018-11-26T05:35:43", "%ptR", &tm);
-	test("0118-10-26T05:35:43", "%ptRr", &tm);
-	test("05:35:43|2018-11-26", "%ptRt|%ptRd", &tm, &tm);
-	test("05:35:43|0118-10-26", "%ptRtr|%ptRdr", &tm, &tm);
-	test("05:35:43|2018-11-26", "%ptRttr|%ptRdtr", &tm, &tm);
-	test("05:35:43 tr|2018-11-26 tr", "%ptRt tr|%ptRd tr", &tm, &tm);
+	tc(test, "(%pt?)", "%pt", &tm);
+	tc(test, "2018-11-26T05:35:43", "%ptR", &tm);
+	tc(test, "0118-10-26T05:35:43", "%ptRr", &tm);
+	tc(test, "05:35:43|2018-11-26", "%ptRt|%ptRd", &tm, &tm);
+	tc(test, "05:35:43|0118-10-26", "%ptRtr|%ptRdr", &tm, &tm);
+	tc(test, "05:35:43|2018-11-26", "%ptRttr|%ptRdtr", &tm, &tm);
+	tc(test, "05:35:43 tr|2018-11-26 tr", "%ptRt tr|%ptRd tr", &tm, &tm);
 
-	test("2019-01-04T15:32:23", "%ptT", &t);
-	test("0119-00-04T15:32:23", "%ptTr", &t);
-	test("15:32:23|2019-01-04", "%ptTt|%ptTd", &t, &t);
-	test("15:32:23|0119-00-04", "%ptTtr|%ptTdr", &t, &t);
+	tc(test, "2019-01-04T15:32:23", "%ptT", &t);
+	tc(test, "0119-00-04T15:32:23", "%ptTr", &t);
+	tc(test, "15:32:23|2019-01-04", "%ptTt|%ptTd", &t, &t);
+	tc(test, "15:32:23|0119-00-04", "%ptTtr|%ptTdr", &t, &t);
 
-	test("2019-01-04 15:32:23", "%ptTs", &t);
-	test("0119-00-04 15:32:23", "%ptTsr", &t);
-	test("15:32:23|2019-01-04", "%ptTts|%ptTds", &t, &t);
-	test("15:32:23|0119-00-04", "%ptTtrs|%ptTdrs", &t, &t);
+	tc(test, "2019-01-04 15:32:23", "%ptTs", &t);
+	tc(test, "0119-00-04 15:32:23", "%ptTsr", &t);
+	tc(test, "15:32:23|2019-01-04", "%ptTts|%ptTds", &t, &t);
+	tc(test, "15:32:23|0119-00-04", "%ptTtrs|%ptTdrs", &t, &t);
 }
 
-static void __init
+static void
 struct_clk(void)
 {
 }
 
-static void __init
-large_bitmap(void)
+static void
+large_bitmap(struct kunit *test)
 {
 	const int nbits = 1 << 16;
 	unsigned long *bits = bitmap_zalloc(nbits, GFP_KERNEL);
@@ -610,34 +559,34 @@ large_bitmap(void)
 
 	bitmap_set(bits, 1, 20);
 	bitmap_set(bits, 60000, 15);
-	test("1-20,60000-60014", "%*pbl", nbits, bits);
+	tc(test, "1-20,60000-60014", "%*pbl", nbits, bits);
 	bitmap_free(bits);
 }
 
-static void __init
-bitmap(void)
+static void
+bitmap(struct kunit *test)
 {
 	DECLARE_BITMAP(bits, 20);
 	const int primes[] = {2,3,5,7,11,13,17,19};
 	int i;
 
 	bitmap_zero(bits, 20);
-	test("00000|00000", "%20pb|%*pb", bits, 20, bits);
-	test("|", "%20pbl|%*pbl", bits, 20, bits);
+	tc(test, "00000|00000", "%20pb|%*pb", bits, 20, bits);
+	tc(test, "|", "%20pbl|%*pbl", bits, 20, bits);
 
 	for (i = 0; i < ARRAY_SIZE(primes); ++i)
 		set_bit(primes[i], bits);
-	test("a28ac|a28ac", "%20pb|%*pb", bits, 20, bits);
-	test("2-3,5,7,11,13,17,19|2-3,5,7,11,13,17,19", "%20pbl|%*pbl", bits, 20, bits);
+	tc(test, "a28ac|a28ac", "%20pb|%*pb", bits, 20, bits);
+	tc(test, "2-3,5,7,11,13,17,19|2-3,5,7,11,13,17,19", "%20pbl|%*pbl", bits, 20, bits);
 
 	bitmap_fill(bits, 20);
-	test("fffff|fffff", "%20pb|%*pb", bits, 20, bits);
-	test("0-19|0-19", "%20pbl|%*pbl", bits, 20, bits);
+	tc(test, "fffff|fffff", "%20pb|%*pb", bits, 20, bits);
+	tc(test, "0-19|0-19", "%20pbl|%*pbl", bits, 20, bits);
 
-	large_bitmap();
+	large_bitmap(test);
 }
 
-static void __init
+static void
 netdev_features(void)
 {
 }
@@ -663,8 +612,8 @@ static const struct page_flags_test pft[] = {
 	 "%#x", "kasantag"},
 };
 
-static void __init
-page_flags_test(int section, int node, int zone, int last_cpupid,
+static void
+page_flags_test(struct kunit *test, int section, int node, int zone, int last_cpupid,
 		int kasan_tag, unsigned long flags, const char *name,
 		char *cmp_buf)
 {
@@ -698,11 +647,11 @@ page_flags_test(int section, int node, int zone, int last_cpupid,
 
 	snprintf(cmp_buf + size, BUF_SIZE - size, ")");
 
-	test(cmp_buf, "%pGp", &flags);
+	tc(test, cmp_buf, "%pGp", &flags);
 }
 
-static void __init
-flags(void)
+static void
+flags(struct kunit *test)
 {
 	unsigned long flags;
 	char *cmp_buffer;
@@ -713,43 +662,43 @@ flags(void)
 		return;
 
 	flags = 0;
-	page_flags_test(0, 0, 0, 0, 0, flags, "", cmp_buffer);
+	page_flags_test(test, 0, 0, 0, 0, 0, flags, "", cmp_buffer);
 
 	flags = 1UL << NR_PAGEFLAGS;
-	page_flags_test(0, 0, 0, 0, 0, flags, "", cmp_buffer);
+	page_flags_test(test, 0, 0, 0, 0, 0, flags, "", cmp_buffer);
 
 	flags |= 1UL << PG_uptodate | 1UL << PG_dirty | 1UL << PG_lru
 		| 1UL << PG_active | 1UL << PG_swapbacked;
-	page_flags_test(1, 1, 1, 0x1fffff, 1, flags,
+	page_flags_test(test, 1, 1, 1, 0x1fffff, 1, flags,
 			"uptodate|dirty|lru|active|swapbacked",
 			cmp_buffer);
 
 	flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
-	test("read|exec|mayread|maywrite|mayexec", "%pGv", &flags);
+	tc(test, "read|exec|mayread|maywrite|mayexec", "%pGv", &flags);
 
 	gfp = GFP_TRANSHUGE;
-	test("GFP_TRANSHUGE", "%pGg", &gfp);
+	tc(test, "GFP_TRANSHUGE", "%pGg", &gfp);
 
 	gfp = GFP_ATOMIC|__GFP_DMA;
-	test("GFP_ATOMIC|GFP_DMA", "%pGg", &gfp);
+	tc(test, "GFP_ATOMIC|GFP_DMA", "%pGg", &gfp);
 
 	gfp = __GFP_HIGH;
-	test("__GFP_HIGH", "%pGg", &gfp);
+	tc(test, "__GFP_HIGH", "%pGg", &gfp);
 
 	/* Any flags not translated by the table should remain numeric */
 	gfp = ~__GFP_BITS_MASK;
 	snprintf(cmp_buffer, BUF_SIZE, "%#lx", (unsigned long) gfp);
-	test(cmp_buffer, "%pGg", &gfp);
+	tc(test, cmp_buffer, "%pGg", &gfp);
 
 	snprintf(cmp_buffer, BUF_SIZE, "__GFP_HIGH|%#lx",
 							(unsigned long) gfp);
 	gfp |= __GFP_HIGH;
-	test(cmp_buffer, "%pGg", &gfp);
+	tc(test, cmp_buffer, "%pGg", &gfp);
 
 	kfree(cmp_buffer);
 }
 
-static void __init fwnode_pointer(void)
+static void fwnode_pointer(struct kunit *test)
 {
 	const struct software_node first = { .name = "first" };
 	const struct software_node second = { .name = "second", .parent = &first };
@@ -767,16 +716,16 @@ static void __init fwnode_pointer(void)
 		return;
 	}
 
-	test(full_name_second, "%pfw", software_node_fwnode(&second));
-	test(full_name_third, "%pfw", software_node_fwnode(&third));
-	test(full_name_third, "%pfwf", software_node_fwnode(&third));
-	test(second_name, "%pfwP", software_node_fwnode(&second));
-	test(third_name, "%pfwP", software_node_fwnode(&third));
+	tc(test, full_name_second, "%pfw", software_node_fwnode(&second));
+	tc(test, full_name_third, "%pfw", software_node_fwnode(&third));
+	tc(test, full_name_third, "%pfwf", software_node_fwnode(&third));
+	tc(test, second_name, "%pfwP", software_node_fwnode(&second));
+	tc(test, third_name, "%pfwP", software_node_fwnode(&third));
 
 	software_node_unregister_node_group(group);
 }
 
-static void __init fourcc_pointer(void)
+static void fourcc_pointer(struct kunit *test)
 {
 	struct {
 		u32 code;
@@ -790,74 +739,85 @@ static void __init fourcc_pointer(void)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(try); i++)
-		test(try[i].str, "%p4cc", &try[i].code);
+		tc(test, try[i].str, "%p4cc", &try[i].code);
 }
 
-static void __init
-errptr(void)
+static void
+errptr(struct kunit *test)
 {
-	test("-1234", "%pe", ERR_PTR(-1234));
+	tc(test, "-1234", "%pe", ERR_PTR(-1234));
 
 	/* Check that %pe with a non-ERR_PTR gets treated as ordinary %p. */
 	BUILD_BUG_ON(IS_ERR(PTR));
-	test_hashed("%pe", PTR);
+	test_hashed(test, "%pe", PTR);
 
 #ifdef CONFIG_SYMBOLIC_ERRNAME
-	test("(-ENOTSOCK)", "(%pe)", ERR_PTR(-ENOTSOCK));
-	test("(-EAGAIN)", "(%pe)", ERR_PTR(-EAGAIN));
+	tc(test, "(-ENOTSOCK)", "(%pe)", ERR_PTR(-ENOTSOCK));
+	tc(test, "(-EAGAIN)", "(%pe)", ERR_PTR(-EAGAIN));
 	BUILD_BUG_ON(EAGAIN != EWOULDBLOCK);
-	test("(-EAGAIN)", "(%pe)", ERR_PTR(-EWOULDBLOCK));
-	test("[-EIO    ]", "[%-8pe]", ERR_PTR(-EIO));
-	test("[    -EIO]", "[%8pe]", ERR_PTR(-EIO));
-	test("-EPROBE_DEFER", "%pe", ERR_PTR(-EPROBE_DEFER));
+	tc(test, "(-EAGAIN)", "(%pe)", ERR_PTR(-EWOULDBLOCK));
+	tc(test, "[-EIO    ]", "[%-8pe]", ERR_PTR(-EIO));
+	tc(test, "[    -EIO]", "[%8pe]", ERR_PTR(-EIO));
+	tc(test, "-EPROBE_DEFER", "%pe", ERR_PTR(-EPROBE_DEFER));
 #endif
 }
 
-static void __init
-test_pointer(void)
+static void
+test_pointer(struct kunit *test)
 {
-	plain();
-	null_pointer();
-	error_pointer();
-	invalid_pointer();
+	plain(test);
+	null_pointer(test);
+	error_pointer(test);
+	invalid_pointer(test);
 	symbol_ptr();
 	kernel_ptr();
-	struct_resource();
-	struct_range();
+	struct_resource(test);
+	struct_range(test);
 	addr();
 	escaped_str();
-	hex_string();
-	mac();
-	ip();
-	uuid();
-	dentry();
+	hex_string(test);
+	mac(test);
+	ip(test);
+	uuid(test);
+	dentry(test);
 	struct_va_format();
-	time_and_date();
+	time_and_date(test);
 	struct_clk();
-	bitmap();
+	bitmap(test);
 	netdev_features();
-	flags();
-	errptr();
-	fwnode_pointer();
-	fourcc_pointer();
+	flags(test);
+	errptr(test);
+	fwnode_pointer(test);
+	fourcc_pointer(test);
 }
 
-static void __init selftest(void)
+static void printf_test(struct kunit *test)
 {
 	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
 	if (!alloced_buffer)
 		return;
 	test_buffer = alloced_buffer + PAD_SIZE;
 
-	test_basic();
-	test_number();
-	test_string();
-	test_pointer();
+	test_basic(test);
+	test_number(test);
+	test_string(test);
+	test_pointer(test);
 
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


