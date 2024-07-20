Return-Path: <linux-kselftest+bounces-13967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1A7938263
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 20:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFAF1F22154
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 18:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091D4148311;
	Sat, 20 Jul 2024 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovAZaTTs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64537462;
	Sat, 20 Jul 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721499033; cv=none; b=dOvB0Tu8lQojN1TzHL6zGjaa/Wsr+d2RatTmhpkFTKHlC5dxu1jts5ndpElI9/573Sm6VFBlox9v9Bu3ky2meMGz+3L2kNg4Qgn5rYgRjUpuPProNapRR6u71maSAdfOigmA7kzHNzxmIFKJP7q2KFnCwzR+kV8NxRXtwg5UMvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721499033; c=relaxed/simple;
	bh=7KjECDG3UMnl0JG/c7/djxbrpIZzqKkVPri+HXLrfnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IyWbvblUeBco/JwDgigvEuitLl38NFdaFI/5INpo+I3V5XjtSlVhqgcqHc+c+GxUHwnufWt2Gyvmavw56XcXsuxCu3wUU5dU1fgQhtoVxd+wyPp2HM7WOCcDA4AhPQOr4lM1NHmNhNnaa6j0IUM+1lXArhMz+h2sXYdAtLQX4AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovAZaTTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC22C2BD10;
	Sat, 20 Jul 2024 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721499033;
	bh=7KjECDG3UMnl0JG/c7/djxbrpIZzqKkVPri+HXLrfnA=;
	h=From:To:Cc:Subject:Date:From;
	b=ovAZaTTsEyVWn6lIc2ACou5zSPQM4HhIXu2JRTZE2L4NS/fi9sLOSFhibKk5kzUS0
	 l7oatRlBU4dkIhX5juOAC+L6+tyhiVqChz56PC4157sFg/iAVT8hdgH6Noct708pB9
	 C5ngEVjHPk+IJ/M+/N7Voum9mODEf87CECRbi4uowyy066E4wAYKCqSIx0yve2PBWw
	 R3IAlaOSVeh+vpv0Tx6vSYeKhcqLWZg6nreTJMCpBCZs3ZLWWRnwAHD7OzuQnBN5OJ
	 YC2uEa6t9Mn7ah8B9C2nWb0mjecbNEDIMI1eSdMB6TnD7jZRLGVrXSa9iosOXjGydz
	 UhoXcU5TDrpYA==
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	David Gow <davidgow@google.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Latypov <dlatypov@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	David Howells <dhowells@redhat.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Fangrui Song <maskray@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lib: Move KUnit tests into tests/ subdirectory
Date: Sat, 20 Jul 2024 11:10:30 -0700
Message-Id: <20240720181025.work.002-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15510; i=kees@kernel.org; h=from:subject:message-id; bh=7KjECDG3UMnl0JG/c7/djxbrpIZzqKkVPri+HXLrfnA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmm/2WXCZSehmjBMLPW/zZmWg4p1VNP1uMjmWVj dD0JUbenXyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpv9lgAKCRCJcvTf3G3A JksGD/493uO43iGBQYiay/nI9Zr92sqgTpnOkm2cOvUJihedzHG48LpZLiICW2bPN1uAoGaSxX6 qjCqKlmSAh432/NQ7pm0jUZcOC4cs0witvN6Mxb3iG/20DywJDem8eq1ijXkCLefPPpezQO45vf gstkMG89styOXplsiAs8ydYauUb0SifuzfAW9fS+Jqa3Mh2RR13eyyOnlX3jD1r/5ALEPgpGJwH v07bi4FflUj1CyMDjqYfkceS4U2uPYfojBX4DV/Z+AxBgKRSJh4o4OMRkjjnuW1BfPCmVgPGVPB XFEylgDxq4SZjKdLIjfI6bS8/tnrkF+t/CMNKM+oXlGXfdzjIIziJ4lrtiHzhow+OlODry4/IMA +CTQEpHRQYssPRYDIIspl+DxBFDNceIhMgxyz/FfToTUD/OV2KoY8/3RtMNBWqiK0hB10xCsUBC VfB01/EAoupv+YCe90B3rnOCXYebV2RhpBg+Cg33UjbaCFdl0p8P6vYJFn6yLAAdI4lOeUz2ASt lNJ3amsZ16UbCZqo4TOg2v9k6XOKVtoiIu6Iz7pxsmLvYVB5YwCvYYzLYqpYl3FguIUNqrH28AB 7YQP+dMG/v5vEBhQU8ui6c9j/pPg1utFx/ksZdsn6fBEJQShcLXt0YupS+53seFx5nPOcsZJurT I5OPRelFdKx0
 dVA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Following from the recent KUnit file naming discussion[1], move all
KUnit tests in lib/ into lib/tests/.

Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
I can carry this in the hardening tree. To disrupt people as little as
possible, I'm hoping to send this either at the end of -rc1 or early
in -rc2.
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: David Gow <davidgow@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-hardening@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: linux-trace-kernel@vger.kernel.org
---
 MAINTAINERS                            | 18 ++++++-------
 lib/Makefile                           | 35 +-----------------------
 lib/tests/Makefile                     | 37 ++++++++++++++++++++++++++
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
 26 files changed, 47 insertions(+), 43 deletions(-)
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

diff --git a/MAINTAINERS b/MAINTAINERS
index 8754ac2c259d..3f4b9d007cbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3737,10 +3737,10 @@ F:	include/vdso/bits.h
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
@@ -8618,9 +8618,9 @@ L:	linux-hardening@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	include/linux/fortify-string.h
-F:	lib/fortify_kunit.c
-F:	lib/memcpy_kunit.c
 F:	lib/test_fortify/*
+F:	lib/tests/fortify_kunit.c
+F:	lib/tests/memcpy_kunit.c
 F:	scripts/test_fortify.sh
 K:	\b__NO_FORTIFY\b
 
@@ -9246,9 +9246,9 @@ F:	include/linux/string.h
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
@@ -12347,7 +12347,7 @@ F:	Documentation/trace/kprobes.rst
 F:	include/asm-generic/kprobes.h
 F:	include/linux/kprobes.h
 F:	kernel/kprobes.c
-F:	lib/test_kprobes.c
+F:	lib/tests/test_kprobes.c
 F:	samples/kprobes
 
 KS0108 LCD CONTROLLER DRIVER
@@ -12697,7 +12697,7 @@ M:	Mark Brown <broonie@kernel.org>
 R:	Matti Vaittinen <mazziesaccount@gmail.com>
 F:	include/linux/linear_range.h
 F:	lib/linear_ranges.c
-F:	lib/test_linear_ranges.c
+F:	lib/tests/test_linear_ranges.c
 
 LINUX FOR POWER MACINTOSH
 L:	linuxppc-dev@lists.ozlabs.org
@@ -12824,7 +12824,7 @@ M:	David Gow <davidgow@google.com>
 L:	linux-kselftest@vger.kernel.org
 L:	kunit-dev@googlegroups.com
 S:	Maintained
-F:	lib/list-test.c
+F:	lib/tests/list-test.c
 
 LITEX PLATFORM
 M:	Karol Gugala <kgugala@antmicro.com>
@@ -20498,7 +20498,7 @@ M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
 F:	include/linux/siphash.h
 F:	lib/siphash.c
-F:	lib/siphash_kunit.c
+F:	lib/tests/siphash_kunit.c
 
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu@fr.zoreil.com>
diff --git a/lib/Makefile b/lib/Makefile
index 3b1769045651..f00fe120ee9e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -49,9 +49,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
 	 generic-radix-tree.o bitmap-str.o
-obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
 obj-y += string_helpers.o
-obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
 obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
@@ -62,22 +60,17 @@ obj-$(CONFIG_TEST_DHRY) += test_dhry.o
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
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
@@ -104,10 +97,7 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
 obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
-obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
-CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
-obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
 obj-$(CONFIG_TEST_OBJPOOL) += test_objpool.o
 
 obj-$(CONFIG_TEST_FPU) += test_fpu.o
@@ -129,7 +119,7 @@ endif
 obj-$(CONFIG_DEBUG_INFO_REDUCED) += debug_info.o
 CFLAGS_debug_info.o += $(call cc-option, -femit-struct-debug-detailed=any)
 
-obj-y += math/ crypto/
+obj-y += math/ crypto/ tests/
 
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
@@ -366,29 +356,6 @@ obj-$(CONFIG_OBJAGG) += objagg.o
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
-
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
 obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
new file mode 100644
index 000000000000..c6a14cc8663e
--- /dev/null
+++ b/lib/tests/Makefile
@@ -0,0 +1,37 @@
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
-- 
2.34.1


