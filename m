Return-Path: <linux-kselftest+bounces-19522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D85DB999DF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 09:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A294B2300A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2220A5CA;
	Fri, 11 Oct 2024 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4c/2QQMX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499520ADD2
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631874; cv=none; b=kEJkH/u3nUj7F2KjEUAPfMzh8AqSDWj4eMnuc6IXcFCWnK8Q8EThUOWKgFe4R/yYpDeLZrJ6660kPqL/IB7earygPjHfWz6TCj0uxad8IDED3uBBzM/D5O0Efn5MF3pOb8f5zciFTO9bT0gTDJScHZ97yae5dcjw6Z6ieLTKmFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631874; c=relaxed/simple;
	bh=YW58ht6CyiuZkFliYx0qFm95AAGfQIn/SYFw2I/6ruc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CzWKRVAl3gQVRy1CKX9QZ0f5e3ruFtv9q6gMmEqxzAhnwnieADOvOQAujxmfhKl0Sdwt0+biBObG0pju0mtaySEjp+qF3HClwba4f5JiTKtATKp4So1jngb1Q9J+z+qWoHJ4xPsUDjdnMVwBVShdSzdWx+h/ikvTWfXxJkg4lEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4c/2QQMX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32b43e053so24730287b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 00:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728631869; x=1729236669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oEo/RIpbwWM3TDrwxpV43z65/ZOiBhGZMKP7K+QyLzo=;
        b=4c/2QQMXtLvBuk0UBIAnCy5Gz7bd5BjB7MelCG8k7P04+4VZFqV0DgeGTchsfjLYEg
         c2hmI6yA8QaoEEKGApBN5UbTTYAzwFZTT0YN9tzzzm558ppyT3jCUbLK9PSRwOZKcHJ5
         /TRLfzEFqgLQGDI/DN6fdVDSSfn867IcPMEokwAP6Ykem7jb1yW6ucN7t4z47P6QB8nL
         Y86phDXLB4skaHK0gBKMokzPBGlICnECHc/7elADmyZJBiDr5WqiuCC/jLFh/zYDno8z
         7ViRI2I8qPKHR8SCjrLFuOfckJeTyurVzVx1cHpzgJZ0E08xNejeO+slj4cF399INebY
         91Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631869; x=1729236669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEo/RIpbwWM3TDrwxpV43z65/ZOiBhGZMKP7K+QyLzo=;
        b=n6XEdIMJYjcUIt+G8FviLp/iBs19IbhPoZRuw9HHF0fs/ETOrXBDZlIOBmlJYfn5yC
         PB4BTQYF/DtXNsNESee70HMWNPw5LbOKCHFkbRdW94h7VU/CiloycSdUXns/HNeGOjTv
         cQMXN1drzie2+Vj3E4BVbr2BgzehVVM6rbJXyJR2/UaqkMZ+wSdJP02xeXOtaDp/Z1Il
         d7bAlq8L7yaY3QP5k+F2lOD58F7TAIhfSUKzR7PIo2mPfD+lCkZf2mgoKMs68jxr3Gyu
         yHkjSna3u+I9M8E7abae/XFtnrsw8gUBqAjEd6ZPwa657W+kpM8uzw+dldsw0K+4NO8B
         01/g==
X-Gm-Message-State: AOJu0Yx/NyKUTNtaucMwJrCwKbawNNWSBukvuAJF9kbjKBO/30wZ697D
	Q10WqGYsasOaUP+/NtkYD2g6rmJzqK75dPgki4eSynbsAa6jbOuW4chMYNcoAoCIBu5NzTf8g/G
	OKYEgJLE+Pg==
X-Google-Smtp-Source: AGHT+IGdqFCzf4VfBt+kJ7UuT23EboG4g5C752yNmlJ+lOYyUe/sQDWFfgg9Cath79/UvjftuMEFz9qfNUfSHQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a05:690c:dc2:b0:6e3:39e5:f0e8 with SMTP
 id 00721157ae682-6e347c4e59fmr218467b3.6.1728631869517; Fri, 11 Oct 2024
 00:31:09 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:25:07 +0800
In-Reply-To: <20241011072509.3068328-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011072509.3068328-2-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011072509.3068328-5-davidgow@google.com>
Subject: [PATCH 3/6] lib: Move KUnit tests into tests/ subdirectory
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Andy Shevchenko <andy@kernel.org>, 
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Brown <broonie@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Charlie Jenkins <charlie@rivosinc.com>, Simon Horman <horms@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Latypov <dlatypov@google.com>, 
	Guenter Roeck <linux@roeck-us.net>, David Howells <dhowells@redhat.com>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Nathan Chancellor <nathan@kernel.org>, 
	Fangrui Song <maskray@google.com>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Kees Cook <kees@kernel.org>

Following from the recent KUnit file naming discussion[1], move all
KUnit tests in lib/ into lib/tests/.

Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [1]
Signed-off-by: Kees Cook <kees@kernel.org>
Acked-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Reviewed-by: David Gow <davidgow@google.com>
[Rebased onto mm-nonmm-unstable, moved usercopy_kunit]
Signed-off-by: David Gow <davidgow@google.com>
---
 MAINTAINERS                            | 19 +++++++------
 lib/Makefile                           | 36 +-----------------------
 lib/tests/Makefile                     | 38 ++++++++++++++++++++++++++
 lib/{ => tests}/bitfield_kunit.c       |  0
 lib/{ => tests}/checksum_kunit.c       |  0
 lib/{ => tests}/cmdline_kunit.c        |  0
 lib/{ => tests}/cpumask_kunit.c        |  0
 lib/{ => tests}/fortify_kunit.c        |  0
 lib/{ => tests}/hashtable_test.c       |  0
 lib/{ => tests}/is_signed_type_kunit.c |  0
 lib/{ => tests}/kunit_iov_iter.c       |  0
 lib/{ => tests}/list-test.c            |  0
 lib/{ => tests}/memcpy_kunit.c         |  0
 lib/{ => tests}/overflow_kunit.c       |  0
 lib/{ => tests}/siphash_kunit.c        |  0
 lib/{ => tests}/slub_kunit.c           |  0
 lib/{ => tests}/stackinit_kunit.c      |  0
 lib/{ => tests}/string_helpers_kunit.c |  0
 lib/{ => tests}/string_kunit.c         |  0
 lib/{ => tests}/test_bits.c            |  0
 lib/{ => tests}/test_fprobe.c          |  0
 lib/{ => tests}/test_hash.c            |  0
 lib/{ => tests}/test_kprobes.c         |  0
 lib/{ => tests}/test_linear_ranges.c   |  0
 lib/{ => tests}/test_list_sort.c       |  0
 lib/{ => tests}/test_sort.c            |  0
 lib/{ => tests}/usercopy_kunit.c       |  0
 27 files changed, 49 insertions(+), 44 deletions(-)
 create mode 100644 lib/tests/Makefile
 rename lib/{ => tests}/bitfield_kunit.c (100%)
 rename lib/{ => tests}/checksum_kunit.c (100%)
 rename lib/{ => tests}/cmdline_kunit.c (100%)
 rename lib/{ => tests}/cpumask_kunit.c (100%)
 rename lib/{ => tests}/fortify_kunit.c (100%)
 rename lib/{ => tests}/hashtable_test.c (100%)
 rename lib/{ => tests}/is_signed_type_kunit.c (100%)
 rename lib/{ => tests}/kunit_iov_iter.c (100%)
 rename lib/{ => tests}/list-test.c (100%)
 rename lib/{ => tests}/memcpy_kunit.c (100%)
 rename lib/{ => tests}/overflow_kunit.c (100%)
 rename lib/{ => tests}/siphash_kunit.c (100%)
 rename lib/{ => tests}/slub_kunit.c (100%)
 rename lib/{ => tests}/stackinit_kunit.c (100%)
 rename lib/{ => tests}/string_helpers_kunit.c (100%)
 rename lib/{ => tests}/string_kunit.c (100%)
 rename lib/{ => tests}/test_bits.c (100%)
 rename lib/{ => tests}/test_fprobe.c (100%)
 rename lib/{ => tests}/test_hash.c (100%)
 rename lib/{ => tests}/test_kprobes.c (100%)
 rename lib/{ => tests}/test_linear_ranges.c (100%)
 rename lib/{ => tests}/test_list_sort.c (100%)
 rename lib/{ => tests}/test_sort.c (100%)
 rename lib/{ => tests}/usercopy_kunit.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1e1cd652699..bbba5c760533 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3929,10 +3929,10 @@ F:	include/vdso/bits.h
 F:	lib/bitmap-str.c
 F:	lib/bitmap.c
 F:	lib/cpumask.c
-F:	lib/cpumask_kunit.c
 F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
 F:	lib/test_bitmap.c
+F:	lib/tests/cpumask_kunit.c
 F:	tools/include/linux/bitfield.h
 F:	tools/include/linux/bitmap.h
 F:	tools/include/linux/bits.h
@@ -8911,9 +8911,10 @@ L:	linux-hardening@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	include/linux/fortify-string.h
-F:	lib/fortify_kunit.c
-F:	lib/memcpy_kunit.c
 F:	lib/test_fortify/*
+F:	lib/tests/fortify_kunit.c
+F:	lib/tests/memcpy_kunit.c
+F:	scripts/test_fortify.sh
 K:	\bunsafe_memcpy\b
 K:	\b__NO_FORTIFY\b
 
@@ -9578,9 +9579,9 @@ F:	include/linux/string.h
 F:	include/linux/string_choices.h
 F:	include/linux/string_helpers.h
 F:	lib/string.c
-F:	lib/string_kunit.c
 F:	lib/string_helpers.c
-F:	lib/string_helpers_kunit.c
+F:	lib/tests/string_helpers_kunit.c
+F:	lib/tests/string_kunit.c
 F:	scripts/coccinelle/api/string_choices.cocci
 
 GENERIC UIO DRIVER FOR PCI DEVICES
@@ -12741,7 +12742,7 @@ F:	Documentation/trace/kprobes.rst
 F:	include/asm-generic/kprobes.h
 F:	include/linux/kprobes.h
 F:	kernel/kprobes.c
-F:	lib/test_kprobes.c
+F:	lib/tests/test_kprobes.c
 F:	samples/kprobes
 
 KS0108 LCD CONTROLLER DRIVER
@@ -13091,7 +13092,7 @@ M:	Mark Brown <broonie@kernel.org>
 R:	Matti Vaittinen <mazziesaccount@gmail.com>
 F:	include/linux/linear_range.h
 F:	lib/linear_ranges.c
-F:	lib/test_linear_ranges.c
+F:	lib/tests/test_linear_ranges.c
 
 LINUX FOR POWER MACINTOSH
 L:	linuxppc-dev@lists.ozlabs.org
@@ -13219,7 +13220,7 @@ M:	David Gow <davidgow@google.com>
 L:	linux-kselftest@vger.kernel.org
 L:	kunit-dev@googlegroups.com
 S:	Maintained
-F:	lib/list-test.c
+F:	lib/tests/list-test.c
 
 LITEX PLATFORM
 M:	Karol Gugala <kgugala@antmicro.com>
@@ -21199,7 +21200,7 @@ M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
 F:	include/linux/siphash.h
 F:	lib/siphash.c
-F:	lib/siphash_kunit.c
+F:	lib/tests/siphash_kunit.c
 
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu@fr.zoreil.com>
diff --git a/lib/Makefile b/lib/Makefile
index 53f82de7cbe2..7f2ddbf03fe9 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -51,9 +51,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
 	 generic-radix-tree.o bitmap-str.o
-obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
 obj-y += string_helpers.o
-obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
 obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
@@ -64,22 +62,17 @@ obj-$(CONFIG_TEST_DHRY) += test_dhry.o
 obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
 obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
 CFLAGS_test_bitops.o += -Werror
-obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_kunit.o
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
-obj-$(CONFIG_TEST_IOV_ITER) += kunit_iov_iter.o
-obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, unused-but-set-variable)
 UBSAN_SANITIZE_test_ubsan.o := y
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
-obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
 obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
-obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
@@ -105,10 +98,7 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
 obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
-obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
-CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
-obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
 obj-$(CONFIG_TEST_OBJPOOL) += test_objpool.o
 
 obj-$(CONFIG_TEST_FPU) += test_fpu.o
@@ -130,7 +120,7 @@ endif
 obj-$(CONFIG_DEBUG_INFO_REDUCED) += debug_info.o
 CFLAGS_debug_info.o += $(call cc-option, -femit-struct-debug-detailed=any)
 
-obj-y += math/ crypto/
+obj-y += math/ crypto/ tests/
 
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
@@ -367,30 +357,6 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 # pldmfw library
 obj-$(CONFIG_PLDMFW) += pldmfw/
 
-# KUnit tests
-CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
-obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
-obj-$(CONFIG_CHECKSUM_KUNIT) += checksum_kunit.o
-obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
-obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
-obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
-obj-$(CONFIG_BITS_TEST) += test_bits.o
-obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
-obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
-obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
-obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_kunit.o
-CFLAGS_overflow_kunit.o = $(call cc-disable-warning, tautological-constant-out-of-range-compare)
-obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
-CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
-obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
-CFLAGS_fortify_kunit.o += $(call cc-disable-warning, unsequenced)
-CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-overread)
-CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-truncation)
-CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
-obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
-obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
-obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
-
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
 obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
new file mode 100644
index 000000000000..41689f0b7c97
--- /dev/null
+++ b/lib/tests/Makefile
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for tests of kernel library functions.
+
+# KUnit tests
+CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
+obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
+obj-$(CONFIG_BITS_TEST) += test_bits.o
+obj-$(CONFIG_CHECKSUM_KUNIT) += checksum_kunit.o
+obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
+obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_kunit.o
+CFLAGS_fortify_kunit.o += $(call cc-disable-warning, unsequenced)
+CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-overread)
+CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-truncation)
+CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
+obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
+CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
+obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
+obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
+obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
+obj-$(CONFIG_TEST_IOV_ITER) += kunit_iov_iter.o
+obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_kunit.o
+obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
+obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
+obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
+obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
+CFLAGS_overflow_kunit.o = $(call cc-disable-warning, tautological-constant-out-of-range-compare)
+obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
+obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
+obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
+obj-$(CONFIG_TEST_SORT) += test_sort.o
+CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
+obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
+obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
+obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
+obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
+
diff --git a/lib/bitfield_kunit.c b/lib/tests/bitfield_kunit.c
similarity index 100%
rename from lib/bitfield_kunit.c
rename to lib/tests/bitfield_kunit.c
diff --git a/lib/checksum_kunit.c b/lib/tests/checksum_kunit.c
similarity index 100%
rename from lib/checksum_kunit.c
rename to lib/tests/checksum_kunit.c
diff --git a/lib/cmdline_kunit.c b/lib/tests/cmdline_kunit.c
similarity index 100%
rename from lib/cmdline_kunit.c
rename to lib/tests/cmdline_kunit.c
diff --git a/lib/cpumask_kunit.c b/lib/tests/cpumask_kunit.c
similarity index 100%
rename from lib/cpumask_kunit.c
rename to lib/tests/cpumask_kunit.c
diff --git a/lib/fortify_kunit.c b/lib/tests/fortify_kunit.c
similarity index 100%
rename from lib/fortify_kunit.c
rename to lib/tests/fortify_kunit.c
diff --git a/lib/hashtable_test.c b/lib/tests/hashtable_test.c
similarity index 100%
rename from lib/hashtable_test.c
rename to lib/tests/hashtable_test.c
diff --git a/lib/is_signed_type_kunit.c b/lib/tests/is_signed_type_kunit.c
similarity index 100%
rename from lib/is_signed_type_kunit.c
rename to lib/tests/is_signed_type_kunit.c
diff --git a/lib/kunit_iov_iter.c b/lib/tests/kunit_iov_iter.c
similarity index 100%
rename from lib/kunit_iov_iter.c
rename to lib/tests/kunit_iov_iter.c
diff --git a/lib/list-test.c b/lib/tests/list-test.c
similarity index 100%
rename from lib/list-test.c
rename to lib/tests/list-test.c
diff --git a/lib/memcpy_kunit.c b/lib/tests/memcpy_kunit.c
similarity index 100%
rename from lib/memcpy_kunit.c
rename to lib/tests/memcpy_kunit.c
diff --git a/lib/overflow_kunit.c b/lib/tests/overflow_kunit.c
similarity index 100%
rename from lib/overflow_kunit.c
rename to lib/tests/overflow_kunit.c
diff --git a/lib/siphash_kunit.c b/lib/tests/siphash_kunit.c
similarity index 100%
rename from lib/siphash_kunit.c
rename to lib/tests/siphash_kunit.c
diff --git a/lib/slub_kunit.c b/lib/tests/slub_kunit.c
similarity index 100%
rename from lib/slub_kunit.c
rename to lib/tests/slub_kunit.c
diff --git a/lib/stackinit_kunit.c b/lib/tests/stackinit_kunit.c
similarity index 100%
rename from lib/stackinit_kunit.c
rename to lib/tests/stackinit_kunit.c
diff --git a/lib/string_helpers_kunit.c b/lib/tests/string_helpers_kunit.c
similarity index 100%
rename from lib/string_helpers_kunit.c
rename to lib/tests/string_helpers_kunit.c
diff --git a/lib/string_kunit.c b/lib/tests/string_kunit.c
similarity index 100%
rename from lib/string_kunit.c
rename to lib/tests/string_kunit.c
diff --git a/lib/test_bits.c b/lib/tests/test_bits.c
similarity index 100%
rename from lib/test_bits.c
rename to lib/tests/test_bits.c
diff --git a/lib/test_fprobe.c b/lib/tests/test_fprobe.c
similarity index 100%
rename from lib/test_fprobe.c
rename to lib/tests/test_fprobe.c
diff --git a/lib/test_hash.c b/lib/tests/test_hash.c
similarity index 100%
rename from lib/test_hash.c
rename to lib/tests/test_hash.c
diff --git a/lib/test_kprobes.c b/lib/tests/test_kprobes.c
similarity index 100%
rename from lib/test_kprobes.c
rename to lib/tests/test_kprobes.c
diff --git a/lib/test_linear_ranges.c b/lib/tests/test_linear_ranges.c
similarity index 100%
rename from lib/test_linear_ranges.c
rename to lib/tests/test_linear_ranges.c
diff --git a/lib/test_list_sort.c b/lib/tests/test_list_sort.c
similarity index 100%
rename from lib/test_list_sort.c
rename to lib/tests/test_list_sort.c
diff --git a/lib/test_sort.c b/lib/tests/test_sort.c
similarity index 100%
rename from lib/test_sort.c
rename to lib/tests/test_sort.c
diff --git a/lib/usercopy_kunit.c b/lib/tests/usercopy_kunit.c
similarity index 100%
rename from lib/usercopy_kunit.c
rename to lib/tests/usercopy_kunit.c
-- 
2.47.0.rc1.288.g06298d1525-goog


