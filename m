Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4B94EFEB1
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Apr 2022 06:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbiDBEho (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Apr 2022 00:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239724AbiDBEhn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Apr 2022 00:37:43 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26743DEE4
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Apr 2022 21:35:51 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id p9-20020a63f449000000b0035ec8c16f0bso2510415pgk.11
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Apr 2022 21:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cZc0GmrzkAfI+cudbavM/icDpyA+Hphtk/mRobHHbxA=;
        b=eJ1+d5OwPj70RjCWQfMFoPQzg7fN44o1GQGVW0qt7KbxVqUVHPBcWXEBNa7aUtWbpz
         1zqTtF19zQcTPpzG31w7ZSz7qVpEZeD5insNCJZRDAGk/jT2Vue3rHkNoeH/OK4JhUaF
         3P3B4Of1iRJU5WQETD8QmUFfy6ZKqpGwVLXw0EetMpjz5Fd34hKtM5DqrgtCbE/bSFKe
         l0R/CYxT+8GaHVuQoUlk+ku8NakR8GcKfKvr0tKyBexAVWYBZwg9qri+bAVkCHqWuF7f
         DAdaAkCQ8e/JEZ+V5MEO0AUd+ochdbfefGVDgCzfEBD/MDfv1SsaTfNQqKeFpRpEE3rF
         W/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cZc0GmrzkAfI+cudbavM/icDpyA+Hphtk/mRobHHbxA=;
        b=mFvNaa474iNtBwnQgalNHWFFWAyBjKhWwEMpxwExCIMWn+CT0PtsZxz09MUELxPyeb
         JrVvGvVW0ypraIa20MeGKPnMQdXQRUe4L+TJgHA7fQM9qUIcv5XQF3omHqjE6+taTAhc
         QOyR9lH0RGjA+oBUPe/Wd6yiiUhOWTNOwFC5w4FkQoNPnziO9Z0neu7Kf/2/KiYjKMm+
         EROd0G6nptLXfB3164f01gnxy61VpJiC+E7HLK0AFMvlTYMWDss9PRsX4kivypUA0otj
         cSUfU7uarV0qmbJQSgHCNhaM9uztdMUkFUL7VlSuhisM9Oesp9BEqt4FkY5xS4ghoz2/
         9d0Q==
X-Gm-Message-State: AOAM531dtWwewPt1p+92qJWD2vAlquz8sXE2iS5dU3YVi+hgYUvxsZRa
        HaT03g5xgyHprpNIvLNhC6s/AjpJr3sePg==
X-Google-Smtp-Source: ABdhPJz6iESWWVvm1oRA6TdmJPuC8W/ScIm4Q/CLBmg0aJ699mQVFgJCdEZecSJv1G8R8/JM3GljcfL3jWSi6w==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90b:e81:b0:1c6:5a9c:5afa with SMTP id
 fv1-20020a17090b0e8100b001c65a9c5afamr751637pjb.1.1648874150361; Fri, 01 Apr
 2022 21:35:50 -0700 (PDT)
Date:   Sat,  2 Apr 2022 12:35:30 +0800
In-Reply-To: <20220402043530.923747-1-davidgow@google.com>
Message-Id: <20220402043530.923747-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220402043530.923747-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v2 2/2] kunit: Rework kunit_resource allocation policy
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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
Tested-by: Daniel Latypov <dlatypov@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220319055600.3471875-1-davidgow@google.com/
- Rebased on top of Daniel's split of the resource system into
  resource.{c,h}
  - https://lore.kernel.org/linux-kselftest/20220328174143.857262-1-dlatypov@google.com/
  - https://lore.kernel.org/linux-kselftest/20220328174143.857262-2-dlatypov@google.com/
- Renamed should_free to should_kfree
- Fixed an issue where should_kfree was overwritten.
- Tidied up some comments slightly.

 include/kunit/resource.h | 142 +++++++++++++++++++++++++++++++--------
 lib/kunit/resource.c     |  64 ++----------------
 2 files changed, 122 insertions(+), 84 deletions(-)

diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index 7ab1fd83972b..09c2b34d1c61 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -25,11 +25,13 @@ typedef void (*kunit_resource_free_t)(struct kunit_resource *);
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
+ * function. The struct kunit_resource itself is freed automatically with
+ * kfree() if it was allocated by KUnit (e.g., by kunit_alloc_resource()), but
+ * must be freed by the user otherwise.
  *
  * Resources are reference counted so if a resource is retrieved via
  * kunit_alloc_and_get_resource() or kunit_find_resource(), we need
@@ -86,18 +88,9 @@ struct kunit_resource {
 	/* private: internal use only. */
 	struct kref refcount;
 	struct list_head node;
+	bool should_kfree;
 };
 
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
@@ -118,11 +111,14 @@ static inline void kunit_release_resource(struct kref *kref)
 	struct kunit_resource *res = container_of(kref, struct kunit_resource,
 						  refcount);
 
-	/* If free function is defined, resource was dynamically allocated. */
-	if (res->free) {
+	if (res->free)
 		res->free(res);
+
+	/* 'res' is valid here, as if should_kfree is set, res->free may not free
+	 * 'res' itself, just res->data
+	 */
+	if (res->should_kfree)
 		kfree(res);
-	}
 }
 
 /**
@@ -142,6 +138,24 @@ static inline void kunit_put_resource(struct kunit_resource *res)
 	kref_put(&res->refcount, kunit_release_resource);
 }
 
+/**
+ * __kunit_add_resource() - Internal helper to add a resource.
+ *
+ * res->should_kfree is not initialised.
+ * @test: The test context object.
+ * @init: a user-supplied function to initialize the result (if needed).  If
+ *        none is supplied, the resource data value is simply set to @data.
+ *	  If an init function is supplied, @data is passed to it instead.
+ * @free: a user-supplied function to free the resource (if needed).
+ * @res: The resource.
+ * @data: value to pass to init function or set in resource data field.
+ */
+int __kunit_add_resource(struct kunit *test,
+			 kunit_resource_init_t init,
+			 kunit_resource_free_t free,
+			 struct kunit_resource *res,
+			 void *data);
+
 /**
  * kunit_add_resource() - Add a *test managed resource*.
  * @test: The test context object.
@@ -152,11 +166,18 @@ static inline void kunit_put_resource(struct kunit_resource *res)
  * @res: The resource.
  * @data: value to pass to init function or set in resource data field.
  */
-int kunit_add_resource(struct kunit *test,
-		       kunit_resource_init_t init,
-		       kunit_resource_free_t free,
-		       struct kunit_resource *res,
-		       void *data);
+static inline int kunit_add_resource(struct kunit *test,
+				     kunit_resource_init_t init,
+				     kunit_resource_free_t free,
+				     struct kunit_resource *res,
+				     void *data)
+{
+	res->should_kfree = false;
+	return __kunit_add_resource(test, init, free, res, data);
+}
+
+static inline struct kunit_resource *
+kunit_find_named_resource(struct kunit *test, const char *name);
 
 /**
  * kunit_add_named_resource() - Add a named *test managed resource*.
@@ -167,18 +188,84 @@ int kunit_add_resource(struct kunit *test,
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
+	res->should_kfree = false;
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
+	res->should_kfree = true;
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
@@ -202,7 +289,8 @@ static inline void *kunit_alloc_resource(struct kunit *test,
 	if (!res)
 		return NULL;
 
-	if (!kunit_add_resource(test, init, free, res, context))
+	res->should_kfree = true;
+	if (!__kunit_add_resource(test, init, free, res, context))
 		return res->data;
 
 	return NULL;
diff --git a/lib/kunit/resource.c b/lib/kunit/resource.c
index 09ec392d2323..9acef295d519 100644
--- a/lib/kunit/resource.c
+++ b/lib/kunit/resource.c
@@ -14,13 +14,13 @@
  * Used for static resources and when a kunit_resource * has been created by
  * kunit_alloc_resource().  When an init function is supplied, @data is passed
  * into the init function; otherwise, we simply set the resource data field to
- * the data value passed in.
+ * the data value passed in. Doesn't initialize res->should_kfree.
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
@@ -43,57 +43,7 @@ int kunit_add_resource(struct kunit *test,
 
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
2.35.1.1094.g7c7d902a7c-goog

