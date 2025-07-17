Return-Path: <linux-kselftest+bounces-37462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730FFB0821F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 03:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CDA1648C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 01:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F011E260A;
	Thu, 17 Jul 2025 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MjAMQV6u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D71E98E3
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Jul 2025 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714635; cv=none; b=awBR1MKfPiY53B89IiVuQuHRZi7vxauDNgM5Czx6p3OWgHwZ0NZo/kCPUYwryAUyAjlikppsKN3wM5T7ciDzOffQMvZmZDt9VwsElJR5lUBZe7WwiX/PtzypUUbhNE2ALSgckWQmXSFD8mBMB3wMyCxcLmH0/w362ZwEptiiAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714635; c=relaxed/simple;
	bh=R45/Drl4MCkAIB5ZH0MlbHKVnH3k9tj2cgqElMDkNPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n3TOYaU1w+X0REvdI8fMWWlMMESA9z+xz78JkQa/z0cRr/eJcUTFZ/ychlEeTVmWikOMGKuQ5ZuBU3pns/p+pd6d9MwSQ32lUc8zUUYEB6issK7/Rm5BiKklKLpDaLkLz8oS4/Wu9Duz5omvA1yF3VRIW8JVyVXgqmoMJjX2xBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MjAMQV6u; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2356ce55d33so6304085ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 18:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752714633; x=1753319433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3HgaVgkV8y/i+XjIBc/JDF7MiiLKDRl5JV2/hXzwng=;
        b=MjAMQV6uannrm9LiBxTaR7iWZEbTu6LDn0UA8Erv4+IfybCrP0HegHSlb7laR+lH47
         BaVkXfNgudRVbhS2AeZMTrLEh1Aa/3G4+a91F+HPBk8hyJSVD1HBSU+X1pCfPWi5i1Qx
         TJLyP+hoykk0G7+ufTy4t5RMDOaf9GPdboY94RjX4u6Er6Gda79FTcWOwqcoQP9cC6AY
         EacN0+tq/Jmz1QnSX7Oxq7fYF01nB547BsB6vwifzKIvnIq/chhjX8rL/9hvOtCMuzDb
         iadyAqrb63fSYqMEtuM0HozE4wGH64+wdIrdyKt0zox/mLB3uK+Ns2FxwffMUnDm0gGQ
         tMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752714633; x=1753319433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3HgaVgkV8y/i+XjIBc/JDF7MiiLKDRl5JV2/hXzwng=;
        b=OwcOsUOCCeDBDbztzuQZL3uDcACN4c9/rHbK4YcglUV0kls8cQljuZiHMS1tepXQHX
         6AUeMUF1jmCbPCrNQkcNXuAubGesZfV9drHGHBjm/4mT3UWgeikrZdtbe5zsuJgCTsD+
         EwihDeXJZsrIVAY7NC+APqGP6aRdaBXMugltca1lY28J3QlhkkpRdVsN810ZHu8MqT2y
         Hm9BMfkJ625pyIcBfnGrZZUp1Aa5nYqFw6UeQV0XfyDkn94clxc5PpAELV0opULGRzJR
         qvrtD4rWSVqCHz3l0GlavvahHcMQ2ApwObwWoCM/t7rKJk9mhLX4zW0vaqXKVt/iWoBS
         4Ndw==
X-Forwarded-Encrypted: i=1; AJvYcCWAEQ9c2moMQGmeXMKu2vdRWviQWrab1XGJcaRdPcHig2tbAQmLYv+EmiEWN0AE/7Wzv8jBjb4gOsKkKDgXUvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdgKZesE22W29u0RmuF1NwgLOoPeVo2ZxVGuiy6u0cDQnX+e2d
	0T1Gw/LVhRddocla7tID67X6U3dieCyY9TZZH5pD1CxTX00VCPT3iQy27KMFkuXgF17Xwaxa/dn
	S8+1ASdkquw==
X-Google-Smtp-Source: AGHT+IG73tdRUkBLJKZdksbYf3zxs3REiEddbD25ho8DDh1XJPka6tRWL27Ece8r/h/YPaseJecL8N0D4OAe
X-Received: from plbje11.prod.google.com ([2002:a17:903:264b:b0:23a:cc37:8ec4])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac2:b0:236:15b7:62e8
 with SMTP id d9443c01a7336-23e3033883bmr12382235ad.25.1752714632734; Wed, 16
 Jul 2025 18:10:32 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:10:07 -0700
In-Reply-To: <20250717011011.3365074-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717011011.3365074-1-ynaffit@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717011011.3365074-5-ynaffit@google.com>
Subject: [PATCH v4 4/6] binder: Scaffolding for binder_alloc KUnit tests
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add setup and teardown for testing binder allocator code with KUnit.
Include minimal test cases to verify that tests are initialized
correctly.

Tested-by: Rae Moar <rmoar@google.com>
Acked-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
v2:
* Added Tested-by tag
v3:
* Split kunit lib change into separate change
v4:
* Added Google Copyright to new files
* Collected tags
---
 drivers/android/Kconfig                    |  11 ++
 drivers/android/Makefile                   |   1 +
 drivers/android/binder.c                   |   5 +-
 drivers/android/binder_alloc.c             |  15 +-
 drivers/android/binder_alloc.h             |   6 +
 drivers/android/binder_internal.h          |   4 +
 drivers/android/tests/.kunitconfig         |   7 +
 drivers/android/tests/Makefile             |   6 +
 drivers/android/tests/binder_alloc_kunit.c | 169 +++++++++++++++++++++
 9 files changed, 218 insertions(+), 6 deletions(-)
 create mode 100644 drivers/android/tests/.kunitconfig
 create mode 100644 drivers/android/tests/Makefile
 create mode 100644 drivers/android/tests/binder_alloc_kunit.c

diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index 07aa8ae0a058..b1bc7183366c 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
@@ -47,4 +47,15 @@ config ANDROID_BINDER_IPC_SELFTEST
 	  exhaustively with combinations of various buffer sizes and
 	  alignments.
 
+config ANDROID_BINDER_ALLOC_KUNIT_TEST
+	tristate "KUnit Tests for Android Binder Alloc" if !KUNIT_ALL_TESTS
+	depends on ANDROID_BINDER_IPC && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This feature builds the binder alloc KUnit tests.
+
+	  Each test case runs using a pared-down binder_alloc struct and
+	  test-specific freelist, which allows this KUnit module to be loaded
+	  for testing without interfering with a running system.
+
 endmenu
diff --git a/drivers/android/Makefile b/drivers/android/Makefile
index c9d3d0c99c25..74d02a335d4e 100644
--- a/drivers/android/Makefile
+++ b/drivers/android/Makefile
@@ -4,3 +4,4 @@ ccflags-y += -I$(src)			# needed for trace events
 obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
 obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
 obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
+obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)	+= tests/
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c463ca4a8fff..9dfe90c284fc 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -68,6 +68,8 @@
 #include <linux/sizes.h>
 #include <linux/ktime.h>
 
+#include <kunit/visibility.h>
+
 #include <uapi/linux/android/binder.h>
 
 #include <linux/cacheflush.h>
@@ -5956,10 +5958,11 @@ static void binder_vma_close(struct vm_area_struct *vma)
 	binder_alloc_vma_close(&proc->alloc);
 }
 
-static vm_fault_t binder_vm_fault(struct vm_fault *vmf)
+VISIBLE_IF_KUNIT vm_fault_t binder_vm_fault(struct vm_fault *vmf)
 {
 	return VM_FAULT_SIGBUS;
 }
+EXPORT_SYMBOL_IF_KUNIT(binder_vm_fault);
 
 static const struct vm_operations_struct binder_vm_ops = {
 	.open = binder_vma_open,
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 2e89f9127883..c79e5c6721f0 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -23,6 +23,7 @@
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
 #include <linux/sizes.h>
+#include <kunit/visibility.h>
 #include "binder_alloc.h"
 #include "binder_trace.h"
 
@@ -57,13 +58,14 @@ static struct binder_buffer *binder_buffer_prev(struct binder_buffer *buffer)
 	return list_entry(buffer->entry.prev, struct binder_buffer, entry);
 }
 
-static size_t binder_alloc_buffer_size(struct binder_alloc *alloc,
-				       struct binder_buffer *buffer)
+VISIBLE_IF_KUNIT size_t binder_alloc_buffer_size(struct binder_alloc *alloc,
+						 struct binder_buffer *buffer)
 {
 	if (list_is_last(&buffer->entry, &alloc->buffers))
 		return alloc->vm_start + alloc->buffer_size - buffer->user_data;
 	return binder_buffer_next(buffer)->user_data - buffer->user_data;
 }
+EXPORT_SYMBOL_IF_KUNIT(binder_alloc_buffer_size);
 
 static void binder_insert_free_buffer(struct binder_alloc *alloc,
 				      struct binder_buffer *new_buffer)
@@ -959,7 +961,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 			   failure_string, ret);
 	return ret;
 }
-
+EXPORT_SYMBOL_IF_KUNIT(binder_alloc_mmap_handler);
 
 void binder_alloc_deferred_release(struct binder_alloc *alloc)
 {
@@ -1028,6 +1030,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 		     "%s: %d buffers %d, pages %d\n",
 		     __func__, alloc->pid, buffers, page_count);
 }
+EXPORT_SYMBOL_IF_KUNIT(binder_alloc_deferred_release);
 
 /**
  * binder_alloc_print_allocated() - print buffer info
@@ -1122,6 +1125,7 @@ void binder_alloc_vma_close(struct binder_alloc *alloc)
 {
 	binder_alloc_set_mapped(alloc, false);
 }
+EXPORT_SYMBOL_IF_KUNIT(binder_alloc_vma_close);
 
 /**
  * binder_alloc_free_page() - shrinker callback to free pages
@@ -1229,8 +1233,8 @@ binder_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 
 static struct shrinker *binder_shrinker;
 
-static void __binder_alloc_init(struct binder_alloc *alloc,
-				struct list_lru *freelist)
+VISIBLE_IF_KUNIT void __binder_alloc_init(struct binder_alloc *alloc,
+					  struct list_lru *freelist)
 {
 	alloc->pid = current->group_leader->pid;
 	alloc->mm = current->mm;
@@ -1239,6 +1243,7 @@ static void __binder_alloc_init(struct binder_alloc *alloc,
 	INIT_LIST_HEAD(&alloc->buffers);
 	alloc->freelist = freelist;
 }
+EXPORT_SYMBOL_IF_KUNIT(__binder_alloc_init);
 
 /**
  * binder_alloc_init() - called by binder_open() for per-proc initialization
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index aa05a9df1360..dc8dce2469a7 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -188,5 +188,11 @@ int binder_alloc_copy_from_buffer(struct binder_alloc *alloc,
 				  binder_size_t buffer_offset,
 				  size_t bytes);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+void __binder_alloc_init(struct binder_alloc *alloc, struct list_lru *freelist);
+size_t binder_alloc_buffer_size(struct binder_alloc *alloc,
+				struct binder_buffer *buffer);
+#endif
+
 #endif /* _LINUX_BINDER_ALLOC_H */
 
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 1ba5caf1d88d..b5d3014fb4dc 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -592,4 +592,8 @@ void binder_add_device(struct binder_device *device);
  */
 void binder_remove_device(struct binder_device *device);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+vm_fault_t binder_vm_fault(struct vm_fault *vmf);
+#endif
+
 #endif /* _LINUX_BINDER_INTERNAL_H */
diff --git a/drivers/android/tests/.kunitconfig b/drivers/android/tests/.kunitconfig
new file mode 100644
index 000000000000..39b76bab9d9a
--- /dev/null
+++ b/drivers/android/tests/.kunitconfig
@@ -0,0 +1,7 @@
+#
+# Copyright 2025 Google LLC.
+#
+
+CONFIG_KUNIT=y
+CONFIG_ANDROID_BINDER_IPC=y
+CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST=y
diff --git a/drivers/android/tests/Makefile b/drivers/android/tests/Makefile
new file mode 100644
index 000000000000..27268418eb03
--- /dev/null
+++ b/drivers/android/tests/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright 2025 Google LLC.
+#
+
+obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)	+= binder_alloc_kunit.o
diff --git a/drivers/android/tests/binder_alloc_kunit.c b/drivers/android/tests/binder_alloc_kunit.c
new file mode 100644
index 000000000000..5e49078c9b23
--- /dev/null
+++ b/drivers/android/tests/binder_alloc_kunit.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for binder allocator code.
+ *
+ * Copyright 2025 Google LLC.
+ * Author: Tiffany Yang <ynaffit@google.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
+#include <linux/anon_inodes.h>
+#include <linux/err.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/sizes.h>
+
+#include "../binder_alloc.h"
+#include "../binder_internal.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+#define BINDER_MMAP_SIZE SZ_128K
+
+struct binder_alloc_test {
+	struct binder_alloc alloc;
+	struct list_lru binder_test_freelist;
+	struct file *filp;
+	unsigned long mmap_uaddr;
+};
+
+static void binder_alloc_test_init_freelist(struct kunit *test)
+{
+	struct binder_alloc_test *priv = test->priv;
+
+	KUNIT_EXPECT_PTR_EQ(test, priv->alloc.freelist,
+			    &priv->binder_test_freelist);
+}
+
+static void binder_alloc_test_mmap(struct kunit *test)
+{
+	struct binder_alloc_test *priv = test->priv;
+	struct binder_alloc *alloc = &priv->alloc;
+	struct binder_buffer *buf;
+	struct rb_node *n;
+
+	KUNIT_EXPECT_EQ(test, alloc->mapped, true);
+	KUNIT_EXPECT_EQ(test, alloc->buffer_size, BINDER_MMAP_SIZE);
+
+	n = rb_first(&alloc->allocated_buffers);
+	KUNIT_EXPECT_PTR_EQ(test, n, NULL);
+
+	n = rb_first(&alloc->free_buffers);
+	buf = rb_entry(n, struct binder_buffer, rb_node);
+	KUNIT_EXPECT_EQ(test, binder_alloc_buffer_size(alloc, buf),
+			BINDER_MMAP_SIZE);
+	KUNIT_EXPECT_TRUE(test, list_is_last(&buf->entry, &alloc->buffers));
+}
+
+/* ===== End test cases ===== */
+
+static void binder_alloc_test_vma_close(struct vm_area_struct *vma)
+{
+	struct binder_alloc *alloc = vma->vm_private_data;
+
+	binder_alloc_vma_close(alloc);
+}
+
+static const struct vm_operations_struct binder_alloc_test_vm_ops = {
+	.close = binder_alloc_test_vma_close,
+	.fault = binder_vm_fault,
+};
+
+static int binder_alloc_test_mmap_handler(struct file *filp,
+					  struct vm_area_struct *vma)
+{
+	struct binder_alloc *alloc = filp->private_data;
+
+	vm_flags_mod(vma, VM_DONTCOPY | VM_MIXEDMAP, VM_MAYWRITE);
+
+	vma->vm_ops = &binder_alloc_test_vm_ops;
+	vma->vm_private_data = alloc;
+
+	return binder_alloc_mmap_handler(alloc, vma);
+}
+
+static const struct file_operations binder_alloc_test_fops = {
+	.mmap = binder_alloc_test_mmap_handler,
+};
+
+static int binder_alloc_test_init(struct kunit *test)
+{
+	struct binder_alloc_test *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	test->priv = priv;
+
+	ret = list_lru_init(&priv->binder_test_freelist);
+	if (ret) {
+		kunit_err(test, "Failed to initialize test freelist\n");
+		return ret;
+	}
+
+	/* __binder_alloc_init requires mm to be attached */
+	ret = kunit_attach_mm();
+	if (ret) {
+		kunit_err(test, "Failed to attach mm\n");
+		return ret;
+	}
+	__binder_alloc_init(&priv->alloc, &priv->binder_test_freelist);
+
+	priv->filp = anon_inode_getfile("binder_alloc_kunit",
+					&binder_alloc_test_fops, &priv->alloc,
+					O_RDWR | O_CLOEXEC);
+	if (IS_ERR_OR_NULL(priv->filp)) {
+		kunit_err(test, "Failed to open binder alloc test driver file\n");
+		return priv->filp ? PTR_ERR(priv->filp) : -ENOMEM;
+	}
+
+	priv->mmap_uaddr = kunit_vm_mmap(test, priv->filp, 0, BINDER_MMAP_SIZE,
+					 PROT_READ, MAP_PRIVATE | MAP_NORESERVE,
+					 0);
+	if (!priv->mmap_uaddr) {
+		kunit_err(test, "Could not map the test's transaction memory\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void binder_alloc_test_exit(struct kunit *test)
+{
+	struct binder_alloc_test *priv = test->priv;
+
+	/* Close the backing file to make sure binder_alloc_vma_close runs */
+	if (!IS_ERR_OR_NULL(priv->filp))
+		fput(priv->filp);
+
+	if (priv->alloc.mm)
+		binder_alloc_deferred_release(&priv->alloc);
+
+	/* Make sure freelist is empty */
+	KUNIT_EXPECT_EQ(test, list_lru_count(&priv->binder_test_freelist), 0);
+	list_lru_destroy(&priv->binder_test_freelist);
+}
+
+static struct kunit_case binder_alloc_test_cases[] = {
+	KUNIT_CASE(binder_alloc_test_init_freelist),
+	KUNIT_CASE(binder_alloc_test_mmap),
+	{}
+};
+
+static struct kunit_suite binder_alloc_test_suite = {
+	.name = "binder_alloc",
+	.test_cases = binder_alloc_test_cases,
+	.init = binder_alloc_test_init,
+	.exit = binder_alloc_test_exit,
+};
+
+kunit_test_suite(binder_alloc_test_suite);
+
+MODULE_AUTHOR("Tiffany Yang <ynaffit@google.com>");
+MODULE_DESCRIPTION("Binder Alloc KUnit tests");
+MODULE_LICENSE("GPL");
-- 
2.50.0.727.gbf7dc18ff4-goog


