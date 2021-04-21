Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B46F367296
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Apr 2021 20:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbhDUSc5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Apr 2021 14:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbhDUSc4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Apr 2021 14:32:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AF5C06174A
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Apr 2021 11:32:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f7-20020a5b0c070000b02904e9a56ee7e7so16810208ybq.9
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Apr 2021 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FvAswNxnPHsrYsB29334aDx0CJGCBFJ87PYQGSoXC7U=;
        b=Jml0dfSb6fz47ZIEY22eqphvQEi8jUZhPeaUH3yBL4lYpGNTOxCsF3JqbFPN6YZ/FN
         u4kSvuOnoXcMkdH6vnguAyqWSlh+kk+5KtLPxDqphU1SbOWmB6jK4BQv5TwH7fd0Hueu
         tWqQMaDeLwsa03LzDzHv34/Vhahm0e+cah9sva3WQ5fO50VCeCrURAsp+zW2v/GBWnXQ
         9j6Kho/ORIiadlzNR+WOjMZdnVwLU2HDIEIlBxwCIdqLBrE0DcdOhRYwqR9pFeMSXnq+
         rNsf1SLYxaUXxyyC+Y7QeArAAiVuIkqIVLBZmsUe5m7L8MLzBML6u7G2tAzTOiZj3oVB
         3e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FvAswNxnPHsrYsB29334aDx0CJGCBFJ87PYQGSoXC7U=;
        b=oY7BeI4sGQJoQZQ4mlnkNgq5qescccmM/mJRoSDWU/ZsN1ucgKjlwg0/uz0/SBHMlU
         P/2i2w9is/iTJtgwcLyxqlCB0P4GnUZnIIMNobOjDEWq5J4MZJtozoLMKkOPr5A02Acw
         na/5mQJq+Rkl3YJEl86mQ/l+DRY3oiO98Y/uvaidfoVhAZzMBPHfJ4y0GthTrbrFd4lU
         SAlBkpdsWSOdcL3vCHJlSCrdmUqZw9nVi7J36gcSVsx35PTOMCouT6Ym5RravxGhk5Tl
         iLfbBJIURS7CVA4kT+lZet5yATTqLk8GoWvT0Wu9904YhOnd/ChKeGb6Xh06AQRYlEzj
         8KbA==
X-Gm-Message-State: AOAM532F86/DkhlkXG9mJeg8zIZyiSIe59Yxvz6Rph0lVOGWgwGC5i1Z
        Fj35bYt26QjmzrAMLfqVapIzILGSRJJmjQ==
X-Google-Smtp-Source: ABdhPJyOHrklTMDQJJLuS1w6K2MpKW95veAmi+cEimLFh0JwPRA0CZyJe82W5vhKKxqxYZxMZUaqD7N69ZeD8g==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:9524:9c1f:6fff:a9ad])
 (user=dlatypov job=sendgmr) by 2002:a25:3f04:: with SMTP id
 m4mr35514845yba.350.1619029941836; Wed, 21 Apr 2021 11:32:21 -0700 (PDT)
Date:   Wed, 21 Apr 2021 11:32:10 -0700
Message-Id: <20210421183210.2557462-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 1/2] kunit: introduce kunit_kmalloc_array/kunit_kcalloc() helpers
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
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
---
 include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++----
 lib/kunit/test.c     | 22 ++++++++++++----------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 49601c4b98b8..7fa0de4af977 100644
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
+ * kunit_kzalloc() - Just like kunit_kmalloc_array(), but zeroes the allocation.
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
index ec9494e914ef..052fccf69eef 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -540,41 +540,43 @@ int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
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

base-commit: 16fc44d6387e260f4932e9248b985837324705d8
-- 
2.31.1.498.g6c1eba8ee3d-goog

