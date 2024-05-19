Return-Path: <linux-kselftest+bounces-10384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2352E8C9604
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 21:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE182811A7
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 19:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C0871B5C;
	Sun, 19 May 2024 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ETKoaGUN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD93170CC8
	for <linux-kselftest@vger.kernel.org>; Sun, 19 May 2024 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716145980; cv=none; b=lh7lhMVTIOPs2cSWcXcS7SWnUgSjL/5elq3xu8GRRjieEQb8HQ4YK7S55kfMGaEYiHbwanRTcDreu0yEvqJNnSKX84C+OgxgtO/xLy2Yqf8nel5/ImU38cVnmcYb3ssVAyQBJSC47XXrU7QplilSrMnO7pM2IHBiimtj31A0r10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716145980; c=relaxed/simple;
	bh=L3h8oa5PuF64ydAhyvtrnNt2zd3Y7BV1STIA5ziEuy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JT3avzakvg46DHiFV07M1IxxKJI7qDUkE32zT0RPXSdOF9aDqxkQgyjjzOjxFftRZKB9AKqtVNZmFFdY3w4bWRDYqPYkIBC6rqbumTOrEItQ1MqyoRGRz6jOFJmmzEuNXKyGpR8q7Hc2jOKM2P8tHaybZN3slMycQiv1KdtXTzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ETKoaGUN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f0537e39b3so53329795ad.3
        for <linux-kselftest@vger.kernel.org>; Sun, 19 May 2024 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716145977; x=1716750777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeeyyE3gX6k5WprMYxI3n5bPX4iwqcQoQPmK3gNObEY=;
        b=ETKoaGUNEzvyj+wuE5w/oFNYWRwkkpYbAKblJ9LL+nTrX6elwXYkZR6NYcH0XZNsie
         4DNyGQZhQ2Uyj8U+XasnZKdI8QhbAtHi2wSBcieMjSuyGLYYOBydZ69PS6ZW3O9gACqU
         amiDidcMYFffY9wSPxz0dMNJZyjUk8qeJTJS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716145977; x=1716750777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeeyyE3gX6k5WprMYxI3n5bPX4iwqcQoQPmK3gNObEY=;
        b=WsljTQpYDTuDE8xijrUDCwufuyNUal146Y5ONdSKxNhlWd1H6zmy1/3QGFMhnqxCoG
         ZlOhIxBAd5kjiEn+JgY5CGPB9u2fSxyXIcp6qkN/SdtXKJos+t8XWBaWOm6NNPLXkSOM
         rQZl0xNwFNRdjjvWUa5iiaK1U0rYZcHz1lG6RGT1e31w12hDnf0g10itc6E+a00/Wh1I
         aKPEL9y4wZxSGr3Gwo0a3pPMd2gufPeNFV6vJ2ed/FKaFXsAjkkA8Rfl5dS+2w5E6PZc
         HG30ZhZ9KkJxid5hM/VkUZjFIM2MubybfpqghXytTQMOi556kNc52V3AjA8fPrr9QFYS
         LhUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH8FPSUqImfnr5t9tXUOxy0w2wAc/TbeEY9xMN3bqq8U2hkQYlB9vFA/ZzB3/H4ZNLZhfeBOxXVtdtVSIMCyXllJ97nHGXnXnjJOui8uzV
X-Gm-Message-State: AOJu0YzJ1wyBlrDG+zyj06bTGDQfCumhJMf312P4UKwBUdq31Axpng7c
	PJKXJzgfD3jGpWcoz2rGd+Okna/vYTkkwv+zvvMtfsWiPqmZmfQd580bsSeWHA==
X-Google-Smtp-Source: AGHT+IFreHhHSGVxRSU86++JXmWMQpsYbCV+TgTtIOmhf7TZfSnPlz6zbN15mKv8Gz/zwDK3TJd/mg==
X-Received: by 2002:a05:6a00:84c:b0:6ea:d794:ccee with SMTP id d2e1a72fcca58-6f4e02d3440mr32532750b3a.17.1716145976953;
        Sun, 19 May 2024 12:12:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4fcb6e14asm13018700b3a.185.2024.05.19.12.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 12:12:55 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] usercopy: Convert test_user_copy to KUnit test
Date: Sun, 19 May 2024 12:12:53 -0700
Message-Id: <20240519191254.651865-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240519190422.work.715-kees@kernel.org>
References: <20240519190422.work.715-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17400; i=keescook@chromium.org;
 h=from:subject; bh=L3h8oa5PuF64ydAhyvtrnNt2zd3Y7BV1STIA5ziEuy4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmSk81NQe1zTzqSF+bUJl9MPcom8Y9lPfEWOsCd
 VHpme7cGs6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZkpPNQAKCRCJcvTf3G3A
 JrsoEACJPnLaQqg3I9bhQz6eEfywpl+56zmu3mDebBa78jlCep3WT5Bone7fwINqs3oxmlH8vmw
 OE8Hy9FrDj1/LQbVMla5+r7tbQhNPUWN57xfgXRIUQZj47kGTGtdnPk0eTeqouXA5ZJY7b+05hm
 IsBfAHmiZMRtqiZnYkwb2YA+algw07lJVa2DC2mcDY9HRymrUV3wxojoa7pJsq6Cy/Tj7xIYMtz
 Wl+oaSuHZMopExn+x0aaNuBNt5G13hQU9rbfehblTk6l0wKJhePAi1vqKniiVpG9ZB67MpEfE2t
 yVJDgViJ6EulzZGhbOfLxItLewr/Nrddoiw/0K3evtWasAcFfQJW7p0VZDjW3aFJodpXYt6FY+e
 MKvt+OuECJfaBzdyZNsR021YCy/2K2uTrwCbWfUGhIV1vKkaTjfW65tgyHg62d88NwRxNu5p2xy
 oUxY+DTI0ze0GpRFBRj25cKvMUd9BbYMCntvMcJVvsy6eaU6TMhqZL5bqh3QCx9jsAKo3QEehUR
 D9oax3InOG8oMjXvmH8ZdVdKRT4IwDOGfCYZdXusXLnnLU0am+uFqU37FDKNWfIKknDn6jgOnha
 9lOvLacosmHTdDhGLlMLZvWkyuXgxl13qOEmVBhPyDKPrKzQ8FUcXLR3IJAsQzolmCSoWQSwpxx wjTfi6j0an1XIWA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Convert the runtime tests of hardened usercopy to standard KUnit tests.

Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Link: https://lore.kernel.org/r/20200721174654.72132-1-vitor@massaru.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS                                |   1 +
 lib/Kconfig.debug                          |  21 +-
 lib/Makefile                               |   2 +-
 lib/{test_user_copy.c => usercopy_kunit.c} | 252 ++++++++++-----------
 4 files changed, 133 insertions(+), 143 deletions(-)
 rename lib/{test_user_copy.c => usercopy_kunit.c} (52%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..73995b807e5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11761,6 +11761,7 @@ F:	arch/*/configs/hardening.config
 F:	include/linux/overflow.h
 F:	include/linux/randomize_kstack.h
 F:	kernel/configs/hardening.config
+F:	lib/usercopy_kunit.c
 F:	mm/usercopy.c
 K:	\b(add|choose)_random_kstack_offset\b
 K:	\b__check_(object_size|heap_object)\b
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c63a5fbf1f1c..fd974480aa45 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2460,18 +2460,6 @@ config TEST_VMALLOC
 
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
@@ -2779,6 +2767,15 @@ config SIPHASH_KUNIT_TEST
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
index ffc6b2341b45..6287bd6be5d7 100644
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
@@ -406,6 +405,7 @@ obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_STRCAT_KUNIT_TEST) += strcat_kunit.o
 obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
+obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/test_user_copy.c b/lib/usercopy_kunit.c
similarity index 52%
rename from lib/test_user_copy.c
rename to lib/usercopy_kunit.c
index 5ff04d8fe971..515df08b3190 100644
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
@@ -31,11 +31,17 @@
 # define TEST_U64
 #endif
 
+struct usercopy_test_priv {
+	char *kmem;
+	char __user *umem;
+	size_t size;
+};
+
 #define test(condition, msg, ...)					\
 ({									\
 	int cond = (condition);						\
 	if (cond)							\
-		pr_warn("[%d] " msg "\n", __LINE__, ##__VA_ARGS__);	\
+		KUNIT_EXPECT_FALSE_MSG(test, cond, msg, ##__VA_ARGS__);	\
 	cond;								\
 })
 
@@ -44,13 +50,16 @@ static bool is_zeroed(void *from, size_t size)
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
@@ -84,8 +93,8 @@ static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
 	for (i = zero_end; i < size; i += 2)
 		kmem[i] = 0xff;
 
-	ret |= test(copy_to_user(umem, kmem, size),
-		    "legitimate copy_to_user failed");
+	KUNIT_EXPECT_EQ_MSG(test, copy_to_user(umem, kmem, size), 0,
+		"legitimate copy_to_user failed");
 
 	for (start = 0; start <= size; start++) {
 		for (end = start; end <= size; end++) {
@@ -93,35 +102,32 @@ static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
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
@@ -131,9 +137,9 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
 	memcpy(expected, umem_src, ksize);
 
 	memset(kmem, 0x0, size);
-	ret |= test(copy_struct_from_user(kmem, ksize, umem, usize),
+	KUNIT_EXPECT_EQ_MSG(test, copy_struct_from_user(kmem, ksize, umem, usize), 0,
 		    "copy_struct_from_user(usize == ksize) failed");
-	ret |= test(memcmp(kmem, expected, ksize),
+	KUNIT_EXPECT_EQ_MSG(test, memcmp(kmem, expected, ksize), 0,
 		    "copy_struct_from_user(usize == ksize) gives unexpected copy");
 
 	/* Old userspace case -- (usize < ksize). */
@@ -144,9 +150,9 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
 	memset(expected + usize, 0x0, ksize - usize);
 
 	memset(kmem, 0x0, size);
-	ret |= test(copy_struct_from_user(kmem, ksize, umem, usize),
+	KUNIT_EXPECT_EQ_MSG(test, copy_struct_from_user(kmem, ksize, umem, usize), 0,
 		    "copy_struct_from_user(usize < ksize) failed");
-	ret |= test(memcmp(kmem, expected, ksize),
+	KUNIT_EXPECT_EQ_MSG(test, memcmp(kmem, expected, ksize), 0,
 		    "copy_struct_from_user(usize < ksize) gives unexpected copy");
 
 	/* New userspace (-E2BIG) case -- (usize > ksize). */
@@ -154,7 +160,7 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
 	usize = size;
 
 	memset(kmem, 0x0, size);
-	ret |= test(copy_struct_from_user(kmem, ksize, umem, usize) != -E2BIG,
+	KUNIT_EXPECT_EQ_MSG(test, copy_struct_from_user(kmem, ksize, umem, usize), -E2BIG,
 		    "copy_struct_from_user(usize > ksize) didn't give E2BIG");
 
 	/* New userspace (success) case -- (usize > ksize). */
@@ -162,78 +168,46 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
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
-
-	user_addr = vm_mmap(NULL, 0, PAGE_SIZE * 2,
-			    PROT_READ | PROT_WRITE | PROT_EXEC,
-			    MAP_ANONYMOUS | MAP_PRIVATE, 0);
-	if (user_addr >= (unsigned long)(TASK_SIZE)) {
-		pr_warn("Failed to allocate user memory\n");
-		kfree(kmem);
-		return -ENOMEM;
-	}
+	struct usercopy_test_priv *priv = test->priv;
+	char __user *usermem = priv->umem;
+	char *kmem = priv->kmem;
 
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
@@ -243,27 +217,29 @@ static int __init test_user_copy_init(void)
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
@@ -273,29 +249,25 @@ static int __init test_user_copy_init(void)
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
 
 #define test_illegal(size, check)					    \
 	do {								    \
-		val_##size = (check);					    \
-		ret |= test(!get_user(val_##size, (size __user *)kmem),	    \
+		size val_##size = (check);					    \
+		KUNIT_EXPECT_NE_MSG(test, get_user(val_##size, (size __user *)kmem), 0, \
 		    "illegal get_user (" #size ") passed");		    \
-		ret |= test(val_##size != (size)0,			    \
+		KUNIT_EXPECT_EQ_MSG(test, val_##size, 0,		    \
 		    "zeroing failure for illegal get_user (" #size ")");    \
-		if (val_##size != (size)0) {				    \
-			pr_info("0x%llx != 0\n",			    \
-				(unsigned long long)val_##size);	    \
-		}							    \
-		ret |= test(!put_user(val_##size, (size __user *)kmem),	    \
+		KUNIT_EXPECT_NE_MSG(test, put_user(val_##size, (size __user *)kmem), 0, \
 		    "illegal put_user (" #size ") passed");		    \
 	} while (0)
 
@@ -306,26 +278,46 @@ static int __init test_user_copy_init(void)
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
+	if (!priv)
+		return -ENOMEM;
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
 MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
 MODULE_LICENSE("GPL");
-- 
2.34.1


