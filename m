Return-Path: <linux-kselftest+bounces-2608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A17822A09
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 10:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382E1B20BF6
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 09:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DF9182AF;
	Wed,  3 Jan 2024 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bArnnaSm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182718627;
	Wed,  3 Jan 2024 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704273256; x=1735809256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=beKMrUAeoM7XiyShL3qFBKJIHdC3YdO1vgauHYZzfX8=;
  b=bArnnaSm5GryXnjbIX93zDN4S/PHYxXm2CBLh//wDyrX36VIAWgR08Mc
   nnQpJIyvdFLs5cCL9bWfzhkguZrI15piZhj8LMOV9IpofW3GN4/vIHl0j
   AiYv3PrCA8vfoEfWdUrRBSFZibD6e6KWbfvmaVeGzZCUgEeGe6amcDKHW
   dfroQHYA0j5bL/y76AG+3y38nAGZ+W0VzYpgDYrtH+IIqr3x+akbEePON
   K83oJ57xRq+PqYb1wCJFFcAW4BdvnDGYZh4Uu23P/nrAIrd//8DMZpION
   PBagbv7F3IpPNc6ivBfUE0nBKl7mO6nOatA40WAjqSjWTX/Xg2KeBSvjf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="394136947"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="394136947"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 01:14:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="923485704"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="923485704"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 01:14:13 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	shuah@kernel.org,
	stevensd@chromium.org,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH v2 2/3] KVM: selftests: add selftest driver for KVM to test memory slots for MMIO BARs
Date: Wed,  3 Jan 2024 16:44:57 +0800
Message-Id: <20240103084457.20086-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240103084327.19955-1-yan.y.zhao@intel.com>
References: <20240103084327.19955-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

This driver is for testing KVM memory slots for device MMIO BARs that are
mapped to pages serving as device resources.

This driver implements a mock device whose device resources are pages
array that can be mmaped into user space. It provides ioctl interface to
users to configure whether the pages are allocated as a compound huge page
or not.

KVM selftest code can then map the mock device resource to KVM memslots
to check if any error encountered. After VM shutdown, mock device
resource's page reference counters are checked to ensure KVM does not hold
extra reference count during memslot add/removal.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 lib/Kconfig.debug               |  14 ++
 lib/Makefile                    |   1 +
 lib/test_kvm_mock_device.c      | 281 ++++++++++++++++++++++++++++++++
 lib/test_kvm_mock_device_uapi.h |  16 ++
 4 files changed, 312 insertions(+)
 create mode 100644 lib/test_kvm_mock_device.c
 create mode 100644 lib/test_kvm_mock_device_uapi.h

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cc7d53d9dc01..c0fd4b53db89 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2922,6 +2922,20 @@ config TEST_HMM
 
 	  If unsure, say N.
 
+config TEST_KVM_MOCK_DEVICE
+	tristate "Test page-backended BAR to KVM mock device"
+	help
+	  This is a mock KVM assigned device whose MMIO BAR is backended by
+	  struct page.
+	  Say M here if you want to build the "test_kvm_mock_device" module.
+	  Doing so will allow you to run KVM selftest
+	  tools/testing/selftest/kvm/set_memory_region_io, which tests
+	  functionality of adding page-backended MMIO memslots in KVM and
+	  ensures that reference count of the backend pages are correctly
+	  handled.
+
+	  If unsure, say N.
+
 config TEST_FREE_PAGES
 	tristate "Test freeing pages"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e61..894a185bbabd 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_SCANF) += test_scanf.o
+obj-$(CONFIG_TEST_KVM_MOCK_DEVICE) += test_kvm_mock_device.o
 
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
diff --git a/lib/test_kvm_mock_device.c b/lib/test_kvm_mock_device.c
new file mode 100644
index 000000000000..4e7527c230cd
--- /dev/null
+++ b/lib/test_kvm_mock_device.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This is a module to test KVM DEVICE MMIO PASSTHROUGH.
+ */
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/mm.h>
+
+#include "test_kvm_mock_device_uapi.h"
+
+/* kvm mock device */
+struct kvm_mock_dev {
+	dev_t devt;
+	struct device device;
+	struct cdev cdev;
+};
+static struct kvm_mock_dev kvm_mock_dev;
+
+struct kvm_mock_device {
+	bool compound;
+	struct page *resource;
+	u64 bar_size;
+	int order;
+	int *ref_array;
+	struct mutex lock;
+	bool prepared;
+};
+
+static bool opened;
+
+#define BAR_SIZE 0x200000UL
+#define DEFAULT_COMPOUND true
+
+static vm_fault_t kvm_mock_device_mmap_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct kvm_mock_device *kmdev = vma->vm_private_data;
+	struct page *p = kmdev->resource;
+	vm_fault_t ret = VM_FAULT_NOPAGE;
+	unsigned long addr;
+	int i;
+
+	for (addr = vma->vm_start, i = vma->vm_pgoff; addr < vma->vm_end;
+	     addr += PAGE_SIZE, i++) {
+
+		ret = vmf_insert_pfn(vma, addr, page_to_pfn(p + i));
+		if (ret == VM_FAULT_NOPAGE)
+			continue;
+
+		zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
+		return ret;
+
+	}
+	return ret;
+}
+
+static const struct vm_operations_struct kvm_mock_device_mmap_ops = {
+	.fault = kvm_mock_device_mmap_fault,
+};
+
+static int kvm_mock_device_fops_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct kvm_mock_device *kmdev = file->private_data;
+	u64 offset, req_len;
+	int ret = 0;
+
+	mutex_lock(&kmdev->lock);
+	if (!kmdev->prepared) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	offset = vma->vm_pgoff << PAGE_SHIFT;
+	req_len = vma->vm_end - vma->vm_start;
+	if (offset + req_len > BAR_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+	vma->vm_ops = &kvm_mock_device_mmap_ops;
+	vma->vm_private_data = kmdev;
+out:
+	mutex_unlock(&kmdev->lock);
+	return ret;
+}
+
+static int kvm_mock_device_prepare_resource(struct kvm_mock_device *kmdev)
+{
+	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
+	unsigned int order = kmdev->order;
+	unsigned long count = 1 << order;
+	unsigned long i;
+	struct page *p;
+	int ret;
+
+	mutex_lock(&kmdev->lock);
+	if (kmdev->prepared) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (kmdev->compound)
+		gfp_flags |= __GFP_COMP;
+
+	p = alloc_pages_node(0, gfp_flags, order);
+	if (!p) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	kmdev->ref_array = kmalloc_array(count, sizeof(kmdev->ref_array),
+					 GFP_KERNEL_ACCOUNT);
+	if (!kmdev->ref_array) {
+		__free_pages(p, order);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < count; i++)
+		kmdev->ref_array[i] = page_ref_count(p + i);
+
+	kmdev->resource = p;
+	kmdev->prepared = true;
+out:
+	mutex_unlock(&kmdev->lock);
+	return ret;
+}
+
+static int kvm_mock_device_check_resource_ref(struct kvm_mock_device *kmdev)
+{
+	u32 i, count = 1 << kmdev->order;
+	struct page *p = kmdev->resource;
+	int inequal = 0;
+
+	mutex_lock(&kmdev->lock);
+	if (!kmdev->prepared) {
+		mutex_unlock(&kmdev->lock);
+		return -ENODEV;
+	}
+
+	for (i = 0; i < count; i++) {
+		if (kmdev->ref_array[i] == page_ref_count(p + i))
+			continue;
+
+		pr_err("kvm test device check resource page %d old ref=%d new ref=%d\n",
+			i, kmdev->ref_array[i], page_ref_count(p + i));
+		inequal++;
+	}
+	mutex_unlock(&kmdev->lock);
+
+	return inequal;
+}
+
+static int kvm_mock_device_fops_open(struct inode *inode, struct file *filp)
+{
+	struct kvm_mock_device *kmdev;
+
+	if (opened)
+		return -EBUSY;
+
+	kmdev = kzalloc(sizeof(*kmdev), GFP_KERNEL_ACCOUNT);
+	if (!kmdev)
+		return -ENOMEM;
+
+	kmdev->compound = DEFAULT_COMPOUND;
+	kmdev->bar_size = BAR_SIZE;
+	kmdev->order = get_order(kmdev->bar_size);
+	mutex_init(&kmdev->lock);
+	filp->private_data = kmdev;
+
+	opened = true;
+	return 0;
+}
+
+static int kvm_mock_device_fops_release(struct inode *inode, struct file *filp)
+{
+	struct kvm_mock_device *kmdev = filp->private_data;
+
+	if (kmdev->prepared)
+		__free_pages(kmdev->resource, kmdev->order);
+	mutex_destroy(&kmdev->lock);
+	kfree(kmdev->ref_array);
+	kfree(kmdev);
+	opened = false;
+	return 0;
+}
+
+static long kvm_mock_device_fops_unlocked_ioctl(struct file *filp,
+					unsigned int command,
+					unsigned long arg)
+{
+	struct kvm_mock_device *kmdev = filp->private_data;
+	int r;
+
+	switch (command) {
+	case KVM_MOCK_DEVICE_GET_BAR_SIZE: {
+		u64 bar_size;
+
+		bar_size = kmdev->bar_size;
+		r = put_user(bar_size, (u64 __user *)arg);
+		break;
+	}
+	case KVM_MOCK_DEVICE_PREPARE_RESOURCE: {
+		u32 compound;
+
+		r = get_user(compound, (u32 __user *)arg);
+		if (r)
+			return r;
+
+		kmdev->compound = compound;
+		r = kvm_mock_device_prepare_resource(kmdev);
+		break;
+
+	}
+	case KVM_MOCK_DEVICE_CHECK_BACKEND_REF: {
+		int inequal;
+
+		inequal = kvm_mock_device_check_resource_ref(kmdev);
+
+		if (inequal < 0)
+			return inequal;
+
+		r = put_user(inequal, (u32 __user *)arg);
+		break;
+	}
+	default:
+		r = -EOPNOTSUPP;
+	}
+
+	return r;
+}
+
+
+static const struct file_operations kvm_mock_device_fops = {
+	.open		= kvm_mock_device_fops_open,
+	.release	= kvm_mock_device_fops_release,
+	.mmap		= kvm_mock_device_fops_mmap,
+	.unlocked_ioctl = kvm_mock_device_fops_unlocked_ioctl,
+	.llseek		= default_llseek,
+	.owner		= THIS_MODULE,
+};
+
+
+static int __init kvm_mock_device_test_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&kvm_mock_dev.devt, 0, 1, "KVM-MOCK-DEVICE");
+	if (ret)
+		goto out;
+
+	cdev_init(&kvm_mock_dev.cdev, &kvm_mock_device_fops);
+	kvm_mock_dev.cdev.owner = THIS_MODULE;
+	device_initialize(&kvm_mock_dev.device);
+	kvm_mock_dev.device.devt =  MKDEV(MAJOR(kvm_mock_dev.devt), 0);
+	ret = dev_set_name(&kvm_mock_dev.device, "kvm_mock_device");
+	if (ret)
+		goto out;
+
+	ret = cdev_device_add(&kvm_mock_dev.cdev, &kvm_mock_dev.device);
+	if (ret)
+		goto out;
+
+out:
+	return ret;
+}
+
+static void __exit kvm_mock_device_test_exit(void)
+{
+	cdev_device_del(&kvm_mock_dev.cdev, &kvm_mock_dev.device);
+	unregister_chrdev_region(kvm_mock_dev.devt, 1);
+}
+
+module_init(kvm_mock_device_test_init);
+module_exit(kvm_mock_device_test_exit);
+MODULE_LICENSE("GPL");
diff --git a/lib/test_kvm_mock_device_uapi.h b/lib/test_kvm_mock_device_uapi.h
new file mode 100644
index 000000000000..227d0bf1d430
--- /dev/null
+++ b/lib/test_kvm_mock_device_uapi.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * This is a module to help test KVM guest access of KVM mock device's BAR,
+ * whose backend is mapped to pages.
+ */
+#ifndef _LIB_TEST_KVM_MOCK_DEVICE_UAPI_H
+#define _LIB_TEST_KVM_MOCK_DEVICE_UAPI_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define KVM_MOCK_DEVICE_GET_BAR_SIZE _IOR('M', 0x00, u64)
+#define KVM_MOCK_DEVICE_PREPARE_RESOURCE _IOWR('M', 0x01, u32)
+#define KVM_MOCK_DEVICE_CHECK_BACKEND_REF _IOWR('M', 0x02, u32)
+
+#endif /* _LIB_TEST_KVM_MOCK_DEVICE_UAPI_H */
-- 
2.17.1


