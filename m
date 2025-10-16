Return-Path: <linux-kselftest+bounces-43280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4022BE188A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A81B3456EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 05:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E523D7C5;
	Thu, 16 Oct 2025 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrdZ+8UC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862BF23D283;
	Thu, 16 Oct 2025 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593375; cv=none; b=Mp2H4JVLOi1ylRw6zmTYsQCFhhOfr6poi6V9BKibsWMdaIHMAguHNbdAYejrcC+mRoum6RTbeN2wXU+0m7T11kIDXMljSkFWWdhV6Ep4wVx+9zC3KPPH1Ccuh9512UrP2RhRQTdBhUJDm1KSJcPyOX0zVNqPHVOoxMxwJC84+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593375; c=relaxed/simple;
	bh=K4qmDGrhCpbipBnlfFqcIp+TTyDw70vxxVANLjpgm54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnUbhv7pikcH4vDW/9SOCN2UcxLuN+zPe0EeAvR3P2p57HImRjGqsT9W3N07J4aqHtpxJzDzutgrbmNRjpBlUG7EJYbpAn2H5WpJNK4e0XjnDUIF/w7Gc2A0T8ym5Inx+UK2gWx0fq+vVRSs34XknxR4lGKJSN9nHy7M+UP0nNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrdZ+8UC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F67C116B1;
	Thu, 16 Oct 2025 05:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760593375;
	bh=K4qmDGrhCpbipBnlfFqcIp+TTyDw70vxxVANLjpgm54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jrdZ+8UCWleAeGJBPn9btmNbGAhkJOQNXwtkqzRiVsaNZPSvSfc0W8Erv8Ub0oMVa
	 ETbvwGk1Db9efOdemYuxems/JjNFzBJzCvgvuka0Xdrc6rp7ANZM2uKelhPgq3PCis
	 QqETMgA3W+jPL6T5DZgLaux7+eOdDv0aKb1jklVm6v9Eg8oO3KbAKbJG9H7FWcyAEN
	 8bPGqGtBt0b6bPHEXT3r+R7k0MsBImjvpvKQzdFWtbkvxFxQyN5tw8zanm4HvPWQ4Y
	 NXnirzJv1rwtM8Ad0+ueNdgrFoT91U5tpdDDDs/2HtOAL9wLlv+PUkyP9uKJvLbmRB
	 73orR4ezIRiEw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 1/7] revocable: Revocable resource management
Date: Thu, 16 Oct 2025 05:41:58 +0000
Message-ID: <20251016054204.1523139-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
In-Reply-To: <20251016054204.1523139-1-tzungbi@kernel.org>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some resources can be removed asynchronously, for example, resources
provided by a hot-pluggable device like USB.  When holding a reference
to such a resource, it's possible for the resource to be removed and
its memory freed, leading to use-after-free errors on subsequent access.

The "revocable" mechanism addresses this by establishing a weak reference
to a resource that might be freed at any time.  It allows a resource
consumer to safely attempt to access the resource, guaranteeing that the
access is valid for the duration of its use, or it fails safely if the
resource has already been revoked.

The implementation uses a provider/consumer model built on Sleepable
RCU (SRCU) to guarantee safe memory access:

- A resource provider, such as a driver for a hot-pluggable device,
  allocates a struct revocable_provider and initializes it with a pointer
  to the resource.

- A resource consumer that wants to access the resource allocates a
  struct revocable which acts as a handle containing a reference to the
  provider.

- To access the resource, the consumer uses revocable_try_access().
  This function enters an SRCU read-side critical section and returns
  the pointer to the resource.  If the provider has already freed the
  resource, it returns NULL.  After use, the consumer calls
  revocable_withdraw_access() to exit the SRCU critical section.  The
  REVOCABLE_TRY_ACCESS_WITH() is a convenient helper for doing that.

- When the provider needs to remove the resource, it calls
  revocable_provider_revoke().  This function sets the internal resource
  pointer to NULL and then calls synchronize_srcu() to wait for all
  current readers to finish before the resource can be completely torn
  down.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v5:
- No changes.

v4: https://lore.kernel.org/chrome-platform/20250923075302.591026-2-tzungbi@kernel.org
- Rename:
  - revocable_provider_free() -> revocable_provider_revoke().
  - REVOCABLE() -> REVOCABLE_TRY_ACCESS_WITH().
  - revocable_release() -> revocable_withdraw_access().
- rcu_dereference() -> srcu_dereference() to fix a warning from lock debugging.
- Move most docs to kernel-doc, include them in Documentation/, and modify the
  commit message accordingly.
- Fix some doc errors.
- Add Acked-by tags.

v3: https://lore.kernel.org/chrome-platform/20250912081718.3827390-2-tzungbi@kernel.org
- No changes.

v2: https://lore.kernel.org/chrome-platform/20250820081645.847919-2-tzungbi@kernel.org
- Rename "ref_proxy" -> "revocable".
- Add introduction in kernel-doc format in revocable.c.
- Add MAINTAINERS entry.
- Add copyright.
- Move from lib/ to drivers/base/.
- EXPORT_SYMBOL() -> EXPORT_SYMBOL_GPL().
- Add Documentation/.
- Rename _get() -> try_access(); _put() -> release().
- Fix a sparse warning by removing the redundant __rcu annotations.
- Fix a sparse warning by adding __acquires() and __releases() annotations.

v1: https://lore.kernel.org/chrome-platform/20250814091020.1302888-2-tzungbi@kernel.org

Note (for my reference):
- An optional .release() callback for revocable provider-managed resource
  hasn't added.
- `make O=build SPHINXDIRS=driver-api/driver-model/ htmldocs` a way to
  verify the Documentation/.

 .../driver-api/driver-model/index.rst         |   1 +
 .../driver-api/driver-model/revocable.rst     |  87 +++++++
 MAINTAINERS                                   |   7 +
 drivers/base/Makefile                         |   2 +-
 drivers/base/revocable.c                      | 233 ++++++++++++++++++
 include/linux/revocable.h                     |  53 ++++
 6 files changed, 382 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/driver-model/revocable.rst
 create mode 100644 drivers/base/revocable.c
 create mode 100644 include/linux/revocable.h

diff --git a/Documentation/driver-api/driver-model/index.rst b/Documentation/driver-api/driver-model/index.rst
index 4831bdd92e5c..8e1ee21185df 100644
--- a/Documentation/driver-api/driver-model/index.rst
+++ b/Documentation/driver-api/driver-model/index.rst
@@ -14,6 +14,7 @@ Driver Model
    overview
    platform
    porting
+   revocable
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/driver-model/revocable.rst b/Documentation/driver-api/driver-model/revocable.rst
new file mode 100644
index 000000000000..ce2d0eb1c8cb
--- /dev/null
+++ b/Documentation/driver-api/driver-model/revocable.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Revocable Resource Management
+==============================
+
+Overview
+========
+
+.. kernel-doc:: drivers/base/revocable.c
+   :doc: Overview
+
+Revocable vs. Device-Managed (devm) Resources
+=============================================
+
+It's important to understand the distinction between a standard
+device-managed (devm) resource and a resource managed by a revocable provider.
+
+The key difference is their lifetime:
+
+*   A **devm resource** is tied to the lifetime of the device.  It is
+    automatically freed when the device is unbound.
+*   A **revocable provider** persists as long as there are active references
+    to it from consumer handles.
+
+This means that a revocable provider can outlive the device that created
+it.  This is a deliberate design feature, allowing consumers to hold a
+reference to a resource even after the underlying device has been removed,
+without causing a fault.  When the consumer attempts to access the resource,
+it will simply be informed that the resource is no longer available.
+
+API and Usage
+=============
+
+For Resource Providers
+----------------------
+
+.. kernel-doc:: drivers/base/revocable.c
+   :identifiers: revocable_provider_alloc
+
+.. kernel-doc:: drivers/base/revocable.c
+   :identifiers: devm_revocable_provider_alloc
+
+.. kernel-doc:: drivers/base/revocable.c
+   :identifiers: revocable_provider_revoke
+
+For Resource Consumers
+----------------------
+
+.. kernel-doc:: drivers/base/revocable.c
+   :identifiers: revocable_alloc
+
+.. kernel-doc:: drivers/base/revocable.c
+   :identifiers: revocable_free
+
+.. kernel-doc:: drivers/base/revocable.c
+   :identifiers: revocable_try_access
+
+.. kernel-doc:: drivers/base/revocable.c
+   :identifiers: revocable_withdraw_access
+
+.. kernel-doc:: include/linux/revocable.h
+   :identifiers: REVOCABLE_TRY_ACCESS_WITH
+
+Example Usage
+~~~~~~~~~~~~~
+
+.. code-block:: c
+
+    void consumer_use_resource(struct revocable *rev)
+    {
+        struct foo_resource *res;
+
+        REVOCABLE_TRY_ACCESS_WITH(rev, res) {
+            // Always check if the resource is valid.
+            if (!res) {
+                pr_warn("Resource is not available\n");
+                return;
+            }
+
+            // At this point, 'res' is guaranteed to be valid until
+            // this block exits.
+            do_something_with(res);
+        }
+
+        // revocable_withdraw_access() is automatically called here.
+    }
diff --git a/MAINTAINERS b/MAINTAINERS
index 25ed1846d970..7d00ff431af9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22020,6 +22020,13 @@ F:	include/uapi/linux/rseq.h
 F:	kernel/rseq.c
 F:	tools/testing/selftests/rseq/
 
+REVOCABLE RESOURCE MANAGEMENT
+M:	Tzung-Bi Shih <tzungbi@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/base/revocable.c
+F:	include/linux/revocable.h
+
 RFKILL
 M:	Johannes Berg <johannes@sipsolutions.net>
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 8074a10183dc..bdf854694e39 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -6,7 +6,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   cpu.o firmware.o init.o map.o devres.o \
 			   attribute_container.o transport_class.o \
 			   topology.o container.o property.o cacheinfo.o \
-			   swnode.o faux.o
+			   swnode.o faux.o revocable.o
 obj-$(CONFIG_AUXILIARY_BUS) += auxiliary.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-y			+= power/
diff --git a/drivers/base/revocable.c b/drivers/base/revocable.c
new file mode 100644
index 000000000000..f8dd4363a87b
--- /dev/null
+++ b/drivers/base/revocable.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Google LLC
+ *
+ * Revocable resource management
+ */
+
+#include <linux/device.h>
+#include <linux/kref.h>
+#include <linux/revocable.h>
+#include <linux/slab.h>
+#include <linux/srcu.h>
+
+/**
+ * DOC: Overview
+ *
+ * Some resources can be removed asynchronously, for example, resources
+ * provided by a hot-pluggable device like USB.  When holding a reference
+ * to such a resource, it's possible for the resource to be removed and
+ * its memory freed, leading to use-after-free errors on subsequent access.
+ *
+ * The "revocable" mechanism addresses this by establishing a weak reference
+ * to a resource that might be freed at any time.  It allows a resource
+ * consumer to safely attempt to access the resource, guaranteeing that the
+ * access is valid for the duration of its use, or it fails safely if the
+ * resource has already been revoked.
+ *
+ * The implementation uses a provider/consumer model built on Sleepable
+ * RCU (SRCU) to guarantee safe memory access:
+ *
+ * - A resource provider, such as a driver for a hot-pluggable device,
+ *   allocates a struct revocable_provider and initializes it with a pointer
+ *   to the resource.
+ *
+ * - A resource consumer that wants to access the resource allocates a
+ *   struct revocable which acts as a handle containing a reference to the
+ *   provider.
+ *
+ * - To access the resource, the consumer uses revocable_try_access().
+ *   This function enters an SRCU read-side critical section and returns
+ *   the pointer to the resource.  If the provider has already freed the
+ *   resource, it returns NULL.  After use, the consumer calls
+ *   revocable_withdraw_access() to exit the SRCU critical section.  The
+ *   REVOCABLE_TRY_ACCESS_WITH() is a convenient helper for doing that.
+ *
+ * - When the provider needs to remove the resource, it calls
+ *   revocable_provider_revoke().  This function sets the internal resource
+ *   pointer to NULL and then calls synchronize_srcu() to wait for all
+ *   current readers to finish before the resource can be completely torn
+ *   down.
+ */
+
+/**
+ * struct revocable_provider - A handle for resource provider.
+ * @srcu: The SRCU to protect the resource.
+ * @res:  The pointer of resource.  It can point to anything.
+ * @kref: The refcount for this handle.
+ */
+struct revocable_provider {
+	struct srcu_struct srcu;
+	void __rcu *res;
+	struct kref kref;
+};
+
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
+/**
+ * revocable_provider_alloc() - Allocate struct revocable_provider.
+ * @res: The pointer of resource.
+ *
+ * This holds an initial refcount to the struct.
+ *
+ * Return: The pointer of struct revocable_provider.  NULL on errors.
+ */
+struct revocable_provider *revocable_provider_alloc(void *res)
+{
+	struct revocable_provider *rp;
+
+	rp = kzalloc(sizeof(*rp), GFP_KERNEL);
+	if (!rp)
+		return NULL;
+
+	init_srcu_struct(&rp->srcu);
+	rcu_assign_pointer(rp->res, res);
+	synchronize_srcu(&rp->srcu);
+	kref_init(&rp->kref);
+
+	return rp;
+}
+EXPORT_SYMBOL_GPL(revocable_provider_alloc);
+
+static void revocable_provider_release(struct kref *kref)
+{
+	struct revocable_provider *rp = container_of(kref,
+			struct revocable_provider, kref);
+
+	cleanup_srcu_struct(&rp->srcu);
+	kfree(rp);
+}
+
+/**
+ * revocable_provider_revoke() - Revoke the managed resource.
+ * @rp: The pointer of resource provider.
+ *
+ * This sets the resource `(struct revocable_provider *)->res` to NULL to
+ * indicate the resource has gone.
+ *
+ * This drops the refcount to the resource provider.  If it is the final
+ * reference, revocable_provider_release() will be called to free the struct.
+ */
+void revocable_provider_revoke(struct revocable_provider *rp)
+{
+	rcu_assign_pointer(rp->res, NULL);
+	synchronize_srcu(&rp->srcu);
+	kref_put(&rp->kref, revocable_provider_release);
+}
+EXPORT_SYMBOL_GPL(revocable_provider_revoke);
+
+static void devm_revocable_provider_revoke(void *data)
+{
+	struct revocable_provider *rp = data;
+
+	revocable_provider_revoke(rp);
+}
+
+/**
+ * devm_revocable_provider_alloc() - Dev-managed revocable_provider_alloc().
+ * @dev: The device.
+ * @res: The pointer of resource.
+ *
+ * It is convenient to allocate providers via this function if the @res is
+ * also tied to the lifetime of the @dev.  revocable_provider_revoke() will
+ * be called automatically when the device is unbound.
+ *
+ * This holds an initial refcount to the struct.
+ *
+ * Return: The pointer of struct revocable_provider.  NULL on errors.
+ */
+struct revocable_provider *devm_revocable_provider_alloc(struct device *dev,
+							 void *res)
+{
+	struct revocable_provider *rp;
+
+	rp = revocable_provider_alloc(res);
+	if (!rp)
+		return NULL;
+
+	if (devm_add_action_or_reset(dev, devm_revocable_provider_revoke, rp))
+		return NULL;
+
+	return rp;
+}
+EXPORT_SYMBOL_GPL(devm_revocable_provider_alloc);
+
+/**
+ * revocable_alloc() - Allocate struct revocable.
+ * @rp: The pointer of resource provider.
+ *
+ * This holds a refcount to the resource provider.
+ *
+ * Return: The pointer of struct revocable.  NULL on errors.
+ */
+struct revocable *revocable_alloc(struct revocable_provider *rp)
+{
+	struct revocable *rev;
+
+	rev = kzalloc(sizeof(*rev), GFP_KERNEL);
+	if (!rev)
+		return NULL;
+
+	rev->rp = rp;
+	kref_get(&rp->kref);
+
+	return rev;
+}
+EXPORT_SYMBOL_GPL(revocable_alloc);
+
+/**
+ * revocable_free() - Free struct revocable.
+ * @rev: The pointer of struct revocable.
+ *
+ * This drops a refcount to the resource provider.  If it is the final
+ * reference, revocable_provider_release() will be called to free the struct.
+ */
+void revocable_free(struct revocable *rev)
+{
+	struct revocable_provider *rp = rev->rp;
+
+	kref_put(&rp->kref, revocable_provider_release);
+	kfree(rev);
+}
+EXPORT_SYMBOL_GPL(revocable_free);
+
+/**
+ * revocable_try_access() - Try to access the resource.
+ * @rev: The pointer of struct revocable.
+ *
+ * This tries to de-reference to the resource and enters a RCU critical
+ * section.
+ *
+ * Return: The pointer to the resource.  NULL if the resource has gone.
+ */
+void *revocable_try_access(struct revocable *rev) __acquires(&rev->rp->srcu)
+{
+	struct revocable_provider *rp = rev->rp;
+
+	rev->idx = srcu_read_lock(&rp->srcu);
+	return srcu_dereference(rp->res, &rp->srcu);
+}
+EXPORT_SYMBOL_GPL(revocable_try_access);
+
+/**
+ * revocable_withdraw_access() - Stop accessing to the resource.
+ * @rev: The pointer of struct revocable.
+ *
+ * Call this function to indicate the resource is no longer used.  It exits
+ * the RCU critical section.
+ */
+void revocable_withdraw_access(struct revocable *rev) __releases(&rev->rp->srcu)
+{
+	struct revocable_provider *rp = rev->rp;
+
+	srcu_read_unlock(&rp->srcu, rev->idx);
+}
+EXPORT_SYMBOL_GPL(revocable_withdraw_access);
diff --git a/include/linux/revocable.h b/include/linux/revocable.h
new file mode 100644
index 000000000000..7177bf045d9c
--- /dev/null
+++ b/include/linux/revocable.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2025 Google LLC
+ */
+
+#ifndef __LINUX_REVOCABLE_H
+#define __LINUX_REVOCABLE_H
+
+#include <linux/cleanup.h>
+
+struct device;
+struct revocable;
+struct revocable_provider;
+
+struct revocable_provider *revocable_provider_alloc(void *res);
+void revocable_provider_revoke(struct revocable_provider *rp);
+struct revocable_provider *devm_revocable_provider_alloc(struct device *dev,
+							 void *res);
+
+struct revocable *revocable_alloc(struct revocable_provider *rp);
+void revocable_free(struct revocable *rev);
+void *revocable_try_access(struct revocable *rev) __acquires(&rev->rp->srcu);
+void revocable_withdraw_access(struct revocable *rev) __releases(&rev->rp->srcu);
+
+DEFINE_FREE(revocable, struct revocable *, if (_T) revocable_withdraw_access(_T))
+
+#define _REVOCABLE_TRY_ACCESS_WITH(_rev, _label, _res)				\
+	for (struct revocable *__UNIQUE_ID(name) __free(revocable) = _rev;	\
+	     (_res = revocable_try_access(_rev)) || true; ({ goto _label; }))	\
+		if (0) {							\
+_label:										\
+			break;							\
+		} else
+
+/**
+ * REVOCABLE_TRY_ACCESS_WITH() - A helper for accessing revocable resource
+ * @_rev: The consumer's ``struct revocable *`` handle.
+ * @_res: A pointer variable that will be assigned the resource.
+ *
+ * The macro simplifies the access-release cycle for consumers, ensuring that
+ * revocable_withdraw_access() is always called, even in the case of an early
+ * exit.
+ *
+ * It creates a ``for`` loop that executes exactly once.  Inside the loop,
+ * @_res is populated with the result of revocable_try_access().  The consumer
+ * code **must** check if @_res is ``NULL`` before using it.  The
+ * revocable_withdraw_access() function is automatically called when the scope
+ * of the loop is exited.
+ */
+#define REVOCABLE_TRY_ACCESS_WITH(_rev, _res)					\
+		_REVOCABLE_TRY_ACCESS_WITH(_rev, __UNIQUE_ID(label), _res)
+
+#endif /* __LINUX_REVOCABLE_H */
-- 
2.51.0.788.g6d19910ace-goog


