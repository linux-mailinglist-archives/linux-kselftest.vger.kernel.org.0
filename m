Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA3820197B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 19:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389507AbgFSR2l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbgFSR2k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 13:28:40 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71D5C06174E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 10:28:40 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id p70so9081343oic.12
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=F1rKKAvA2IGNgvyfp1GIdROaF8UtMGLKWPeo1bZgxbQ=;
        b=TzYuRsCXL9RVmQPFZ08BYboYSYVZ1i5hngm3dvG3iZJIF7OFqhMBbOG9l08z/SSsD5
         /LiBHJuFhovx6iZVR7BViXf3JuauvZ9nGipA9XUwXet5eRxaBA1faFbkKqTrIRYoGXFz
         BQSVqd536ItZ8CZp90spSkh/PJjiIT9mPmfxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=F1rKKAvA2IGNgvyfp1GIdROaF8UtMGLKWPeo1bZgxbQ=;
        b=JC8EBU52ay4WRkL1+8pTotsyk6IsIeudPd6oGki0d3q8bOd1B0RHdu1/QsJWTmt072
         imjA5b3k7j3UFBge5hysYPB/n9neXD0NqcpYQwuAhrqNfiU3/ZMJtBF17vYUcR+2YeyT
         XRQs1OI9uEqJ5/XtySazM77AKu15PMfPpSAGBrvl2Pq4OfogwRNNd1oZX74eE38pXXn+
         gEH6Y4TD+Q4llzXD910/P82sHehGOX8cPw5zJ6d2G5FsyPN+GclwyomXw/OxI8Jbz7Vb
         MKfHs2TzD176CqrKa1tZogt3LnxxMeJKzhP7GgSaryOSQqhJV3rqCEGAIitGcJewIcec
         MvWg==
X-Gm-Message-State: AOAM530noNIjfsc0upGhHnILuD2/XwM6OYvlcGWyXtsvyt816MDgQHtJ
        7amjHp4QMx1TXebFlk1Gzs2H8Q==
X-Google-Smtp-Source: ABdhPJxaa2p913oUa39pN8qy9rW+8VnzJd709BewLyZojOhVBv692I5vsKKQFkmB0Ry6Gj8otSEVCQ==
X-Received: by 2002:a05:6808:4c1:: with SMTP id a1mr3901015oie.100.1592587720056;
        Fri, 19 Jun 2020 10:28:40 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 6sm1584270ooy.18.2020.06.19.10.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 10:28:39 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kunit update for Linux 5.8-rc2
Message-ID: <90024a5c-ea67-2529-e330-3a4f0bef6596@linuxfoundation.org>
Date:   Fri, 19 Jun 2020 11:28:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------F323B03CA4D0B5E3B3156FEF"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------F323B03CA4D0B5E3B3156FEF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the Kunit update for Linux 5.8-rc12.

This Kunit update for Linux 5.8-rc2 consists of:

- Adds a generic kunit_resource API extending it to support
   resources that are passed in to kunit in addition kunit
   allocated resources. In addition, KUnit resources are now
   refcounted to avoid passed in resources being released while
   in use by kunit.

- Add support for named resources.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-5.8-rc2

for you to fetch changes up to 7bf200b3a4ac10b1b0376c70b8c66ed39eae7cdd:

   kunit: add support for named resources (2020-06-15 09:31:23 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-5.8-rc2

This Kunit update for Linux 5.8-rc2 consists of:

- Adds a generic kunit_resource API extending it to support
   resources that are passed in to kunit in addition kunit
   allocated resources. In addition, KUnit resources are now
   refcounted to avoid passed in resources being released while
   in use by kunit.

- Add support for named resources.

----------------------------------------------------------------
Alan Maguire (2):
       kunit: generalize kunit_resource API beyond allocated resources
       kunit: add support for named resources

  include/kunit/test.h      | 210 
+++++++++++++++++++++++++++++++++++++++-------
  lib/kunit/kunit-test.c    | 111 +++++++++++++++++++-----
  lib/kunit/string-stream.c |  14 ++--
  lib/kunit/test.c          | 171 ++++++++++++++++++++++---------------
  4 files changed, 380 insertions(+), 126 deletions(-)

----------------------------------------------------------------

--------------F323B03CA4D0B5E3B3156FEF
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.8-rc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.8-rc2.diff"

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 47e61e1d5337..59f3144f009a 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/kref.h>
 
 struct kunit_resource;
 
@@ -23,13 +24,19 @@ typedef void (*kunit_resource_free_t)(struct kunit_resource *);
 
 /**
  * struct kunit_resource - represents a *test managed resource*
- * @allocation: for the user to store arbitrary data.
+ * @data: for the user to store arbitrary data.
  * @free: a user supplied function to free the resource. Populated by
- * kunit_alloc_resource().
+ * kunit_resource_alloc().
  *
  * Represents a *test managed resource*, a resource which will automatically be
  * cleaned up at the end of a test case.
  *
+ * Resources are reference counted so if a resource is retrieved via
+ * kunit_alloc_and_get_resource() or kunit_find_resource(), we need
+ * to call kunit_put_resource() to reduce the resource reference count
+ * when finished with it.  Note that kunit_alloc_resource() does not require a
+ * kunit_resource_put() because it does not retrieve the resource itself.
+ *
  * Example:
  *
  * .. code-block:: c
@@ -42,9 +49,9 @@ typedef void (*kunit_resource_free_t)(struct kunit_resource *);
  *	static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
  *	{
  *		struct kunit_kmalloc_params *params = context;
- *		res->allocation = kmalloc(params->size, params->gfp);
+ *		res->data = kmalloc(params->size, params->gfp);
  *
- *		if (!res->allocation)
+ *		if (!res->data)
  *			return -ENOMEM;
  *
  *		return 0;
@@ -52,30 +59,32 @@ typedef void (*kunit_resource_free_t)(struct kunit_resource *);
  *
  *	static void kunit_kmalloc_free(struct kunit_resource *res)
  *	{
- *		kfree(res->allocation);
+ *		kfree(res->data);
  *	}
  *
  *	void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
  *	{
  *		struct kunit_kmalloc_params params;
- *		struct kunit_resource *res;
  *
  *		params.size = size;
  *		params.gfp = gfp;
  *
- *		res = kunit_alloc_resource(test, kunit_kmalloc_init,
+ *		return kunit_alloc_resource(test, kunit_kmalloc_init,
  *			kunit_kmalloc_free, &params);
- *		if (res)
- *			return res->allocation;
- *
- *		return NULL;
  *	}
+ *
+ * Resources can also be named, with lookup/removal done on a name
+ * basis also.  kunit_add_named_resource(), kunit_find_named_resource()
+ * and kunit_destroy_named_resource().  Resource names must be
+ * unique within the test instance.
  */
 struct kunit_resource {
-	void *allocation;
-	kunit_resource_free_t free;
+	void *data;
+	const char *name;		/* optional name */
 
 	/* private: internal use only. */
+	kunit_resource_free_t free;
+	struct kref refcount;
 	struct list_head node;
 };
 
@@ -283,6 +292,79 @@ struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
 						    gfp_t internal_gfp,
 						    void *context);
 
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
+ * Called when refcount reaches zero via kunit_put_resources();
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
+ * @name_data: name and data to be set for resource.
+ */
+int kunit_add_named_resource(struct kunit *test,
+			     kunit_resource_init_t init,
+			     kunit_resource_free_t free,
+			     struct kunit_resource *res,
+			     const char *name,
+			     void *data);
+
 /**
  * kunit_alloc_resource() - Allocates a *test managed resource*.
  * @test: The test context object.
@@ -295,7 +377,7 @@ struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
  * cleaned up at the end of a test case. See &struct kunit_resource for an
  * example.
  *
- * NOTE: KUnit needs to allocate memory for each kunit_resource object. You must
+ * Note: KUnit needs to allocate memory for a kunit_resource object. You must
  * specify an @internal_gfp that is compatible with the use context of your
  * resource.
  */
@@ -307,54 +389,122 @@ static inline void *kunit_alloc_resource(struct kunit *test,
 {
 	struct kunit_resource *res;
 
-	res = kunit_alloc_and_get_resource(test, init, free, internal_gfp,
-					   context);
+	res = kzalloc(sizeof(*res), internal_gfp);
+	if (!res)
+		return NULL;
 
-	if (res)
-		return res->allocation;
+	if (!kunit_add_resource(test, init, free, res, context))
+		return res->data;
 
 	return NULL;
 }
 
 typedef bool (*kunit_resource_match_t)(struct kunit *test,
-				       const void *res,
+				       struct kunit_resource *res,
 				       void *match_data);
 
 /**
  * kunit_resource_instance_match() - Match a resource with the same instance.
  * @test: Test case to which the resource belongs.
- * @res: The data stored in kunit_resource->allocation.
+ * @res: The resource.
  * @match_data: The resource pointer to match against.
  *
  * An instance of kunit_resource_match_t that matches a resource whose
  * allocation matches @match_data.
  */
 static inline bool kunit_resource_instance_match(struct kunit *test,
-						 const void *res,
+						 struct kunit_resource *res,
 						 void *match_data)
 {
-	return res == match_data;
+	return res->data == match_data;
 }
 
 /**
- * kunit_resource_destroy() - Find a kunit_resource and destroy it.
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
+
+	spin_lock(&test->lock);
+
+	list_for_each_entry_reverse(res, &test->resources, node) {
+		if (match(test, res, (void *)match_data)) {
+			found = res;
+			kunit_get_resource(found);
+			break;
+		}
+	}
+
+	spin_unlock(&test->lock);
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
  * @test: Test case to which the resource belongs.
  * @match: Match function. Returns whether a given resource matches @match_data.
- * @free: Must match free on the kunit_resource to free.
  * @match_data: Data passed into @match.
  *
- * Free the latest kunit_resource of @test for which @free matches the
- * kunit_resource_free_t associated with the resource and for which @match
- * returns true.
- *
  * RETURNS:
  * 0 if kunit_resource is found and freed, -ENOENT if not found.
  */
-int kunit_resource_destroy(struct kunit *test,
+int kunit_destroy_resource(struct kunit *test,
 			   kunit_resource_match_t match,
-			   kunit_resource_free_t free,
 			   void *match_data);
 
+static inline int kunit_destroy_named_resource(struct kunit *test,
+					       const char *name)
+{
+	return kunit_destroy_resource(test, kunit_resource_name_match,
+				      (void *)name);
+}
+
+/**
+ * kunit_remove_resource: remove resource from resource list associated with
+ *			  test.
+ * @test: The test context object.
+ * @res: The resource to be removed.
+ *
+ * Note that the resource will not be immediately freed since it is likely
+ * the caller has a reference to it via alloc_and_get() or find();
+ * in this case a final call to kunit_put_resource() is required.
+ */
+void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
+
 /**
  * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
  * @test: The test context object.
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 4f3d36a72f8f..69f902440a0e 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -118,14 +118,14 @@ static int fake_resource_init(struct kunit_resource *res, void *context)
 {
 	struct kunit_test_resource_context *ctx = context;
 
-	res->allocation = &ctx->is_resource_initialized;
+	res->data = &ctx->is_resource_initialized;
 	ctx->is_resource_initialized = true;
 	return 0;
 }
 
 static void fake_resource_free(struct kunit_resource *res)
 {
-	bool *is_resource_initialized = res->allocation;
+	bool *is_resource_initialized = res->data;
 
 	*is_resource_initialized = false;
 }
@@ -154,11 +154,21 @@ static void kunit_resource_test_alloc_resource(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
 	KUNIT_EXPECT_PTR_EQ(test,
 			    &ctx->is_resource_initialized,
-			    (bool *) res->allocation);
+			    (bool *)res->data);
 	KUNIT_EXPECT_TRUE(test, list_is_last(&res->node, &ctx->test.resources));
 	KUNIT_EXPECT_PTR_EQ(test, free, res->free);
+
+	kunit_put_resource(res);
 }
 
+/*
+ * Note: tests below use kunit_alloc_and_get_resource(), so as a consequence
+ * they have a reference to the associated resource that they must release
+ * via kunit_put_resource().  In normal operation, users will only
+ * have to do this for cases where they use kunit_find_resource(), and the
+ * kunit_alloc_resource() function will be used (which does not take a
+ * resource reference).
+ */
 static void kunit_resource_test_destroy_resource(struct kunit *test)
 {
 	struct kunit_test_resource_context *ctx = test->priv;
@@ -169,11 +179,12 @@ static void kunit_resource_test_destroy_resource(struct kunit *test)
 			GFP_KERNEL,
 			ctx);
 
+	kunit_put_resource(res);
+
 	KUNIT_ASSERT_FALSE(test,
-			   kunit_resource_destroy(&ctx->test,
+			   kunit_destroy_resource(&ctx->test,
 						  kunit_resource_instance_match,
-						  res->free,
-						  res->allocation));
+						  res->data));
 
 	KUNIT_EXPECT_FALSE(test, ctx->is_resource_initialized);
 	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
@@ -191,6 +202,7 @@ static void kunit_resource_test_cleanup_resources(struct kunit *test)
 							    fake_resource_free,
 							    GFP_KERNEL,
 							    ctx);
+		kunit_put_resource(resources[i]);
 	}
 
 	kunit_cleanup(&ctx->test);
@@ -221,14 +233,14 @@ static int fake_resource_2_init(struct kunit_resource *res, void *context)
 
 	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 2);
 
-	res->allocation = ctx;
+	res->data = ctx;
 
 	return 0;
 }
 
 static void fake_resource_2_free(struct kunit_resource *res)
 {
-	struct kunit_test_resource_context *ctx = res->allocation;
+	struct kunit_test_resource_context *ctx = res->data;
 
 	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 2);
 }
@@ -236,23 +248,26 @@ static void fake_resource_2_free(struct kunit_resource *res)
 static int fake_resource_1_init(struct kunit_resource *res, void *context)
 {
 	struct kunit_test_resource_context *ctx = context;
+	struct kunit_resource *res2;
 
-	kunit_alloc_and_get_resource(&ctx->test,
-				     fake_resource_2_init,
-				     fake_resource_2_free,
-				     GFP_KERNEL,
-				     ctx);
+	res2 = kunit_alloc_and_get_resource(&ctx->test,
+					    fake_resource_2_init,
+					    fake_resource_2_free,
+					    GFP_KERNEL,
+					    ctx);
 
 	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 1);
 
-	res->allocation = ctx;
+	res->data = ctx;
+
+	kunit_put_resource(res2);
 
 	return 0;
 }
 
 static void fake_resource_1_free(struct kunit_resource *res)
 {
-	struct kunit_test_resource_context *ctx = res->allocation;
+	struct kunit_test_resource_context *ctx = res->data;
 
 	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 1);
 }
@@ -265,13 +280,14 @@ static void fake_resource_1_free(struct kunit_resource *res)
 static void kunit_resource_test_proper_free_ordering(struct kunit *test)
 {
 	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res;
 
 	/* fake_resource_1 allocates a fake_resource_2 in its init. */
-	kunit_alloc_and_get_resource(&ctx->test,
-				     fake_resource_1_init,
-				     fake_resource_1_free,
-				     GFP_KERNEL,
-				     ctx);
+	res = kunit_alloc_and_get_resource(&ctx->test,
+					   fake_resource_1_init,
+					   fake_resource_1_free,
+					   GFP_KERNEL,
+					   ctx);
 
 	/*
 	 * Since fake_resource_2_init calls KUNIT_RESOURCE_TEST_MARK_ORDER
@@ -281,6 +297,8 @@ static void kunit_resource_test_proper_free_ordering(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx->allocate_order[0], 2);
 	KUNIT_EXPECT_EQ(test, ctx->allocate_order[1], 1);
 
+	kunit_put_resource(res);
+
 	kunit_cleanup(&ctx->test);
 
 	/*
@@ -292,6 +310,57 @@ static void kunit_resource_test_proper_free_ordering(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx->free_order[1], 2);
 }
 
+static void kunit_resource_test_static(struct kunit *test)
+{
+	struct kunit_test_resource_context ctx;
+	struct kunit_resource res;
+
+	KUNIT_EXPECT_EQ(test, kunit_add_resource(test, NULL, NULL, &res, &ctx),
+			0);
+
+	KUNIT_EXPECT_PTR_EQ(test, res.data, (void *)&ctx);
+
+	kunit_cleanup(test);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&test->resources));
+}
+
+static void kunit_resource_test_named(struct kunit *test)
+{
+	struct kunit_resource res1, res2, *found = NULL;
+	struct kunit_test_resource_context ctx;
+
+	KUNIT_EXPECT_EQ(test,
+			kunit_add_named_resource(test, NULL, NULL, &res1,
+						 "resource_1", &ctx),
+			0);
+	KUNIT_EXPECT_PTR_EQ(test, res1.data, (void *)&ctx);
+
+	KUNIT_EXPECT_EQ(test,
+			kunit_add_named_resource(test, NULL, NULL, &res1,
+						 "resource_1", &ctx),
+			-EEXIST);
+
+	KUNIT_EXPECT_EQ(test,
+			kunit_add_named_resource(test, NULL, NULL, &res2,
+						 "resource_2", &ctx),
+			0);
+
+	found = kunit_find_named_resource(test, "resource_1");
+
+	KUNIT_EXPECT_PTR_EQ(test, found, &res1);
+
+	if (found)
+		kunit_put_resource(&res1);
+
+	KUNIT_EXPECT_EQ(test, kunit_destroy_named_resource(test, "resource_2"),
+			0);
+
+	kunit_cleanup(test);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&test->resources));
+}
+
 static int kunit_resource_test_init(struct kunit *test)
 {
 	struct kunit_test_resource_context *ctx =
@@ -320,6 +389,8 @@ static struct kunit_case kunit_resource_test_cases[] = {
 	KUNIT_CASE(kunit_resource_test_destroy_resource),
 	KUNIT_CASE(kunit_resource_test_cleanup_resources),
 	KUNIT_CASE(kunit_resource_test_proper_free_ordering),
+	KUNIT_CASE(kunit_resource_test_static),
+	KUNIT_CASE(kunit_resource_test_named),
 	{}
 };
 
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index 350392013c14..141789ca8949 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -33,14 +33,14 @@ static int string_stream_fragment_init(struct kunit_resource *res,
 	if (!frag->fragment)
 		return -ENOMEM;
 
-	res->allocation = frag;
+	res->data = frag;
 
 	return 0;
 }
 
 static void string_stream_fragment_free(struct kunit_resource *res)
 {
-	struct string_stream_fragment *frag = res->allocation;
+	struct string_stream_fragment *frag = res->data;
 
 	list_del(&frag->node);
 	kunit_kfree(frag->test, frag->fragment);
@@ -65,9 +65,8 @@ static struct string_stream_fragment *alloc_string_stream_fragment(
 
 static int string_stream_fragment_destroy(struct string_stream_fragment *frag)
 {
-	return kunit_resource_destroy(frag->test,
+	return kunit_destroy_resource(frag->test,
 				      kunit_resource_instance_match,
-				      string_stream_fragment_free,
 				      frag);
 }
 
@@ -179,7 +178,7 @@ static int string_stream_init(struct kunit_resource *res, void *context)
 	if (!stream)
 		return -ENOMEM;
 
-	res->allocation = stream;
+	res->data = stream;
 	stream->gfp = ctx->gfp;
 	stream->test = ctx->test;
 	INIT_LIST_HEAD(&stream->fragments);
@@ -190,7 +189,7 @@ static int string_stream_init(struct kunit_resource *res, void *context)
 
 static void string_stream_free(struct kunit_resource *res)
 {
-	struct string_stream *stream = res->allocation;
+	struct string_stream *stream = res->data;
 
 	string_stream_clear(stream);
 }
@@ -211,8 +210,7 @@ struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
 
 int string_stream_destroy(struct string_stream *stream)
 {
-	return kunit_resource_destroy(stream->test,
+	return kunit_destroy_resource(stream->test,
 				      kunit_resource_instance_match,
-				      string_stream_free,
 				      stream);
 }
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index ccb2ffad8dcf..c36037200310 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -8,6 +8,7 @@
 
 #include <kunit/test.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/sched/debug.h>
 
 #include "debugfs.h"
@@ -406,90 +407,116 @@ void __kunit_test_suites_exit(struct kunit_suite **suites)
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
-struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
-						    kunit_resource_init_t init,
-						    kunit_resource_free_t free,
-						    gfp_t internal_gfp,
-						    void *context)
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
 {
-	struct kunit_resource *res;
-	int ret;
+	int ret = 0;
 
-	res = kzalloc(sizeof(*res), internal_gfp);
-	if (!res)
-		return NULL;
+	res->free = free;
+	kref_init(&res->refcount);
 
-	ret = init(res, context);
-	if (ret)
-		return NULL;
+	if (init) {
+		ret = init(res, data);
+		if (ret)
+			return ret;
+	} else {
+		res->data = data;
+	}
 
-	res->free = free;
 	spin_lock(&test->lock);
 	list_add_tail(&res->node, &test->resources);
+	/* refcount for list is established by kref_init() */
 	spin_unlock(&test->lock);
 
-	return res;
+	return ret;
 }
-EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
+EXPORT_SYMBOL_GPL(kunit_add_resource);
 
-static void kunit_resource_free(struct kunit *test, struct kunit_resource *res)
+int kunit_add_named_resource(struct kunit *test,
+			     kunit_resource_init_t init,
+			     kunit_resource_free_t free,
+			     struct kunit_resource *res,
+			     const char *name,
+			     void *data)
 {
-	res->free(res);
-	kfree(res);
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
 }
+EXPORT_SYMBOL_GPL(kunit_add_named_resource);
 
-static struct kunit_resource *kunit_resource_find(struct kunit *test,
-						  kunit_resource_match_t match,
-						  kunit_resource_free_t free,
-						  void *match_data)
+struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
+						    kunit_resource_init_t init,
+						    kunit_resource_free_t free,
+						    gfp_t internal_gfp,
+						    void *data)
 {
-	struct kunit_resource *resource;
+	struct kunit_resource *res;
+	int ret;
 
-	lockdep_assert_held(&test->lock);
+	res = kzalloc(sizeof(*res), internal_gfp);
+	if (!res)
+		return NULL;
 
-	list_for_each_entry_reverse(resource, &test->resources, node) {
-		if (resource->free != free)
-			continue;
-		if (match(test, resource->allocation, match_data))
-			return resource;
+	ret = kunit_add_resource(test, init, free, res, data);
+	if (!ret) {
+		/*
+		 * bump refcount for get; kunit_resource_put() should be called
+		 * when done.
+		 */
+		kunit_get_resource(res);
+		return res;
 	}
-
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
 
-static struct kunit_resource *kunit_resource_remove(
-		struct kunit *test,
-		kunit_resource_match_t match,
-		kunit_resource_free_t free,
-		void *match_data)
+void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
 {
-	struct kunit_resource *resource;
-
 	spin_lock(&test->lock);
-	resource = kunit_resource_find(test, match, free, match_data);
-	if (resource)
-		list_del(&resource->node);
+	list_del(&res->node);
 	spin_unlock(&test->lock);
-
-	return resource;
+	kunit_put_resource(res);
 }
+EXPORT_SYMBOL_GPL(kunit_remove_resource);
 
-int kunit_resource_destroy(struct kunit *test,
-			   kunit_resource_match_t match,
-			   kunit_resource_free_t free,
+int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
 			   void *match_data)
 {
-	struct kunit_resource *resource;
-
-	resource = kunit_resource_remove(test, match, free, match_data);
+	struct kunit_resource *res = kunit_find_resource(test, match,
+							 match_data);
 
-	if (!resource)
+	if (!res)
 		return -ENOENT;
 
-	kunit_resource_free(test, resource);
+	kunit_remove_resource(test, res);
+
+	/* We have a reference also via _find(); drop it. */
+	kunit_put_resource(res);
+
 	return 0;
 }
-EXPORT_SYMBOL_GPL(kunit_resource_destroy);
+EXPORT_SYMBOL_GPL(kunit_destroy_resource);
 
 struct kunit_kmalloc_params {
 	size_t size;
@@ -500,8 +527,8 @@ static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
 {
 	struct kunit_kmalloc_params *params = context;
 
-	res->allocation = kmalloc(params->size, params->gfp);
-	if (!res->allocation)
+	res->data = kmalloc(params->size, params->gfp);
+	if (!res->data)
 		return -ENOMEM;
 
 	return 0;
@@ -509,7 +536,7 @@ static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
 
 static void kunit_kmalloc_free(struct kunit_resource *res)
 {
-	kfree(res->allocation);
+	kfree(res->data);
 }
 
 void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
@@ -529,20 +556,25 @@ EXPORT_SYMBOL_GPL(kunit_kmalloc);
 
 void kunit_kfree(struct kunit *test, const void *ptr)
 {
-	int rc;
+	struct kunit_resource *res;
 
-	rc = kunit_resource_destroy(test,
-				    kunit_resource_instance_match,
-				    kunit_kmalloc_free,
-				    (void *)ptr);
+	res = kunit_find_resource(test, kunit_resource_instance_match,
+				  (void *)ptr);
+
+	/*
+	 * Removing the resource from the list of resources drops the
+	 * reference count to 1; the final put will trigger the free.
+	 */
+	kunit_remove_resource(test, res);
+
+	kunit_put_resource(res);
 
-	WARN_ON(rc);
 }
 EXPORT_SYMBOL_GPL(kunit_kfree);
 
 void kunit_cleanup(struct kunit *test)
 {
-	struct kunit_resource *resource;
+	struct kunit_resource *res;
 
 	/*
 	 * test->resources is a stack - each allocation must be freed in the
@@ -559,13 +591,16 @@ void kunit_cleanup(struct kunit *test)
 			spin_unlock(&test->lock);
 			break;
 		}
-		resource = list_last_entry(&test->resources,
-					   struct kunit_resource,
-					   node);
-		list_del(&resource->node);
+		res = list_last_entry(&test->resources,
+				      struct kunit_resource,
+				      node);
+		/*
+		 * Need to unlock here as a resource may remove another
+		 * resource, and this can't happen if the test->lock
+		 * is held.
+		 */
 		spin_unlock(&test->lock);
-
-		kunit_resource_free(test, resource);
+		kunit_remove_resource(test, res);
 	}
 }
 EXPORT_SYMBOL_GPL(kunit_cleanup);

--------------F323B03CA4D0B5E3B3156FEF--
