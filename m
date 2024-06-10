Return-Path: <linux-kselftest+bounces-11605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7428A902AA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 23:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD9D1F22876
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 21:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF50C1411DF;
	Mon, 10 Jun 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAc91S7n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6506823A3;
	Mon, 10 Jun 2024 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055211; cv=none; b=b1SMNeWHy0chnCKrrM9gJogL2z0hH0XXPRDOzo833RyqgO7XM3KE41tij2EJ+hM66SCRV8YmDH0Vw3KpOoq1nR4QTx/jcBzRkL8Ypvyz/hjAZeIdgxytzW2nqbsdwXK+p0oTva+5UWSpwN5qN0oUk+PDYw7CfA/RYmQ2yckL59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055211; c=relaxed/simple;
	bh=GRnlzHKq5aMXH2GhwxdxPnYAkFdUtWZSo+OWffpaVfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SS/p25Bg0A2+By65L/8HLQZHnktD/zk/D16oxRbK/pNmr1MLbVY+v4MyAp/qJpPM/6wl8YOiyVuMmDf1QKLuatV0IGdG7cOztfkesAae9MegcV9rRJwk5Pxhx8X7qM4PbBpFSi2ZcL87pB0vqUlu86ndq0WkllkmJfQnUwgVlKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAc91S7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC95C4AF1C;
	Mon, 10 Jun 2024 21:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718055210;
	bh=GRnlzHKq5aMXH2GhwxdxPnYAkFdUtWZSo+OWffpaVfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAc91S7nbFtkADGUTbMbHpC2IcLORyoMvAXxg6Sbm5+ebymJwnwvMBm+uBDAi8F5R
	 qxipyNMP7NyKPOB0k232lSARvfzlfrfH6TTH46T4cwe/SYcQ8dCFYXgnoEaUJUwF7E
	 jmL1poJDtXvpIZ6bAXWA+qPk9OkcgSIh+v4BXP+Q0ScoyOyG87/K38TGcGbUwxtqFB
	 drYZN1E58Fy1FPlN/iibnvsDDsDPNRA8oIdjr+/OzNmfujyP1Bmokf4ObAv5ZQWNbq
	 zakxmAQWSd2gXHkoOArzY9Fe8xBQR/0OMCKhKQSpyF+MBmM+Vo2z3i+lOsYjUsP/HF
	 sMGdM8qlgr+Fw==
From: Kees Cook <kees@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2] usercopy: Convert test_user_copy to KUnit test
Date: Mon, 10 Jun 2024 14:33:29 -0700
Message-Id: <20240610213330.1310156-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610213055.it.075-kees@kernel.org>
References: <20240610213055.it.075-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17970; i=kees@kernel.org; h=from:subject; bh=GRnlzHKq5aMXH2GhwxdxPnYAkFdUtWZSo+OWffpaVfE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmZ3EplFH97VNa3dWpoXuKJ2EVjs8oxzqd6qqbq dSJlbhHUimJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZmdxKQAKCRCJcvTf3G3A JhupD/oChI8KvX6ELI7TU1GIrmMet6CGbY+03yqABngtaU548/GGjFk4yQcjNAfDxHHObrOAWXj FgBGdIzFXvwvXHafCmwqgicebuczS+j8hxrCHrylf6PDr0epnjDBNgO006+lZA1uoISYq4OlWso u3765Y4mbNL6S2D+QNwdQ4s9Llb5bzt5FY6gmrnMr/dBIG3fYT7JnJDRt1nYKUyiYtK+/y87PW6 20Si4AzK6CDutoZ40n2oo6sICpPLYVv1ge8LP4XFcG7xqsEfCEqI5j62bAehL5dFZKnmtKt5+8N wrWAyIUd4tnsmPgmC8EVHSgu3qH2ZnLPWmkXuMPahTV/XL7soGUz2ToEQjS8zUa94zCAY6UJGwK iFoCt4SlLv5ualrcWQImHsjps/5AQh/AzRHKhu7iYuMFgE7c6dJ3aq0frMG+/UNHhQ2XLOLDbJi E4779kLqffHu2gEqUJH5nhMvGEwrbi/hMZMRnsz6gSlw44qVmciTn5i5b8sLXxOLd7MaG8MAaLo Wx8xvtqFWMekVJWYPT4PVXPik6tL6VVpK876zuV8s1IjCojQRa+W2rx24vmnUCht0NGp4J6rg9m HZNJHt2/Q3CqoBb52UWDPy/F8NK4R/uh0F4drh9UDYbH/984to9lP79WUWF9AKfaFbtmFSGl20p pNVmTUIKssE49/A==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Convert the runtime tests of hardened usercopy to standard KUnit tests.

Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Link: https://lore.kernel.org/r/20200721174654.72132-1-vitor@massaru.org
Tested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 MAINTAINERS                                |   1 +
 lib/Kconfig.debug                          |  21 +-
 lib/Makefile                               |   2 +-
 lib/{test_user_copy.c => usercopy_kunit.c} | 273 ++++++++++-----------
 4 files changed, 142 insertions(+), 155 deletions(-)
 rename lib/{test_user_copy.c => usercopy_kunit.c} (47%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8754ac2c259d..0cd171ec6010 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11962,6 +11962,7 @@ F:	arch/*/configs/hardening.config
 F:	include/linux/overflow.h
 F:	include/linux/randomize_kstack.h
 F:	kernel/configs/hardening.config
+F:	lib/usercopy_kunit.c
 F:	mm/usercopy.c
 K:	\b(add|choose)_random_kstack_offset\b
 K:	\b__check_(object_size|heap_object)\b
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 59b6765d86b8..561e346f5cb0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2505,18 +2505,6 @@ config TEST_VMALLOC
 
 	  If unsure, say N.
 
-config TEST_USER_COPY
-	tristate "Test user/kernel boundary protections"
-	depends on m
-	help
-	  This builds the "test_user_copy" module that runs sanity checks
-	  on the copy_to/from_user infrastructure, making sure basic
-	  user/kernel boundary testing is working. If it fails to load,
-	  a regression has been detected in the user/kernel memory boundary
-	  protections.
-
-	  If unsure, say N.
-
 config TEST_BPF
 	tristate "Test BPF filter functionality"
 	depends on m && NET
@@ -2814,6 +2802,15 @@ config SIPHASH_KUNIT_TEST
 	  This is intended to help people writing architecture-specific
 	  optimized versions.  If unsure, say N.
 
+config USERCOPY_KUNIT_TEST
+	tristate "KUnit Test for user/kernel boundary protections"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the "usercopy_kunit" module that runs sanity checks
+	  on the copy_to/from_user infrastructure, making sure basic
+	  user/kernel boundary testing is working.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 3b1769045651..fae5cc67b95a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -78,7 +78,6 @@ obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
 obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
 obj-$(CONFIG_TEST_SORT) += test_sort.o
-obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
@@ -388,6 +387,7 @@ CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-truncation)
 CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
+obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/test_user_copy.c b/lib/usercopy_kunit.c
similarity index 47%
rename from lib/test_user_copy.c
rename to lib/usercopy_kunit.c
index 5ff04d8fe971..f1689f2c5c7b 100644
--- a/lib/test_user_copy.c
+++ b/lib/usercopy_kunit.c
@@ -15,7 +15,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
-#include <linux/vmalloc.h>
+#include <kunit/test.h>
 
 /*
  * Several 32-bit architectures support 64-bit {get,put}_user() calls.
@@ -31,26 +31,27 @@
 # define TEST_U64
 #endif
 
-#define test(condition, msg, ...)					\
-({									\
-	int cond = (condition);						\
-	if (cond)							\
-		pr_warn("[%d] " msg "\n", __LINE__, ##__VA_ARGS__);	\
-	cond;								\
-})
+struct usercopy_test_priv {
+	char *kmem;
+	char __user *umem;
+	size_t size;
+};
 
 static bool is_zeroed(void *from, size_t size)
 {
 	return memchr_inv(from, 0x0, size) == NULL;
 }
 
-static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
+/* Test usage of check_nonzero_user(). */
+static void usercopy_test_check_nonzero_user(struct kunit *test)
 {
-	int ret = 0;
 	size_t start, end, i, zero_start, zero_end;
+	struct usercopy_test_priv *priv = test->priv;
+	char __user *umem = priv->umem;
+	char *kmem = priv->kmem;
+	size_t size = priv->size;
 
-	if (test(size < 2 * PAGE_SIZE, "buffer too small"))
-		return -EINVAL;
+	KUNIT_ASSERT_GE_MSG(test, size, 2 * PAGE_SIZE, "buffer too small");
 
 	/*
 	 * We want to cross a page boundary to exercise the code more
@@ -84,8 +85,8 @@ static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
 	for (i = zero_end; i < size; i += 2)
 		kmem[i] = 0xff;
 
-	ret |= test(copy_to_user(umem, kmem, size),
-		    "legitimate copy_to_user failed");
+	KUNIT_EXPECT_EQ_MSG(test, copy_to_user(umem, kmem, size), 0,
+		"legitimate copy_to_user failed");
 
 	for (start = 0; start <= size; start++) {
 		for (end = start; end <= size; end++) {
@@ -93,35 +94,32 @@ static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
 			int retval = check_zeroed_user(umem + start, len);
 			int expected = is_zeroed(kmem + start, len);
 
-			ret |= test(retval != expected,
-				    "check_nonzero_user(=%d) != memchr_inv(=%d) mismatch (start=%zu, end=%zu)",
-				    retval, expected, start, end);
+			KUNIT_EXPECT_EQ_MSG(test, retval, expected,
+				"check_nonzero_user(=%d) != memchr_inv(=%d) mismatch (start=%zu, end=%zu)",
+				retval, expected, start, end);
 		}
 	}
-
-	return ret;
 }
 
-static int test_copy_struct_from_user(char *kmem, char __user *umem,
-				      size_t size)
+/* Test usage of copy_struct_from_user(). */
+static void usercopy_test_copy_struct_from_user(struct kunit *test)
 {
-	int ret = 0;
 	char *umem_src = NULL, *expected = NULL;
+	struct usercopy_test_priv *priv = test->priv;
+	char __user *umem = priv->umem;
+	char *kmem = priv->kmem;
+	size_t size = priv->size;
 	size_t ksize, usize;
 
-	umem_src = kmalloc(size, GFP_KERNEL);
-	ret = test(umem_src == NULL, "kmalloc failed");
-	if (ret)
-		goto out_free;
+	umem_src = kunit_kmalloc(test, size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, umem_src);
 
-	expected = kmalloc(size, GFP_KERNEL);
-	ret = test(expected == NULL, "kmalloc failed");
-	if (ret)
-		goto out_free;
+	expected = kunit_kmalloc(test, size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected);
 
 	/* Fill umem with a fixed byte pattern. */
 	memset(umem_src, 0x3e, size);
-	ret |= test(copy_to_user(umem, umem_src, size),
+	KUNIT_ASSERT_EQ_MSG(test, copy_to_user(umem, umem_src, size), 0,
 		    "legitimate copy_to_user failed");
 
 	/* Check basic case -- (usize == ksize). */
@@ -131,9 +129,9 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
 	memcpy(expected, umem_src, ksize);
 
 	memset(kmem, 0x0, size);
-	ret |= test(copy_struct_from_user(kmem, ksize, umem, usize),
+	KUNIT_EXPECT_EQ_MSG(test, copy_struct_from_user(kmem, ksize, umem, usize), 0,
 		    "copy_struct_from_user(usize == ksize) failed");
-	ret |= test(memcmp(kmem, expected, ksize),
+	KUNIT_EXPECT_EQ_MSG(test, memcmp(kmem, expected, ksize), 0,
 		    "copy_struct_from_user(usize == ksize) gives unexpected copy");
 
 	/* Old userspace case -- (usize < ksize). */
@@ -144,9 +142,9 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
 	memset(expected + usize, 0x0, ksize - usize);
 
 	memset(kmem, 0x0, size);
-	ret |= test(copy_struct_from_user(kmem, ksize, umem, usize),
+	KUNIT_EXPECT_EQ_MSG(test, copy_struct_from_user(kmem, ksize, umem, usize), 0,
 		    "copy_struct_from_user(usize < ksize) failed");
-	ret |= test(memcmp(kmem, expected, ksize),
+	KUNIT_EXPECT_EQ_MSG(test, memcmp(kmem, expected, ksize), 0,
 		    "copy_struct_from_user(usize < ksize) gives unexpected copy");
 
 	/* New userspace (-E2BIG) case -- (usize > ksize). */
@@ -154,7 +152,7 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
 	usize = size;
 
 	memset(kmem, 0x0, size);
-	ret |= test(copy_struct_from_user(kmem, ksize, umem, usize) != -E2BIG,
+	KUNIT_EXPECT_EQ_MSG(test, copy_struct_from_user(kmem, ksize, umem, usize), -E2BIG,
 		    "copy_struct_from_user(usize > ksize) didn't give E2BIG");
 
 	/* New userspace (success) case -- (usize > ksize). */
@@ -162,78 +160,46 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
 	usize = size;
 
 	memcpy(expected, umem_src, ksize);
-	ret |= test(clear_user(umem + ksize, usize - ksize),
+	KUNIT_EXPECT_EQ_MSG(test, clear_user(umem + ksize, usize - ksize), 0,
 		    "legitimate clear_user failed");
 
 	memset(kmem, 0x0, size);
-	ret |= test(copy_struct_from_user(kmem, ksize, umem, usize),
+	KUNIT_EXPECT_EQ_MSG(test, copy_struct_from_user(kmem, ksize, umem, usize), 0,
 		    "copy_struct_from_user(usize > ksize) failed");
-	ret |= test(memcmp(kmem, expected, ksize),
+	KUNIT_EXPECT_EQ_MSG(test, memcmp(kmem, expected, ksize), 0,
 		    "copy_struct_from_user(usize > ksize) gives unexpected copy");
-
-out_free:
-	kfree(expected);
-	kfree(umem_src);
-	return ret;
 }
 
-static int __init test_user_copy_init(void)
+/*
+ * Legitimate usage: none of these copies should fail.
+ */
+static void usercopy_test_valid(struct kunit *test)
 {
-	int ret = 0;
-	char *kmem;
-	char __user *usermem;
-	char *bad_usermem;
-	unsigned long user_addr;
-	u8 val_u8;
-	u16 val_u16;
-	u32 val_u32;
-#ifdef TEST_U64
-	u64 val_u64;
-#endif
-
-	kmem = kmalloc(PAGE_SIZE * 2, GFP_KERNEL);
-	if (!kmem)
-		return -ENOMEM;
+	struct usercopy_test_priv *priv = test->priv;
+	char __user *usermem = priv->umem;
+	char *kmem = priv->kmem;
 
-	user_addr = vm_mmap(NULL, 0, PAGE_SIZE * 2,
-			    PROT_READ | PROT_WRITE | PROT_EXEC,
-			    MAP_ANONYMOUS | MAP_PRIVATE, 0);
-	if (user_addr >= (unsigned long)(TASK_SIZE)) {
-		pr_warn("Failed to allocate user memory\n");
-		kfree(kmem);
-		return -ENOMEM;
-	}
-
-	usermem = (char __user *)user_addr;
-	bad_usermem = (char *)user_addr;
-
-	/*
-	 * Legitimate usage: none of these copies should fail.
-	 */
 	memset(kmem, 0x3a, PAGE_SIZE * 2);
-	ret |= test(copy_to_user(usermem, kmem, PAGE_SIZE),
-		    "legitimate copy_to_user failed");
+	KUNIT_EXPECT_EQ_MSG(test, 0, copy_to_user(usermem, kmem, PAGE_SIZE),
+	     "legitimate copy_to_user failed");
 	memset(kmem, 0x0, PAGE_SIZE);
-	ret |= test(copy_from_user(kmem, usermem, PAGE_SIZE),
-		    "legitimate copy_from_user failed");
-	ret |= test(memcmp(kmem, kmem + PAGE_SIZE, PAGE_SIZE),
-		    "legitimate usercopy failed to copy data");
-
-#define test_legit(size, check)						  \
-	do {								  \
-		val_##size = check;					  \
-		ret |= test(put_user(val_##size, (size __user *)usermem), \
-		    "legitimate put_user (" #size ") failed");		  \
-		val_##size = 0;						  \
-		ret |= test(get_user(val_##size, (size __user *)usermem), \
-		    "legitimate get_user (" #size ") failed");		  \
-		ret |= test(val_##size != check,			  \
-		    "legitimate get_user (" #size ") failed to do copy"); \
-		if (val_##size != check) {				  \
-			pr_info("0x%llx != 0x%llx\n",			  \
-				(unsigned long long)val_##size,		  \
-				(unsigned long long)check);		  \
-		}							  \
+	KUNIT_EXPECT_EQ_MSG(test, 0, copy_from_user(kmem, usermem, PAGE_SIZE),
+	     "legitimate copy_from_user failed");
+	KUNIT_EXPECT_EQ_MSG(test, 0, memcmp(kmem, kmem + PAGE_SIZE, PAGE_SIZE),
+	     "legitimate usercopy failed to copy data");
+
+#define test_legit(size, check)						\
+	do {								\
+		size val_##size = (check);				\
+		KUNIT_EXPECT_EQ_MSG(test, 0,				\
+			put_user(val_##size, (size __user *)usermem),	\
+			"legitimate put_user (" #size ") failed");	\
+		val_##size = 0;						\
+		KUNIT_EXPECT_EQ_MSG(test, 0,				\
+			get_user(val_##size, (size __user *)usermem),	\
+			"legitimate get_user (" #size ") failed");	\
+		KUNIT_EXPECT_EQ_MSG(test, val_##size, check,		\
+			"legitimate get_user (" #size ") failed to do copy"); \
 	} while (0)
 
 	test_legit(u8,  0x5a);
@@ -243,27 +209,30 @@ static int __init test_user_copy_init(void)
 	test_legit(u64, 0x5a5b5c5d6a6b6c6d);
 #endif
 #undef test_legit
+}
 
-	/* Test usage of check_nonzero_user(). */
-	ret |= test_check_nonzero_user(kmem, usermem, 2 * PAGE_SIZE);
-	/* Test usage of copy_struct_from_user(). */
-	ret |= test_copy_struct_from_user(kmem, usermem, 2 * PAGE_SIZE);
-
-	/*
-	 * Invalid usage: none of these copies should succeed.
-	 */
+/*
+ * Invalid usage: none of these copies should succeed.
+ */
+static void usercopy_test_invalid(struct kunit *test)
+{
+	struct usercopy_test_priv *priv = test->priv;
+	char __user *usermem = priv->umem;
+	char *bad_usermem = (char *)usermem;
+	char *kmem = priv->kmem;
+	u64 *kmem_u64 = (u64 *)kmem;
 
 	/* Prepare kernel memory with check values. */
 	memset(kmem, 0x5a, PAGE_SIZE);
 	memset(kmem + PAGE_SIZE, 0, PAGE_SIZE);
 
 	/* Reject kernel-to-kernel copies through copy_from_user(). */
-	ret |= test(!copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
-				    PAGE_SIZE),
+	KUNIT_EXPECT_NE_MSG(test, copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
+						 PAGE_SIZE), 0,
 		    "illegal all-kernel copy_from_user passed");
 
 	/* Destination half of buffer should have been zeroed. */
-	ret |= test(memcmp(kmem + PAGE_SIZE, kmem, PAGE_SIZE),
+	KUNIT_EXPECT_EQ_MSG(test, memcmp(kmem + PAGE_SIZE, kmem, PAGE_SIZE), 0,
 		    "zeroing failure for illegal all-kernel copy_from_user");
 
 #if 0
@@ -273,30 +242,31 @@ static int __init test_user_copy_init(void)
 	 * to be tested in LKDTM instead, since this test module does not
 	 * expect to explode.
 	 */
-	ret |= test(!copy_from_user(bad_usermem, (char __user *)kmem,
-				    PAGE_SIZE),
+	KUNIT_EXPECT_NE_MSG(test, copy_from_user(bad_usermem, (char __user *)kmem,
+						 PAGE_SIZE), 0,
 		    "illegal reversed copy_from_user passed");
 #endif
-	ret |= test(!copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
-				  PAGE_SIZE),
+	KUNIT_EXPECT_NE_MSG(test, copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
+					       PAGE_SIZE), 0,
 		    "illegal all-kernel copy_to_user passed");
-	ret |= test(!copy_to_user((char __user *)kmem, bad_usermem,
-				  PAGE_SIZE),
+	KUNIT_EXPECT_NE_MSG(test, copy_to_user((char __user *)kmem, bad_usermem,
+					       PAGE_SIZE), 0,
 		    "illegal reversed copy_to_user passed");
 
-#define test_illegal(size, check)					    \
-	do {								    \
-		val_##size = (check);					    \
-		ret |= test(!get_user(val_##size, (size __user *)kmem),	    \
-		    "illegal get_user (" #size ") passed");		    \
-		ret |= test(val_##size != (size)0,			    \
-		    "zeroing failure for illegal get_user (" #size ")");    \
-		if (val_##size != (size)0) {				    \
-			pr_info("0x%llx != 0\n",			    \
-				(unsigned long long)val_##size);	    \
-		}							    \
-		ret |= test(!put_user(val_##size, (size __user *)kmem),	    \
-		    "illegal put_user (" #size ") passed");		    \
+#define test_illegal(size, check)							\
+	do {										\
+		size val_##size = (check);						\
+		/* get_user() */							\
+		KUNIT_EXPECT_NE_MSG(test, get_user(val_##size, (size __user *)kmem), 0,	\
+		    "illegal get_user (" #size ") passed");				\
+		KUNIT_EXPECT_EQ_MSG(test, val_##size, 0,				\
+		    "zeroing failure for illegal get_user (" #size ")");		\
+		/* put_user() */							\
+		*kmem_u64 = 0xF09FA4AFF09FA4AF;						\
+		KUNIT_EXPECT_NE_MSG(test, put_user(val_##size, (size __user *)kmem), 0,	\
+		    "illegal put_user (" #size ") passed");				\
+		KUNIT_EXPECT_EQ_MSG(test, *kmem_u64, 0xF09FA4AFF09FA4AF,		\
+		    "illegal put_user (" #size ") wrote to kernel memory!");		\
 	} while (0)
 
 	test_illegal(u8,  0x5a);
@@ -306,26 +276,45 @@ static int __init test_user_copy_init(void)
 	test_illegal(u64, 0x5a5b5c5d6a6b6c6d);
 #endif
 #undef test_illegal
+}
 
-	vm_munmap(user_addr, PAGE_SIZE * 2);
-	kfree(kmem);
+static int usercopy_test_init(struct kunit *test)
+{
+	struct usercopy_test_priv *priv;
+	unsigned long user_addr;
 
-	if (ret == 0) {
-		pr_info("tests passed.\n");
-		return 0;
-	}
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+	test->priv = priv;
+	priv->size = PAGE_SIZE * 2;
 
-	return -EINVAL;
-}
+	priv->kmem = kunit_kmalloc(test, priv->size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->kmem);
 
-module_init(test_user_copy_init);
+	user_addr = kunit_vm_mmap(test, NULL, 0, priv->size,
+			    PROT_READ | PROT_WRITE | PROT_EXEC,
+			    MAP_ANONYMOUS | MAP_PRIVATE, 0);
+	KUNIT_ASSERT_LT_MSG(test, user_addr, (unsigned long)TASK_SIZE,
+		"Failed to allocate user memory");
+	priv->umem = (char __user *)user_addr;
 
-static void __exit test_user_copy_exit(void)
-{
-	pr_info("unloaded.\n");
+	return 0;
 }
 
-module_exit(test_user_copy_exit);
-
-MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
+static struct kunit_case usercopy_test_cases[] = {
+	KUNIT_CASE(usercopy_test_valid),
+	KUNIT_CASE(usercopy_test_invalid),
+	KUNIT_CASE(usercopy_test_check_nonzero_user),
+	KUNIT_CASE(usercopy_test_copy_struct_from_user),
+	{}
+};
+
+static struct kunit_suite usercopy_test_suite = {
+	.name = "usercopy",
+	.init = usercopy_test_init,
+	.test_cases = usercopy_test_cases,
+};
+
+kunit_test_suites(&usercopy_test_suite);
+MODULE_AUTHOR("Kees Cook <kees@kernel.org>");
 MODULE_LICENSE("GPL");
-- 
2.34.1


