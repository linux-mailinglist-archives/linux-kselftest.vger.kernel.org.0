Return-Path: <linux-kselftest+bounces-19118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ED8991B36
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 00:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C8F1F218A3
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 22:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05F515AD9C;
	Sat,  5 Oct 2024 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlNVyW4e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8D2B9A6
	for <linux-kselftest@vger.kernel.org>; Sat,  5 Oct 2024 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728167111; cv=none; b=Z8WA0CfxFEEQ4QnjbIaEArBr2CQF0RJWWFdAdOF6+WSXKeBxhldEVWmWRY0VAC+FLydtt9Ucp2bG8r/K+i2yorT7yMK1BMuAsQp151EbpySqR4Q6Nii2LJ3hWbnoHLe/BnItyWN+hs9Rf+ApsxjBXC1+dmtPaOKppb2Yr/FOL9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728167111; c=relaxed/simple;
	bh=q82pZifR1W2blH4N/+nd55gnwNOI6BUTGrkjzF+o/b0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1N5O2m08kHSs2RXuxiv0a/LC9fCTL/3c3bTsKPHTQqIbe6P5TFRbu4kFCiLXZ7aqgVJ19OqHGUHCOc3EkZAnRyV1yIpf/Z4MhCHrj3+7u07rmcncWQbdr42XaTXDpF1e53nh0ExbqLf4/dtqwSM4fdw/N79kmFNTMYokGM8SH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlNVyW4e; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84eb2f32097so939894241.2
        for <linux-kselftest@vger.kernel.org>; Sat, 05 Oct 2024 15:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728167109; x=1728771909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDfiCHkM6iRNBN2C/aIKKCpm5M7jUVZxqO9j658Fvlo=;
        b=OlNVyW4eKbQzaK49N1obt3JUiqgwNOOJvWvs1UFW7RVbx6EG7ZNOn/XKXw0WyuYtkr
         tkvxzCBt3lliWk7lUcnjJuD5Va+7TFUFpg1hGvzFXFg0FXoQ9S0q9jicurEQxR6Ll7nb
         VvKH1ZtKZeNtlNh2k6U3f0ZIoEwe/TD+/qBGdmatvF34joH1820CAltwVTfcgxsUhn7E
         cfQRhN++YPiI4QfRLcsf0c6mMtAERVGUGjEV4LkrShP5hUTSCnxTsJUYOUBWsBh1IiUb
         oa7q16OmZyMyJGQsD+GfllUzGmoIyc9yTiR9c5TVSSYyGiB5vrlTx9pBISyxic34bT7V
         HMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728167109; x=1728771909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDfiCHkM6iRNBN2C/aIKKCpm5M7jUVZxqO9j658Fvlo=;
        b=bESXuCdN9vz4aLhN4SCQtDpBZl3on+gZATsEEEV0hWdNF3mSLoOS92g6Q/afy2MMRL
         ABK49hk1AOncSw12rbujhhgFfWemWLpm6BbJD1WBIUXM3OxNDwmsJwoiBvw1qQsvKihn
         1Rk+WCx+ZQOweVMRw5dIh92YESwagIgREu8w/yrP1QXG7Jt51yhLbc8do7u1kKBSCGy5
         iR/nvGolfe6t9GD4DoASgS7C8JGMcftP72wbhvXWMHTAdSN3sDYWmMlh1nqC1/RrgQvF
         Rb+Jz55G2hM43sGKVGGverV4J2rA0GMWZhKTu+Z4OfqUEeEuQeXOG7EhBQDP+g4L0aym
         AzUw==
X-Forwarded-Encrypted: i=1; AJvYcCUsotkejq8M6vTwHxV/cz8OGQhmDAAwZJiagorkjMP3CN9reAn3zh2qhfWkx+XslsVMOfoJluY2vwNapKYutxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+V6WvSqJTobn1kE9mhTTM26YC/psDWaO7dMDy146EvctPlrG
	e4EHAs7lc5faV6e3bIgvj4bInvxa5RRFoL0r/d2hmfgCaIVq+X89
X-Google-Smtp-Source: AGHT+IG9IC6wXOdmrb4x8YrDY/Q2PgIvr82+BNrG5moIFbBBl6jXPRRtTozwbv0WiOmFCmnNv7bmPg==
X-Received: by 2002:a05:6122:3126:b0:50a:12e4:2618 with SMTP id 71dfb90a1353d-50c85448878mr6747290e0c.2.1728167108805;
        Sat, 05 Oct 2024 15:25:08 -0700 (PDT)
Received: from x13.. ([186.1.186.79])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50c9ae365c3sm383791e0c.44.2024.10.05.15.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 15:25:07 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com,
	quic_jjohnson@quicinc.com,
	macro@orcam.me.uk,
	npitre@baylibre.com,
	tpiepho@gmail.com
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org,
	ricardo@marliere.net,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] lib: math: Move kunit tests into tests/ subdir
Date: Sat,  5 Oct 2024 18:24:45 -0400
Message-ID: <20241005222446.10471-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is a follow-up task from a discussion stemming from point 3
in a recent patch introducing the int_pow kunit test [1] and
documentation regarding kunit test style and nomenclature [2].

Colocate all kunit test suites in lib/math/tests/ and
follow recommended naming convention for files <suite>_kunit.c
and kconfig entries CONFIG_<name>_KUNIT_TEST.

Link: https://lore.kernel.org/all/CABVgOS=-vh5TqHFCq_jo=ffq8v_nGgr6JsPnOZag3e6+19ysxQ@mail.gmail.com/ [1]
Link: https://docs.kernel.org/dev-tools/kunit/style.html [2]

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
---
Changes in v2: Fix cc recipient list inclusion in cover letter
Changes in v3: Update mul_u64_u64_div_u64_kunit.c path in comment describing shell script
---
 arch/m68k/configs/amiga_defconfig                           | 2 +-
 arch/m68k/configs/apollo_defconfig                          | 2 +-
 arch/m68k/configs/atari_defconfig                           | 2 +-
 arch/m68k/configs/bvme6000_defconfig                        | 2 +-
 arch/m68k/configs/hp300_defconfig                           | 2 +-
 arch/m68k/configs/mac_defconfig                             | 2 +-
 arch/m68k/configs/multi_defconfig                           | 2 +-
 arch/m68k/configs/mvme147_defconfig                         | 2 +-
 arch/m68k/configs/mvme16x_defconfig                         | 2 +-
 arch/m68k/configs/q40_defconfig                             | 2 +-
 arch/m68k/configs/sun3_defconfig                            | 2 +-
 arch/m68k/configs/sun3x_defconfig                           | 2 +-
 arch/powerpc/configs/ppc64_defconfig                        | 2 +-
 lib/Kconfig.debug                                           | 6 +++---
 lib/math/Makefile                                           | 5 +----
 lib/math/tests/Makefile                                     | 5 ++++-
 lib/math/{test_div64.c => tests/div64_kunit.c}              | 0
 .../mul_u64_u64_div_u64_kunit.c}                            | 2 +-
 lib/math/{rational-test.c => tests/rational_kunit.c}        | 0
 19 files changed, 22 insertions(+), 22 deletions(-)
 rename lib/math/{test_div64.c => tests/div64_kunit.c} (100%)
 rename lib/math/{test_mul_u64_u64_div_u64.c => tests/mul_u64_u64_div_u64_kunit.c} (98%)
 rename lib/math/{rational-test.c => tests/rational_kunit.c} (100%)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index d01dc47d52ea..7ba9311c084c 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -619,7 +619,7 @@ CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
-CONFIG_TEST_DIV64=m
+CONFIG_DIV64_KUNIT_TEST=m
 CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 46808e581d7b..273fe4032b85 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -576,7 +576,7 @@ CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
-CONFIG_TEST_DIV64=m
+CONFIG_DIV64_KUNIT_TEST=m
 CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 4469a7839c9d..9976cda99fc1 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -596,7 +596,7 @@ CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
-CONFIG_TEST_DIV64=m
+CONFIG_DIV64_KUNIT_TEST=m
 CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index c0719322c028..f59082c8fe06 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -568,7 +568,7 @@ CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
-CONFIG_TEST_DIV64=m
+CONFIG_DIV64_KUNIT_TEST=m
 CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 8d429e63f8f2..6db3556da9ac 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -578,7 +578,7 @@ CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
-CONFIG_TEST_DIV64=m
+CONFIG_DIV64_KUNIT_TEST=m
 CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index bafd33da27c1..25c06b5c83ee 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -595,7 +595,7 @@ CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
-CONFIG_TEST_DIV64=m
+CONFIG_DIV64_KUNIT_TEST=m
 CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 6f5ca3f85ea1..35e57e0ee139 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -681,7 +681,7 @@ CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
-CONFIG_TEST_DIV64=m
+CONFIG_DIV64_KUNIT_TEST=m
 CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index d16b328c7136..d253b686119a 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -567,7 +567,7 @@ CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
-CONFIG_TEST_DIV64=m
+CONFIG_DIV64_KUNIT_TEST=m
 CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 80f6c15a5ed5..62bc6ad63783 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -568,7 +568,7 @@ CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
-CONFIG_TEST_DIV64=m
+CONFIG_DIV64_KUNIT_TEST=m
 CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 0e81589f0ee2..caba39c61bac 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -585,7 +585,7 @@ CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
-CONFIG_TEST_DIV64=m
+CONFIG_DIV64_KUNIT_TEST=m
 CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 8cd785290339..a348f645ed55 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -565,7 +565,7 @@ CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
-CONFIG_TEST_DIV64=m
+CONFIG_DIV64_KUNIT_TEST=m
 CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 78035369f60f..f8b3cfc3275b 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -566,7 +566,7 @@ CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_TEST_DHRY=m
 CONFIG_TEST_MIN_HEAP=m
-CONFIG_TEST_DIV64=m
+CONFIG_DIV64_KUNIT_TEST=m
 CONFIG_REED_SOLOMON_TEST=m
 CONFIG_ATOMIC64_SELFTEST=m
 CONFIG_ASYNC_RAID6_TEST=m
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index a5e3e7f97f4d..f1f21765c0c1 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -435,7 +435,7 @@ CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
 CONFIG_LKDTM=m
 CONFIG_TEST_MIN_HEAP=m
-CONFIG_TEST_DIV64=m
+CONFIG_DIV64_KUNIT_TEST=m
 CONFIG_BACKTRACE_SELF_TEST=m
 CONFIG_TEST_REF_TRACKER=m
 CONFIG_RBTREE_TEST=m
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..0d6c979f0bfd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2296,7 +2296,7 @@ config TEST_SORT
 
 	  If unsure, say N.
 
-config TEST_DIV64
+config DIV64_KUNIT_TEST
 	tristate "64bit/32bit division and modulo test"
 	depends on DEBUG_KERNEL || m
 	help
@@ -2306,7 +2306,7 @@ config TEST_DIV64
 
 	  If unsure, say N.
 
-config TEST_MULDIV64
+config MULDIV64_KUNIT_TEST
 	tristate "mul_u64_u64_div_u64() test"
 	depends on DEBUG_KERNEL || m
 	help
@@ -3089,7 +3089,7 @@ endmenu # "Rust"
 
 endmenu # Kernel hacking
 
-config INT_POW_TEST
+config INT_POW_KUNIT_TEST
 	tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 3ef11305f8d2..1c489501ff57 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -5,7 +5,4 @@ obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
 
-obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
-obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
-obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
-obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
+obj-y  += tests/
diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
index 6a169123320a..f9a0a0e6b73a 100644
--- a/lib/math/tests/Makefile
+++ b/lib/math/tests/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
+obj-$(CONFIG_DIV64_KUNIT_TEST)    += div64_kunit.o
+obj-$(CONFIG_INT_POW_KUNIT_TEST)  += int_pow_kunit.o
+obj-$(CONFIG_MULDIV64_KUNIT_TEST) += mul_u64_u64_div_u64_kunit.o
+obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational_kunit.o
diff --git a/lib/math/test_div64.c b/lib/math/tests/div64_kunit.c
similarity index 100%
rename from lib/math/test_div64.c
rename to lib/math/tests/div64_kunit.c
diff --git a/lib/math/test_mul_u64_u64_div_u64.c b/lib/math/tests/mul_u64_u64_div_u64_kunit.c
similarity index 98%
rename from lib/math/test_mul_u64_u64_div_u64.c
rename to lib/math/tests/mul_u64_u64_div_u64_kunit.c
index 58d058de4e73..f61f571a0a2e 100644
--- a/lib/math/test_mul_u64_u64_div_u64.c
+++ b/lib/math/tests/mul_u64_u64_div_u64_kunit.c
@@ -49,7 +49,7 @@ static test_params test_values[] = {
  *
  * #!/bin/sh
  * sed -ne 's/^{ \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\) },$/\1 \2 \3 \4/p' \
- *     lib/math/test_mul_u64_u64_div_u64.c |
+ *     lib/math/tests/mul_u64_u64_div_u64_kunit.c |
  * while read a b c r; do
  *   expected=$( printf "obase=16; ibase=16; %X * %X / %X\n" $a $b $c | bc )
  *   given=$( printf "%X\n" $r )
diff --git a/lib/math/rational-test.c b/lib/math/tests/rational_kunit.c
similarity index 100%
rename from lib/math/rational-test.c
rename to lib/math/tests/rational_kunit.c
-- 
2.46.2


