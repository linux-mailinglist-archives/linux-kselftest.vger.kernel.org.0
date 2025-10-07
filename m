Return-Path: <linux-kselftest+bounces-42805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5574BC0177
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 05:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B8F18990A9
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 03:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373B421858D;
	Tue,  7 Oct 2025 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="WJp7dLI/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A81D6DB6
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 03:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759807872; cv=none; b=G5EKBXX5CYmT62m98QDmpEm6btc14aOYcKYcmbYYuysJBkCX2zbJzRETQbI+v1LSW9n3sYhI1PuumUUFbd39pJRfwetEW4ac3j8M3wjfWpc69e0b0DeGUasLVWfe8freVe2RVO3xgIHa5fesg3WaQJ1HwdyQw0j9NPf13dhA+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759807872; c=relaxed/simple;
	bh=g1Il+TFGDLrGFUmJb7mLr9b87faBHG4T9M5bk5mlfLs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ps8Gwn6naczuA4JfIK2HhXIYgZUZJaeZx+vL4KXNGdq4xK1zo7MjHgO/t5yW5MP4S0iTSnwmECKpp+pZ2idGh/fkYAYvB5sNDkf+gKZGZWsX4PYexmCPbfnAuggN8LMuQ7ebX1q8lrJPrCEXVAnZDx7nkB4Y+wGNLIimQsRq6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=WJp7dLI/; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5523142df73so4129278e0c.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Oct 2025 20:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759807869; x=1760412669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibvELv1DY2+vIcA7qwUjdArdZEQD1fTrYRAZviRoTvY=;
        b=WJp7dLI/u5KI7knhyyUvAo7V9zFbVa2kGOn6jOxVhDd+JO2kAkBlXeqwCkpq1xgFQn
         MXv80DhqVT+KKEnLTtGbQ2rnjcIW6movwgwS/0IaILT8SAUjCpCWTC+SCxkRmdgLqIHK
         Ksdt2tdSzaf7Sq0XVwGB1t98BjnEN47+oOxzzKlqZcokLlZtmL3O9XOHaSHQNZ1sVuXA
         KvZDckzqvhnDyo0FZOXB1LvdeNe+iJzHslLna5iqf00tbqKMshFShsZb2LgwLEZ4B2p5
         WZk0LSjTA3mfYKpBk7N+uwyUyB35XFrZTrXnok9g4mNpxtcfLT3gZ6j/BnnsF7m9T636
         x5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759807869; x=1760412669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibvELv1DY2+vIcA7qwUjdArdZEQD1fTrYRAZviRoTvY=;
        b=E8AGqKn5lpTIae9VOPusCW4YSDtl+yuFWNnUyp6dh5RqYSR7izNeNBLaigGWHzo+kU
         AgJ7kZTx8JpfQGPwt+zGgzeeSWbLE/1q0odq7h6WDjF8WKkegNFNEydQ0RwqwQJ0fqxy
         c6mMD/0cFrU9fghp14qf3rRiOq4q90OZhCROUGccZQAP1Sq/S+qT9UAJy1UvXm3lOeUx
         WDbeH6fYVqx7PT4zkJoe9eNxWlcRbF5bhC+sH30jz8pH07mXSZhreEU2WiorXkLYW94c
         fMEiY5L1dcotzFGAQ7wVAgWRHYOj0SoobJH25FVjtDI9hAPRUazBCI+GbasYnZ6ntzUA
         GAYg==
X-Forwarded-Encrypted: i=1; AJvYcCVBT7379dQDLYgbMpl9iUe0S6uXKq0HKHGfh11QP/6RSCxRThFlNbb1Spn0lcBbBH38T5ZMJlWfCQ+GcUIEK5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoRm4twifHYVVSejJ8fH8HXVa4X2fArsO+xTm4FTJqBs9PrIKa
	jlgPxe/dHe1WkKDtZ/LVLYvk4wL6zHUz6DGm0aGQoxPF2RGRqxnGTQg4qi7LXaPMWMU=
X-Gm-Gg: ASbGncuHB4NpQVW5GqOuQv7rIv0INvg8zFusoCXnQh0lMOHjbFcIyp434bUvJrd0yTB
	ggNM3LKGFnoDueinM9U/epbLRAAzC9GOReDNhBmqhVuOYKh4lq+lVLKTUn0kcCwvx9rQ1e3hbG2
	fEqOM9DNOV+Y+IDwtJKOiuW5uWDPkKU5kss+lXhvaE04XAs8TPbbWRNWE/9K+8e+OD/OIrghDjM
	OKGuQDRp80P7GXj/tBHLfOwbFWzLLy0sfTvL8ebSgBXlY2guCnyLRc1Mm+AZXSfxkbtC07CTvOS
	YqW3wmcLP5+iBkX29GmFKL0fPk377dYXHVAMmXVJpAxcRAWkLrVkTz+T7ZK1T57BDA4sAToX+m+
	mQ8fGIGEDdJ06mh4DJ/nRol6jSIezULkrIqlpnOJ3l4bhWcsi9qJtGWRGvEGCi4DY2fzGUTbe8/
	T6FXy+GSt+RuoLBCTY4YB65jj15RSU2IU=
X-Google-Smtp-Source: AGHT+IFPTwIt7nEjlmvRxp5PL1S4hQtURwGy/5RtjK3MnXQGFAvywh+tGC7FpmbU5zh5Lt8qYg6brA==
X-Received: by 2002:a05:6122:17a9:b0:54b:d7b6:2edb with SMTP id 71dfb90a1353d-5524e934263mr5092007e0c.8.1759807868739;
        Mon, 06 Oct 2025 20:31:08 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-552ea335f07sm2446030e0c.15.2025.10.06.20.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 20:31:07 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org
Subject: [PATCH v5 2/7] kho: make debugfs interface optional
Date: Tue,  7 Oct 2025 03:30:55 +0000
Message-ID: <20251007033100.836886-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
In-Reply-To: <20251007033100.836886-1-pasha.tatashin@soleen.com>
References: <20251007033100.836886-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, KHO is controlled via debugfs interface, but once LUO is
introduced, it can control KHO, and the debug interface becomes
optional.

Add a separate config CONFIG_KEXEC_HANDOVER_DEBUGFS that enables
the debugfs interface, and allows to inspect the tree.

Move all debugfs related code to a new file to keep the .c files
clear of ifdefs.

Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS                           |   3 +-
 kernel/Kconfig.kexec                  |  10 ++
 kernel/Makefile                       |   1 +
 kernel/kexec_handover.c               | 223 +++-----------------------
 kernel/kexec_handover_debug.c         | 213 ++++++++++++++++++++++++
 kernel/kexec_handover_internal.h      |  44 +++++
 tools/testing/selftests/kho/vmtest.sh |   1 +
 7 files changed, 290 insertions(+), 205 deletions(-)
 create mode 100644 kernel/kexec_handover_debug.c
 create mode 100644 kernel/kexec_handover_internal.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3773c74b31d6..49e8fc4a393e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13770,13 +13770,14 @@ KEXEC HANDOVER (KHO)
 M:	Alexander Graf <graf@amazon.com>
 M:	Mike Rapoport <rppt@kernel.org>
 M:	Changyuan Lyu <changyuanl@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
 L:	kexec@lists.infradead.org
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
-F:	kernel/kexec_handover.c
+F:	kernel/kexec_handover*
 F:	tools/testing/selftests/kho/
 
 KEYS-ENCRYPTED
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 422270d64820..03c3aa6263d3 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -109,6 +109,16 @@ config KEXEC_HANDOVER
 	  to keep data or state alive across the kexec. For this to work,
 	  both source and target kernels need to have this option enabled.
 
+config KEXEC_HANDOVER_DEBUGFS
+	bool "kexec handover debugfs interface"
+	depends on KEXEC_HANDOVER
+	depends on DEBUG_FS
+	help
+	  Allow to control kexec handover device tree via debugfs
+	  interface, i.e. finalize the state or aborting the finalization.
+	  Also, enables inspecting the KHO fdt trees with the debugfs binary
+	  blobs.
+
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	default ARCH_DEFAULT_CRASH_DUMP
diff --git a/kernel/Makefile b/kernel/Makefile
index df3dd8291bb6..f21d8c98d857 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
 obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
+obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS) += kexec_handover_debug.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 76c34ea923f0..f3627430b3c3 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -10,7 +10,6 @@
 
 #include <linux/cma.h>
 #include <linux/count_zeros.h>
-#include <linux/debugfs.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
 #include <linux/libfdt.h>
@@ -28,6 +27,7 @@
  */
 #include "../mm/internal.h"
 #include "kexec_internal.h"
+#include "kexec_handover_internal.h"
 
 #define KHO_FDT_COMPATIBLE "kho-v1"
 #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
@@ -101,8 +101,6 @@ struct khoser_mem_chunk;
 
 struct kho_serialization {
 	struct page *fdt;
-	struct list_head fdt_list;
-	struct dentry *sub_fdt_dir;
 	struct kho_mem_track track;
 	/* First chunk of serialized preserved memory map */
 	struct khoser_mem_chunk *preserved_mem_map;
@@ -110,20 +108,16 @@ struct kho_serialization {
 
 struct kho_out {
 	struct blocking_notifier_head chain_head;
-
-	struct dentry *dir;
-
 	struct mutex lock; /* protects KHO FDT finalization */
-
 	struct kho_serialization ser;
 	bool finalized;
+	struct kho_debugfs dbg;
 };
 
 static struct kho_out kho_out = {
 	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
 	.lock = __MUTEX_INITIALIZER(kho_out.lock),
 	.ser = {
-		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
 		.track = {
 			.orders = XARRAY_INIT(kho_out.ser.track.orders, 0),
 		},
@@ -465,8 +459,8 @@ static void __init kho_mem_deserialize(const void *fdt)
  * area for early allocations that happen before page allocator is
  * initialized.
  */
-static struct kho_scratch *kho_scratch;
-static unsigned int kho_scratch_cnt;
+struct kho_scratch *kho_scratch;
+unsigned int kho_scratch_cnt;
 
 /*
  * The scratch areas are scaled by default as percent of memory allocated from
@@ -662,37 +656,6 @@ static void __init kho_reserve_scratch(void)
 	kho_enable = false;
 }
 
-struct fdt_debugfs {
-	struct list_head list;
-	struct debugfs_blob_wrapper wrapper;
-	struct dentry *file;
-};
-
-static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
-			       const char *name, const void *fdt)
-{
-	struct fdt_debugfs *f;
-	struct dentry *file;
-
-	f = kmalloc(sizeof(*f), GFP_KERNEL);
-	if (!f)
-		return -ENOMEM;
-
-	f->wrapper.data = (void *)fdt;
-	f->wrapper.size = fdt_totalsize(fdt);
-
-	file = debugfs_create_blob(name, 0400, dir, &f->wrapper);
-	if (IS_ERR(file)) {
-		kfree(f);
-		return PTR_ERR(file);
-	}
-
-	f->file = file;
-	list_add(&f->list, list);
-
-	return 0;
-}
-
 /**
  * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
  * @ser: serialization control object passed by KHO notifiers.
@@ -704,7 +667,8 @@ static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
  * by KHO for the new kernel to retrieve it after kexec.
  *
  * A debugfs blob entry is also created at
- * ``/sys/kernel/debug/kho/out/sub_fdts/@name``.
+ * ``/sys/kernel/debug/kho/out/sub_fdts/@name`` when kernel is configured with
+ * CONFIG_KEXEC_HANDOVER_DEBUGFS
  *
  * Return: 0 on success, error code on failure
  */
@@ -721,7 +685,7 @@ int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
 	if (err)
 		return err;
 
-	return kho_debugfs_fdt_add(&ser->fdt_list, ser->sub_fdt_dir, name, fdt);
+	return kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
@@ -1044,29 +1008,6 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 }
 EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
-/* Handling for debug/kho/out */
-
-static struct dentry *debugfs_root;
-
-static int kho_out_update_debugfs_fdt(void)
-{
-	int err = 0;
-	struct fdt_debugfs *ff, *tmp;
-
-	if (kho_out.finalized) {
-		err = kho_debugfs_fdt_add(&kho_out.ser.fdt_list, kho_out.dir,
-					  "fdt", page_to_virt(kho_out.ser.fdt));
-	} else {
-		list_for_each_entry_safe(ff, tmp, &kho_out.ser.fdt_list, list) {
-			debugfs_remove(ff->file);
-			list_del(&ff->list);
-			kfree(ff);
-		}
-	}
-
-	return err;
-}
-
 static int __kho_abort(void)
 {
 	int err;
@@ -1116,8 +1057,9 @@ int kho_abort(void)
 		return ret;
 
 	kho_out.finalized = false;
+	kho_debugfs_cleanup(&kho_out.dbg);
 
-	return kho_out_update_debugfs_fdt();
+	return 0;
 }
 
 static int __kho_finalize(void)
@@ -1186,89 +1128,23 @@ int kho_finalize(void)
 
 	kho_out.finalized = true;
 
-	return kho_out_update_debugfs_fdt();
-}
-
-static int kho_out_finalize_get(void *data, u64 *val)
-{
-	mutex_lock(&kho_out.lock);
-	*val = kho_out.finalized;
-	mutex_unlock(&kho_out.lock);
-
-	return 0;
-}
-
-static int kho_out_finalize_set(void *data, u64 _val)
-{
-	return (!!_val) ? kho_finalize() : kho_abort();
-}
-
-DEFINE_DEBUGFS_ATTRIBUTE(fops_kho_out_finalize, kho_out_finalize_get,
-			 kho_out_finalize_set, "%llu\n");
-
-static int scratch_phys_show(struct seq_file *m, void *v)
-{
-	for (int i = 0; i < kho_scratch_cnt; i++)
-		seq_printf(m, "0x%llx\n", kho_scratch[i].addr);
-
-	return 0;
-}
-DEFINE_SHOW_ATTRIBUTE(scratch_phys);
-
-static int scratch_len_show(struct seq_file *m, void *v)
-{
-	for (int i = 0; i < kho_scratch_cnt; i++)
-		seq_printf(m, "0x%llx\n", kho_scratch[i].size);
-
-	return 0;
+	return kho_debugfs_fdt_add(&kho_out.dbg, "fdt",
+				   page_to_virt(kho_out.ser.fdt), true);
 }
-DEFINE_SHOW_ATTRIBUTE(scratch_len);
 
-static __init int kho_out_debugfs_init(void)
+bool kho_finalized(void)
 {
-	struct dentry *dir, *f, *sub_fdt_dir;
-
-	dir = debugfs_create_dir("out", debugfs_root);
-	if (IS_ERR(dir))
-		return -ENOMEM;
-
-	sub_fdt_dir = debugfs_create_dir("sub_fdts", dir);
-	if (IS_ERR(sub_fdt_dir))
-		goto err_rmdir;
-
-	f = debugfs_create_file("scratch_phys", 0400, dir, NULL,
-				&scratch_phys_fops);
-	if (IS_ERR(f))
-		goto err_rmdir;
-
-	f = debugfs_create_file("scratch_len", 0400, dir, NULL,
-				&scratch_len_fops);
-	if (IS_ERR(f))
-		goto err_rmdir;
-
-	f = debugfs_create_file("finalize", 0600, dir, NULL,
-				&fops_kho_out_finalize);
-	if (IS_ERR(f))
-		goto err_rmdir;
-
-	kho_out.dir = dir;
-	kho_out.ser.sub_fdt_dir = sub_fdt_dir;
-	return 0;
-
-err_rmdir:
-	debugfs_remove_recursive(dir);
-	return -ENOENT;
+	guard(mutex)(&kho_out.lock);
+	return kho_out.finalized;
 }
 
 struct kho_in {
-	struct dentry *dir;
 	phys_addr_t fdt_phys;
 	phys_addr_t scratch_phys;
-	struct list_head fdt_list;
+	struct kho_debugfs dbg;
 };
 
 static struct kho_in kho_in = {
-	.fdt_list = LIST_HEAD_INIT(kho_in.fdt_list),
 };
 
 static const void *kho_get_fdt(void)
@@ -1332,56 +1208,6 @@ int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 }
 EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
 
-/* Handling for debugfs/kho/in */
-
-static __init int kho_in_debugfs_init(const void *fdt)
-{
-	struct dentry *sub_fdt_dir;
-	int err, child;
-
-	kho_in.dir = debugfs_create_dir("in", debugfs_root);
-	if (IS_ERR(kho_in.dir))
-		return PTR_ERR(kho_in.dir);
-
-	sub_fdt_dir = debugfs_create_dir("sub_fdts", kho_in.dir);
-	if (IS_ERR(sub_fdt_dir)) {
-		err = PTR_ERR(sub_fdt_dir);
-		goto err_rmdir;
-	}
-
-	err = kho_debugfs_fdt_add(&kho_in.fdt_list, kho_in.dir, "fdt", fdt);
-	if (err)
-		goto err_rmdir;
-
-	fdt_for_each_subnode(child, fdt, 0) {
-		int len = 0;
-		const char *name = fdt_get_name(fdt, child, NULL);
-		const u64 *fdt_phys;
-
-		fdt_phys = fdt_getprop(fdt, child, "fdt", &len);
-		if (!fdt_phys)
-			continue;
-		if (len != sizeof(*fdt_phys)) {
-			pr_warn("node `%s`'s prop `fdt` has invalid length: %d\n",
-				name, len);
-			continue;
-		}
-		err = kho_debugfs_fdt_add(&kho_in.fdt_list, sub_fdt_dir, name,
-					  phys_to_virt(*fdt_phys));
-		if (err) {
-			pr_warn("failed to add fdt `%s` to debugfs: %d\n", name,
-				err);
-			continue;
-		}
-	}
-
-	return 0;
-
-err_rmdir:
-	debugfs_remove_recursive(kho_in.dir);
-	return err;
-}
-
 static __init int kho_init(void)
 {
 	int err = 0;
@@ -1396,27 +1222,16 @@ static __init int kho_init(void)
 		goto err_free_scratch;
 	}
 
-	debugfs_root = debugfs_create_dir("kho", NULL);
-	if (IS_ERR(debugfs_root)) {
-		err = -ENOENT;
+	err = kho_debugfs_init();
+	if (err)
 		goto err_free_fdt;
-	}
 
-	err = kho_out_debugfs_init();
+	err = kho_out_debugfs_init(&kho_out.dbg);
 	if (err)
 		goto err_free_fdt;
 
 	if (fdt) {
-		err = kho_in_debugfs_init(fdt);
-		/*
-		 * Failure to create /sys/kernel/debug/kho/in does not prevent
-		 * reviving state from KHO and setting up KHO for the next
-		 * kexec.
-		 */
-		if (err)
-			pr_err("failed exposing handover FDT in debugfs: %d\n",
-			       err);
-
+		kho_in_debugfs_init(&kho_in.dbg, fdt);
 		return 0;
 	}
 
diff --git a/kernel/kexec_handover_debug.c b/kernel/kexec_handover_debug.c
new file mode 100644
index 000000000000..edd080c42f1c
--- /dev/null
+++ b/kernel/kexec_handover_debug.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kexec_handover.c - kexec handover metadata processing
+ * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
+ * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
+ * Copyright (C) 2025 Google LLC, Changyuan Lyu <changyuanl@google.com>
+ * Copyright (C) 2025 Google LLC, Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#define pr_fmt(fmt) "KHO: " fmt
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/libfdt.h>
+#include <linux/mm.h>
+#include "kexec_handover_internal.h"
+
+static struct dentry *debugfs_root;
+
+struct fdt_debugfs {
+	struct list_head list;
+	struct debugfs_blob_wrapper wrapper;
+	struct dentry *file;
+};
+
+static int __kho_debugfs_fdt_add(struct list_head *list, struct dentry *dir,
+				 const char *name, const void *fdt)
+{
+	struct fdt_debugfs *f;
+	struct dentry *file;
+
+	f = kmalloc(sizeof(*f), GFP_KERNEL);
+	if (!f)
+		return -ENOMEM;
+
+	f->wrapper.data = (void *)fdt;
+	f->wrapper.size = fdt_totalsize(fdt);
+
+	file = debugfs_create_blob(name, 0400, dir, &f->wrapper);
+	if (IS_ERR(file)) {
+		kfree(f);
+		return PTR_ERR(file);
+	}
+
+	f->file = file;
+	list_add(&f->list, list);
+
+	return 0;
+}
+
+int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
+			const void *fdt, bool root)
+{
+	struct dentry *dir;
+
+	if (root)
+		dir = dbg->dir;
+	else
+		dir = dbg->sub_fdt_dir;
+
+	return __kho_debugfs_fdt_add(&dbg->fdt_list, dir, name, fdt);
+}
+
+void kho_debugfs_cleanup(struct kho_debugfs *dbg)
+{
+	struct fdt_debugfs *ff, *tmp;
+
+	list_for_each_entry_safe(ff, tmp, &dbg->fdt_list, list) {
+		debugfs_remove(ff->file);
+		list_del(&ff->list);
+		kfree(ff);
+	}
+}
+
+static int kho_out_finalize_get(void *data, u64 *val)
+{
+	*val = kho_finalized();
+
+	return 0;
+}
+
+static int kho_out_finalize_set(void *data, u64 _val)
+{
+	return (!!_val) ? kho_finalize() : kho_abort();
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(kho_out_finalize_fops, kho_out_finalize_get,
+			 kho_out_finalize_set, "%llu\n");
+
+static int scratch_phys_show(struct seq_file *m, void *v)
+{
+	for (int i = 0; i < kho_scratch_cnt; i++)
+		seq_printf(m, "0x%llx\n", kho_scratch[i].addr);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(scratch_phys);
+
+static int scratch_len_show(struct seq_file *m, void *v)
+{
+	for (int i = 0; i < kho_scratch_cnt; i++)
+		seq_printf(m, "0x%llx\n", kho_scratch[i].size);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(scratch_len);
+
+__init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
+{
+	struct dentry *dir, *sub_fdt_dir;
+	int err, child;
+
+	INIT_LIST_HEAD(&dbg->fdt_list);
+
+	dir = debugfs_create_dir("in", debugfs_root);
+	if (IS_ERR(dir)) {
+		err = PTR_ERR(dir);
+		goto err_out;
+	}
+
+	sub_fdt_dir = debugfs_create_dir("sub_fdts", dir);
+	if (IS_ERR(sub_fdt_dir)) {
+		err = PTR_ERR(sub_fdt_dir);
+		goto err_rmdir;
+	}
+
+	err = __kho_debugfs_fdt_add(&dbg->fdt_list, dir, "fdt", fdt);
+	if (err)
+		goto err_rmdir;
+
+	fdt_for_each_subnode(child, fdt, 0) {
+		int len = 0;
+		const char *name = fdt_get_name(fdt, child, NULL);
+		const u64 *fdt_phys;
+
+		fdt_phys = fdt_getprop(fdt, child, "fdt", &len);
+		if (!fdt_phys)
+			continue;
+		if (len != sizeof(*fdt_phys)) {
+			pr_warn("node %s prop fdt has invalid length: %d\n",
+				name, len);
+			continue;
+		}
+		err = __kho_debugfs_fdt_add(&dbg->fdt_list, sub_fdt_dir, name,
+					    phys_to_virt(*fdt_phys));
+		if (err) {
+			pr_warn("failed to add fdt %s to debugfs: %d\n", name,
+				err);
+			continue;
+		}
+	}
+
+	dbg->dir = dir;
+	dbg->sub_fdt_dir = sub_fdt_dir;
+
+	return;
+err_rmdir:
+	debugfs_remove_recursive(dir);
+err_out:
+	/*
+	 * Failure to create /sys/kernel/debug/kho/in does not prevent
+	 * reviving state from KHO and setting up KHO for the next
+	 * kexec.
+	 */
+	if (err)
+		pr_err("failed exposing handover FDT in debugfs: %d\n", err);
+}
+
+__init int kho_out_debugfs_init(struct kho_debugfs *dbg)
+{
+	struct dentry *dir, *f, *sub_fdt_dir;
+
+	INIT_LIST_HEAD(&dbg->fdt_list);
+
+	dir = debugfs_create_dir("out", debugfs_root);
+	if (IS_ERR(dir))
+		return -ENOMEM;
+
+	sub_fdt_dir = debugfs_create_dir("sub_fdts", dir);
+	if (IS_ERR(sub_fdt_dir))
+		goto err_rmdir;
+
+	f = debugfs_create_file("scratch_phys", 0400, dir, NULL,
+				&scratch_phys_fops);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
+	f = debugfs_create_file("scratch_len", 0400, dir, NULL,
+				&scratch_len_fops);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
+	f = debugfs_create_file("finalize", 0600, dir, NULL,
+				&kho_out_finalize_fops);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
+	dbg->dir = dir;
+	dbg->sub_fdt_dir = sub_fdt_dir;
+	return 0;
+
+err_rmdir:
+	debugfs_remove_recursive(dir);
+	return -ENOENT;
+}
+
+__init int kho_debugfs_init(void)
+{
+	debugfs_root = debugfs_create_dir("kho", NULL);
+	if (IS_ERR(debugfs_root))
+		return -ENOENT;
+	return 0;
+}
diff --git a/kernel/kexec_handover_internal.h b/kernel/kexec_handover_internal.h
new file mode 100644
index 000000000000..042c189af768
--- /dev/null
+++ b/kernel/kexec_handover_internal.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_KEXEC_HANDOVER_INTERNAL_H
+#define LINUX_KEXEC_HANDOVER_INTERNAL_H
+
+#include <linux/kexec_handover.h>
+#include <linux/list.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUGFS
+#include <linux/debugfs.h>
+
+struct kho_debugfs {
+	struct dentry *dir;
+	struct dentry *sub_fdt_dir;
+	struct list_head fdt_list;
+};
+
+#else
+struct kho_debugfs {};
+#endif
+
+extern struct kho_scratch *kho_scratch;
+extern unsigned int kho_scratch_cnt;
+
+bool kho_finalized(void);
+
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUGFS
+int kho_debugfs_init(void);
+void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt);
+int kho_out_debugfs_init(struct kho_debugfs *dbg);
+int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
+			const void *fdt, bool root);
+void kho_debugfs_cleanup(struct kho_debugfs *dbg);
+#else
+static inline int kho_debugfs_init(void) { return 0; }
+static inline void kho_in_debugfs_init(struct kho_debugfs *dbg,
+				       const void *fdt) { }
+static inline int kho_out_debugfs_init(struct kho_debugfs *dbg) { return 0; }
+static inline int kho_debugfs_fdt_add(struct kho_debugfs *dbg, const char *name,
+				      const void *fdt, bool root) { return 0; }
+static inline void kho_debugfs_cleanup(struct kho_debugfs *dbg) {}
+#endif /* CONFIG_KEXEC_HANDOVER_DEBUGFS */
+
+#endif /* LINUX_KEXEC_HANDOVER_INTERNAL_H */
diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index 3f6c17166846..49fdac8e8b15 100755
--- a/tools/testing/selftests/kho/vmtest.sh
+++ b/tools/testing/selftests/kho/vmtest.sh
@@ -59,6 +59,7 @@ function build_kernel() {
 	tee "$kconfig" > "$kho_config" <<EOF
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KEXEC_HANDOVER=y
+CONFIG_KEXEC_HANDOVER_DEBUGFS=y
 CONFIG_TEST_KEXEC_HANDOVER=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_VM=y
-- 
2.51.0.618.g983fd99d29-goog


