Return-Path: <linux-kselftest+bounces-36008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53108AEC124
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 22:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C148917F960
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBC72ED150;
	Fri, 27 Jun 2025 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LY9U2N3G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A602ECE84
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751056697; cv=none; b=XRHT0rSh12Wauh+PKOXwyyUPWNdRzyo4A3Wml676eB5RVMs6cgIS8gw95WmoaIWyCLkE5AwSqaQy6Xzrq8e8ljZXYYouBt96PiMkWLYyaDlW4YJFeIukc1AMREQMXvzdK/jM3HpoLUy/CMVhe7mu/QfvJg2jwMiIHIMGQfX8hLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751056697; c=relaxed/simple;
	bh=rtQcj5/G+YvdAph34dfSB2n4HO4B/CrzdQJLOznysD8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eaOPKYoLwSpfTcsYrwRIu02NyF5wCzhEb4S2J6qt3G8/k96roluyv5glbYaJHpwVkLORv8KKzkEPGkBcAOfjZJY3lxxCOzytFwxXv8T4ca9rQ0uefY7X+skWJDfuaR5fijEmxJJswe1LZog5GdjGfdwWZ81AooxrpNyO/BDS5rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LY9U2N3G; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7494999de28so3912874b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 13:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751056695; x=1751661495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rG0I4EZS/eL2lavIZX7DGorwUd6CPm/AfEhDCj2j1Ug=;
        b=LY9U2N3GZaunmvb3wrwh13HSuM8v4oMLClaqevjOP4h4sOYfzTCrLX8A2fCNgxEPAp
         9ldflkBsuZlsObY3hSe/aBW//H2PcmcMVxwOfbKR+Rsyajowxll6YhPscS9uSULkQM44
         VDEK1JcI/sQ0Kz0bRhuvY5FUgyPYkpCeO8OQOeSsg4efKI0U1AUuvpZN9BTmsVs8s2yV
         CcYVKL/Bsg74OXStUOrV+WZ6/fAmJLkHaMi3aAGT7BmRWR51nshInUqnkTgE/lxCDEto
         r2Pz+hw3/NOJV8nd1lL6Zg0GHwzBm2TKABp1JaU78fdVmtOxQiyO3Ew6DgRCtou9t7wA
         g5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751056695; x=1751661495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rG0I4EZS/eL2lavIZX7DGorwUd6CPm/AfEhDCj2j1Ug=;
        b=G1hxlxNcY87oUlqsrlGzXhH2lZmdKlnC7qQMb+o0Rkqk4KlFLETBiOWo/hNUhKKKli
         a41MYPoioCGBxJr0NoaDOaWPy6iPvO2LZGqE6StX+qbTBJXx40hMsb4SGf97u3I5BSSU
         YAo+V5uIjCcrgOl/aV8He3lzgq9YLI7vw1es+ueJf7zTquJdtrP1YiA6D02tWES8Qujy
         veapCWaoXLb4MhYX2/LR1gb13GcUnC+54jDBKNDuQPnyFvjMLGezS351vjHLZDoGnPqy
         wGfeYVHi2ovAt4YAOmqoVsrERK9j86TAACAg/NlWeTQ5YQ1KBqt0IqVscPD11zb5As0C
         84mw==
X-Forwarded-Encrypted: i=1; AJvYcCVo6Nx0Qu5VAGTe3y9t9dnmMjwiFBDZZrI1pm5T+qzPJMzj5GwBbPTP9ZM3f3WQ3uIt1RuCwJSwKSt5qkH96Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxohhdGMnz/qdmldR1uB1p1MN/OxNisUIFS4XETN0gVzGuwdDZI
	wTIqjpGDUA2eUruAe8yWamekWMIRRziyuzXa8zMEhIJFTlwtnRaY33cqVNiD/IL/qf6paF4AUmy
	UJQvy4n0Xog==
X-Google-Smtp-Source: AGHT+IFxtfrD81QwY3oSvM13Wp5QQaP71rVt8N0WbQdAqBowIqymXLf2AWL6ZuY0IWR3NS5LDTXk+SJYkp3I
X-Received: from plblf6.prod.google.com ([2002:a17:902:fb46:b0:237:e715:e543])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1388:b0:235:e9fe:83c0
 with SMTP id d9443c01a7336-23ac462453bmr49518535ad.27.1751056694990; Fri, 27
 Jun 2025 13:38:14 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:37:44 -0700
In-Reply-To: <20250627203748.881022-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627203748.881022-1-ynaffit@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627203748.881022-4-ynaffit@google.com>
Subject: [PATCH 3/5] binder: Scaffolding for binder_alloc KUnit tests
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Add setup and teardown for testing binder allocator code with KUnit.
Include minimal test cases to verify that tests are initialized
correctly.

Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
 drivers/android/Kconfig                    |  11 ++
 drivers/android/Makefile                   |   1 +
 drivers/android/binder.c                   |   5 +-
 drivers/android/binder_alloc.c             |  15 +-
 drivers/android/binder_alloc.h             |   6 +
 drivers/android/binder_internal.h          |   4 +
 drivers/android/tests/.kunitconfig         |   3 +
 drivers/android/tests/Makefile             |   3 +
 drivers/android/tests/binder_alloc_kunit.c | 166 +++++++++++++++++++++
 include/kunit/test.h                       |  12 ++
 lib/kunit/user_alloc.c                     |   4 +-
 11 files changed, 222 insertions(+), 8 deletions(-)
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
index 000000000000..a73601231049
--- /dev/null
+++ b/drivers/android/tests/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_ANDROID_BINDER_IPC=y
+CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST=y
diff --git a/drivers/android/tests/Makefile b/drivers/android/tests/Makefile
new file mode 100644
index 000000000000..6780967e573b
--- /dev/null
+++ b/drivers/android/tests/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)	+= binder_alloc_kunit.o
diff --git a/drivers/android/tests/binder_alloc_kunit.c b/drivers/android/tests/binder_alloc_kunit.c
new file mode 100644
index 000000000000..4b68b5687d33
--- /dev/null
+++ b/drivers/android/tests/binder_alloc_kunit.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for binder allocator code
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
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 39c768f87dc9..d958ee53050e 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -531,6 +531,18 @@ static inline char *kunit_kstrdup(struct kunit *test, const char *str, gfp_t gfp
  */
 const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp);
 
+/**
+ * kunit_attach_mm() - Create and attach a new mm if it doesn't already exist.
+ *
+ * Allocates a &struct mm_struct and attaches it to @current. In most cases, call
+ * kunit_vm_mmap() without calling kunit_attach_mm() directly. Only necessary when
+ * code under test accesses the mm before executing the mmap (e.g., to perform
+ * additional initialization beforehand).
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int kunit_attach_mm(void);
+
 /**
  * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
  * @test: The test context object.
diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
index 46951be018be..b8cac765e620 100644
--- a/lib/kunit/user_alloc.c
+++ b/lib/kunit/user_alloc.c
@@ -22,8 +22,7 @@ struct kunit_vm_mmap_params {
 	unsigned long offset;
 };
 
-/* Create and attach a new mm if it doesn't already exist. */
-static int kunit_attach_mm(void)
+int kunit_attach_mm(void)
 {
 	struct mm_struct *mm;
 
@@ -49,6 +48,7 @@ static int kunit_attach_mm(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kunit_attach_mm);
 
 static int kunit_vm_mmap_init(struct kunit_resource *res, void *context)
 {
-- 
2.50.0.727.gbf7dc18ff4-goog


