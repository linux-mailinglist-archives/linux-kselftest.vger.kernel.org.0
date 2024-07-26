Return-Path: <linux-kselftest+bounces-14269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C31E93D1AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 13:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256121F22B00
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E116817995A;
	Fri, 26 Jul 2024 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mZyBSfM/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5890D179654;
	Fri, 26 Jul 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992056; cv=none; b=mVJZwnIDUmVXIz1kB/bwMIIwZzbyCzvIK5tsUcM44AGP/c/BFRQ7Vb8nqB/PpWI0R0IDnwtOm8TmaPnaYz6CJvsm1PyCWSTaMuBtqz4Is2/9JjNRNtEyNYzMtxArY4dHHpoGdKlmECgSUEsU34RUrorJ3U0mCVzAMvGBTKSaZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992056; c=relaxed/simple;
	bh=qlJpgo+fjQH19YWBypGfPkv7Rvg9USZzUiPnUXgG4vM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLTAvbasE4vDboWLKLa5dQ5OEF91QPiPPz9uWuZG5jk9oiEZ1JsfD6qLC4ntNmPATUlpqx876jIDQf5DuFGCxMAapAX+HX1amHvo0h8ijKhxc1Pvb2A+/TOgO8Zsqfvfwj9EGfHEHxk38FA+58wJj3WZz0netAyysbR59gZxOMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mZyBSfM/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721992053;
	bh=qlJpgo+fjQH19YWBypGfPkv7Rvg9USZzUiPnUXgG4vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZyBSfM/KnUww0pFA94IpQSOp1twR5k87H4UzG0toqBTGs9/tv/siERlb0tUDF+y0
	 c1FxFi5gCao6uRQrbV7Alcu3jvhgJAT3H5tMP9JgUJxBHKzulkt+RMYQEIf5ENBxzC
	 +gGmfFAjvqFYXdRKCPqu9/8SlY472/8+1NsYevnnATDXQG6Lj5BMRilZ7SyzYAveix
	 bCGlTnaq8yLy/hS5hR6Pnxxi2q6HW4liwmCte92nSK9QX+rnWSSTqO3VJosVCqHxMI
	 5nXwMbAkOQVSB4Gzilcg9hr4+vNzXlOvMtLoMubqHRLUh8LoDV/QBvpTiqt8GtFhQz
	 26Q0SPS9cPJdw==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CEC3937821B7;
	Fri, 26 Jul 2024 11:07:27 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kees@kernel.org,
	David Gow <davidgow@google.com>,
	John Hubbard <jhubbard@nvidia.com>
Cc: kernel@collabora.com
Subject: [PATCH 2/3] bitmap: Rename module
Date: Fri, 26 Jul 2024 16:06:57 +0500
Message-Id: <20240726110658.2281070-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240726110658.2281070-1-usama.anjum@collabora.com>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename module to bitmap_kunit and rename the configuration option
compliant with kunit framework.

Cc: kees@kernel.org
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 MAINTAINERS                           |  2 +-
 lib/Kconfig.debug                     | 15 ++++++++-------
 lib/Makefile                          |  2 +-
 lib/{test_bitmap.c => bitmap_kunit.c} |  0
 4 files changed, 10 insertions(+), 9 deletions(-)
 rename lib/{test_bitmap.c => bitmap_kunit.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12b870712da4a..289b727344d64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3814,13 +3814,13 @@ F:	include/linux/find.h
 F:	include/linux/nodemask.h
 F:	include/linux/nodemask_types.h
 F:	include/vdso/bits.h
+F:	lib/bitmap_kunit.c
 F:	lib/bitmap-str.c
 F:	lib/bitmap.c
 F:	lib/cpumask.c
 F:	lib/cpumask_kunit.c
 F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
-F:	lib/test_bitmap.c
 F:	tools/include/linux/bitfield.h
 F:	tools/include/linux/bitmap.h
 F:	tools/include/linux/bits.h
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a661726..6bb02990a73e7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2420,13 +2420,6 @@ config TEST_PRINTF
 config TEST_SCANF
 	tristate "Test scanf() family of functions at runtime"
 
-config TEST_BITMAP
-	tristate "Test bitmap_*() family of functions at runtime"
-	help
-	  Enable this option to test the bitmap functions at boot.
-
-	  If unsure, say N.
-
 config TEST_UUID
 	tristate "Test functions located in the uuid module at runtime"
 
@@ -2813,6 +2806,14 @@ config USERCOPY_KUNIT_TEST
 	  on the copy_to/from_user infrastructure, making sure basic
 	  user/kernel boundary testing is working.
 
+config BITMAP_KUNIT_TEST
+	tristate "KUnit Test for bitmap_*() family of functions"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the "bitmap_kunit" module that runs tests for
+	  bitmaps int the kernel making sure that there isn't any bug.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 322bb127b4dc6..37e7359a7065e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -84,7 +84,6 @@ obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_SCANF) += test_scanf.o
 
-obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
 # FIXME: Clang breaks test_bitmap_const_eval when KASAN and GCOV are enabled
 GCOV_PROFILE_test_bitmap.o := n
@@ -388,6 +387,7 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
+obj-$(CONFIG_BITMAP_KUNIT_TEST) += bitmap_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/test_bitmap.c b/lib/bitmap_kunit.c
similarity index 100%
rename from lib/test_bitmap.c
rename to lib/bitmap_kunit.c
-- 
2.39.2


