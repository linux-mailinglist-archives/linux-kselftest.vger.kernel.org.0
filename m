Return-Path: <linux-kselftest+bounces-22660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7079DFB7C
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 08:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBEB6B23182
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 07:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3900A1F9F4B;
	Mon,  2 Dec 2024 07:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kl/LlEgv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C501F9F45
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126171; cv=none; b=SC2dRoGxSjml770JlwjPCZOA1F6bQ6iQT41efL1YEz4JtG1Q7CCcpiZ8KpaS8fIuPn7ogLJ5gpru8fdqkJ/HtRjjHsEBHemhVxXpSl9Y9XkUZm7oN80YaWVx/0C8sGnVeLk8LFryh35W1S4FQzg6KXD7OR4acBhMyp1lHba3wfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126171; c=relaxed/simple;
	bh=PTwZG+xeW4r6TGRZabeBQgiUfqSbeBJL0Rc7EatVp7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RwO2trrHc/3whGmTBjfSeU2+2zNObOmB3MgPU0sPp7vyY2Yz78vouFHtHRXHWE0nNPX7tethFKpyhg/MyZL5lPpW2ZjWUOkiw40OvzM2rl6i4rLJIS4snFhVoO1HHNy+8ARzf5FojIXDIJ3cqXBGmWVdFg7JWUR3CHFBqC3tQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kl/LlEgv; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-71d408ed723so2240036a34.1
        for <linux-kselftest@vger.kernel.org>; Sun, 01 Dec 2024 23:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733126167; x=1733730967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9jM/9b5jx9DMRfGm5JMb8cVSoHQiHXfvZ3cw4a/aiN8=;
        b=kl/LlEgvROYQQrghJv4bWwzKd9Ulk2DKld/5+dsgFmMu1ekfdSaG+j0QxX9vcFmEWj
         6hYXGByk4vL3ARL3YTYKU26NHT36MDqxOPgHJoX6qqsQDI6ybnEK0rxqencON2MJAZHE
         dHQSNQZvq/naULRCWowIjflDZpOjpgRkrp/8TJEZoudfVo/PILuoZTFjqfmE7wTjmDP/
         NtYV9KWasZNYu62PM24uHgtVbLzPhd5tCpPim2jIteS58J2nNItZpFw5fpxJsuxkcRaR
         Uw8JgtY2ipLeb+QM+Io7TlFuwtJOdbQiur9F1zGL9PKJHkAUYmLjxxWBWdyMXwY8OZEq
         do/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733126167; x=1733730967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jM/9b5jx9DMRfGm5JMb8cVSoHQiHXfvZ3cw4a/aiN8=;
        b=Q/ZWuL7pWGMiqzBU3k+aWSLULJdpmeoFwFGw0iplb+0BsNZB2/bqKquYAAIf8Oe41M
         Pjvh5AFFWTrP0vFirgqriojJNjVNliJUNkTYxHZD/it//Gy41soiNuMnBm9fiOFgLL4z
         w8uqbyMn9663xcT0OKK5HIKlQwD3pivIWSpqpXnjC3UgiEFvOs+yY08QtSP9OnP2wdCQ
         7bXgrg0rgGPEDSImmygdLqw311Pe/mRAcplHc0kkCP5Wqn37v/6bCpBg7Euom2zfUY8c
         EVTnT9Qpe4DlY4KgLMJCV274GWKjby+h4seWDMt1ReX4qO3UjMQYgdnxfAUwVBhOW6tT
         QSNg==
X-Gm-Message-State: AOJu0YzB2v+kM/uUPHYmQxx/i/6WL2G24bGYRBW015CLu0GTtz0ePX7q
	BIzzH59hsFuDccA/1mEYkSQDzIDkIugmRczIXaxU4QQYqRX338jhufWcySL97QKFFnKVcLBzP12
	V1Jm/kwnSaw==
X-Google-Smtp-Source: AGHT+IELB2c5ZfJpNRGUZy9vdSpjB/iCYlrbq6NGv7iDk6gjohS448uqDwSM8kx+wKR/U7gS9yci46f4T4pKiA==
X-Received: from pgah11.prod.google.com ([2002:a05:6a02:4e8b:b0:7fc:2b57:38f5])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:44a5:b0:71d:3e91:31b0 with SMTP id 46e09a7af769-71d65c78435mr14160469a34.4.1733126166976;
 Sun, 01 Dec 2024 23:56:06 -0800 (PST)
Date: Mon,  2 Dec 2024 15:55:40 +0800
In-Reply-To: <20241202075545.3648096-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202075545.3648096-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202075545.3648096-4-davidgow@google.com>
Subject: [PATCH v2 3/6] lib: Move KUnit tests into tests/ subdirectory
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Rae Moar <rmoar@google.com>, Kees Cook <kees@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Andy Shevchenko <andy@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, Jakub Kicinski <kuba@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, David Gow <davidgow@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>
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
Acked-by: Vlastimil Babka <vbabka@suse.cz> #slab
[Rebased onto v6.13-rc1, moved crc16,usercopy,util-macros tests]
Signed-off-by: David Gow <davidgow@google.com>
---
 MAINTAINERS                            | 19 ++++++------
 lib/Makefile                           | 39 +------------------------
 lib/tests/Makefile                     | 40 ++++++++++++++++++++++++++
 lib/{ => tests}/bitfield_kunit.c       |  0
 lib/{ => tests}/checksum_kunit.c       |  0
 lib/{ => tests}/cmdline_kunit.c        |  0
 lib/{ => tests}/cpumask_kunit.c        |  0
 lib/{ => tests}/crc16_kunit.c          |  0
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
 rename lib/{ => tests}/crc16_kunit.c (100%)
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
index 1e930c7a58b1..9c35902ffccf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3966,10 +3966,10 @@ F:	include/vdso/bits.h
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
@@ -8972,9 +8972,10 @@ L:	linux-hardening@vger.kernel.org
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
 
@@ -9655,9 +9656,9 @@ F:	include/linux/string.h
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
@@ -12868,7 +12869,7 @@ F:	Documentation/trace/kprobes.rst
 F:	include/asm-generic/kprobes.h
 F:	include/linux/kprobes.h
 F:	kernel/kprobes.c
-F:	lib/test_kprobes.c
+F:	lib/tests/test_kprobes.c
 F:	samples/kprobes
 
 KS0108 LCD CONTROLLER DRIVER
@@ -13198,7 +13199,7 @@ M:	Mark Brown <broonie@kernel.org>
 R:	Matti Vaittinen <mazziesaccount@gmail.com>
 F:	include/linux/linear_range.h
 F:	lib/linear_ranges.c
-F:	lib/test_linear_ranges.c
+F:	lib/tests/test_linear_ranges.c
 
 LINUX FOR POWER MACINTOSH
 L:	linuxppc-dev@lists.ozlabs.org
@@ -13326,7 +13327,7 @@ M:	David Gow <davidgow@google.com>
 L:	linux-kselftest@vger.kernel.org
 L:	kunit-dev@googlegroups.com
 S:	Maintained
-F:	lib/list-test.c
+F:	lib/tests/list-test.c
 
 LITEX PLATFORM
 M:	Karol Gugala <kgugala@antmicro.com>
@@ -21490,7 +21491,7 @@ M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
 F:	include/linux/siphash.h
 F:	lib/siphash.c
-F:	lib/siphash_kunit.c
+F:	lib/tests/siphash_kunit.c
 
 SIS 190 ETHERNET DRIVER
 M:	Francois Romieu <romieu@fr.zoreil.com>
diff --git a/lib/Makefile b/lib/Makefile
index a8155c972f02..3fa31c4c1e57 100644
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
@@ -370,32 +359,6 @@ obj-$(CONFIG_OBJAGG) += objagg.o
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
-obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
-obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
-obj-$(CONFIG_CRC16_KUNIT_TEST) += crc16_kunit.o
-
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
 obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 8e4f42cb9c54..03bf5a884984 100644
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
+obj-$(CONFIG_CRC16_KUNIT_TEST) += crc16_kunit.o
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
diff --git a/lib/crc16_kunit.c b/lib/tests/crc16_kunit.c
similarity index 100%
rename from lib/crc16_kunit.c
rename to lib/tests/crc16_kunit.c
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
2.47.0.338.g60cca15819-goog


