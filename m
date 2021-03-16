Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C70933D412
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Mar 2021 13:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhCPMlo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 08:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhCPMlW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 08:41:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19EBC06174A;
        Tue, 16 Mar 2021 05:41:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v15so10382231wrx.4;
        Tue, 16 Mar 2021 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WbbPs3LK2G3Ypycm0idMfjevIz3nCRtpzY+NLq63piM=;
        b=orni/HtXfBweJ2c/nRKqeYrkKX4zVxfsywpQ6P4MLBSFjB+hBRurnTmQA9pKmUe3qb
         PghF4tYowOxF8UtuBW707iMDdb1mKQ7HNRifkVLTu7KKbPAAptBOqa9fMRmA8AmjaoF3
         6B00ghHm22V9BEsI9kihn73zliMmlKN40Fr2HbMuyN2SMks3Z/sUSKh5Y1s35M9gsXon
         Egwb3jzw5xc35DNULADxJfnKGMtysxRSpWtq2Xy/dX2fFE/M4cCVL1/mt7pn/pNSSlif
         s1SBmJRBSNgSMfdYljhmtQN5bNn2+pLRF1ssPidDR8ykhE6oLFt9el69U8x8uYm12mon
         k1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WbbPs3LK2G3Ypycm0idMfjevIz3nCRtpzY+NLq63piM=;
        b=Dm+heOMgMpehtlEkN07SU2ztLEfbYwpgF0cKjOJBt0kJZwmsYIDNbwH2Uzblgx/ilD
         3Pj57ezoAYfKrTpzq4LSzfNLG4YFJXk6J1NBUKPe/xarGuSERn+1UQMGr6V2f0Ld0dMd
         QYvaaV4WMOCv93SpGaVmZ9Fd1fkWHW4S5HylItC50TK01xp1olVHHMQI2CqPE7hns1Nr
         NySCcBygrlzM/WQXIExOqUK802fHMsEgJLdDHIaN+FNf+v2r/wSYI9OyEzgrOCTga8ys
         /oTzKSj7IY3MCXId+5NjPJ20GUBL2ra9ZipTi9vQsHCtEIkCk2fVzQyjeO4t6OwFaB0F
         MSBg==
X-Gm-Message-State: AOAM531plC/sPfqbU74N5PiQaYzpH/OzfW+H8frtu3ttP4a0/qGsAQSc
        hTWjdcBwXHeCtvEUJmcLb5s=
X-Google-Smtp-Source: ABdhPJwJVXPQpPl2UdLWYlbE9pqZU+kLhQ06TZtcQL7tU+/tYN0pHqcFEpNYagOjLfxQT6NCauX6hQ==
X-Received: by 2002:a5d:5250:: with SMTP id k16mr4707874wrc.309.1615898480317;
        Tue, 16 Mar 2021 05:41:20 -0700 (PDT)
Received: from oliver-Z170M-D3H.cuni.cz ([2001:718:1e03:5128:e847:73bd:bb49:39d7])
        by smtp.gmail.com with ESMTPSA id o2sm3042159wme.16.2021.03.16.05.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 05:41:19 -0700 (PDT)
From:   glittao@gmail.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Oliver Glitta <glittao@gmail.com>
Subject: [PATCH 1/2] selftests: add a kselftest for SLUB debugging functionality
Date:   Tue, 16 Mar 2021 13:41:17 +0100
Message-Id: <20210316124118.6874-1-glittao@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Oliver Glitta <glittao@gmail.com>

SLUB has resiliency_test() function which is hidden behind #ifdef
SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
runs it. Kselftest should proper replacement for it.

Try changing byte in redzone after allocation and changing
pointer to next free node, first byte, 50th byte and redzone
byte. Check if validation finds errors.

There are several differences from the original resiliency test:
Tests create own caches with known state instead of corrupting
shared kmalloc caches.

The corruption of freepointer uses correct offset, the original
resiliency test got broken with freepointer changes.

Scratch changing random byte test, because it does not have
meaning in this form where we need deterministic results.

Add new option CONFIG_TEST_SLUB in Kconfig.

Add parameter to function validate_slab_cache() to return
number of errors in cache.

Signed-off-by: Oliver Glitta <glittao@gmail.com>
---
 lib/Kconfig.debug                    |   4 +
 lib/Makefile                         |   1 +
 lib/test_slub.c                      | 125 +++++++++++++++++++++++++++
 mm/slab.h                            |   1 +
 mm/slub.c                            |  34 +++++---
 tools/testing/selftests/lib/Makefile |   2 +-
 tools/testing/selftests/lib/config   |   1 +
 tools/testing/selftests/lib/slub.sh  |   3 +
 8 files changed, 159 insertions(+), 12 deletions(-)
 create mode 100644 lib/test_slub.c
 create mode 100755 tools/testing/selftests/lib/slub.sh

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2779c29d9981..2d56092abbc4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2123,6 +2123,10 @@ config TEST_KSTRTOX
 config TEST_PRINTF
 	tristate "Test printf() family of functions at runtime"
 
+config TEST_SLUB
+	tristate "Test SLUB cache errors at runtime"
+	depends on SLUB_DEBUG
+
 config TEST_BITMAP
 	tristate "Test bitmap_*() family of functions at runtime"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index b5307d3eec1a..b6603803b1c4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
+obj-$(CONFIG_TEST_SLUB) += test_slub.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
 obj-$(CONFIG_TEST_UUID) += test_uuid.o
diff --git a/lib/test_slub.c b/lib/test_slub.c
new file mode 100644
index 000000000000..0075d9b44251
--- /dev/null
+++ b/lib/test_slub.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test cases for slub facility.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include "../mm/slab.h"
+
+#include "../tools/testing/selftests/kselftest_module.h"
+
+
+KSTM_MODULE_GLOBALS();
+
+
+static void __init validate_result(struct kmem_cache *s, int expected_errors)
+{
+	int errors = 0;
+
+	validate_slab_cache(s, &errors);
+	KSTM_CHECK_ZERO(errors - expected_errors);
+}
+
+static void __init test_clobber_zone(void)
+{
+	struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_alloc", 64, 0,
+				SLAB_RED_ZONE, NULL);
+	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
+
+	p[64] = 0x12;
+	pr_err("1. kmem_cache: Clobber Redzone 0x12->0x%p\n", p + 64);
+
+	validate_result(s, 1);
+	kmem_cache_free(s, p);
+	kmem_cache_destroy(s);
+}
+
+static void __init test_next_pointer(void)
+{
+	struct kmem_cache *s = kmem_cache_create("TestSlub_next_ptr_free", 64, 0,
+				SLAB_RED_ZONE, NULL);
+	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
+
+	kmem_cache_free(s, p);
+	p[s->offset] = 0x12;
+	pr_err("1. kmem_cache: Clobber next pointer 0x34 -> -0x%p\n", p);
+
+	validate_result(s, 1);
+	kmem_cache_destroy(s);
+}
+
+static void __init test_first_word(void)
+{
+	struct kmem_cache *s = kmem_cache_create("TestSlub_1th_word_free", 64, 0,
+				SLAB_POISON, NULL);
+	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
+
+	kmem_cache_free(s, p);
+	*p = 0x78;
+	pr_err("2. kmem_cache: Clobber first word 0x78->0x%p\n", p);
+
+	validate_result(s, 1);
+	kmem_cache_destroy(s);
+}
+
+static void __init test_clobber_50th_byte(void)
+{
+	struct kmem_cache *s = kmem_cache_create("TestSlub_50th_word_free", 64, 0,
+				SLAB_POISON, NULL);
+	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
+
+	kmem_cache_free(s, p);
+	p[50] = 0x9a;
+	pr_err("3. kmem_cache: Clobber 50th byte 0x9a->0x%p\n", p);
+
+	validate_result(s, 1);
+	kmem_cache_destroy(s);
+}
+
+static void __init test_clobber_redzone_free(void)
+{
+	struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_free", 64, 0,
+				SLAB_RED_ZONE, NULL);
+	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
+
+	kmem_cache_free(s, p);
+	p[64] = 0xab;
+	pr_err("4. kmem_cache: Clobber redzone 0xab->0x%p\n", p);
+
+	validate_result(s, 1);
+	kmem_cache_destroy(s);
+}
+
+static void __init resiliency_test(void)
+{
+
+	BUILD_BUG_ON(KMALLOC_MIN_SIZE > 16 || KMALLOC_SHIFT_HIGH < 10);
+
+	pr_err("SLUB resiliency testing\n");
+	pr_err("-----------------------\n");
+	pr_err("A. Corruption after allocation\n");
+
+	test_clobber_zone();
+
+	pr_err("\nB. Corruption after free\n");
+
+	test_next_pointer();
+	test_first_word();
+	test_clobber_50th_byte();
+	test_clobber_redzone_free();
+}
+
+
+static void __init selftest(void)
+{
+	resiliency_test();
+}
+
+
+KSTM_MODULE_LOADERS(test_slub);
+MODULE_LICENSE("GPL");
diff --git a/mm/slab.h b/mm/slab.h
index 076582f58f68..5fc18d506b3b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -215,6 +215,7 @@ DECLARE_STATIC_KEY_TRUE(slub_debug_enabled);
 DECLARE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
 extern void print_tracking(struct kmem_cache *s, void *object);
+long validate_slab_cache(struct kmem_cache *s, int *errors);
 #else
 static inline void print_tracking(struct kmem_cache *s, void *object)
 {
diff --git a/mm/slub.c b/mm/slub.c
index e26c274b4657..c00e2b263e03 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4612,7 +4612,8 @@ static int count_total(struct page *page)
 #endif
 
 #ifdef CONFIG_SLUB_DEBUG
-static void validate_slab(struct kmem_cache *s, struct page *page)
+static void validate_slab(struct kmem_cache *s, struct page *page,
+						int *errors)
 {
 	void *p;
 	void *addr = page_address(page);
@@ -4620,8 +4621,10 @@ static void validate_slab(struct kmem_cache *s, struct page *page)
 
 	slab_lock(page);
 
-	if (!check_slab(s, page) || !on_freelist(s, page, NULL))
+	if (!check_slab(s, page) || !on_freelist(s, page, NULL)) {
+		*errors += 1;
 		goto unlock;
+	}
 
 	/* Now we know that a valid freelist exists */
 	map = get_map(s, page);
@@ -4629,8 +4632,10 @@ static void validate_slab(struct kmem_cache *s, struct page *page)
 		u8 val = test_bit(__obj_to_index(s, addr, p), map) ?
 			 SLUB_RED_INACTIVE : SLUB_RED_ACTIVE;
 
-		if (!check_object(s, page, p, val))
+		if (!check_object(s, page, p, val)) {
+			*errors += 1;
 			break;
+		}
 	}
 	put_map(map);
 unlock:
@@ -4638,7 +4643,7 @@ static void validate_slab(struct kmem_cache *s, struct page *page)
 }
 
 static int validate_slab_node(struct kmem_cache *s,
-		struct kmem_cache_node *n)
+		struct kmem_cache_node *n, int *errors)
 {
 	unsigned long count = 0;
 	struct page *page;
@@ -4647,30 +4652,34 @@ static int validate_slab_node(struct kmem_cache *s,
 	spin_lock_irqsave(&n->list_lock, flags);
 
 	list_for_each_entry(page, &n->partial, slab_list) {
-		validate_slab(s, page);
+		validate_slab(s, page, errors);
 		count++;
 	}
-	if (count != n->nr_partial)
+	if (count != n->nr_partial) {
 		pr_err("SLUB %s: %ld partial slabs counted but counter=%ld\n",
 		       s->name, count, n->nr_partial);
+		*errors += 1;
+	}
 
 	if (!(s->flags & SLAB_STORE_USER))
 		goto out;
 
 	list_for_each_entry(page, &n->full, slab_list) {
-		validate_slab(s, page);
+		validate_slab(s, page, errors);
 		count++;
 	}
-	if (count != atomic_long_read(&n->nr_slabs))
+	if (count != atomic_long_read(&n->nr_slabs)) {
 		pr_err("SLUB: %s %ld slabs counted but counter=%ld\n",
 		       s->name, count, atomic_long_read(&n->nr_slabs));
+		*errors += 1;
+	}
 
 out:
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return count;
 }
 
-static long validate_slab_cache(struct kmem_cache *s)
+long validate_slab_cache(struct kmem_cache *s, int *errors)
 {
 	int node;
 	unsigned long count = 0;
@@ -4678,10 +4687,12 @@ static long validate_slab_cache(struct kmem_cache *s)
 
 	flush_all(s);
 	for_each_kmem_cache_node(s, node, n)
-		count += validate_slab_node(s, n);
+		count += validate_slab_node(s, n, errors);
 
 	return count;
 }
+EXPORT_SYMBOL(validate_slab_cache);
+
 /*
  * Generate lists of code addresses where slabcache objects are allocated
  * and freed.
@@ -5336,9 +5347,10 @@ static ssize_t validate_store(struct kmem_cache *s,
 			const char *buf, size_t length)
 {
 	int ret = -EINVAL;
+	int errors = 0;
 
 	if (buf[0] == '1') {
-		ret = validate_slab_cache(s);
+		ret = validate_slab_cache(s, &errors);
 		if (ret >= 0)
 			ret = length;
 	}
diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index a105f094676e..f168313b7949 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -4,6 +4,6 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh strscpy.sh
+TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh strscpy.sh slub.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index b80ee3f6e265..4190863032e7 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -3,3 +3,4 @@ CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_BITOPS=m
+CONFIG_TEST_SLUB=m
\ No newline at end of file
diff --git a/tools/testing/selftests/lib/slub.sh b/tools/testing/selftests/lib/slub.sh
new file mode 100755
index 000000000000..8b5757702910
--- /dev/null
+++ b/tools/testing/selftests/lib/slub.sh
@@ -0,0 +1,3 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+$(dirname $0)/../kselftest/module.sh "slub" test_slub
-- 
2.17.1

