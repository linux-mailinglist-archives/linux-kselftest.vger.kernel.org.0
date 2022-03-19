Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F9A4DE65B
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Mar 2022 06:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242243AbiCSF5a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Mar 2022 01:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiCSF53 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Mar 2022 01:57:29 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5175523D584
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Mar 2022 22:56:08 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id u67-20020a627946000000b004fa6338bd77so3134863pfc.10
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Mar 2022 22:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nOSscoLBz+9Ez3L4Uv5wJKlo4Zgucqk65NIslIX0k5k=;
        b=jnf5Wpt/CuS2xwZqbh1dbM/o6C/et+7Zba5iWmAOmLySKqO03YfW8yNOkSFI88fEyO
         WF30USIj2Kjpt4rHtEuF2l8MLi/8g5rs35hZTL9TcmlhPI3OGcypqR7I+Ona2BQdLXxq
         0oNU+IiAEma8mKeo4HyEL1AyMSxzqCNK1Pn3SsT7y5YeR8NMYkK42MCPNcuE9j/zAgpV
         zkx3PTDz1cdK9ghzz+aZ7+d+RidEAIVwL9XybzbFhV6fkH3P26Jz2t3BpHnHCQdnh+RA
         v9qLLKTrWMfqsEzQfwE7IzdzS3O2zeo8m2/usibNnz2cusUXr5XUVhJaPpjnZCaLZHWS
         kmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nOSscoLBz+9Ez3L4Uv5wJKlo4Zgucqk65NIslIX0k5k=;
        b=E291rayZK2JpHbjMcK9c4L52mjA+Vkw9f2ji667F3QsFbDSUhnj/Mm3/2CR7vKQT9s
         MvfBlRS3mdpqB9S5zRg3ZlTBgUnIbMEgwjS8nZy7XmtKs9SOT+P44PMJGyYUuHZ+nrVL
         55ckKW3WfnOq9+pGSbgk0uFj8bbvXblhJIYc2uVKIB3i5QuH6BC77Ck7uAY34U4cRYYT
         RlZ5I3wq3ZdvJSUaGTEk8YdX5DXkUcnnCbj4V+ootrXpOk8DLuMvw2Qosh91f/v6Nv5Q
         9FEyF1zCKb5FrbzutrMwc/Cngrvwvh/z2bgWJDSEJeUjSXLoWCKDKKLNuiNMUTIvo7A/
         /I3g==
X-Gm-Message-State: AOAM532sw4ezKZCzZ/K/85LDHXY2K8VpsLR1+f9JF12Bc5QSq6C34hqu
        ZsfCExhUGmW71v0lgNNHjSDCdPZwvN5Evw==
X-Google-Smtp-Source: ABdhPJxqHkAvVA6p1JsGlFu9o1xcfR1E6qQ6OS5h2MpA6WLr5xgXKzCqcI5Qk0OiQC/hlqmlSE9d2ADHMzsY8w==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90b:e81:b0:1c6:5a9c:5afa with SMTP id
 fv1-20020a17090b0e8100b001c65a9c5afamr742984pjb.1.1647669367224; Fri, 18 Mar
 2022 22:56:07 -0700 (PDT)
Date:   Sat, 19 Mar 2022 13:56:00 +0800
Message-Id: <20220319055600.3471875-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH] kunit: Rework kunit_resource allocation policy
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

KUnit's test-managed resources can be created in two ways:
- Using the kunit_add_resource() family of functions, which accept a
  struct kunit_resource pointer, typically allocated statically or on
  the stack during the test.
- Using the kunit_alloc_resource() family of functions, which allocate a
  struct kunit_resource using kzalloc() behind the scenes.

Both of these families of functions accept a 'free' function to be
called when the resource is finally disposed of.

At present, KUnit will kfree() the resource if this 'free' function is
specified, and will not if it is NULL. However, this can lead
kunit_alloc_resource() to leak memory (if no 'free' function is passed
in), or kunit_add_resource() to incorrectly kfree() memory which was
allocated by some other means (on the stack, as part of a larger
allocation, etc), if a 'free' function is provided.

Instead, always kfree() if the resource was allocated with
kunit_alloc_resource(), and never kfree() if it was passed into
kunit_add_resource() by the user. (If the user of kunit_add_resource()
wishes the resource be kfree()ed, they can call kfree() on the resource
from within the 'free' function.

This is implemented by adding a 'should_free' member to
struct kunit_resource and setting it appropriately. To facilitate this,
the various resource add/alloc functions have been refactored somewhat,
making them all call a __kunit_add_resource() helper after setting the
'should_free' member appropriately. In the process, all other functions
have been made static inline functions.

Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/test.h | 135 +++++++++++++++++++++++++++++++++++--------
 lib/kunit/test.c     |  65 +++------------------
 2 files changed, 120 insertions(+), 80 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 00b9ff7783ab..5a3aacbadda2 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -36,11 +36,14 @@ typedef void (*kunit_resource_free_t)(struct kunit_resource *);
  * struct kunit_resource - represents a *test managed resource*
  * @data: for the user to store arbitrary data.
  * @name: optional name
- * @free: a user supplied function to free the resource. Populated by
- * kunit_resource_alloc().
+ * @free: a user supplied function to free the resource.
  *
  * Represents a *test managed resource*, a resource which will automatically be
- * cleaned up at the end of a test case.
+ * cleaned up at the end of a test case. This cleanup is performed by the 'free'
+ * function. The resource itself is allocated with kmalloc() and freed with
+ * kfree() if created with kunit_alloc_{,and_get_}resource(), otherwise it must
+ * be freed by the user, typically with the 'free' function, or automatically if
+ * it's allocated on the stack.
  *
  * Resources are reference counted so if a resource is retrieved via
  * kunit_alloc_and_get_resource() or kunit_find_resource(), we need
@@ -97,6 +100,7 @@ struct kunit_resource {
 	/* private: internal use only. */
 	struct kref refcount;
 	struct list_head node;
+	bool should_free;
 };
 
 struct kunit;
@@ -385,16 +389,6 @@ static inline int kunit_run_all_tests(void)
 
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
 /**
  * kunit_get_resource() - Hold resource for use.  Should not need to be used
  *			  by most users as we automatically get resources
@@ -416,10 +410,14 @@ static inline void kunit_release_resource(struct kref *kref)
 						  refcount);
 
 	/* If free function is defined, resource was dynamically allocated. */
-	if (res->free) {
+	if (res->free)
 		res->free(res);
+
+	/* 'res' is valid here, as if should_free is set, res->free may not free
+	 * 'res' itself, just res->data
+	 */
+	if (res->should_free)
 		kfree(res);
-	}
 }
 
 /**
@@ -440,7 +438,9 @@ static inline void kunit_put_resource(struct kunit_resource *res)
 }
 
 /**
- * kunit_add_resource() - Add a *test managed resource*.
+ * __kunit_add_resource() - Internal helper to add a resource.
+ *
+ * res->should_free is not initialised.
  * @test: The test context object.
  * @init: a user-supplied function to initialize the result (if needed).  If
  *        none is supplied, the resource data value is simply set to @data.
@@ -449,12 +449,34 @@ static inline void kunit_put_resource(struct kunit_resource *res)
  * @res: The resource.
  * @data: value to pass to init function or set in resource data field.
  */
-int kunit_add_resource(struct kunit *test,
+int __kunit_add_resource(struct kunit *test,
 		       kunit_resource_init_t init,
 		       kunit_resource_free_t free,
 		       struct kunit_resource *res,
 		       void *data);
 
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
+static inline int kunit_add_resource(struct kunit *test,
+				     kunit_resource_init_t init,
+				     kunit_resource_free_t free,
+				     struct kunit_resource *res,
+				     void *data)
+{
+	res->should_free = false;
+	return __kunit_add_resource(test, init, free, res, data);
+}
+
+static inline struct kunit_resource *
+kunit_find_named_resource(struct kunit *test, const char *name);
 /**
  * kunit_add_named_resource() - Add a named *test managed resource*.
  * @test: The test context object.
@@ -464,18 +486,84 @@ int kunit_add_resource(struct kunit *test,
  * @name: name to be set for resource.
  * @data: value to pass to init function or set in resource data field.
  */
-int kunit_add_named_resource(struct kunit *test,
+static inline int kunit_add_named_resource(struct kunit *test,
+					   kunit_resource_init_t init,
+					   kunit_resource_free_t free,
+					   struct kunit_resource *res,
+					   const char *name,
+					   void *data)
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
+	res->should_free = false;
+
+	return __kunit_add_resource(test, init, free, res, data);
+}
+
+/**
+ * kunit_alloc_and_get_resource() - Allocates and returns a *test managed resource*.
+ * @test: The test context object.
+ * @init: a user supplied function to initialize the resource.
+ * @free: a user supplied function to free the resource (if needed).
+ * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
+ * @context: for the user to pass in arbitrary data to the init function.
+ *
+ * Allocates a *test managed resource*, a resource which will automatically be
+ * cleaned up at the end of a test case. See &struct kunit_resource for an
+ * example.
+ *
+ * This is effectively identical to kunit_alloc_resource, but returns the
+ * struct kunit_resource pointer, not just the 'data' pointer. It therefore
+ * also increments the resource's refcount, so kunit_put_resource() should be
+ * called when you've finished with it.
+ *
+ * Note: KUnit needs to allocate memory for a kunit_resource object. You must
+ * specify an @internal_gfp that is compatible with the use context of your
+ * resource.
+ */
+static inline struct kunit_resource *
+kunit_alloc_and_get_resource(struct kunit *test,
 			     kunit_resource_init_t init,
 			     kunit_resource_free_t free,
-			     struct kunit_resource *res,
-			     const char *name,
-			     void *data);
+			     gfp_t internal_gfp,
+			     void *context)
+{
+	struct kunit_resource *res;
+	int ret;
+
+	res = kzalloc(sizeof(*res), internal_gfp);
+	if (!res)
+		return NULL;
+
+	res->should_free = true;
+
+	ret = __kunit_add_resource(test, init, free, res, context);
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
 
 /**
  * kunit_alloc_resource() - Allocates a *test managed resource*.
  * @test: The test context object.
  * @init: a user supplied function to initialize the resource.
- * @free: a user supplied function to free the resource.
+ * @free: a user supplied function to free the resource (if needed).
  * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
  * @context: for the user to pass in arbitrary data to the init function.
  *
@@ -499,7 +587,8 @@ static inline void *kunit_alloc_resource(struct kunit *test,
 	if (!res)
 		return NULL;
 
-	if (!kunit_add_resource(test, init, free, res, context))
+	res->should_free = true;
+	if (!__kunit_add_resource(test, init, free, res, context))
 		return res->data;
 
 	return NULL;
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3bca3bf5c15b..b4f10329abb8 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -596,18 +596,19 @@ EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
  * Used for static resources and when a kunit_resource * has been created by
  * kunit_alloc_resource().  When an init function is supplied, @data is passed
  * into the init function; otherwise, we simply set the resource data field to
- * the data value passed in.
+ * the data value passed in. Doesn't initialize res->should_free.
  */
-int kunit_add_resource(struct kunit *test,
-		       kunit_resource_init_t init,
-		       kunit_resource_free_t free,
-		       struct kunit_resource *res,
-		       void *data)
+int __kunit_add_resource(struct kunit *test,
+			 kunit_resource_init_t init,
+			 kunit_resource_free_t free,
+			 struct kunit_resource *res,
+			 void *data)
 {
 	int ret = 0;
 	unsigned long flags;
 
 	res->free = free;
+	res->should_free = false;
 	kref_init(&res->refcount);
 
 	if (init) {
@@ -625,57 +626,7 @@ int kunit_add_resource(struct kunit *test,
 
 	return ret;
 }
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
+EXPORT_SYMBOL_GPL(__kunit_add_resource);
 
 void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
 {
-- 
2.35.1.894.gb6a874cedc-goog

