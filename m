Return-Path: <linux-kselftest+bounces-49123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D29B9D2DDF6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28B6B3021548
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332FC2FF661;
	Fri, 16 Jan 2026 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3HKbG5s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C2E2F8BC3;
	Fri, 16 Jan 2026 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551126; cv=none; b=g+u3hWmcsprfixNdsazs3gEycOHPX+CtWvRGfjHYRgjlwmac7t8Vh0ttLEQvTt/h1eWmiE8CjVIlHD972Wmh662Gpo2bX1JlvzA91G1Ez4Mxdb83FgNMQSBvuwgMRPAucGg5mcuCnljdA0rbeRJefkUX/Jx/4a1YOBmAHr26q6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551126; c=relaxed/simple;
	bh=oleKZCrD+Q1YjsXErAMRTh03iiXXqBdvvaG8jWLHuBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXGjPO+9tlCoByvJYxGDF1Ehkv8rherZGSccisR4ivYMXGD0XVCEvBKoijLMNCeMElIIGtxvAM1Wb8C8Zk1ViiV4DnQ24562+EJyirbSnHZYz3GZnGGgZG045aHbP2AMkDhlmJp08zyR5hwhSRbp2I0JHAeu9fXZEff7Q3JBNxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3HKbG5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B52C116C6;
	Fri, 16 Jan 2026 08:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551125;
	bh=oleKZCrD+Q1YjsXErAMRTh03iiXXqBdvvaG8jWLHuBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3HKbG5skQYvv3jPQ2ObXMcA+7vaDn0gfYohtMGrKAg0Blraad/Sq9NesvJKoerWT
	 jEU9DZwExPV/fWageQ0z7eK8MJFboebjL39kQg62OjszgltUqfYIdshkY278tFKVZT
	 1v6c45azOCDpEi80MEGzOd/AvDTrKsENfdG5oXnREXbKa6B//zlFn6IDAXlk0OFN9P
	 C2SKhX4GH08JBka/C9z/IVj43mZXNy1/DYiMj+ckUHRstHe3FDjtnTXJqEFb1blYkc
	 XsG4CArJe/bTbBWOx3dwdK4eGX0ORcESJxjyPl4KPxb8dusvhFa7lFTh5eJXv7QDVV
	 LE3W6Mn8IM+xg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	linux-gpio@vger.kernel.org
Subject: [PATCH 19/23] revocable: Support to define revocable consumer handle on stack
Date: Fri, 16 Jan 2026 08:10:32 +0000
Message-ID: <20260116081036.352286-20-tzungbi@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260116081036.352286-1-tzungbi@kernel.org>
References: <20260116081036.352286-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support a way to define a revocable consumer handle on stack.  Under
some circumstances, the user wouldn't like to use dynamic memory
allocation for consumer handles.

This makes the struct revocable no longer opaque.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 .../driver-api/driver-model/revocable.rst     |  5 +-
 drivers/base/revocable.c                      | 60 +++++++++++++------
 include/linux/revocable.h                     | 30 +++++++++-
 3 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/driver-model/revocable.rst b/Documentation/driver-api/driver-model/revocable.rst
index 22a442cc8d7f..fff081dbd296 100644
--- a/Documentation/driver-api/driver-model/revocable.rst
+++ b/Documentation/driver-api/driver-model/revocable.rst
@@ -84,7 +84,7 @@ For Resource Providers
 
 For Resource Consumers
 ----------------------
-.. kernel-doc:: drivers/base/revocable.c
+.. kernel-doc:: include/linux/revocable.h
    :identifiers: revocable
 
 .. kernel-doc:: drivers/base/revocable.c
@@ -93,6 +93,9 @@ For Resource Consumers
 .. kernel-doc:: drivers/base/revocable.c
    :identifiers: revocable_free
 
+.. kernel-doc:: include/linux/revocable.h
+   :identifiers: DEFINE_REVOCABLE
+
 .. kernel-doc:: drivers/base/revocable.c
    :identifiers: revocable_try_access
 
diff --git a/drivers/base/revocable.c b/drivers/base/revocable.c
index f6cece275aac..93c925252665 100644
--- a/drivers/base/revocable.c
+++ b/drivers/base/revocable.c
@@ -71,16 +71,6 @@ struct revocable_provider {
 	struct kref kref;
 };
 
-/**
- * struct revocable - A handle for resource consumer.
- * @rp: The pointer of resource provider.
- * @idx: The index for the RCU critical section.
- */
-struct revocable {
-	struct revocable_provider *rp;
-	int idx;
-};
-
 /**
  * revocable_provider_alloc() - Allocate struct revocable_provider.
  * @res: The pointer of resource.
@@ -170,11 +160,47 @@ struct revocable_provider *devm_revocable_provider_alloc(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_revocable_provider_alloc);
 
 /**
- * revocable_alloc() - Allocate struct revocable.
+ * revocable_init() - Initialize struct revocable.
+ * @rev: The pointer of struct revocable.
  * @rp: The pointer of resource provider.
  *
  * This holds a refcount to the resource provider.
  *
+ * Don't call this function directly.  Use revocable_alloc() or
+ * DEFINE_REVOCABLE().
+ */
+void revocable_init(struct revocable *rev, struct revocable_provider *rp)
+{
+	rev->rp = rp;
+	kref_get(&rp->kref);
+}
+EXPORT_SYMBOL_GPL(revocable_init);
+
+/**
+ * revocable_deinit() - Deinitialize struct revocable.
+ * @rev: The pointer of struct revocable.
+ *
+ * This drops a refcount to the resource provider.  If it is the final
+ * reference, revocable_provider_release() will be called to free the struct.
+ *
+ * Don't call this function directly.  revocable_free() or DEFINE_REVOCABLE()
+ * should help to do so.
+ */
+void revocable_deinit(struct revocable *rev)
+{
+	struct revocable_provider *rp = rev->rp;
+
+	kref_put(&rp->kref, revocable_provider_release);
+}
+EXPORT_SYMBOL_GPL(revocable_deinit);
+
+/**
+ * revocable_alloc() - Allocate struct revocable.
+ * @rp: The pointer of resource provider.
+ *
+ * Allocate a struct revocable and call revocable_init() to holds a refcount
+ * to the resource provider.
+ *
  * Return: The pointer of struct revocable.  NULL on errors.
  */
 struct revocable *revocable_alloc(struct revocable_provider *rp)
@@ -185,9 +211,7 @@ struct revocable *revocable_alloc(struct revocable_provider *rp)
 	if (!rev)
 		return NULL;
 
-	rev->rp = rp;
-	kref_get(&rp->kref);
-
+	revocable_init(rev, rp);
 	return rev;
 }
 EXPORT_SYMBOL_GPL(revocable_alloc);
@@ -196,14 +220,12 @@ EXPORT_SYMBOL_GPL(revocable_alloc);
  * revocable_free() - Free struct revocable.
  * @rev: The pointer of struct revocable.
  *
- * This drops a refcount to the resource provider.  If it is the final
- * reference, revocable_provider_release() will be called to free the struct.
+ * Call revocable_deinit() to drop a refcount to the resource provider and
+ * free the struct revocable.
  */
 void revocable_free(struct revocable *rev)
 {
-	struct revocable_provider *rp = rev->rp;
-
-	kref_put(&rp->kref, revocable_provider_release);
+	revocable_deinit(rev);
 	kfree(rev);
 }
 EXPORT_SYMBOL_GPL(revocable_free);
diff --git a/include/linux/revocable.h b/include/linux/revocable.h
index 659ba01c58db..89bb1a5c74e4 100644
--- a/include/linux/revocable.h
+++ b/include/linux/revocable.h
@@ -10,19 +10,47 @@
 #include <linux/cleanup.h>
 
 struct device;
-struct revocable;
 struct revocable_provider;
 
+/**
+ * struct revocable - A handle for resource consumer.
+ * @rp: The pointer of resource provider.
+ * @idx: The index for the RCU critical section.
+ */
+struct revocable {
+	struct revocable_provider *rp;
+	int idx;
+};
+
 struct revocable_provider *revocable_provider_alloc(void *res);
 void revocable_provider_revoke(struct revocable_provider *rp);
 struct revocable_provider *devm_revocable_provider_alloc(struct device *dev,
 							 void *res);
 
+void revocable_init(struct revocable *rev, struct revocable_provider *rp);
+void revocable_deinit(struct revocable *rev);
 struct revocable *revocable_alloc(struct revocable_provider *rp);
 void revocable_free(struct revocable *rev);
 void *revocable_try_access(struct revocable *rev) __acquires(&rev->rp->srcu);
 void revocable_withdraw_access(struct revocable *rev) __releases(&rev->rp->srcu);
 
+DEFINE_FREE(define_rev, struct revocable *, revocable_deinit(_T))
+
+#define _DEFINE_REVOCABLE(_rev, _name, _rp)					\
+	struct revocable _name;							\
+	struct revocable *_rev __free(define_rev) = &_name;			\
+	revocable_init(_rev, _rp)
+
+/**
+ * DEFINE_REVOCABLE() - A helper for defining a revocable consumer on stack
+ * @_rev: The variable name to ``struct revocable *``.
+ * @_rp: The provider's ``struct revocable_provider *`` handle.
+ *
+ * The macro declares and defines a revocable consumer handle on stack.
+ */
+#define DEFINE_REVOCABLE(_rev, _rp)						\
+	_DEFINE_REVOCABLE(_rev, __UNIQUE_ID(name), _rp)
+
 DEFINE_FREE(access_rev, struct revocable *, if (_T) revocable_withdraw_access(_T))
 
 /**
-- 
2.52.0.457.g6b5491de43-goog


