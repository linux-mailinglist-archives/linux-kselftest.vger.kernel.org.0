Return-Path: <linux-kselftest+bounces-26274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305FEA2FF1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BA01889382
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6561B4243;
	Tue, 11 Feb 2025 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax9sibUj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE45165F13;
	Tue, 11 Feb 2025 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233897; cv=none; b=fi1Ujhsu2E/Enwv1mjYZ3FajsAZp7UqC+CYifARoSEuWFaAwnW3qObc1k7W0+qzrRBVcKPxuHzPT1L8usbpOdYge/2wEgWv5tbJvuGz3YsaSUgvn7Nol89tTGAXS/4maKuLYVStH9/suh3U/USeBmQ5qXfD9ImD447Yylwsp9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233897; c=relaxed/simple;
	bh=2aBcGYde6FqKkGz9SbdnoeL7YJGk9ss6Wg4DyxvPqHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SqLTCAJ8m0XTNMqPEnOYvwYuYA6akHcdQZtsIrdMhWzBCVDG2CLphay1VEjDrrCEEHLmuevJuE2mnK83UG1OvhbNMA9g2SmeizgSV1ULG4iUj4cqPQuUjaMRrxwwNQwQ9YjsXViVhEpXhz6cPp7cbGxeKmRueS/9oWix46DzEzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax9sibUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E85DC4CEE7;
	Tue, 11 Feb 2025 00:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739233896;
	bh=2aBcGYde6FqKkGz9SbdnoeL7YJGk9ss6Wg4DyxvPqHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ax9sibUjQwEcsIGBlYJjiUPyBGuyF29oZsfqj1TOtTNWh8H3rcbVmzM4eBySOQS1F
	 1+Fb+QqVHViQWzw0fJYKw4CHDyoCelcEybUtQjoUUfpSfrJMj4EOlqve6uOg+nOKxD
	 eM0w8kU37EvIXUZCUTANqTMGM2mwSIej33il51RnJ+EMlM0eIOhelSyiXyyDPQUuii
	 Rg7tPkWyR9urmYMw86u8+tkNcwu8FnLD3Wt8jZf4nITcIMjUzYm9F3aLeedfefUkSQ
	 fF7bgzUogZeDiFf4NIGVXiodB1wcuhvmm0byHBl5kGzh6iA08iwEk5kzrGbixGmGTY
	 kIdKZAyZhHMbw==
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Rae Moar <rmoar@google.com>,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Pedro Orlando <porlando@lkcamp.dev>,
	Danilo Pereira <dpereira@lkcamp.dev>,
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	=?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH v2 3/6] lib: Move KUnit tests into tests/ subdirectory
Date: Mon, 10 Feb 2025 16:31:31 -0800
Message-Id: <20250211003136.2860503-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211002600.it.339-kees@kernel.org>
References: <20250211002600.it.339-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16536; i=kees@kernel.org; h=from:subject; bh=2aBcGYde6FqKkGz9SbdnoeL7YJGk9ss6Wg4DyxvPqHs=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmrZqVqL/+ysfRDUWC2/j2B1rPlh/eIbI1LiBVddd/zd tn2ffcmdJSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzE+jfDHy4OvT1TfHdt9XZe 9Z7Bc8KyFW3yRlYZH3v4fU8tiK4vy2P4Z87wIJX7KmOi+/kWfWunayZvJusW2/YIiSbdeLC9Kii QFQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Following from the recent KUnit file naming discussion[1], move all
KUnit tests in lib/ into lib/tests/.

Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [1]
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Rae Moar <rmoar@google.com>
Link: https://lore.kernel.org/r/20241202075545.3648096-4-davidgow@google.com
Signed-off-by: Kees Cook <kees@kernel.org>
---
 MAINTAINERS                            | 19 ++++++------
 lib/Makefile                           | 39 +------------------------
 lib/tests/Makefile                     | 40 ++++++++++++++++++++++++++
 lib/{ => tests}/bitfield_kunit.c       |  0
 lib/{ => tests}/checksum_kunit.c       |  0
 lib/{ => tests}/cmdline_kunit.c        |  0
 lib/{ => tests}/cpumask_kunit.c        |  0
 lib/{ => tests}/crc_kunit.c            |  0
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
 lib/{ => tests}/util_macros_kunit.c    |  0
 29 files changed, 51 insertions(+), 47 deletions(-)
 rename lib/{ => tests}/bitfield_kunit.c (100%)
 rename lib/{ => tests}/checksum_kunit.c (100%)
 rename lib/{ => tests}/cmdline_kunit.c (100%)
 rename lib/{ => tests}/cpumask_kunit.c (100%)
 rename lib/{ => tests}/crc_kunit.c (100%)
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
 rename lib/{ => tests}/util_macros_kunit.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353d..78be36fb1a74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4017,10 +4017,10 @@ F:	include/vdso/bits.h
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
@@ -9065,9 +9065,10 @@ L:	linux-hardening@vger.kernel.org
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
 
@@ -9755,9 +9756,9 @@ F:	include/linux/string.h
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
@@ -12985,7 +12986,7 @@ F:	Documentation/trace/kprobes.rst
 F:	include/asm-generic/kprobes.h
 F:	include/linux/kprobes.h
 F:	kernel/kprobes.c
-F:	lib/test_kprobes.c
+F:	lib/tests/test_kprobes.c
 F:	samples/kprobes
 
 KS0108 LCD CONTROLLER DRIVER
@@ -13315,7 +13316,7 @@ M:	Mark Brown <broonie@kernel.org>
 R:	Matti Vaittinen <mazziesaccount@gmail.com>
 F:	include/linux/linear_range.h
 F:	lib/linear_ranges.c
-F:	lib/test_linear_ranges.c
+F:	lib/tests/test_linear_ranges.c
 
 LINUX FOR POWER MACINTOSH
 L:	linuxppc-dev@lists.ozlabs.org
@@ -13443,7 +13444,7 @@ M:	David Gow <davidgow@google.com>
 L:	linux-kselftest@vger.kernel.org
 L:	kunit-dev@googlegroups.com
 S:	Maintained
-F:	lib/list-test.c
+F:	lib/tests/list-test.c
 
 LITEX PLATFORM
 M:	Karol Gugala <kgugala@antmicro.com>
@@ -21732,7 +21733,7 @@ M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
 F:	include/linux/siphash.h
 F:	lib/siphash.c
-F:	lib/siphash_kunit.c
+F:	lib/tests/siphash_kunit.c
 
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu@fr.zoreil.com>
diff --git a/lib/Makefile b/lib/Makefile
index d5cfc7afbbb8..1e886482a6a3 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -52,9 +52,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
 	 generic-radix-tree.o bitmap-str.o
-obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
 obj-y += string_helpers.o
-obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
 obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
@@ -65,22 +63,17 @@ obj-$(CONFIG_TEST_DHRY) += test_dhry.o
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
@@ -98,7 +91,6 @@ obj-$(CONFIG_TEST_XARRAY) += test_xarray.o
 obj-$(CONFIG_TEST_MAPLE_TREE) += test_maple_tree.o
 obj-$(CONFIG_TEST_PARMAN) += test_parman.o
 obj-$(CONFIG_TEST_KMOD) += test_kmod.o
-obj-$(CONFIG_TEST_RUNTIME) += tests/
 obj-$(CONFIG_TEST_DEBUG_VIRTUAL) += test_debug_virtual.o
 obj-$(CONFIG_TEST_MEMCAT_P) += test_memcat_p.o
 obj-$(CONFIG_TEST_OBJAGG) += test_objagg.o
@@ -107,10 +99,7 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
 obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
-obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
-CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
-obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
 obj-$(CONFIG_TEST_OBJPOOL) += test_objpool.o
 
 obj-$(CONFIG_TEST_FPU) += test_fpu.o
@@ -132,7 +121,7 @@ endif
 obj-$(CONFIG_DEBUG_INFO_REDUCED) += debug_info.o
 CFLAGS_debug_info.o += $(call cc-option, -femit-struct-debug-detailed=any)
 
-obj-y += math/ crypto/
+obj-y += math/ crypto/ tests/
 
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
@@ -368,32 +357,6 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 # pldmfw library
 obj-$(CONFIG_PLDMFW) += pldmfw/
 
-# KUnit tests
-CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
-obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
-obj-$(CONFIG_CHECKSUM_KUNIT) += checksum_kunit.o
-obj-$(CONFIG_UTIL_MACROS_KUNIT) += util_macros_kunit.o
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
-obj-$(CONFIG_CRC_KUNIT_TEST) += crc_kunit.o
-obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
-obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
-
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
 obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 8e4f42cb9c54..c7b5170359c1 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -1 +1,41 @@
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
+obj-$(CONFIG_CRC_KUNIT_TEST) += crc_kunit.o
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
+obj-$(CONFIG_UTIL_MACROS_KUNIT) += util_macros_kunit.o
+
 obj-$(CONFIG_TEST_RUNTIME_MODULE)		+= module/
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
diff --git a/lib/crc_kunit.c b/lib/tests/crc_kunit.c
similarity index 100%
rename from lib/crc_kunit.c
rename to lib/tests/crc_kunit.c
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
diff --git a/lib/util_macros_kunit.c b/lib/tests/util_macros_kunit.c
similarity index 100%
rename from lib/util_macros_kunit.c
rename to lib/tests/util_macros_kunit.c
-- 
2.34.1


