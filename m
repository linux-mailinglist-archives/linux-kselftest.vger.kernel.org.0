Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18478372222
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 May 2021 22:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhECU7m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 May 2021 16:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhECU7m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 May 2021 16:59:42 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6C2C06174A
        for <linux-kselftest@vger.kernel.org>; Mon,  3 May 2021 13:58:47 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id h88-20020a0c82610000b02901b70a2884e8so5907721qva.20
        for <linux-kselftest@vger.kernel.org>; Mon, 03 May 2021 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4GvPQxvbZB1WUMCOr9KxWHeCmVVSSWaKC4bVu2z6ktE=;
        b=Rr7ZHJlMpOCmxTk/pU0CFMzOgRVAm2xeg4ps4u2sP5Ntnvh2ai1b64yH6ZrvDRQIOD
         ndlJXjiaYbUiWbn2x34Pf+nGCqjagW3CPmCmQiYa6E9A9KtYqVjV9jHpVbJlXm0QFsfD
         C0I40gUHYWQaUhRCTsA7eJCl1aPwc5dIQgK9Ei6RFol/gv8EsBaMKeOp2EN7naJbfj10
         nRqUNWDX5cgQUSAKIn+Qnzyd6xokHkxWbqU+eGdy9VVvRHS3T4q69g2YFoTUzjwgupul
         WDy7DAl8gxVdj/VCTx9aa6qjrlX5Gz9srF0xn9BSxUFuBlBJBmHU9Oa0Ba8UQsVieIz3
         XGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4GvPQxvbZB1WUMCOr9KxWHeCmVVSSWaKC4bVu2z6ktE=;
        b=isuqZcmoZww5GNIyY3FCAraa8DRTobN9TQ3KOOEgWTu6PyKQ55wWMDaqJa8b+g95g0
         O0XTSHsRU3L4K2Xef1khSIkHak7qdpsop0eU2udbkOv0+SkVcdhmymWMrszIq9sTTnzI
         bbJRBtR++x3oG+ncV8t7dYiIYxEg7Ted71GC5hjUiRrarqKXEw7Ug3Ys37Qrh0YGr1QW
         8RXiwxFEAWyD0UnGe5oPVXxniBFi+1xdLx/OvAT8tc38zerINPsw6OORWZ6zn+KIRYlw
         aoFDme8f5sQyFbW+00TSQABLZ1RcOJUIaqhq5+nKPWfK/yxkP7iR3F0a6cHMzfnceB1I
         Hedg==
X-Gm-Message-State: AOAM533es8575yL8mV/s09wi2b2/S34TDgskw5Cq6W+XzpsWxHpnSBlY
        Ev4Kn21KqIjERJNXiDDq87v32haKZj3/zw==
X-Google-Smtp-Source: ABdhPJzFP2r1+dGH0S8O15z1q3NwIzQf7JdUW4ChYar/4b03/bcdCPxjqm5pWJ3NnWsolAINDIfhfHx5Zn1wrg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1dbc:8749:a56:dada])
 (user=dlatypov job=sendgmr) by 2002:ad4:4bc4:: with SMTP id
 l4mr7386619qvw.46.1620075526869; Mon, 03 May 2021 13:58:46 -0700 (PDT)
Date:   Mon,  3 May 2021 13:58:34 -0700
Message-Id: <20210503205835.1370850-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v2 1/2] kunit: introduce kunit_kmalloc_array/kunit_kcalloc() helpers
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     npache@redhat.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add in:
* kunit_kmalloc_array() and wire up kunit_kmalloc() to be a special
case of it.
* kunit_kcalloc() for symmetry with kunit_kzalloc()

This should using KUnit more natural by making it more similar to the
existing *alloc() APIs.

And while we shouldn't necessarily be writing unit tests where overflow
should be a concern, it can't hurt to be safe.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: s/kzalloc/kcalloc in doc comment.
---
 include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++----
 lib/kunit/test.c     | 22 ++++++++++++----------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 49601c4b98b8..e8ecb69dd567 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -577,16 +577,30 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
 void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
 
 /**
- * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
+ * kunit_kmalloc_array() - Like kmalloc_array() except the allocation is *test managed*.
  * @test: The test context object.
+ * @n: number of elements.
  * @size: The size in bytes of the desired memory.
  * @gfp: flags passed to underlying kmalloc().
  *
- * Just like `kmalloc(...)`, except the allocation is managed by the test case
+ * Just like `kmalloc_array(...)`, except the allocation is managed by the test case
  * and is automatically cleaned up after the test case concludes. See &struct
  * kunit_resource for more information.
  */
-void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp);
+void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t flags);
+
+/**
+ * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
+ * @test: The test context object.
+ * @size: The size in bytes of the desired memory.
+ * @gfp: flags passed to underlying kmalloc().
+ *
+ * See kmalloc() and kunit_kmalloc_array() for more information.
+ */
+static inline void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
+{
+	return kunit_kmalloc_array(test, 1, size, gfp);
+}
 
 /**
  * kunit_kfree() - Like kfree except for allocations managed by KUnit.
@@ -601,13 +615,27 @@ void kunit_kfree(struct kunit *test, const void *ptr);
  * @size: The size in bytes of the desired memory.
  * @gfp: flags passed to underlying kmalloc().
  *
- * See kzalloc() and kunit_kmalloc() for more information.
+ * See kzalloc() and kunit_kmalloc_array() for more information.
  */
 static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
 {
 	return kunit_kmalloc(test, size, gfp | __GFP_ZERO);
 }
 
+/**
+ * kunit_kcalloc() - Just like kunit_kmalloc_array(), but zeroes the allocation.
+ * @test: The test context object.
+ * @n: number of elements.
+ * @size: The size in bytes of the desired memory.
+ * @gfp: flags passed to underlying kmalloc().
+ *
+ * See kcalloc() and kunit_kmalloc_array() for more information.
+ */
+static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp_t flags)
+{
+	return kunit_kmalloc_array(test, n, size, flags | __GFP_ZERO);
+}
+
 void kunit_cleanup(struct kunit *test);
 
 void kunit_log_append(char *log, const char *fmt, ...);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 2f6cc0123232..41fa46b14c3b 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -573,41 +573,43 @@ int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
 }
 EXPORT_SYMBOL_GPL(kunit_destroy_resource);
 
-struct kunit_kmalloc_params {
+struct kunit_kmalloc_array_params {
+	size_t n;
 	size_t size;
 	gfp_t gfp;
 };
 
-static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
+static int kunit_kmalloc_array_init(struct kunit_resource *res, void *context)
 {
-	struct kunit_kmalloc_params *params = context;
+	struct kunit_kmalloc_array_params *params = context;
 
-	res->data = kmalloc(params->size, params->gfp);
+	res->data = kmalloc_array(params->n, params->size, params->gfp);
 	if (!res->data)
 		return -ENOMEM;
 
 	return 0;
 }
 
-static void kunit_kmalloc_free(struct kunit_resource *res)
+static void kunit_kmalloc_array_free(struct kunit_resource *res)
 {
 	kfree(res->data);
 }
 
-void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
+void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
 {
-	struct kunit_kmalloc_params params = {
+	struct kunit_kmalloc_array_params params = {
 		.size = size,
+		.n = n,
 		.gfp = gfp
 	};
 
 	return kunit_alloc_resource(test,
-				    kunit_kmalloc_init,
-				    kunit_kmalloc_free,
+				    kunit_kmalloc_array_init,
+				    kunit_kmalloc_array_free,
 				    gfp,
 				    &params);
 }
-EXPORT_SYMBOL_GPL(kunit_kmalloc);
+EXPORT_SYMBOL_GPL(kunit_kmalloc_array);
 
 void kunit_kfree(struct kunit *test, const void *ptr)
 {

base-commit: cda689f8708b6bef0b921c3a17fcdecbe959a079
-- 
2.31.1.527.g47e6f16901-goog

