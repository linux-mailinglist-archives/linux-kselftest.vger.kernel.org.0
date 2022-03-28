Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961054E9DBB
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbiC1Rnd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 13:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244680AbiC1Rnd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 13:43:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDB0652C4
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 10:41:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e4-20020a056902034400b00633691534d5so11350736ybs.7
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 10:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1Po40l0FZTAWOf3KalVZPn9i2/EavL+ibDRiBzFdoPI=;
        b=qQec3BK/leiI8VQ0ZYzZAnoKuUwVPnAFcMw2oVwdqzqmA0nqIsYHrRcrcMi7zC8U3C
         QVsxq0XbJ77AHaX82JuxsQJ/Nq937KI85s0Mc415oYM6EhuoFGdi6gH+vfyq4VBgHkg+
         pEjGdcen2ha1n99JfIDwm18PP/X3/ViHggMSCOt1cuNYtccRRMqClbhy9U9UtIsyY7yq
         yCCkItJxvKq35pTR1YhUZI7tmKfLqqsfEGeKw3erKGRKZY0DbxSOURvl8LqYmv7hrPe1
         vOEvtn4GvaGLLva+CNHBaBSub+KQg77Hjq5FnhQDmspNQAEyjezyyq2c6f0L9WUXiWhD
         Vlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1Po40l0FZTAWOf3KalVZPn9i2/EavL+ibDRiBzFdoPI=;
        b=KEmBGotrpE4d6PrEqhSKjGmafbEOGSsh9A6/iY4+TXSdCwvNbCnvXEvd/2FHc+cBvk
         RLO79qfGlJI+sO/VI1l/WuRSDE9Rc90NhO4i4pLNSrs/5LlR0jKXE1EsDHFt60t1Dyoe
         U9zZ3oEy20XDUZJRCYKiAVSv2Mxf7TM8j+Cz80xZC1eAbwyTkAlORbvjf8esVhUhFp+X
         Ug3JTEoaTpbkEVcBIL2N8ylIuXd4f4UUq1lS2ru3k45yFcHsPfrGY9e8iU7ZCkwUKrN+
         BV0KF0IY4KvmpxNwIlIB1ixJhEbN6U/hKmI5GOJrejRKodOiFTo3P9Wicl9L590rAnkf
         wUSg==
X-Gm-Message-State: AOAM532e/AyThEn/VmXzQ15hID5PMiSMqdZ0GChdlNGaT24ylm+NrfNn
        PvT+WIOCB5nae+uMiDURCxw8ShRdkJJ1cg==
X-Google-Smtp-Source: ABdhPJwauVxiYni30yz8ZSVzAQ5jgbBq9B3zUtyFnBSp+ko/cSKO2T1NeJyngeCIDK2jUTqq459U2vXWJUf3uw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:73c:9f0b:d20c:cf44])
 (user=dlatypov job=sendgmr) by 2002:a05:690c:81:b0:2e6:d4de:e04b with SMTP id
 be1-20020a05690c008100b002e6d4dee04bmr23890195ywb.303.1648489309661; Mon, 28
 Mar 2022 10:41:49 -0700 (PDT)
Date:   Mon, 28 Mar 2022 10:41:42 -0700
Message-Id: <20220328174143.857262-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v3 1/2] kunit: split resource API from test.h into new resource.h
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Background:
Currently, a reader looking at kunit/test.h will find the file is quite
long, and the first meaty comment is a doc comment about struct
kunit_resource.

Most users will not ever use the KUnit resource API directly.
They'll use kunit_kmalloc() and friends, or decide it's simpler to do
cleanups via labels (it often can be) instead of figuring out how to use
the API.

It's also logically separate from everything else in test.h.
Removing it from the file doesn't cause any compilation errors (since
struct kunit has `struct list_head resources` to store them).

This commit:
Let's move it into a kunit/resource.h file and give it a separate page
in the docs, kunit/api/resource.rst.

We include resource.h at the bottom of test.h since
* don't want to force existing users to add a new include if they use the API
* it accesses `lock` inside `struct kunit` in a inline func
  * so we can't just forward declare, and the alternatives require
    uninlining the func, adding hepers to lock/unlock, or other more
    invasive changes.

Now the first big comment in test.h is about kunit_case, which is a lot
more relevant to what a new user wants to know.

A side effect of this is git blame won't properly track history by
default, users need to run
$ git blame -L ,1 -C17 include/kunit/resource.h

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: add TODO to make users #include resource.h, drop redundant fwd
decl of struct kunit in resource.h
v2 -> v3: no change.
---
 Documentation/dev-tools/kunit/api/index.rst   |   5 +
 .../dev-tools/kunit/api/resource.rst          |  13 +
 include/kunit/resource.h                      | 318 ++++++++++++++++++
 include/kunit/test.h                          | 303 +----------------
 4 files changed, 340 insertions(+), 299 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/api/resource.rst
 create mode 100644 include/kunit/resource.h

diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index 3006cadcf44a..45ce04823f9f 100644
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -6,6 +6,7 @@ API Reference
 .. toctree::
 
 	test
+	resource
 
 This section documents the KUnit kernel testing API. It is divided into the
 following sections:
@@ -13,3 +14,7 @@ following sections:
 Documentation/dev-tools/kunit/api/test.rst
 
  - documents all of the standard testing API
+
+Documentation/dev-tools/kunit/api/resource.rst
+
+ - documents the KUnit resource API
diff --git a/Documentation/dev-tools/kunit/api/resource.rst b/Documentation/dev-tools/kunit/api/resource.rst
new file mode 100644
index 000000000000..0a94f831259e
--- /dev/null
+++ b/Documentation/dev-tools/kunit/api/resource.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+Resource API
+============
+
+This file documents the KUnit resource API.
+
+Most users won't need to use this API directly, power users can use it to store
+state on a per-test basis, register custom cleanup actions, and more.
+
+.. kernel-doc:: include/kunit/resource.h
+   :internal:
diff --git a/include/kunit/resource.h b/include/kunit/resource.h
new file mode 100644
index 000000000000..7ab1fd83972b
--- /dev/null
+++ b/include/kunit/resource.h
@@ -0,0 +1,318 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit resource API for test managed resources (allocations, etc.).
+ *
+ * Copyright (C) 2022, Google LLC.
+ * Author: Daniel Latypov <dlatypov@google.com>
+ */
+
+#ifndef _KUNIT_RESOURCE_H
+#define _KUNIT_RESOURCE_H
+
+#include <kunit/test.h>
+
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+struct kunit_resource;
+
+typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
+typedef void (*kunit_resource_free_t)(struct kunit_resource *);
+
+/**
+ * struct kunit_resource - represents a *test managed resource*
+ * @data: for the user to store arbitrary data.
+ * @name: optional name
+ * @free: a user supplied function to free the resource. Populated by
+ * kunit_resource_alloc().
+ *
+ * Represents a *test managed resource*, a resource which will automatically be
+ * cleaned up at the end of a test case.
+ *
+ * Resources are reference counted so if a resource is retrieved via
+ * kunit_alloc_and_get_resource() or kunit_find_resource(), we need
+ * to call kunit_put_resource() to reduce the resource reference count
+ * when finished with it.  Note that kunit_alloc_resource() does not require a
+ * kunit_resource_put() because it does not retrieve the resource itself.
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	struct kunit_kmalloc_params {
+ *		size_t size;
+ *		gfp_t gfp;
+ *	};
+ *
+ *	static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
+ *	{
+ *		struct kunit_kmalloc_params *params = context;
+ *		res->data = kmalloc(params->size, params->gfp);
+ *
+ *		if (!res->data)
+ *			return -ENOMEM;
+ *
+ *		return 0;
+ *	}
+ *
+ *	static void kunit_kmalloc_free(struct kunit_resource *res)
+ *	{
+ *		kfree(res->data);
+ *	}
+ *
+ *	void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
+ *	{
+ *		struct kunit_kmalloc_params params;
+ *
+ *		params.size = size;
+ *		params.gfp = gfp;
+ *
+ *		return kunit_alloc_resource(test, kunit_kmalloc_init,
+ *			kunit_kmalloc_free, &params);
+ *	}
+ *
+ * Resources can also be named, with lookup/removal done on a name
+ * basis also.  kunit_add_named_resource(), kunit_find_named_resource()
+ * and kunit_destroy_named_resource().  Resource names must be
+ * unique within the test instance.
+ */
+struct kunit_resource {
+	void *data;
+	const char *name;
+	kunit_resource_free_t free;
+
+	/* private: internal use only. */
+	struct kref refcount;
+	struct list_head node;
+};
+
+/*
+ * Like kunit_alloc_resource() below, but returns the struct kunit_resource
+ * object that contains the allocation. This is mostly for testing purposes.
+ */
+struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
+						    kunit_resource_init_t init,
+						    kunit_resource_free_t free,
+						    gfp_t internal_gfp,
+						    void *context);
+
+/**
+ * kunit_get_resource() - Hold resource for use.  Should not need to be used
+ *			  by most users as we automatically get resources
+ *			  retrieved by kunit_find_resource*().
+ * @res: resource
+ */
+static inline void kunit_get_resource(struct kunit_resource *res)
+{
+	kref_get(&res->refcount);
+}
+
+/*
+ * Called when refcount reaches zero via kunit_put_resource();
+ * should not be called directly.
+ */
+static inline void kunit_release_resource(struct kref *kref)
+{
+	struct kunit_resource *res = container_of(kref, struct kunit_resource,
+						  refcount);
+
+	/* If free function is defined, resource was dynamically allocated. */
+	if (res->free) {
+		res->free(res);
+		kfree(res);
+	}
+}
+
+/**
+ * kunit_put_resource() - When caller is done with retrieved resource,
+ *			  kunit_put_resource() should be called to drop
+ *			  reference count.  The resource list maintains
+ *			  a reference count on resources, so if no users
+ *			  are utilizing a resource and it is removed from
+ *			  the resource list, it will be freed via the
+ *			  associated free function (if any).  Only
+ *			  needs to be used if we alloc_and_get() or
+ *			  find() resource.
+ * @res: resource
+ */
+static inline void kunit_put_resource(struct kunit_resource *res)
+{
+	kref_put(&res->refcount, kunit_release_resource);
+}
+
+/**
+ * kunit_add_resource() - Add a *test managed resource*.
+ * @test: The test context object.
+ * @init: a user-supplied function to initialize the result (if needed).  If
+ *        none is supplied, the resource data value is simply set to @data.
+ *	  If an init function is supplied, @data is passed to it instead.
+ * @free: a user-supplied function to free the resource (if needed).
+ * @res: The resource.
+ * @data: value to pass to init function or set in resource data field.
+ */
+int kunit_add_resource(struct kunit *test,
+		       kunit_resource_init_t init,
+		       kunit_resource_free_t free,
+		       struct kunit_resource *res,
+		       void *data);
+
+/**
+ * kunit_add_named_resource() - Add a named *test managed resource*.
+ * @test: The test context object.
+ * @init: a user-supplied function to initialize the resource data, if needed.
+ * @free: a user-supplied function to free the resource data, if needed.
+ * @res: The resource.
+ * @name: name to be set for resource.
+ * @data: value to pass to init function or set in resource data field.
+ */
+int kunit_add_named_resource(struct kunit *test,
+			     kunit_resource_init_t init,
+			     kunit_resource_free_t free,
+			     struct kunit_resource *res,
+			     const char *name,
+			     void *data);
+
+/**
+ * kunit_alloc_resource() - Allocates a *test managed resource*.
+ * @test: The test context object.
+ * @init: a user supplied function to initialize the resource.
+ * @free: a user supplied function to free the resource.
+ * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
+ * @context: for the user to pass in arbitrary data to the init function.
+ *
+ * Allocates a *test managed resource*, a resource which will automatically be
+ * cleaned up at the end of a test case. See &struct kunit_resource for an
+ * example.
+ *
+ * Note: KUnit needs to allocate memory for a kunit_resource object. You must
+ * specify an @internal_gfp that is compatible with the use context of your
+ * resource.
+ */
+static inline void *kunit_alloc_resource(struct kunit *test,
+					 kunit_resource_init_t init,
+					 kunit_resource_free_t free,
+					 gfp_t internal_gfp,
+					 void *context)
+{
+	struct kunit_resource *res;
+
+	res = kzalloc(sizeof(*res), internal_gfp);
+	if (!res)
+		return NULL;
+
+	if (!kunit_add_resource(test, init, free, res, context))
+		return res->data;
+
+	return NULL;
+}
+
+typedef bool (*kunit_resource_match_t)(struct kunit *test,
+				       struct kunit_resource *res,
+				       void *match_data);
+
+/**
+ * kunit_resource_instance_match() - Match a resource with the same instance.
+ * @test: Test case to which the resource belongs.
+ * @res: The resource.
+ * @match_data: The resource pointer to match against.
+ *
+ * An instance of kunit_resource_match_t that matches a resource whose
+ * allocation matches @match_data.
+ */
+static inline bool kunit_resource_instance_match(struct kunit *test,
+						 struct kunit_resource *res,
+						 void *match_data)
+{
+	return res->data == match_data;
+}
+
+/**
+ * kunit_resource_name_match() - Match a resource with the same name.
+ * @test: Test case to which the resource belongs.
+ * @res: The resource.
+ * @match_name: The name to match against.
+ */
+static inline bool kunit_resource_name_match(struct kunit *test,
+					     struct kunit_resource *res,
+					     void *match_name)
+{
+	return res->name && strcmp(res->name, match_name) == 0;
+}
+
+/**
+ * kunit_find_resource() - Find a resource using match function/data.
+ * @test: Test case to which the resource belongs.
+ * @match: match function to be applied to resources/match data.
+ * @match_data: data to be used in matching.
+ */
+static inline struct kunit_resource *
+kunit_find_resource(struct kunit *test,
+		    kunit_resource_match_t match,
+		    void *match_data)
+{
+	struct kunit_resource *res, *found = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&test->lock, flags);
+
+	list_for_each_entry_reverse(res, &test->resources, node) {
+		if (match(test, res, (void *)match_data)) {
+			found = res;
+			kunit_get_resource(found);
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&test->lock, flags);
+
+	return found;
+}
+
+/**
+ * kunit_find_named_resource() - Find a resource using match name.
+ * @test: Test case to which the resource belongs.
+ * @name: match name.
+ */
+static inline struct kunit_resource *
+kunit_find_named_resource(struct kunit *test,
+			  const char *name)
+{
+	return kunit_find_resource(test, kunit_resource_name_match,
+				   (void *)name);
+}
+
+/**
+ * kunit_destroy_resource() - Find a kunit_resource and destroy it.
+ * @test: Test case to which the resource belongs.
+ * @match: Match function. Returns whether a given resource matches @match_data.
+ * @match_data: Data passed into @match.
+ *
+ * RETURNS:
+ * 0 if kunit_resource is found and freed, -ENOENT if not found.
+ */
+int kunit_destroy_resource(struct kunit *test,
+			   kunit_resource_match_t match,
+			   void *match_data);
+
+static inline int kunit_destroy_named_resource(struct kunit *test,
+					       const char *name)
+{
+	return kunit_destroy_resource(test, kunit_resource_name_match,
+				      (void *)name);
+}
+
+/**
+ * kunit_remove_resource() - remove resource from resource list associated with
+ *			     test.
+ * @test: The test context object.
+ * @res: The resource to be removed.
+ *
+ * Note that the resource will not be immediately freed since it is likely
+ * the caller has a reference to it via alloc_and_get() or find();
+ * in this case a final call to kunit_put_resource() is required.
+ */
+void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
+
+#endif /* _KUNIT_RESOURCE_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 00b9ff7783ab..d04f9e2fd5e7 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -27,78 +27,6 @@
 
 #include <asm/rwonce.h>
 
-struct kunit_resource;
-
-typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
-typedef void (*kunit_resource_free_t)(struct kunit_resource *);
-
-/**
- * struct kunit_resource - represents a *test managed resource*
- * @data: for the user to store arbitrary data.
- * @name: optional name
- * @free: a user supplied function to free the resource. Populated by
- * kunit_resource_alloc().
- *
- * Represents a *test managed resource*, a resource which will automatically be
- * cleaned up at the end of a test case.
- *
- * Resources are reference counted so if a resource is retrieved via
- * kunit_alloc_and_get_resource() or kunit_find_resource(), we need
- * to call kunit_put_resource() to reduce the resource reference count
- * when finished with it.  Note that kunit_alloc_resource() does not require a
- * kunit_resource_put() because it does not retrieve the resource itself.
- *
- * Example:
- *
- * .. code-block:: c
- *
- *	struct kunit_kmalloc_params {
- *		size_t size;
- *		gfp_t gfp;
- *	};
- *
- *	static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
- *	{
- *		struct kunit_kmalloc_params *params = context;
- *		res->data = kmalloc(params->size, params->gfp);
- *
- *		if (!res->data)
- *			return -ENOMEM;
- *
- *		return 0;
- *	}
- *
- *	static void kunit_kmalloc_free(struct kunit_resource *res)
- *	{
- *		kfree(res->data);
- *	}
- *
- *	void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
- *	{
- *		struct kunit_kmalloc_params params;
- *
- *		params.size = size;
- *		params.gfp = gfp;
- *
- *		return kunit_alloc_resource(test, kunit_kmalloc_init,
- *			kunit_kmalloc_free, &params);
- *	}
- *
- * Resources can also be named, with lookup/removal done on a name
- * basis also.  kunit_add_named_resource(), kunit_find_named_resource()
- * and kunit_destroy_named_resource().  Resource names must be
- * unique within the test instance.
- */
-struct kunit_resource {
-	void *data;
-	const char *name;
-	kunit_resource_free_t free;
-
-	/* private: internal use only. */
-	struct kref refcount;
-	struct list_head node;
-};
-
 struct kunit;
 
 /* Size of log associated with test. */
@@ -385,233 +313,6 @@ static inline int kunit_run_all_tests(void)
 
 enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite);
 
-/*
- * Like kunit_alloc_resource() below, but returns the struct kunit_resource
- * object that contains the allocation. This is mostly for testing purposes.
- */
-struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
-						    kunit_resource_init_t init,
-						    kunit_resource_free_t free,
-						    gfp_t internal_gfp,
-						    void *context);
-
-/**
- * kunit_get_resource() - Hold resource for use.  Should not need to be used
- *			  by most users as we automatically get resources
- *			  retrieved by kunit_find_resource*().
- * @res: resource
- */
-static inline void kunit_get_resource(struct kunit_resource *res)
-{
-	kref_get(&res->refcount);
-}
-
-/*
- * Called when refcount reaches zero via kunit_put_resources();
- * should not be called directly.
- */
-static inline void kunit_release_resource(struct kref *kref)
-{
-	struct kunit_resource *res = container_of(kref, struct kunit_resource,
-						  refcount);
-
-	/* If free function is defined, resource was dynamically allocated. */
-	if (res->free) {
-		res->free(res);
-		kfree(res);
-	}
-}
-
-/**
- * kunit_put_resource() - When caller is done with retrieved resource,
- *			  kunit_put_resource() should be called to drop
- *			  reference count.  The resource list maintains
- *			  a reference count on resources, so if no users
- *			  are utilizing a resource and it is removed from
- *			  the resource list, it will be freed via the
- *			  associated free function (if any).  Only
- *			  needs to be used if we alloc_and_get() or
- *			  find() resource.
- * @res: resource
- */
-static inline void kunit_put_resource(struct kunit_resource *res)
-{
-	kref_put(&res->refcount, kunit_release_resource);
-}
-
-/**
- * kunit_add_resource() - Add a *test managed resource*.
- * @test: The test context object.
- * @init: a user-supplied function to initialize the result (if needed).  If
- *        none is supplied, the resource data value is simply set to @data.
- *	  If an init function is supplied, @data is passed to it instead.
- * @free: a user-supplied function to free the resource (if needed).
- * @res: The resource.
- * @data: value to pass to init function or set in resource data field.
- */
-int kunit_add_resource(struct kunit *test,
-		       kunit_resource_init_t init,
-		       kunit_resource_free_t free,
-		       struct kunit_resource *res,
-		       void *data);
-
-/**
- * kunit_add_named_resource() - Add a named *test managed resource*.
- * @test: The test context object.
- * @init: a user-supplied function to initialize the resource data, if needed.
- * @free: a user-supplied function to free the resource data, if needed.
- * @res: The resource.
- * @name: name to be set for resource.
- * @data: value to pass to init function or set in resource data field.
- */
-int kunit_add_named_resource(struct kunit *test,
-			     kunit_resource_init_t init,
-			     kunit_resource_free_t free,
-			     struct kunit_resource *res,
-			     const char *name,
-			     void *data);
-
-/**
- * kunit_alloc_resource() - Allocates a *test managed resource*.
- * @test: The test context object.
- * @init: a user supplied function to initialize the resource.
- * @free: a user supplied function to free the resource.
- * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
- * @context: for the user to pass in arbitrary data to the init function.
- *
- * Allocates a *test managed resource*, a resource which will automatically be
- * cleaned up at the end of a test case. See &struct kunit_resource for an
- * example.
- *
- * Note: KUnit needs to allocate memory for a kunit_resource object. You must
- * specify an @internal_gfp that is compatible with the use context of your
- * resource.
- */
-static inline void *kunit_alloc_resource(struct kunit *test,
-					 kunit_resource_init_t init,
-					 kunit_resource_free_t free,
-					 gfp_t internal_gfp,
-					 void *context)
-{
-	struct kunit_resource *res;
-
-	res = kzalloc(sizeof(*res), internal_gfp);
-	if (!res)
-		return NULL;
-
-	if (!kunit_add_resource(test, init, free, res, context))
-		return res->data;
-
-	return NULL;
-}
-
-typedef bool (*kunit_resource_match_t)(struct kunit *test,
-				       struct kunit_resource *res,
-				       void *match_data);
-
-/**
- * kunit_resource_instance_match() - Match a resource with the same instance.
- * @test: Test case to which the resource belongs.
- * @res: The resource.
- * @match_data: The resource pointer to match against.
- *
- * An instance of kunit_resource_match_t that matches a resource whose
- * allocation matches @match_data.
- */
-static inline bool kunit_resource_instance_match(struct kunit *test,
-						 struct kunit_resource *res,
-						 void *match_data)
-{
-	return res->data == match_data;
-}
-
-/**
- * kunit_resource_name_match() - Match a resource with the same name.
- * @test: Test case to which the resource belongs.
- * @res: The resource.
- * @match_name: The name to match against.
- */
-static inline bool kunit_resource_name_match(struct kunit *test,
-					     struct kunit_resource *res,
-					     void *match_name)
-{
-	return res->name && strcmp(res->name, match_name) == 0;
-}
-
-/**
- * kunit_find_resource() - Find a resource using match function/data.
- * @test: Test case to which the resource belongs.
- * @match: match function to be applied to resources/match data.
- * @match_data: data to be used in matching.
- */
-static inline struct kunit_resource *
-kunit_find_resource(struct kunit *test,
-		    kunit_resource_match_t match,
-		    void *match_data)
-{
-	struct kunit_resource *res, *found = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&test->lock, flags);
-
-	list_for_each_entry_reverse(res, &test->resources, node) {
-		if (match(test, res, (void *)match_data)) {
-			found = res;
-			kunit_get_resource(found);
-			break;
-		}
-	}
-
-	spin_unlock_irqrestore(&test->lock, flags);
-
-	return found;
-}
-
-/**
- * kunit_find_named_resource() - Find a resource using match name.
- * @test: Test case to which the resource belongs.
- * @name: match name.
- */
-static inline struct kunit_resource *
-kunit_find_named_resource(struct kunit *test,
-			  const char *name)
-{
-	return kunit_find_resource(test, kunit_resource_name_match,
-				   (void *)name);
-}
-
-/**
- * kunit_destroy_resource() - Find a kunit_resource and destroy it.
- * @test: Test case to which the resource belongs.
- * @match: Match function. Returns whether a given resource matches @match_data.
- * @match_data: Data passed into @match.
- *
- * RETURNS:
- * 0 if kunit_resource is found and freed, -ENOENT if not found.
- */
-int kunit_destroy_resource(struct kunit *test,
-			   kunit_resource_match_t match,
-			   void *match_data);
-
-static inline int kunit_destroy_named_resource(struct kunit *test,
-					       const char *name)
-{
-	return kunit_destroy_resource(test, kunit_resource_name_match,
-				      (void *)name);
-}
-
-/**
- * kunit_remove_resource() - remove resource from resource list associated with
- *			     test.
- * @test: The test context object.
- * @res: The resource to be removed.
- *
- * Note that the resource will not be immediately freed since it is likely
- * the caller has a reference to it via alloc_and_get() or find();
- * in this case a final call to kunit_put_resource() is required.
- */
-void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
-
 /**
  * kunit_kmalloc_array() - Like kmalloc_array() except the allocation is *test managed*.
  * @test: The test context object.
@@ -1526,4 +1227,8 @@ do {									       \
 		return NULL;									\
 	}
 
+// TODO(dlatypov@google.com): consider eventually migrating users to explicitly
+// include resource.h themselves if they need it.
+#include <kunit/resource.h>
+
 #endif /* _KUNIT_TEST_H */

base-commit: b14ffae378aa1db993e62b01392e70d1e585fb23
-- 
2.35.1.1021.g381101b075-goog

