Return-Path: <linux-kselftest+bounces-18264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2231983B6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 05:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7DAB22045
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 03:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4EF175BF;
	Tue, 24 Sep 2024 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+FhX4w2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE80EAD7
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727146808; cv=none; b=A20vlhVbuY1GfMyAfvkZQYjYGia2jKrgWaFgabPczyi3Xl+RKyTKxM81hpRvig1uQP93qqa1ULR9SMBJvQLRI7+tmL4KSw4EuNcpcGJj6mBFtfAMaqoxQ2nmf7lBVy627QEdt5GYiWt0oJAE2mycvhEeTIpl6JRY2FFxXMIIk6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727146808; c=relaxed/simple;
	bh=PGKVfCFLOcXyG1UJ64FDSbsGJz7GJVylmoPAjSei5mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xvqz4pi2kRqk7ApqAwLg06aHPiMNp67K65k2zZ7hXL/N5/7iHqmZ8voQl6VK1dqN06cInANUAxGK66CYnAoNPtQupD9ONW/7uY7uOJEILHGb7f9uw3/6doXbrjINBSu5iq61V0QxCqgTozzUUeLxb7Dln9KwRvSNorem6owdaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+FhX4w2; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5019d48b1aaso1125732e0c.1
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 20:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727146806; x=1727751606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nU+Wd+xETs3An1e9pyRBvPBluwxhPMxkS03pCtGHAuY=;
        b=I+FhX4w2RA1nLPawd78IqAQ+OZSHuRKtqQ4lwnB6puKzJuHyUSAJQIR96EWmV1F5nd
         llYlA/6CtyIPlHYYbC0oxSSAw+ESDAZr34fA+aI4yETmG0f/h18QDRCW5bnjkRJgp7S0
         CdHTUSKLQzoFPu3lVZbDZRczP1xGUfDvx3K1OonKvVoDUgUKJhWFdys6UusQTqXokPA8
         sLtmcJZ+BOXggNh2eDDpLuShrHm452SDTC9XgaAJc2DhQ2AcCl7AdYjZTIASZISzXnyd
         GNkeUVYUSFpoETwD3G41FEtbfX0fUr/rULBi6AZ+jPERLIL7m0x2FB9KYdXL6FhXsBGz
         RFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727146806; x=1727751606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nU+Wd+xETs3An1e9pyRBvPBluwxhPMxkS03pCtGHAuY=;
        b=ORQzMCtGKxII+AtioIbBe2iTh0eM0NBHZMYUoutjCQiXYejoRqYVvNNxs34leNFKEs
         87usdh9IRSECIMFTZ5iAUTSnCeYQoXyUZ06CmX5XVR9t48n7C5DD2mVmkU8h5KSB0O7X
         7xwtQCKvczIwJeD7VFFaaHIT0aNCEwmg82QwPdL9Ng/g3dAYgVJFGMN9SCvrcFoqi0aV
         ZieOAPMmSfRtQjO9DFro5QFTA0qR9QCv/loPA1wdZ3V5Ms6j8LIRPQS2JRwU8biu77p/
         gENxQx0nhR8G56YoPpLB+avHgtR+YZhrSHEshWYm0Q+Nj1ShpPYU8+BTg2ExvUrzDCQW
         BxHw==
X-Forwarded-Encrypted: i=1; AJvYcCVV+0Xtc3pbSr4+x3dZXlSHlSNV8c8w4dPRCk4WskKS3+U/APebp+GlBMunixsXH/gm7IGD7hmPLr2jdSRmbsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89J4oN3RZcaZz7p4lydLOlqAqzX04k1csvWzjRFFKofgJGEjy
	IRIHZAinxmUxzBUWyl0CeRjYO/Qgl/VRJTUzUrUJ2/brJH9f0TB3
X-Google-Smtp-Source: AGHT+IGZ0Rz2z0bn6FdZif0Y9AzsJm59+n9vupufk9+1k3TxlIVxLv1CUbs8X86kSWoManPYVqpWGg==
X-Received: by 2002:a05:6122:2a4b:b0:502:873f:13c2 with SMTP id 71dfb90a1353d-503e055467fmr8126285e0c.13.1727146805574;
        Mon, 23 Sep 2024 20:00:05 -0700 (PDT)
Received: from x13.. (syn-142-197-128-048.res.spectrum.com. [142.197.128.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-505aa080d82sm374760e0c.35.2024.09.23.20.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 20:00:04 -0700 (PDT)
From: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com,
	quic_jjohnson@quicinc.com,
	macro@orcam.me.uk,
	npitre@baylibre.com,
	tpiepho@gmail.com
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] lib: math: Move kunit tests into tests/ subdir
Date: Mon, 23 Sep 2024 22:59:33 -0400
Message-ID: <20240924025935.165499-1-luis.hernandez093@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: linux-kselftest@vger.kernel.org,
    kunit-dev@googlegroups.com,
    skhan@linuxfoundation.org,
	ricardo@marliere.net,
    linux-kernel-mentees@lists.linuxfoundation.org

This patch is a follow-up task from a discussion stemming from point 3
in a recent patch introducing the int_pow kunit test [1] and
documentation regarding kunit test style and nomenclature [2].

Colocate all kunit test suites in lib/math/tests/ and
follow the recommended naming convention for files <suite>_kunit.c
and kconfig entries CONFIG_<name>_KUNIT_TEST.

Link: https://lore.kernel.org/all/CABVgOS=-vh5TqHFCq_jo=ffq8v_nGgr6JsPnOZag3e6+19ysxQ@mail.gmail.com/ [1]
Link: https://docs.kernel.org/dev-tools/kunit/style.html [2]

Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
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
 .../mul_u64_u64_div_u64_kunit.c}                            | 0
 lib/math/{rational-test.c => tests/rational_kunit.c}        | 0
 19 files changed, 21 insertions(+), 21 deletions(-)
 rename lib/math/{test_div64.c => tests/div64_kunit.c} (100%)
 rename lib/math/{test_mul_u64_u64_div_u64.c => tests/mul_u64_u64_div_u64_kunit.c} (100%)
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
index bc8faa4509e1..49807e18b0fc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2281,7 +2281,7 @@ config TEST_SORT
 
 	  If unsure, say N.
 
-config TEST_DIV64
+config DIV64_KUNIT_TEST
 	tristate "64bit/32bit division and modulo test"
 	depends on DEBUG_KERNEL || m
 	help
@@ -2291,7 +2291,7 @@ config TEST_DIV64
 
 	  If unsure, say N.
 
-config TEST_MULDIV64
+config MULDIV64_KUNIT_TEST
 	tristate "mul_u64_u64_div_u64() test"
 	depends on DEBUG_KERNEL || m
 	help
@@ -3074,7 +3074,7 @@ endmenu # "Rust"
 
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
similarity index 100%
rename from lib/math/test_mul_u64_u64_div_u64.c
rename to lib/math/tests/mul_u64_u64_div_u64_kunit.c
diff --git a/lib/math/rational-test.c b/lib/math/tests/rational_kunit.c
similarity index 100%
rename from lib/math/rational-test.c
rename to lib/math/tests/rational_kunit.c
-- 
2.46.1


