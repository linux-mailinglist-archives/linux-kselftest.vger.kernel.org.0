Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3486A4E7DC3
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Mar 2022 01:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiCZAWH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Mar 2022 20:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiCZAWG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Mar 2022 20:22:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A2929839
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 17:20:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e9eb7d669fso2755277b3.14
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 17:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hgvJZIq6FS59H45AI6EmsqKDugmfm6LlItsBv/JFTKg=;
        b=XRzUUSHf+YAUSaDgRQ8JutoOAursgJZYWQT4fnYk4+S+oLW3OXnK9W1SacJXTpbkM8
         eyttJtrYR852bSmDHY7K8PGwiKVwvc4h6c4ZSz2vXFGzrAuTPwYZmvNnoHFwy3c4FsnR
         dTbihGKz19CI+i/GwE5Th9UmE4xvygS3MWbW9PRbX5BvA3kVOS4+6aHzOVmvVwoFQK1P
         Pk44XQqD0/32V+HfErRigUaf23EfFeQTOTDXv7IxOOUJKArrtR+9gTYNpPKJtF8FlkMc
         rgF8AW9hbZnmS0c9RevuV7HnhE0Txsi0c90sD7KXDMr9ttDUQgmcxtYpVAv3W4mWHbZs
         jJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hgvJZIq6FS59H45AI6EmsqKDugmfm6LlItsBv/JFTKg=;
        b=4RLwFJpSiJ5BLp2WQi8ax4I0goA4JnJljFYWmSkNMvT6jwjhzhWhXa9sIpLLd+6lWR
         D8rrxPIIMTF7FjMONznGcntKiR79MkKgF1JSRNGU5nA98jEz45TwyEjVXURZhS8sY3ew
         byhr0J0NFPpLYPCCV8FBPo09ZRZCYsas7rD6lla5tVfVDdjFaCouc5BNsER7I3dJtW20
         1Bgc0Kc4QiS8JoSKH5hYz25ijjMenu66hrqmiDOYSYaaQYZavFaxl0Ym1GvQobyQQBSc
         oniZ98pKQFOcPafaPwlML75Uwg+/7x/hSY0H8/ui8UjRCg31O3oy57mir9W5/cYX1viz
         WWIg==
X-Gm-Message-State: AOAM533o3OgIGaFuQxaCMFpSwXN2mVota1I716ySQ6eUYU1GGVD5QWtM
        nkAt2GfunT/6FwWY9ebQi84y2DQ5USZ+1Q==
X-Google-Smtp-Source: ABdhPJzGhQ9wIzZAJ/3GfJX/cyWEUhzgA5Vw8K+D6EBJTjqlICZUaHIXKxPtYGN1vUaCdPTqwho0NJF8EYj6bQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:be84:4a49:e731:f1fa])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:114b:b0:634:6f24:afc2 with SMTP
 id p11-20020a056902114b00b006346f24afc2mr13264298ybu.229.1648254026339; Fri,
 25 Mar 2022 17:20:26 -0700 (PDT)
Date:   Fri, 25 Mar 2022 17:20:13 -0700
In-Reply-To: <20220326002013.483394-1-dlatypov@google.com>
Message-Id: <20220326002013.483394-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220326002013.483394-1-dlatypov@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 2/2] kunit: split resource API impl from test.c into new resource.c
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We've split out the declarations from include/kunit/test.h into
resource.h.
This patch splits out the definitions as well for consistency.

A side effect of this is git blame won't properly track history by
default, users need to run
$ git blame -L ,1 -C13 lib/kunit/resource.c

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/Makefile   |   1 +
 lib/kunit/resource.c | 126 +++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/test.c     | 116 +--------------------------------------
 3 files changed, 128 insertions(+), 115 deletions(-)
 create mode 100644 lib/kunit/resource.c

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index c49f4ffb6273..29aff6562b42 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_KUNIT) +=			kunit.o
 
 kunit-objs +=				test.o \
+					resource.o \
 					string-stream.o \
 					assert.o \
 					try-catch.o \
diff --git a/lib/kunit/resource.c b/lib/kunit/resource.c
new file mode 100644
index 000000000000..b8bced246217
--- /dev/null
+++ b/lib/kunit/resource.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit resource API for test managed resources (allocations, etc.).
+ *
+ * Copyright (C) 2022, Google LLC.
+ * Author: Daniel Latypov <dlatypov@google.com>
+ */
+
+#include <kunit/resource.h>
+#include <kunit/test.h>
+#include <linux/kref.h>
+
+/*
+ * Used for static resources and when a kunit_resource * has been created by
+ * kunit_alloc_resource().  When an init function is supplied, @data is passed
+ * into the init function; otherwise, we simply set the resource data field to
+ * the data value passed in.
+ */
+int kunit_add_resource(struct kunit *test,
+		       kunit_resource_init_t init,
+		       kunit_resource_free_t free,
+		       struct kunit_resource *res,
+		       void *data)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	res->free = free;
+	kref_init(&res->refcount);
+
+	if (init) {
+		ret = init(res, data);
+		if (ret)
+			return ret;
+	} else {
+		res->data = data;
+	}
+
+	spin_lock_irqsave(&test->lock, flags);
+	list_add_tail(&res->node, &test->resources);
+	/* refcount for list is established by kref_init() */
+	spin_unlock_irqrestore(&test->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kunit_add_resource);
+
+int kunit_add_named_resource(struct kunit *test,
+			     kunit_resource_init_t init,
+			     kunit_resource_free_t free,
+			     struct kunit_resource *res,
+			     const char *name,
+			     void *data)
+{
+	struct kunit_resource *existing;
+
+	if (!name)
+		return -EINVAL;
+
+	existing = kunit_find_named_resource(test, name);
+	if (existing) {
+		kunit_put_resource(existing);
+		return -EEXIST;
+	}
+
+	res->name = name;
+
+	return kunit_add_resource(test, init, free, res, data);
+}
+EXPORT_SYMBOL_GPL(kunit_add_named_resource);
+
+struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
+						    kunit_resource_init_t init,
+						    kunit_resource_free_t free,
+						    gfp_t internal_gfp,
+						    void *data)
+{
+	struct kunit_resource *res;
+	int ret;
+
+	res = kzalloc(sizeof(*res), internal_gfp);
+	if (!res)
+		return NULL;
+
+	ret = kunit_add_resource(test, init, free, res, data);
+	if (!ret) {
+		/*
+		 * bump refcount for get; kunit_resource_put() should be called
+		 * when done.
+		 */
+		kunit_get_resource(res);
+		return res;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
+
+void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&test->lock, flags);
+	list_del(&res->node);
+	spin_unlock_irqrestore(&test->lock, flags);
+	kunit_put_resource(res);
+}
+EXPORT_SYMBOL_GPL(kunit_remove_resource);
+
+int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
+			   void *match_data)
+{
+	struct kunit_resource *res = kunit_find_resource(test, match,
+							 match_data);
+
+	if (!res)
+		return -ENOENT;
+
+	kunit_remove_resource(test, res);
+
+	/* We have a reference also via _find(); drop it. */
+	kunit_put_resource(res);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kunit_destroy_resource);
+
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3bca3bf5c15b..0f66c13d126e 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -6,10 +6,10 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
+#include <kunit/resource.h>
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 #include <linux/kernel.h>
-#include <linux/kref.h>
 #include <linux/moduleparam.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
@@ -592,120 +592,6 @@ void __kunit_test_suites_exit(struct kunit_suite **suites)
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
-/*
- * Used for static resources and when a kunit_resource * has been created by
- * kunit_alloc_resource().  When an init function is supplied, @data is passed
- * into the init function; otherwise, we simply set the resource data field to
- * the data value passed in.
- */
-int kunit_add_resource(struct kunit *test,
-		       kunit_resource_init_t init,
-		       kunit_resource_free_t free,
-		       struct kunit_resource *res,
-		       void *data)
-{
-	int ret = 0;
-	unsigned long flags;
-
-	res->free = free;
-	kref_init(&res->refcount);
-
-	if (init) {
-		ret = init(res, data);
-		if (ret)
-			return ret;
-	} else {
-		res->data = data;
-	}
-
-	spin_lock_irqsave(&test->lock, flags);
-	list_add_tail(&res->node, &test->resources);
-	/* refcount for list is established by kref_init() */
-	spin_unlock_irqrestore(&test->lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(kunit_add_resource);
-
-int kunit_add_named_resource(struct kunit *test,
-			     kunit_resource_init_t init,
-			     kunit_resource_free_t free,
-			     struct kunit_resource *res,
-			     const char *name,
-			     void *data)
-{
-	struct kunit_resource *existing;
-
-	if (!name)
-		return -EINVAL;
-
-	existing = kunit_find_named_resource(test, name);
-	if (existing) {
-		kunit_put_resource(existing);
-		return -EEXIST;
-	}
-
-	res->name = name;
-
-	return kunit_add_resource(test, init, free, res, data);
-}
-EXPORT_SYMBOL_GPL(kunit_add_named_resource);
-
-struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
-						    kunit_resource_init_t init,
-						    kunit_resource_free_t free,
-						    gfp_t internal_gfp,
-						    void *data)
-{
-	struct kunit_resource *res;
-	int ret;
-
-	res = kzalloc(sizeof(*res), internal_gfp);
-	if (!res)
-		return NULL;
-
-	ret = kunit_add_resource(test, init, free, res, data);
-	if (!ret) {
-		/*
-		 * bump refcount for get; kunit_resource_put() should be called
-		 * when done.
-		 */
-		kunit_get_resource(res);
-		return res;
-	}
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
-
-void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&test->lock, flags);
-	list_del(&res->node);
-	spin_unlock_irqrestore(&test->lock, flags);
-	kunit_put_resource(res);
-}
-EXPORT_SYMBOL_GPL(kunit_remove_resource);
-
-int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
-			   void *match_data)
-{
-	struct kunit_resource *res = kunit_find_resource(test, match,
-							 match_data);
-
-	if (!res)
-		return -ENOENT;
-
-	kunit_remove_resource(test, res);
-
-	/* We have a reference also via _find(); drop it. */
-	kunit_put_resource(res);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kunit_destroy_resource);
-
 struct kunit_kmalloc_array_params {
 	size_t n;
 	size_t size;
-- 
2.35.1.1021.g381101b075-goog

