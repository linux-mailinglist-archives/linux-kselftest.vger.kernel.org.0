Return-Path: <linux-kselftest+bounces-38965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5564CB265B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 14:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FB7A22286
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 12:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661672FFDF8;
	Thu, 14 Aug 2025 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+6uURxj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A44400
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175521; cv=none; b=csZXGdb5koIUfSQmTBNnHiyPoekJ/fmZW/oV6wLcB8wydGDtrhn4gQgsgM18b6QF+sa8fQYq8vbuL8BLD3+7M1M5szBQ+C9R+P1qqRA9Mn+TLC14OSQO2nZvX2TktLjG0ARtF2EqRdzyjS6caVDHvPoiQZvoXUHHgk3ce720FIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175521; c=relaxed/simple;
	bh=7ahjSTBeLjUbFf0Bwlancwo9DYFeqGOSSspEEh+y9GU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BN2t8N47jAZpzy0BshE534J8u4mqP4RHegei57Wl7TZAtf2fXXdSFm/sWeS+YNiScynZ5D2Kwr8ZGG7ArrtcqcwCzGAq5BAadB0iHOSCSahoS56V5l3fyijS3HYe/5lzjS7nvcw0DwxEiJWSCVFcYgmH7gly+7d4Q+jwEmmFpNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r+6uURxj; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b109912dd8so8411031cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 05:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755175518; x=1755780318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kbxup2Slgkw+15cQ2AptlaSh/NObK/IYFeU45ShOWVQ=;
        b=r+6uURxjoVihurCAEdRwc7gKxa/k6NeJyPPQNBAxJu7SlxEiHuD8DjYbLq5tfe7XBR
         L+BbJJtIQNKRULW2Ke0qjkj9VJjTseQ14w9sV9luEYOg66XFU0z3BEUayxc7KtUpWmGg
         rlPaUEyOu9hs9t++6qp60qv7VxQtjDyaiKtSFYI58ycYJFn14hKlj7NKp29+9Ha+SNp2
         dy6DhqpGJ8VsFXQCPO+buRYa0Cd3h6WfJX/7CBvfg/iohdIVsAhHIkPKyWGeX6jjuFHi
         hMfONA4mMQ7MV5+EgPiLgyU5y11I33WE72kyz1UOYnq4sUu2pZtSh6jvRUVPz5Pq+Oad
         OFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755175518; x=1755780318;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kbxup2Slgkw+15cQ2AptlaSh/NObK/IYFeU45ShOWVQ=;
        b=pOzdFwbE8qnRHzgHVAktfGd1e3871ftS2JNYjSVdit/VXTa7WXoqXjasDQHtYvHWLJ
         Lai64MCJ+0W9G5iyNyiC46l6g2c53zLCR1B4vOzKdoM3DgoJfRnwPzueDTRD9HeEAk75
         d1dQSasy56j/q23vARNS0SsI9PvW3+jOz7sFxBLxL/KoFmWYZc7AddO4u3inBF0J5m5P
         OY5qgkTbEZc16EjOXYrqEMhJNDfJ5/rhjDNJVPQvcchLqTITd1FntCYtX/IL3pCFwCxV
         pT2PZ2497z4JlFRz9351JzOCnYKzPnRIOyalSCeq9xPjTRU+L/xVASZGFNADIvzyQyb4
         TD9A==
X-Gm-Message-State: AOJu0Yzk/gZF09SGGeAyi4rbIOKIOdSvHn8rdS1A+f+xINAsyBjRbQhz
	adkD4Zu+JmsubUx9eMQLfdbtE4Pspf7aX80NY7ylpvuPUpQIntCMT+vXL3GgSeONIxTycNNoa6C
	b9Um8pbhwxULHug==
X-Google-Smtp-Source: AGHT+IFQWg3RSRtRCxGs5L40ORJsSddDPfQoU7dkTFdZxUsQqbjLeAOB9hy54Cn68eZ7ybyS2Rk3hI368D3QIA==
X-Received: from qtxf4.prod.google.com ([2002:ac8:5d04:0:b0:4ab:7d4c:827c])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1887:b0:4a9:cff3:68a2 with SMTP id d75a77b69052e-4b10aa6271bmr45090061cf.37.1755175517877;
 Thu, 14 Aug 2025 05:45:17 -0700 (PDT)
Date: Thu, 14 Aug 2025 12:44:59 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
Message-ID: <20250814124459.3484753-1-marievic@google.com>
Subject: [RFC PATCH] kunit: Put checking for existing named resource between
 locks to prevent race conditions in the Resource API
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

Named resources attached to a KUnit test must be unique. Currently, the
check for existing named resources in kunit_add_named_resource() is
performed without a lock. While KUnit is largely single-threaded, a
race condition could theoretically lead to multiple resources with the
same name being added.

To prevent this, the uniqueness check logic has been moved into the locked
portion of the __kunit_add_resource() function. This ensures that the
check and resource addition are atomic, preventing duplicate named
resources.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---

This patch raises a fundamental question about KUnit's concurrency model.
What are the thread-safety guarantees that KUnit should provide? Should
these guarantees be formally defined before we introduce changes like
this one?

It would be great to have everyone's thoughts on this, as it could have
implications on how we have handle concurrency in KUnit going forward.

---
 include/kunit/resource.h | 84 ++++++++++++++++++++++++++++++----------
 lib/kunit/resource.c     | 12 +++++-
 2 files changed, 74 insertions(+), 22 deletions(-)

diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index 4ad69a2642a5..7b33f332769c 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -148,12 +148,14 @@ static inline void kunit_put_resource(struct kunit_resource *res)
  *	  If an init function is supplied, @data is passed to it instead.
  * @free: a user-supplied function to free the resource (if needed).
  * @res: The resource.
+ * @name: name of the resource if there is one.
  * @data: value to pass to init function or set in resource data field.
  */
 int __kunit_add_resource(struct kunit *test,
 			 kunit_resource_init_t init,
 			 kunit_resource_free_t free,
 			 struct kunit_resource *res,
+			 const char *name,
 			 void *data);
 
 /**
@@ -173,7 +175,7 @@ static inline int kunit_add_resource(struct kunit *test,
 				     void *data)
 {
 	res->should_kfree = false;
-	return __kunit_add_resource(test, init, free, res, data);
+	return __kunit_add_resource(test, init, free, res, NULL, data);
 }
 
 static inline struct kunit_resource *
@@ -195,21 +197,14 @@ static inline int kunit_add_named_resource(struct kunit *test,
 					   const char *name,
 					   void *data)
 {
-	struct kunit_resource *existing;
 
 	if (!name)
 		return -EINVAL;
 
-	existing = kunit_find_named_resource(test, name);
-	if (existing) {
-		kunit_put_resource(existing);
-		return -EEXIST;
-	}
-
 	res->name = name;
 	res->should_kfree = false;
 
-	return __kunit_add_resource(test, init, free, res, data);
+	return __kunit_add_resource(test, init, free, res, name, data);
 }
 
 /**
@@ -249,7 +244,7 @@ kunit_alloc_and_get_resource(struct kunit *test,
 
 	res->should_kfree = true;
 
-	ret = __kunit_add_resource(test, init, free, res, context);
+	ret = __kunit_add_resource(test, init, free, res, NULL, context);
 	if (!ret) {
 		/*
 		 * bump refcount for get; kunit_resource_put() should be called
@@ -290,7 +285,7 @@ static inline void *kunit_alloc_resource(struct kunit *test,
 		return NULL;
 
 	res->should_kfree = true;
-	if (!__kunit_add_resource(test, init, free, res, context))
+	if (!__kunit_add_resource(test, init, free, res, NULL, context))
 		return res->data;
 
 	return NULL;
@@ -314,29 +309,54 @@ static inline bool kunit_resource_name_match(struct kunit *test,
 }
 
 /**
- * kunit_find_resource() - Find a resource using match function/data.
+ * kunit_find_resource_unlocked() - Find a resource using match function/data
+ * without locking.
  * @test: Test case to which the resource belongs.
- * @match: match function to be applied to resources/match data.
- * @match_data: data to be used in matching.
+ * @match: Match function to be applied to resources/match data.
+ * @match_data: Data to be used in matching.
+ *
+ * Finds a resource in @test->resources using @match, but does not acquire
+ * the test's lock.
+ *
+ * Note: This function is for specialized use only as it is **NOT thread-safe**
+ * regarding the test's resource list and test reference count. Callers must prevent
+ * potential race conditions, typically by providing external locking. The thread-safe
+ * alternative, kunit_find_resource(), should be used in most situations.
  */
 static inline struct kunit_resource *
-kunit_find_resource(struct kunit *test,
-		    kunit_resource_match_t match,
-		    void *match_data)
+kunit_find_resource_unlocked(struct kunit *test,
+			     kunit_resource_match_t match,
+			     void *match_data)
 {
 	struct kunit_resource *res, *found = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&test->lock, flags);
 
 	list_for_each_entry_reverse(res, &test->resources, node) {
-		if (match(test, res, (void *)match_data)) {
+		if (match(test, res, match_data)) {
 			found = res;
 			kunit_get_resource(found);
 			break;
 		}
 	}
 
+	return found;
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
+	struct kunit_resource *found = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&test->lock, flags);
+	found = kunit_find_resource_unlocked(test, match, match_data);
 	spin_unlock_irqrestore(&test->lock, flags);
 
 	return found;
@@ -355,6 +375,28 @@ kunit_find_named_resource(struct kunit *test,
 				   (void *)name);
 }
 
+/**
+ * kunit_find_named_resource_unlocked() - Find a resource using match name
+ * without locking.
+ * @test: Test case to which the resource belongs.
+ * @name: Match name.
+ *
+ * Finds a resource in @test->resources using its name, but does not acquire
+ * the test's resource lock.
+ *
+ * Note: This function is for specialized use only as it is **NOT thread-safe**
+ * regarding the test's resource list and test reference count. Callers must prevent
+ * potential race conditions, typically by providing external locking. The thread-safe
+ * alternative, kunit_find_named_resource(), should be used in most situations.
+ */
+static inline struct kunit_resource *
+kunit_find_named_resource_unlocked(struct kunit *test,
+				   const char *name)
+{
+	return kunit_find_resource_unlocked(test, kunit_resource_name_match,
+				   (void *)name);
+}
+
 /**
  * kunit_destroy_resource() - Find a kunit_resource and destroy it.
  * @test: Test case to which the resource belongs.
diff --git a/lib/kunit/resource.c b/lib/kunit/resource.c
index f0209252b179..dae708f81f97 100644
--- a/lib/kunit/resource.c
+++ b/lib/kunit/resource.c
@@ -20,10 +20,12 @@ int __kunit_add_resource(struct kunit *test,
 			 kunit_resource_init_t init,
 			 kunit_resource_free_t free,
 			 struct kunit_resource *res,
+			 const char *name,
 			 void *data)
 {
 	int ret = 0;
 	unsigned long flags;
+	struct kunit_resource *existing;
 
 	res->free = free;
 	kref_init(&res->refcount);
@@ -37,6 +39,14 @@ int __kunit_add_resource(struct kunit *test,
 	}
 
 	spin_lock_irqsave(&test->lock, flags);
+	if (name) {
+		existing = kunit_find_named_resource_unlocked(test, name);
+		if (existing) {
+			kunit_put_resource(existing);
+			spin_unlock_irqrestore(&test->lock, flags);
+			return -EEXIST;
+		}
+	}
 	list_add_tail(&res->node, &test->resources);
 	/* refcount for list is established by kref_init() */
 	spin_unlock_irqrestore(&test->lock, flags);
@@ -107,7 +117,7 @@ int kunit_add_action(struct kunit *test, void (*action)(void *), void *ctx)
 
 	action_ctx->res.should_kfree = true;
 	/* As init is NULL, this cannot fail. */
-	__kunit_add_resource(test, NULL, __kunit_action_free, &action_ctx->res, action_ctx);
+	__kunit_add_resource(test, NULL, __kunit_action_free, &action_ctx->res, NULL, action_ctx);
 
 	return 0;
 }
-- 
2.51.0.rc0.215.g125493bb4a-goog


