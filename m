Return-Path: <linux-kselftest+bounces-41282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FEAB544FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 10:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201AD3AF4E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 08:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175E82D6E56;
	Fri, 12 Sep 2025 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT8m2S7V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85872E401;
	Fri, 12 Sep 2025 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665100; cv=none; b=K0aiqxmXSwKjPlwP3HUh+J5L8Ozwg9WoilhiEv/4EcjwGIlzDG2faFhsXKAHBIp83n/mfbPtROTixp4MiAoxJ86LvbOB1i3jMpAIwOZ72nvOtfLvlsMFfhc058Ad0JI+/Qs8SGIWu3ckSR8thgmhhMc52TxZNDZRTvDEExte/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665100; c=relaxed/simple;
	bh=hCs2MuquISe3xBHyQof8vQBuzIKmejcLXWXY9Xaxn+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9v/EhPD5uC5QS3Y5FsnkwkVO/WXbe+48OCrkecSSnxbogSnGmcq41BjFYgcMAz3n2oFga6MK6bsEbAqQ9Q7YNytY2yh5b/ikg7H1GE0wHulTrR5i+6NFqeQMgZ+PMs6ZZiGkey7XuNfAFudx++V7BWfJVchcC5DbLaVR5bDUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT8m2S7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908A2C4CEF8;
	Fri, 12 Sep 2025 08:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757665098;
	bh=hCs2MuquISe3xBHyQof8vQBuzIKmejcLXWXY9Xaxn+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HT8m2S7VChKnOfVnqmup6VWXs0vwCwARSCrDWVBpLKh9VxykRDkLbu6AD6KkHFqNi
	 ZrI/bHWeQVisOE8nzE5aH7huW0s5t5M6efQwwtdEkNeqICC7cCTAllV1+PGA4gAxYu
	 qUbGw6nckc+e1UHNEuUEElYJ4nI3tussV8xpgsx3dQqRgAB3jK+481cbAYYPVBrbLX
	 t5whhycdUd6OaMVycNMosSml6avzfhmOWIFBzY3cK63lBQuac0zQsO/3UuFunZeq6Z
	 cK7x5EjLiGfpNEEd1PlA5NAOgxOb3xJqQ/hHn73OlVOLSUEz0NGqp2yKNUffjq1VCQ
	 Vro/VTfhWq0Aw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v3 1/5] revocable: Revocable resource management
Date: Fri, 12 Sep 2025 08:17:13 +0000
Message-ID: <20250912081718.3827390-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912081718.3827390-1-tzungbi@kernel.org>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
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

Introduce the revocable to establish weak references to such resources.
It allows a resource consumer to safely attempt to access a resource
that might be freed at any time by the resource provider.

The implementation uses a provider/consumer model built on Sleepable
RCU (SRCU) to guarantee safe memory access:

 - A resource provider allocates a struct revocable_provider and
   initializes it with a pointer to the resource.

 - A resource consumer that wants to access the resource allocates a
   struct revocable which holds a reference to the provider.

 - To access the resource, the consumer uses revocable_try_access().
   This function enters an SRCU read-side critical section and returns
   the pointer to the resource.  If the provider has already freed the
   resource, it returns NULL.  After use, the consumer calls
   revocable_release() to exit the SRCU critical section.  The
   REVOCABLE() is a convenient helper for doing that.

 - When the provider needs to remove the resource, it calls
   revocable_provider_free().  This function sets the internal resource
   pointer to NULL and then calls synchronize_srcu() to wait for all
   current readers to finish before the resource can be completely torn
   down.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v3:
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

 .../driver-api/driver-model/index.rst         |   1 +
 .../driver-api/driver-model/revocable.rst     | 151 ++++++++++++
 MAINTAINERS                                   |   7 +
 drivers/base/Makefile                         |   2 +-
 drivers/base/revocable.c                      | 229 ++++++++++++++++++
 include/linux/revocable.h                     |  37 +++
 6 files changed, 426 insertions(+), 1 deletion(-)
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
index 000000000000..b9e2968ba9c1
--- /dev/null
+++ b/Documentation/driver-api/driver-model/revocable.rst
@@ -0,0 +1,151 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Revocable Resource Management
+==============================
+
+Overview
+========
+
+In a system with hot-pluggable devices, such as USB, resources provided by
+these devices can be removed asynchronously.  If a consumer holds a reference
+to such a resource, the resource might be deallocated while the reference is
+still held, leading to use-after-free errors upon subsequent access.
+
+The "revocable" mechanism addresses this by establishing a weak reference to a
+resource that might be freed at any time.  It allows a resource consumer to
+safely attempt to access the resource, guaranteeing that the access is valid
+for the duration of its use, or it fails safely if the resource has already
+been revoked.
+
+The implementation is based on a provider/consumer model that uses Sleepable
+RCU (SRCU) to ensure safe memory access without traditional locking.
+
+How It Works
+============
+
+1.  **Provider**: A resource provider, such as a driver for a hot-pluggable
+    device, allocates a ``struct revocable_provider``.  This structure is
+    initialized with a pointer to the actual resource it manages.
+
+2.  **Consumer**: A consumer that needs to access the resource is given a
+    ``struct revocable``, which acts as a handle containing a reference to
+    the provider.
+
+3.  **Accessing the Resource**: To access the resource, the consumer uses
+    ``revocable_try_access()``.  This function enters an SRCU read-side
+    critical section and returns a pointer to the resource.  If the provider
+    has already revoked the resource, this function returns ``NULL``.  The
+    consumer must check for this ``NULL`` return.
+
+4.  **Releasing the Resource**: After the consumer has finished using the
+    resource, it must call ``revocable_release()`` to exit the SRCU critical
+    section.  This signals that the consumer no longer requires access.  The
+    ``REVOCABLE()`` macro is provided as a convenient and safe way to manage
+    the access-release cycle.
+
+5.  **Revoking the Resource**: When the provider needs to remove the resource
+    (e.g., the device is unplugged), it calls ``revocable_provider_free()``.
+    This function first sets the internal resource pointer to ``NULL``,
+    preventing any new consumers from accessing it.  It then calls
+    ``synchronize_srcu()``, which waits for all existing consumers currently
+    in the SRCU critical section to finish their work.  Once all consumers
+    have released their access, the resource can be safely deallocated.
+
+Revocable vs. Device-Managed (devm) Resources
+=============================================
+
+It's important to understand the distinction between a standard
+device-managed (devm) resource and a resource managed by a
+``revocable_provider``.
+
+The key difference is their lifetime:
+
+*   A **devm resource** is tied to the lifetime of the device.  It is
+    automatically freed when the device is unbound.
+*   A **revocable_provider** persists as long as there are active references
+    to it from ``revocable`` consumer handles.
+
+This means that a ``revocable_provider`` can outlive the device that created
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
+``struct revocable_provider *revocable_provider_alloc(void *res);``
+    Allocates a provider handle for the given resource ``res``.  It returns a
+    pointer to the ``revocable_provider`` on success, or ``NULL`` on failure.
+
+``struct revocable_provider *devm_revocable_provider_alloc(struct device *dev, void *res);``
+    A device-managed version of ``revocable_provider_alloc``.  It is
+    convenient to allocate providers via this function if the ``res`` is also
+    tied to the lifetime of the ``dev``.  ``revocable_provider_free`` will be
+    called automatically when the device is unbound.
+
+``void revocable_provider_free(struct revocable_provider *rp);``
+    Revokes the resource.  This function marks the resource as unavailable and
+    waits for all current consumers to finish before the underlying memory
+    can be freed.
+
+For Resource Consumers
+----------------------
+
+``struct revocable *revocable_alloc(struct revocable_provider *rp);``
+    Allocates a consumer handle for a given provider ``rp``.
+
+``void revocable_free(struct revocable *rev);``
+    Frees a consumer handle.
+
+``void *revocable_try_access(struct revocable *rev);``
+    Attempts to gain access to the resource.  Returns a pointer to the
+    resource on success or ``NULL`` if it has been revoked.
+
+``void revocable_release(struct revocable *rev);``
+    Releases access to the resource, exiting the SRCU critical section.
+
+The ``REVOCABLE()`` Macro
+=========================
+
+The ``REVOCABLE()`` macro simplifies the access-release cycle for consumers,
+ensuring that ``revocable_release()`` is always called, even in the case of
+an early exit.
+
+``REVOCABLE(rev, res)``
+    *   ``rev``: The consumer's ``struct revocable *`` handle.
+    *   ``res``: A pointer variable that will be assigned the resource.
+
+The macro creates a ``for`` loop that executes exactly once.  Inside the loop,
+``res`` is populated with the result of ``revocable_try_access()``.  The
+consumer code **must** check if ``res`` is ``NULL`` before using it.  The
+``revocable_release()`` function is automatically called when the scope of
+the loop is exited.
+
+Example Usage
+-------------
+
+.. code-block:: c
+
+    void consumer_use_resource(struct revocable *rev)
+    {
+        struct foo_resource *res;
+
+        REVOCABLE(rev, res) {
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
+        // revocable_release() is automatically called here.
+    }
diff --git a/MAINTAINERS b/MAINTAINERS
index fa7f80bd7b2f..5d11aeeb546e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21877,6 +21877,13 @@ F:	include/uapi/linux/rseq.h
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
index 000000000000..80a48896b241
--- /dev/null
+++ b/drivers/base/revocable.c
@@ -0,0 +1,229 @@
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
+ * Introduce the revocable to establish weak references to such resources.
+ * It allows a resource consumer to safely attempt to access a resource
+ * that might be freed at any time by the resource provider.
+ *
+ * The implementation uses a provider/consumer model built on Sleepable
+ * RCU (SRCU) to guarantee safe memory access:
+ *
+ * - A resource provider allocates a struct revocable_provider and
+ *   initializes it with a pointer to the resource.
+ *
+ * - A resource consumer that wants to access the resource allocates a
+ *   struct revocable which holds a reference to the provider.
+ *
+ * - To access the resource, the consumer uses revocable_try_access().
+ *   This function enters an SRCU read-side critical section and returns
+ *   the pointer to the resource.  If the provider has already freed the
+ *   resource, it returns NULL.  After use, the consumer calls
+ *   revocable_release() to exit the SRCU critical section.  The
+ *   REVOCABLE() is a convenient helper for doing that.
+ *
+ * - When the provider needs to remove the resource, it calls
+ *   revocable_provider_free().  This function sets the internal resource
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
+ * revocable_provider_free() - Free struct revocable_provider.
+ * @rp: The pointer of resource provider.
+ *
+ * This sets the resource `(struct revocable_provider *)->res` to NULL to
+ * indicate the resource has gone.
+ *
+ * This drops the refcount to the resource provider.  If it is the final
+ * reference, revocable_provider_release() will be called to free the struct.
+ */
+void revocable_provider_free(struct revocable_provider *rp)
+{
+	rcu_assign_pointer(rp->res, NULL);
+	synchronize_srcu(&rp->srcu);
+	kref_put(&rp->kref, revocable_provider_release);
+}
+EXPORT_SYMBOL_GPL(revocable_provider_free);
+
+static void devm_revocable_provider_free(void *data)
+{
+	struct revocable_provider *rp = data;
+
+	revocable_provider_free(rp);
+}
+
+/**
+ * devm_revocable_provider_alloc() - Dev-managed revocable_provider_alloc().
+ * @dev: The device.
+ * @res: The pointer of resource.
+ *
+ * It is convenient to allocate providers via this function if the @res is
+ * also tied to the lifetime of the @dev.  revocable_provider_free() will
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
+	if (devm_add_action_or_reset(dev, devm_revocable_provider_free, rp))
+		return NULL;
+
+	return rp;
+}
+EXPORT_SYMBOL_GPL(devm_revocable_provider_alloc);
+
+/**
+ * revocable_alloc() - Allocate struct revocable_provider.
+ * @rp: The pointer of resource provider.
+ *
+ * This holds a refcount to the resource provider.
+ *
+ * Return: The pointer of struct revocable_provider.  NULL on errors.
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
+	return rcu_dereference(rp->res);
+}
+EXPORT_SYMBOL_GPL(revocable_try_access);
+
+/**
+ * revocable_release() - Stop accessing to the resource.
+ * @rev: The pointer of struct revocable.
+ *
+ * Call this function to indicate the resource is no longer used.  It exits
+ * the RCU critical section.
+ */
+void revocable_release(struct revocable *rev) __releases(&rev->rp->srcu)
+{
+	struct revocable_provider *rp = rev->rp;
+
+	srcu_read_unlock(&rp->srcu, rev->idx);
+}
+EXPORT_SYMBOL_GPL(revocable_release);
diff --git a/include/linux/revocable.h b/include/linux/revocable.h
new file mode 100644
index 000000000000..17d9b7ce633d
--- /dev/null
+++ b/include/linux/revocable.h
@@ -0,0 +1,37 @@
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
+void revocable_provider_free(struct revocable_provider *rp);
+struct revocable_provider *devm_revocable_provider_alloc(struct device *dev,
+							 void *res);
+
+struct revocable *revocable_alloc(struct revocable_provider *rp);
+void revocable_free(struct revocable *rev);
+void *revocable_try_access(struct revocable *rev) __acquires(&rev->rp->srcu);
+void revocable_release(struct revocable *rev) __releases(&rev->rp->srcu);
+
+DEFINE_FREE(revocable, struct revocable *, if (_T) revocable_release(_T))
+
+#define _REVOCABLE(_rev, _label, _res)						\
+	for (struct revocable *__UNIQUE_ID(name) __free(revocable) = _rev;	\
+	     (_res = revocable_try_access(_rev)) || true; ({ goto _label; }))	\
+		if (0) {							\
+_label:										\
+			break;							\
+		} else
+
+#define REVOCABLE(_rev, _res) _REVOCABLE(_rev, __UNIQUE_ID(label), _res)
+
+#endif /* __LINUX_REVOCABLE_H */
-- 
2.51.0.384.g4c02a37b29-goog


