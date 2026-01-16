Return-Path: <linux-kselftest+bounces-49100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FB9D2DB09
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB65F30BC958
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F8C2EB873;
	Fri, 16 Jan 2026 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMq0yuIf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072322E2EF2;
	Fri, 16 Jan 2026 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550603; cv=none; b=KAIhlSieyGTk7Z5Tg96NDw9QwRgjdVdyv+Su9rhEwXiRzy2B3LIU8ZJ7QN58oIrebC2fa1rnsg9p4DmBstq+djhFtk69GLOMdXRHTEu30I4+JESnE2iBSHA5tgfp8dwX5iZ/JKvKpRlV8sAYvt/TzKc/eia9X8pWTMyL9/Wk4Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550603; c=relaxed/simple;
	bh=NGlLg2wfkaS/UD8ySu81w3opwQk+z7hVmTBbWkqUS+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZZkP7omd3YjQvqxo/sveJx9i2e8jueEbAoGF68rYzIQPqcz0PePhtqRY8JGRMeIJ320vLJigWaG5arZV+eeEPa87r49S19DSwg/IEl70rOPEWoxsstKR+QTxWLI6VmFsVi8uBO498zpMkGqC6QvE4Soj3nRNGZE4cA2IU9JkXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMq0yuIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9A9C19421;
	Fri, 16 Jan 2026 08:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768550600;
	bh=NGlLg2wfkaS/UD8ySu81w3opwQk+z7hVmTBbWkqUS+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMq0yuIf/NGHWZFDOYpdwZiaEWSZDEGuCYz6UmHMzhv15PNm2h0l9pq+sN39LrY/e
	 rxDnm5c2tYfbmnXdYAiCMw1aX8SBzDsYNb1dpFRetD+4S39D73aRjkw+7MDTE32cXj
	 wnKUUOLYEAObvBDPcG/LJAdYRwtj9zvgbUbBA9DEzQ8RTCBIUP/AiGsXUKSKfMA05M
	 syffKYZY7dBi6pHtnH8J0eJd+1dMXNkffjyNqern2Z9uJzoaImNWmc0HQzWhwl5wLZ
	 EOM/HpJXedJQXVyjTzfopLqV6lv//qAs2yLBaL9RrF86MXN/L2JXDz/aBqnwj7uh88
	 L4laBYD8mqGgA==
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
Subject: [PATCH v7 1/3] revocable: Revocable resource management
Date: Fri, 16 Jan 2026 08:02:33 +0000
Message-ID: <20260116080235.350305-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260116080235.350305-1-tzungbi@kernel.org>
References: <20260116080235.350305-1-tzungbi@kernel.org>
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
  REVOCABLE_TRY_ACCESS_WITH() and REVOCABLE_TRY_ACCESS_SCOPED() are
  convenient helpers for doing that.

- When the provider needs to remove the resource, it calls
  revocable_provider_revoke().  This function sets the internal resource
  pointer to NULL and then calls synchronize_srcu() to wait for all
  current readers to finish before the resource can be completely torn
  down.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v7:
- "2025" -> "2026" in copyright.
- Documentation/
  - Rephrase section "Revocable vs. Devres (devm)".
  - Include sections for struct revocable_provider and struct revocable.
- Minor rename: "revocable" -> "access_rev" for DEFINE_FREE().
- Add Acked-by tag.

v6: https://lore.kernel.org/chrome-platform/20251106152330.11733-2-tzungbi@kernel.org
- Rename REVOCABLE_TRY_ACCESS_WITH() -> REVOCABLE_TRY_ACCESS_SCOPED().
- Add new REVOCABLE_TRY_ACCESS_WITH().
- Remove Acked-by tags as the API names changed a bit.

v5: https://lore.kernel.org/chrome-platform/20251016054204.1523139-2-tzungbi@kernel.org
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
 .../driver-api/driver-model/revocable.rst     | 152 +++++++++++
 MAINTAINERS                                   |   7 +
 drivers/base/Makefile                         |   2 +-
 drivers/base/revocable.c                      | 242 ++++++++++++++++++
 include/linux/revocable.h                     |  69 +++++
 6 files changed, 472 insertions(+), 1 deletion(-)
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
index 000000000000..22a442cc8d7f
--- /dev/null
+++ b/Documentation/driver-api/driver-model/revocable.rst
@@ -0,0 +1,152 @@
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
+Revocable vs. Devres (devm)
+===========================
+
+It's important to understand the distinct roles of the Revocable and Devres,
+and how they can complement each other.  They address different problems in
+resource management:
+
+*   **Devres:** Primarily address **resource leaks**.  The lifetime of the
+    resources is tied to the lifetime of the device.  The resource is
+    automatically freed when the device is unbound.  This cleanup happens
+    irrespective of any potential active users.
+
+*   **Revocable:** Primarily addresses **invalid memory access**,
+    such as Use-After-Free (UAF).  It's an independent synchronization
+    primitive that decouples consumer access from the resource's actual
+    presence.  Consumers interact with a "revocable object" (an intermediary),
+    not the underlying resource directly.  This revocable object persists as
+    long as there are active references to it from consumer handles.
+
+**Key Distinctions & How They Complement Each Other:**
+
+1.  **Reference Target:** Consumers of a resource managed by the Revocable
+    mechanism hold a reference to the *revocable object*, not the
+    encapsulated resource itself.
+
+2.  **Resource Lifetime vs. Access:** The underlying resource's lifetime is
+    independent of the number of references to the revocable object.  The
+    resource can be freed at any point.  A common scenario is the resource
+    being freed by `devres` when the providing device is unbound.
+
+3.  **Safe Access:** Revocable provides a safe way to attempt access.  Before
+    using the resource, a consumer uses the Revocable API (e.g.,
+    revocable_try_access()).  This function checks if the resource is still
+    valid.  It returns a pointer to the resource only if it hasn't been
+    revoked; otherwise, it returns NULL.  This prevents UAF by providing a
+    clear signal that the resource is gone.
+
+4.  **Complementary Usage:** `devres` and Revocable work well together.
+    `devres` can handle the automatic allocation and deallocation of a
+    resource tied to a device.  The Revocable mechanism can be layered on top
+    to provide safe access for consumers whose lifetimes might extend beyond
+    the provider device's lifetime.  For instance, a userspace program might
+    keep a character device file open even after the physical device has been
+    removed.  In this case:
+
+    *   `devres` frees the device-specific resource upon unbinding.
+    *   The Revocable mechanism ensures that any subsequent operations on the
+        open file handle, which attempt to access the now-freed resource,
+        will fail gracefully (e.g., revocable_try_access() returns NULL)
+        instead of causing a UAF.
+
+In summary, `devres` ensures resources are *released* to prevent leaks, while
+the Revocable mechanism ensures that attempts to *access* these resources are
+done safely, even if the resource has been released.
+
+API and Usage
+=============
+
+For Resource Providers
+----------------------
+.. kernel-doc:: drivers/base/revocable.c
+   :identifiers: revocable_provider
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
+.. kernel-doc:: drivers/base/revocable.c
+   :identifiers: revocable
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
+        REVOCABLE_TRY_ACCESS_WITH(rev, res);
+        // Always check if the resource is valid.
+        if (!res) {
+            pr_warn("Resource is not available\n");
+            return;
+        }
+
+        // At this point, 'res' is guaranteed to be valid until
+        // this block exits.
+        do_something_with(res);
+
+    } // revocable_withdraw_access() is automatically called here.
+
+.. kernel-doc:: include/linux/revocable.h
+   :identifiers: REVOCABLE_TRY_ACCESS_SCOPED
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
+        REVOCABLE_TRY_ACCESS_SCOPED(rev, res) {
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
index a671e3d4e8be..fd683c62012a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22517,6 +22517,13 @@ F:	include/uapi/linux/rseq.h
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
index 000000000000..f6cece275aac
--- /dev/null
+++ b/drivers/base/revocable.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2026 Google LLC
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
+ * The "revocable" mechanism is a synchronization primitive designed to manage
+ * safe access to resources that can be asynchronously removed or invalidated.
+ * Its primary purpose is to prevent Use-After-Free (UAF) errors when
+ * interacting with resources whose lifetimes are not guaranteed to outlast
+ * their consumers.
+ *
+ * This is particularly useful in systems where resources can disappear
+ * unexpectedly, such as those provided by hot-pluggable devices like USB.
+ * When a consumer holds a reference to such a resource, the underlying device
+ * might be removed, causing the resource's memory to be freed.  Subsequent
+ * access attempts by the consumer would then lead to UAF errors.
+ *
+ * Revocable addresses this by providing a form of "weak reference" and a
+ * controlled access method.  It allows a resource consumer to safely attempt to
+ * access the resource.  The mechanism guarantees that any access granted is
+ * valid for the duration of its use.  If the resource has already been
+ * revoked (i.e., freed), the access attempt will fail safely, typically by
+ * returning NULL, instead of causing a crash.
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
+ *   REVOCABLE_TRY_ACCESS_WITH() and REVOCABLE_TRY_ACCESS_SCOPED() are
+ *   convenient helpers for doing that.
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
index 000000000000..659ba01c58db
--- /dev/null
+++ b/include/linux/revocable.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2026 Google LLC
+ */
+
+#ifndef __LINUX_REVOCABLE_H
+#define __LINUX_REVOCABLE_H
+
+#include <linux/compiler.h>
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
+DEFINE_FREE(access_rev, struct revocable *, if (_T) revocable_withdraw_access(_T))
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
+ * It creates a local variable in the current scope.  @_res is populated with
+ * the result of revocable_try_access().  The consumer code **must** check if
+ * @_res is ``NULL`` before using it.  The revocable_withdraw_access() function
+ * is automatically called when the scope is exited.
+ *
+ * Note: It shares the same issue with guard() in cleanup.h.  No goto statements
+ * are allowed before the helper.  Otherwise, the compiler fails with
+ * "jump bypasses initialization of variable with __attribute__((cleanup))".
+ */
+#define REVOCABLE_TRY_ACCESS_WITH(_rev, _res)					\
+	struct revocable *__UNIQUE_ID(name) __free(access_rev) = _rev;		\
+	_res = revocable_try_access(_rev)
+
+#define _REVOCABLE_TRY_ACCESS_SCOPED(_rev, _label, _res)			\
+	for (struct revocable *__UNIQUE_ID(name) __free(access_rev) = _rev;	\
+	     (_res = revocable_try_access(_rev)) || true; ({ goto _label; }))	\
+		if (0) {							\
+_label:										\
+			break;							\
+		} else
+
+/**
+ * REVOCABLE_TRY_ACCESS_SCOPED() - A helper for accessing revocable resource
+ * @_rev: The consumer's ``struct revocable *`` handle.
+ * @_res: A pointer variable that will be assigned the resource.
+ *
+ * Similar to REVOCABLE_TRY_ACCESS_WITH() but with an explicit scope from a
+ * temporary ``for`` loop.
+ */
+#define REVOCABLE_TRY_ACCESS_SCOPED(_rev, _res)					\
+	_REVOCABLE_TRY_ACCESS_SCOPED(_rev, __UNIQUE_ID(label), _res)
+
+#endif /* __LINUX_REVOCABLE_H */
-- 
2.52.0.457.g6b5491de43-goog


