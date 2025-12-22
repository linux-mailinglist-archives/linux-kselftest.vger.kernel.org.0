Return-Path: <linux-kselftest+bounces-47845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6994CD6321
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 14:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 187B7301CD8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 13:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB06F30E0EF;
	Mon, 22 Dec 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIcyOygu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567431B80D;
	Mon, 22 Dec 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766410811; cv=none; b=n7DlUwWbe5enA6X9qbLLQfawargQz3NN2PfoFmYzF/eZy83EcvYtihsBPOy27/ad9j6mHFxk95Yu9mrXDjP4L3fmYsGYgLT1DToMJiKtohKScqmXzFnlFcTg9IepC1X7H4Zyi8h6KQ2gTP95N+ufUGufrhT42bV4GmuSbxyQfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766410811; c=relaxed/simple;
	bh=mtS8Kvu9/mONxUUwl2Nlym25iZ9mTaL+M/fwiwknd1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2wvcaVmCBCjvblVYqFB8R5qNp7po52L9e4BExJQnXDePfFawqqlIFbN2MmPk2Omg6pLQqWNXtRCRRilru4+jxPaRUXBXvjUJZn3BZwp7Ke3q5o9pwF0yetT5OhZh+XGLYpTgghg1MMTEkM0E9XW9y2YoPISx1YFzm0Q356p2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIcyOygu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5F7C4CEF1;
	Mon, 22 Dec 2025 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766410810;
	bh=mtS8Kvu9/mONxUUwl2Nlym25iZ9mTaL+M/fwiwknd1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QIcyOygu4QXSvh5kbxH4W9KKoJp6FVUgO5+mABqtp9oUGzu+w4CNLor2JFs4HOT1V
	 09dkOrXUQ0hiYLM2GZNLBclCyKkUjNiS0OEYPN3k9UnaDiKBJa0FpMpcvDhXrhdp3+
	 Dw6yOaxkE/RAkF7qkZasm7l8nbE+XKf2j/AAGXlAWssXpB4+yC4O4UG9cArnEywaRN
	 TyE/YLbhOZZmFbOeGkYBaKPUJZQ4julhQbPV8/vERDfgXiveRxTnTlImSeRch8dPKI
	 k1CLCJtk8nMixGjO/iKUQIpM/dcRI4HVJ+6dPX587iDuWvUyRMYp631vIuWOGr6kvY
	 DMXhu0w1SxzYg==
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 22 Dec 2025 14:39:54 +0100
Subject: [PATCH v2 1/3] test_bitmap: extract benchmark module
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-bitmap-kunit-convert-v2-1-6a61a5330eff@gmail.com>
References: <20251222-bitmap-kunit-convert-v2-0-6a61a5330eff@gmail.com>
In-Reply-To: <20251222-bitmap-kunit-convert-v2-0-6a61a5330eff@gmail.com>
To: David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Naveen N Rao <naveen@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>, 
 Kees Cook <kees@kernel.org>, Christophe Leroy <chleroy@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>, 
 Alexander Potapenko <glider@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1766410800; l=6436;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=GMqVJX7sYDmccv8BUc6BjwKaZE9btULzDU952wHq7kU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QN1w0lwI4EDkjSCyvbmTMG0+z/zTkm5yd4Nv6KtVEft48jXkSO8zk7SfPpZMbZ/9tuYSrr8xcfZ
 FiM4s3AVcHgc=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

Add CONFIG_BITMAP_BENCHMARK to build benchmarks separately from unit
tests. The new module is marked authored by the author of commit
991e5583647d ("lib/test_bitmap: add tests for bitmap_{read,write}()")
which added these benchmarks.

Extract duplicated code between `test_bitmap_{read,write}_perf`.

Cc: Alexander Potapenko <glider@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 MAINTAINERS            |  1 +
 lib/Kconfig.debug      |  8 +++++
 lib/Makefile           |  1 +
 lib/bitmap_benchmark.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/test_bitmap.c      | 50 ----------------------------
 5 files changed, 99 insertions(+), 50 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..4ddaef15b408 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4426,6 +4426,7 @@ F:	include/uapi/linux/bits.h
 F:	include/vdso/bits.h
 F:	lib/bitmap-str.c
 F:	lib/bitmap.c
+F:	lib/bitmap_benchmark.c
 F:	lib/cpumask.c
 F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939fda79..60434b31a940 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2492,6 +2492,14 @@ config FFS_KUNIT_TEST
 config TEST_KSTRTOX
 	tristate "Test kstrto*() family of functions at runtime"
 
+config BITMAP_BENCHMARK
+	tristate "Benchmark bitmap_*() family of functions"
+	help
+	  This builds the "bitmap_benchmark_test" module that measure bitmap_*()
+	  family of functions performance.
+
+	  If unsure, say N.
+
 config TEST_BITMAP
 	tristate "Test bitmap_*() family of functions at runtime"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index aaf677cf4527..892cb3152b65 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -61,6 +61,7 @@ obj-y += string_helpers.o
 obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
+obj-$(CONFIG_BITMAP_BENCHMARK) += bitmap_benchmark.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK_RUST) += find_bit_benchmark_rust.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
diff --git a/lib/bitmap_benchmark.c b/lib/bitmap_benchmark.c
new file mode 100644
index 000000000000..47f4cea4e831
--- /dev/null
+++ b/lib/bitmap_benchmark.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Benchmarks for bitmap API.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/bitmap.h>
+#include <linux/init.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+
+/*
+ * Test bitmap should be big enough to include the cases when start is not in
+ * the first word, and start+nbits lands in the following word.
+ */
+#define TEST_BIT_LEN (1000)
+
+typedef void (*bitmap_bench_fn)(unsigned long *bitmap, unsigned long i, unsigned long nbits);
+
+static void __init bench_bitmap(bitmap_bench_fn bench_fn, const char *name)
+{
+	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
+	unsigned int cnt, nbits, i;
+	ktime_t time;
+
+	bitmap_fill(bitmap, TEST_BIT_LEN);
+	time = ktime_get();
+	for (cnt = 0; cnt < 5; cnt++) {
+		for (nbits = 1; nbits <= BITS_PER_LONG; nbits++) {
+			for (i = 0; i < TEST_BIT_LEN; i++) {
+				if (i + nbits > TEST_BIT_LEN)
+					break;
+				bench_fn(bitmap, i, nbits);
+			}
+		}
+	}
+	time = ktime_get() - time;
+	pr_info("Time spent in %s:\t%llu\n", name, time);
+}
+
+#undef TEST_BIT_LEN
+
+static inline void bitmap_read_bench(unsigned long *bitmap, unsigned long i, unsigned long nbits)
+{
+	unsigned long val;
+	/*
+	 * Prevent the compiler from optimizing away the
+	 * bitmap_read() by using its value.
+	 */
+	WRITE_ONCE(val, bitmap_read(bitmap, i, nbits));
+}
+
+static void __init test_bitmap_read_perf(void)
+{
+	bench_bitmap(bitmap_read_bench, __func__);
+}
+
+static inline void bitmap_write_bench(unsigned long *bitmap, unsigned long i, unsigned long nbits)
+{
+	unsigned long val = 0xfeedface;
+
+	bitmap_write(bitmap, val, i, nbits);
+}
+
+static void __init test_bitmap_write_perf(void)
+{
+	bench_bitmap(bitmap_write_bench, __func__);
+}
+
+static int __init bitmap_benchmark_init(void)
+{
+	test_bitmap_read_perf();
+	test_bitmap_write_perf();
+
+	return 0;
+}
+module_init(bitmap_benchmark_init);
+
+static void __exit bitmap_benchmark_exit(void)
+{
+	pr_info("Unloaded\n");
+}
+module_exit(bitmap_benchmark_exit);
+
+MODULE_AUTHOR("Alexander Potapenko <glider@google.com>");
+MODULE_DESCRIPTION("Benchmarks for bitmap API");
+MODULE_LICENSE("GPL");
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index c83829ef557f..f728b6485c88 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -1372,54 +1372,6 @@ static void __init test_bitmap_read_write(void)
 		test_bitmap_write_helper(pattern[pi]);
 }
 
-static void __init test_bitmap_read_perf(void)
-{
-	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
-	unsigned int cnt, nbits, i;
-	unsigned long val;
-	ktime_t time;
-
-	bitmap_fill(bitmap, TEST_BIT_LEN);
-	time = ktime_get();
-	for (cnt = 0; cnt < 5; cnt++) {
-		for (nbits = 1; nbits <= BITS_PER_LONG; nbits++) {
-			for (i = 0; i < TEST_BIT_LEN; i++) {
-				if (i + nbits > TEST_BIT_LEN)
-					break;
-				/*
-				 * Prevent the compiler from optimizing away the
-				 * bitmap_read() by using its value.
-				 */
-				WRITE_ONCE(val, bitmap_read(bitmap, i, nbits));
-			}
-		}
-	}
-	time = ktime_get() - time;
-	pr_info("Time spent in %s:\t%llu\n", __func__, time);
-}
-
-static void __init test_bitmap_write_perf(void)
-{
-	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
-	unsigned int cnt, nbits, i;
-	unsigned long val = 0xfeedface;
-	ktime_t time;
-
-	bitmap_zero(bitmap, TEST_BIT_LEN);
-	time = ktime_get();
-	for (cnt = 0; cnt < 5; cnt++) {
-		for (nbits = 1; nbits <= BITS_PER_LONG; nbits++) {
-			for (i = 0; i < TEST_BIT_LEN; i++) {
-				if (i + nbits > TEST_BIT_LEN)
-					break;
-				bitmap_write(bitmap, val, i, nbits);
-			}
-		}
-	}
-	time = ktime_get() - time;
-	pr_info("Time spent in %s:\t%llu\n", __func__, time);
-}
-
 #undef TEST_BIT_LEN
 
 static void __init selftest(void)
@@ -1440,8 +1392,6 @@ static void __init selftest(void)
 	test_bitmap_print_buf();
 	test_bitmap_const_eval();
 	test_bitmap_read_write();
-	test_bitmap_read_perf();
-	test_bitmap_write_perf();
 
 	test_find_nth_bit();
 	test_for_each_set_bit();

-- 
2.52.0


