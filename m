Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA95EEF8C
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2019 23:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389275AbfKDWVy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Nov 2019 17:21:54 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11400 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389328AbfKDWVu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Nov 2019 17:21:50 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc0a4820001>; Mon, 04 Nov 2019 14:21:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Nov 2019 14:21:47 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Nov 2019 14:21:47 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Nov
 2019 22:21:46 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 4 Nov 2019 22:21:46 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dc0a47a0000>; Mon, 04 Nov 2019 14:21:46 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Shuah Khan" <shuah@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v4 2/2] mm/hmm/test: add self tests for HMM
Date:   Mon, 4 Nov 2019 14:21:41 -0800
Message-ID: <20191104222141.5173-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191104222141.5173-1-rcampbell@nvidia.com>
References: <20191104222141.5173-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572906114; bh=NoFKldfFJAvpJWGaxMgHls2vX1Pe8W2FTOZecp65QRQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=ghGbUQNZhGQeQgPF8qD/C/cklS/DGebiHyXAw8PeuS2jNBgCFib/plMekKy9othl8
         aTY2brUmW6tSj6Xbkq3RXyxsRXxLtQpB1f33oJZGsGwl00flxpexlPos+E3l0nWx65
         RtamYkmHouQ1uGV66+ThSXPmw9Psq5zBa//arPxs6TBwHLfxf2smKa0IA+AfP21+El
         SwVsG2aPumeYYV7Xc/glmi2mwb0hshKrwqFTOvcdtS4EkGbAdXNPAnEyHRT4vUrv4S
         iQv0cWCvzqJ3aL+16peOfaxCAREJnGuolAq7DbJWLiYJCGTUbm3L1y8cWLOTcHpi+T
         eLBjJ0VYlBRLg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add self tests for HMM.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
---
 MAINTAINERS                            |    3 +
 include/uapi/linux/test_hmm.h          |   59 ++
 lib/Kconfig.debug                      |   11 +
 lib/Makefile                           |    1 +
 lib/test_hmm.c                         | 1306 ++++++++++++++++++++++++
 tools/testing/selftests/vm/.gitignore  |    1 +
 tools/testing/selftests/vm/Makefile    |    3 +
 tools/testing/selftests/vm/config      |    2 +
 tools/testing/selftests/vm/hmm-tests.c | 1295 +++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests |   16 +
 tools/testing/selftests/vm/test_hmm.sh |   97 ++
 11 files changed, 2794 insertions(+)
 create mode 100644 include/uapi/linux/test_hmm.h
 create mode 100644 lib/test_hmm.c
 create mode 100644 tools/testing/selftests/vm/hmm-tests.c
 create mode 100755 tools/testing/selftests/vm/test_hmm.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index c6c34d04ce95..8d53e39df193 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7428,7 +7428,10 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/hmm*
 F:	include/linux/hmm*
+F:	include/uapi/linux/test_hmm*
 F:	Documentation/vm/hmm.rst
+F:	lib/test_hmm*
+F:	tools/testing/selftests/vm/*hmm*
=20
 HOST AP DRIVER
 M:	Jouni Malinen <j@w1.fi>
diff --git a/include/uapi/linux/test_hmm.h b/include/uapi/linux/test_hmm.h
new file mode 100644
index 000000000000..8c5f70c160bf
--- /dev/null
+++ b/include/uapi/linux/test_hmm.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * This is a module to test the HMM (Heterogeneous Memory Management) API
+ * of the kernel. It allows a userspace program to expose its entire addre=
ss
+ * space through the HMM test module device file.
+ */
+#ifndef _UAPI_LINUX_HMM_DMIRROR_H
+#define _UAPI_LINUX_HMM_DMIRROR_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/*
+ * Structure to pass to the HMM test driver to mimic a device accessing
+ * system memory and ZONE_DEVICE private memory through device page tables=
.
+ *
+ * @addr: (in) user address the device will read/write
+ * @ptr: (in) user address where device data is copied to/from
+ * @npages: (in) number of pages to read/write
+ * @cpages: (out) number of pages copied
+ * @faults: (out) number of device page faults seen
+ */
+struct hmm_dmirror_cmd {
+	__u64		addr;
+	__u64		ptr;
+	__u64		npages;
+	__u64		cpages;
+	__u64		faults;
+};
+
+/* Expose the address space of the calling process through hmm device file=
 */
+#define HMM_DMIRROR_READ		_IOWR('H', 0x00, struct hmm_dmirror_cmd)
+#define HMM_DMIRROR_WRITE		_IOWR('H', 0x01, struct hmm_dmirror_cmd)
+#define HMM_DMIRROR_MIGRATE		_IOWR('H', 0x02, struct hmm_dmirror_cmd)
+#define HMM_DMIRROR_SNAPSHOT		_IOWR('H', 0x03, struct hmm_dmirror_cmd)
+
+/*
+ * Values returned in hmm_dmirror_cmd.ptr for HMM_DMIRROR_SNAPSHOT.
+ * HMM_DMIRROR_PROT_ERROR: no valid mirror PTE for this page
+ * HMM_DMIRROR_PROT_NONE: unpopulated PTE or PTE with no access
+ * HMM_DMIRROR_PROT_READ: read-only PTE
+ * HMM_DMIRROR_PROT_WRITE: read/write PTE
+ * HMM_DMIRROR_PROT_ZERO: special read-only zero page
+ * HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL: Migrated device private page on the
+ *					device the ioctl() is made
+ * HMM_DMIRROR_PROT_DEV_PRIVATE_REMOTE: Migrated device private page on so=
me
+ *					other device
+ */
+enum {
+	HMM_DMIRROR_PROT_ERROR			=3D 0xFF,
+	HMM_DMIRROR_PROT_NONE			=3D 0x00,
+	HMM_DMIRROR_PROT_READ			=3D 0x01,
+	HMM_DMIRROR_PROT_WRITE			=3D 0x02,
+	HMM_DMIRROR_PROT_ZERO			=3D 0x10,
+	HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL	=3D 0x20,
+	HMM_DMIRROR_PROT_DEV_PRIVATE_REMOTE	=3D 0x30,
+};
+
+#endif /* _UAPI_LINUX_HMM_DMIRROR_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 93d97f9b0157..0354379d6cd0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2057,6 +2057,17 @@ config TEST_MEMINIT
=20
 	  If unsure, say N.
=20
+config TEST_HMM
+	tristate "Test HMM (Heterogeneous Memory Management)"
+	depends on HMM_MIRROR
+	depends on DEVICE_PRIVATE
+	help
+	  This is a pseudo device driver solely for testing HMM.
+	  Say M here if you want to build the HMM test module.
+	  Doing so will allow you to run tools/testing/selftest/vm/hmm-tests.
+
+	  If unsure, say N.
+
 endif # RUNTIME_TESTING_MENU
=20
 config MEMTEST
diff --git a/lib/Makefile b/lib/Makefile
index c5892807e06f..6a9a0e564866 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_TEST_OBJAGG) +=3D test_objagg.o
 obj-$(CONFIG_TEST_STACKINIT) +=3D test_stackinit.o
 obj-$(CONFIG_TEST_BLACKHOLE_DEV) +=3D test_blackhole_dev.o
 obj-$(CONFIG_TEST_MEMINIT) +=3D test_meminit.o
+obj-$(CONFIG_TEST_HMM) +=3D test_hmm.o
=20
 obj-$(CONFIG_TEST_LIVEPATCH) +=3D livepatch/
=20
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
new file mode 100644
index 000000000000..9887a804d75a
--- /dev/null
+++ b/lib/test_hmm.c
@@ -0,0 +1,1306 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This is a module to test the HMM (Heterogeneous Memory Management)
+ * mirror and zone device private memory migration APIs of the kernel.
+ * Userspace programs can register with the driver to mirror their own add=
ress
+ * space and can use the device to read/write any valid virtual address.
+ *
+ * In some ways it can also serve as an example driver for people wanting =
to use
+ * HMM inside their own device driver.
+ */
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/rwsem.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/highmem.h>
+#include <linux/delay.h>
+#include <linux/pagemap.h>
+#include <linux/hmm.h>
+#include <linux/vmalloc.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/sched/mm.h>
+#include <linux/platform_device.h>
+
+#include <uapi/linux/test_hmm.h>
+
+#define DMIRROR_NDEVICES		2
+#define DMIRROR_RANGE_FAULT_TIMEOUT	1000
+#define DEVMEM_CHUNK_SIZE		(256 * 1024 * 1024U)
+#define DEVMEM_CHUNKS_RESERVE		16
+
+static const struct dev_pagemap_ops dmirror_devmem_ops;
+static dev_t dmirror_dev;
+static struct page *dmirror_zero_page;
+
+struct dmirror_device;
+
+struct dmirror_bounce {
+	void			*ptr;
+	unsigned long		size;
+	unsigned long		addr;
+	unsigned long		cpages;
+};
+
+#define DPT_SHIFT PAGE_SHIFT
+#define DPT_VALID (1UL << 0)
+#define DPT_WRITE (1UL << 1)
+#define DPT_DPAGE (1UL << 2)
+
+#define DPT_XA_TAG_WRITE 3UL
+
+static const uint64_t dmirror_hmm_flags[HMM_PFN_FLAG_MAX] =3D {
+	[HMM_PFN_VALID] =3D DPT_VALID,
+	[HMM_PFN_WRITE] =3D DPT_WRITE,
+	[HMM_PFN_DEVICE_PRIVATE] =3D DPT_DPAGE,
+};
+
+static const uint64_t dmirror_hmm_values[HMM_PFN_VALUE_MAX] =3D {
+	[HMM_PFN_NONE]    =3D 0,
+	[HMM_PFN_ERROR]   =3D 0x10,
+	[HMM_PFN_SPECIAL] =3D 0x10,
+};
+
+/*
+ * Data attached to the open device file.
+ * Note that it might be shared after a fork().
+ */
+struct dmirror {
+	struct mmu_notifier     notifier;
+	struct dmirror_device	*mdevice;
+	struct xarray		pt;
+	struct mutex		mutex;
+};
+
+struct dmirror_notifier {
+	struct mmu_range_notifier notifier;
+	struct dmirror		*dmirror;
+};
+
+/*
+ * ZONE_DEVICE pages for migration and simulating device memory.
+ */
+struct dmirror_chunk {
+	struct dev_pagemap	pagemap;
+	struct dmirror_device	*mdevice;
+};
+
+/*
+ * Per device data.
+ */
+struct dmirror_device {
+	struct cdev		cdevice;
+	struct hmm_devmem	*devmem;
+
+	unsigned int		devmem_capacity;
+	unsigned int		devmem_count;
+	struct dmirror_chunk	**devmem_chunks;
+	struct mutex		devmem_lock;	/* protects the above */
+
+	unsigned long		calloc;
+	unsigned long		cfree;
+	struct page		*free_pages;
+	spinlock_t		lock;		/* protects the above */
+};
+
+static struct dmirror_device dmirror_devices[DMIRROR_NDEVICES];
+
+static int dmirror_bounce_init(struct dmirror_bounce *bounce,
+			       unsigned long addr,
+			       unsigned long size)
+{
+	bounce->addr =3D addr;
+	bounce->size =3D size;
+	bounce->cpages =3D 0;
+	bounce->ptr =3D vmalloc(size);
+	if (!bounce->ptr)
+		return -ENOMEM;
+	return 0;
+}
+
+static int dmirror_bounce_copy_from(struct dmirror_bounce *bounce,
+				    unsigned long addr)
+{
+	unsigned long end =3D addr + bounce->size;
+	char __user *uptr =3D (void __user *)addr;
+	void *ptr =3D bounce->ptr;
+
+	for (; addr < end; addr +=3D PAGE_SIZE, ptr +=3D PAGE_SIZE,
+					      uptr +=3D PAGE_SIZE) {
+		int ret;
+
+		ret =3D copy_from_user(ptr, uptr, PAGE_SIZE);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int dmirror_bounce_copy_to(struct dmirror_bounce *bounce,
+				  unsigned long addr)
+{
+	unsigned long end =3D addr + bounce->size;
+	char __user *uptr =3D (void __user *)addr;
+	void *ptr =3D bounce->ptr;
+
+	for (; addr < end; addr +=3D PAGE_SIZE, ptr +=3D PAGE_SIZE,
+					      uptr +=3D PAGE_SIZE) {
+		int ret;
+
+		ret =3D copy_to_user(uptr, ptr, PAGE_SIZE);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void dmirror_bounce_fini(struct dmirror_bounce *bounce)
+{
+	vfree(bounce->ptr);
+}
+
+static void dmirror_do_update(struct dmirror *dmirror, unsigned long start=
,
+			      unsigned long end)
+{
+	unsigned long pfn;
+
+	/*
+	 * The XArray doesn't hold references to pages since it relies on
+	 * the mmu notifier to clear pointers when they become stale.
+	 * Therefore, it is OK to just clear the entry.
+	 */
+	for (pfn =3D start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++)
+		xa_store(&dmirror->pt, pfn, NULL, GFP_KERNEL);
+}
+
+static int dmirror_invalidate_range_start(struct mmu_notifier *mn,
+				const struct mmu_notifier_range *update)
+{
+	struct dmirror *dmirror =3D container_of(mn, struct dmirror, notifier);
+
+	if (mmu_notifier_range_blockable(update))
+		mutex_lock(&dmirror->mutex);
+	else if (!mutex_trylock(&dmirror->mutex))
+		return -EAGAIN;
+
+	dmirror_do_update(dmirror, update->start, update->end);
+	mutex_unlock(&dmirror->mutex);
+	return 0;
+}
+
+static void dmirror_free_notifier(struct mmu_notifier *mn)
+{
+	struct dmirror *dmirror =3D container_of(mn, struct dmirror, notifier);
+
+	xa_destroy(&dmirror->pt);
+	kfree(dmirror);
+}
+
+static const struct mmu_notifier_ops dmirror_mn_ops =3D {
+	.invalidate_range_start =3D dmirror_invalidate_range_start,
+	.free_notifier =3D dmirror_free_notifier,
+};
+
+/*
+ * dmirror_new() - allocate and initialize dmirror struct.
+ *
+ * @mdevice: The device this mirror is associated with.
+ * @filp: The active device file descriptor this mirror is associated with=
.
+ */
+static struct dmirror *dmirror_new(struct dmirror_device *mdevice)
+{
+	struct dmirror *dmirror;
+	int ret;
+
+	/* Mirror this process address space */
+	dmirror =3D kzalloc(sizeof(*dmirror), GFP_KERNEL);
+	if (dmirror =3D=3D NULL)
+		goto err;
+
+	dmirror->mdevice =3D mdevice;
+	mutex_init(&dmirror->mutex);
+	xa_init(&dmirror->pt);
+
+	dmirror->notifier.ops =3D &dmirror_mn_ops;
+	ret =3D mmu_notifier_register(&dmirror->notifier, current->mm);
+	if (ret)
+		goto err_free;
+
+	return dmirror;
+
+err_free:
+	kfree(dmirror);
+err:
+	return NULL;
+}
+
+static int dmirror_fops_open(struct inode *inode, struct file *filp)
+{
+	struct cdev *cdev =3D inode->i_cdev;
+	struct dmirror_device *mdevice;
+	struct dmirror *dmirror;
+
+	/* No exclusive opens. */
+	if (filp->f_flags & O_EXCL)
+		return -EINVAL;
+
+	mdevice =3D container_of(cdev, struct dmirror_device, cdevice);
+	dmirror =3D dmirror_new(mdevice);
+	if (!dmirror)
+		return -ENOMEM;
+
+	/* Only the first open registers the address space. */
+	mutex_lock(&mdevice->devmem_lock);
+	if (filp->private_data)
+		goto err_busy;
+	filp->private_data =3D dmirror;
+	mutex_unlock(&mdevice->devmem_lock);
+
+	return 0;
+
+err_busy:
+	mutex_unlock(&mdevice->devmem_lock);
+	mmu_notifier_put(&dmirror->notifier);
+	return -EBUSY;
+}
+
+static int dmirror_fops_release(struct inode *inode, struct file *filp)
+{
+	struct dmirror *dmirror =3D filp->private_data;
+
+	if (!dmirror)
+		return 0;
+
+	filp->private_data =3D NULL;
+	mmu_notifier_put(&dmirror->notifier);
+
+	return 0;
+}
+
+static inline struct dmirror_device *dmirror_page_to_device(struct page *p=
age)
+
+{
+	struct dmirror_chunk *devmem;
+
+	devmem =3D container_of(page->pgmap, struct dmirror_chunk, pagemap);
+	return devmem->mdevice;
+}
+
+static bool dmirror_device_is_mine(struct dmirror_device *mdevice,
+				   struct page *page)
+{
+	if (!is_zone_device_page(page))
+		return false;
+	return page->pgmap->ops =3D=3D &dmirror_devmem_ops &&
+		dmirror_page_to_device(page) =3D=3D mdevice;
+}
+
+static int dmirror_do_fault(struct dmirror *dmirror, unsigned long start,
+			    unsigned long end, struct hmm_range *range)
+{
+	unsigned long idx =3D (start - range->start) >> PAGE_SHIFT;
+	uint64_t *pfns =3D range->pfns + idx;
+	unsigned long pfn;
+
+	for (pfn =3D start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++,
+								   pfns++) {
+		struct page *page;
+		void *entry;
+
+		/*
+		 * HMM_PFN_ERROR is returned if it is accessing invalid memory
+		 * either because of memory error (hardware detected memory
+		 * corruption) or more likely because of truncate on mmap
+		 * file.
+		 */
+		if (*pfns =3D=3D range->values[HMM_PFN_ERROR])
+			return -EFAULT;
+		if (!(*pfns & range->flags[HMM_PFN_VALID]))
+			return -EFAULT;
+		page =3D hmm_device_entry_to_page(range, *pfns);
+		/* We asked for pages to be populated but check anyway. */
+		if (!page)
+			return -EFAULT;
+		if (is_zone_device_page(page)) {
+			/*
+			 * TODO: need a way to ask HMM to fault foreign zone
+			 * device private pages.
+			 */
+			if (!dmirror_device_is_mine(dmirror->mdevice, page))
+				continue;
+		}
+		entry =3D page;
+		if (*pfns & range->flags[HMM_PFN_WRITE])
+			entry =3D xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
+		else if (range->default_flags & range->flags[HMM_PFN_WRITE])
+			return -EFAULT;
+		entry =3D xa_store(&dmirror->pt, pfn, entry, GFP_KERNEL);
+		if (xa_is_err(entry))
+			return xa_err(entry);
+	}
+
+	return 0;
+}
+
+static bool dmirror_range_invalidate(struct mmu_range_notifier *mrn,
+				const struct mmu_notifier_range *range,
+				unsigned long cur_seq)
+{
+	struct dmirror_notifier *dn =3D
+		container_of(mrn, struct dmirror_notifier, notifier);
+
+	/*
+	 * Serializes the update to mrn->invalidate_seq done by caller and
+	 * prevents invalidation from progressing while a device's page table
+	 * is being updated.
+	 */
+	if (mmu_notifier_range_blockable(range))
+		mutex_lock(&dn->dmirror->mutex);
+	else if (!mutex_trylock(&dn->dmirror->mutex))
+		return false;
+	mmu_range_set_seq(mrn, cur_seq);
+	mutex_unlock(&dn->dmirror->mutex);
+	return true;
+}
+
+static const struct mmu_range_notifier_ops dmirror_mrn_ops =3D {
+	.invalidate =3D dmirror_range_invalidate,
+};
+
+static int dmirror_range_fault(struct dmirror *dmirror,
+				struct hmm_range *range)
+{
+	struct mm_struct *mm =3D dmirror->notifier.mm;
+	struct dmirror_notifier notifier;
+	unsigned long timeout =3D
+		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	int ret;
+
+	/* Since the mm is for the mirrored process, get a reference first. */
+	if (!mmget_not_zero(mm))
+		return 0;
+
+	notifier.dmirror =3D dmirror;
+	notifier.notifier.ops =3D &dmirror_mrn_ops;
+	range->notifier =3D &notifier.notifier;
+
+	ret =3D mmu_range_notifier_insert(&notifier.notifier, range->start,
+					range->end - range->start, mm);
+	if (ret)
+		return ret;
+
+	while (true) {
+		long count;
+
+		if (time_after(jiffies, timeout)) {
+			ret =3D -EBUSY;
+			goto out;
+		}
+
+		range->notifier_seq =3D mmu_range_read_begin(range->notifier);
+
+		down_read(&mm->mmap_sem);
+		count =3D hmm_range_fault(range, 0);
+		up_read(&mm->mmap_sem);
+		if (count <=3D 0) {
+			if (count =3D=3D 0 || count =3D=3D -EBUSY)
+				continue;
+			ret =3D count;
+			goto out;
+		}
+
+		mutex_lock(&dmirror->mutex);
+		if (mmu_range_read_retry(range->notifier,
+					 range->notifier_seq)) {
+			mutex_unlock(&dmirror->mutex);
+			continue;
+		}
+		break;
+	}
+
+	ret =3D dmirror_do_fault(dmirror, range->start, range->end, range);
+
+	mutex_unlock(&dmirror->mutex);
+out:
+	mmu_range_notifier_remove(&notifier.notifier);
+	mmput(mm);
+	return ret;
+}
+
+static int dmirror_fault(struct dmirror *dmirror, unsigned long start,
+			 unsigned long end, bool write)
+{
+	struct mm_struct *mm =3D dmirror->notifier.mm;
+	unsigned long addr;
+	unsigned long next;
+	uint64_t pfns[64];
+	struct hmm_range range =3D {
+		.pfns =3D pfns,
+		.flags =3D dmirror_hmm_flags,
+		.values =3D dmirror_hmm_values,
+		.pfn_shift =3D DPT_SHIFT,
+		.pfn_flags_mask =3D ~(dmirror_hmm_flags[HMM_PFN_VALID] |
+				    dmirror_hmm_flags[HMM_PFN_WRITE]),
+		.default_flags =3D dmirror_hmm_flags[HMM_PFN_VALID] |
+				(write ? dmirror_hmm_flags[HMM_PFN_WRITE] : 0),
+	};
+	int ret =3D 0;
+
+	/* Since the mm is for the mirrored process, get a reference first. */
+	if (!mmget_not_zero(mm))
+		return 0;
+
+	for (addr =3D start; addr < end; addr =3D next) {
+		next =3D min(addr + (ARRAY_SIZE(pfns) << PAGE_SHIFT), end);
+		range.start =3D addr;
+		range.end =3D next;
+
+		ret =3D dmirror_range_fault(dmirror, &range);
+		if (ret)
+			break;
+	}
+	mmput(mm);
+
+	return ret;
+}
+
+static int dmirror_do_read(struct dmirror *dmirror, unsigned long start,
+			   unsigned long end, struct dmirror_bounce *bounce)
+{
+	unsigned long pfn;
+	void *ptr;
+
+	ptr =3D bounce->ptr + ((start - bounce->addr) & PAGE_MASK);
+
+	for (pfn =3D start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++) {
+		void *entry;
+		struct page *page;
+		void *tmp;
+
+		entry =3D xa_load(&dmirror->pt, pfn);
+		page =3D xa_untag_pointer(entry);
+		if (!page)
+			return -ENOENT;
+
+		tmp =3D kmap(page);
+		memcpy(ptr, tmp, PAGE_SIZE);
+		kunmap(page);
+
+		ptr +=3D PAGE_SIZE;
+		bounce->cpages++;
+	}
+
+	return 0;
+}
+
+static int dmirror_read(struct dmirror *dmirror, struct hmm_dmirror_cmd *c=
md)
+{
+	struct dmirror_bounce bounce;
+	unsigned long start, end;
+	unsigned long size =3D cmd->npages << PAGE_SHIFT;
+	int ret;
+
+	start =3D cmd->addr;
+	end =3D start + size;
+	if (end < start)
+		return -EINVAL;
+
+	ret =3D dmirror_bounce_init(&bounce, start, size);
+	if (ret)
+		return ret;
+
+again:
+	mutex_lock(&dmirror->mutex);
+	ret =3D dmirror_do_read(dmirror, start, end, &bounce);
+	mutex_unlock(&dmirror->mutex);
+	if (ret =3D=3D 0)
+		ret =3D dmirror_bounce_copy_to(&bounce, cmd->ptr);
+	else if (ret =3D=3D -ENOENT) {
+		start =3D cmd->addr + (bounce.cpages << PAGE_SHIFT);
+		ret =3D dmirror_fault(dmirror, start, end, false);
+		if (ret =3D=3D 0) {
+			cmd->faults++;
+			goto again;
+		}
+	}
+
+	cmd->cpages =3D bounce.cpages;
+	dmirror_bounce_fini(&bounce);
+	return ret;
+}
+
+static int dmirror_do_write(struct dmirror *dmirror, unsigned long start,
+			    unsigned long end, struct dmirror_bounce *bounce)
+{
+	unsigned long pfn;
+	void *ptr;
+
+	ptr =3D bounce->ptr + ((start - bounce->addr) & PAGE_MASK);
+
+	for (pfn =3D start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++) {
+		void *entry;
+		struct page *page;
+		void *tmp;
+
+		entry =3D xa_load(&dmirror->pt, pfn);
+		page =3D xa_untag_pointer(entry);
+		if (!page || xa_pointer_tag(entry) !=3D DPT_XA_TAG_WRITE)
+			return -ENOENT;
+
+		tmp =3D kmap(page);
+		memcpy(tmp, ptr, PAGE_SIZE);
+		kunmap(page);
+
+		ptr +=3D PAGE_SIZE;
+		bounce->cpages++;
+	}
+
+	return 0;
+}
+
+static int dmirror_write(struct dmirror *dmirror, struct hmm_dmirror_cmd *=
cmd)
+{
+	struct dmirror_bounce bounce;
+	unsigned long start, end;
+	unsigned long size =3D cmd->npages << PAGE_SHIFT;
+	int ret;
+
+	start =3D cmd->addr;
+	end =3D start + size;
+	if (end < start)
+		return -EINVAL;
+
+	ret =3D dmirror_bounce_init(&bounce, start, size);
+	if (ret)
+		return ret;
+	ret =3D dmirror_bounce_copy_from(&bounce, cmd->ptr);
+	if (ret)
+		return ret;
+
+again:
+	mutex_lock(&dmirror->mutex);
+	ret =3D dmirror_do_write(dmirror, start, end, &bounce);
+	mutex_unlock(&dmirror->mutex);
+	if (ret =3D=3D -ENOENT) {
+		start =3D cmd->addr + (bounce.cpages << PAGE_SHIFT);
+		ret =3D dmirror_fault(dmirror, start, end, true);
+		if (ret =3D=3D 0) {
+			cmd->faults++;
+			goto again;
+		}
+	}
+
+	cmd->cpages =3D bounce.cpages;
+	dmirror_bounce_fini(&bounce);
+	return ret;
+}
+
+static bool dmirror_allocate_chunk(struct dmirror_device *mdevice,
+				   struct page **ppage)
+{
+	struct dmirror_chunk *devmem;
+	struct resource *res;
+	unsigned long pfn;
+	unsigned long pfn_first;
+	unsigned long pfn_last;
+	void *ptr;
+
+	mutex_lock(&mdevice->devmem_lock);
+
+	if (mdevice->devmem_count =3D=3D mdevice->devmem_capacity) {
+		struct dmirror_chunk **new_chunks;
+		unsigned int new_capacity;
+
+		new_capacity =3D mdevice->devmem_capacity +
+				DEVMEM_CHUNKS_RESERVE;
+		new_chunks =3D krealloc(mdevice->devmem_chunks,
+				sizeof(new_chunks[0]) * new_capacity,
+				GFP_KERNEL);
+		if (!new_chunks)
+			goto err;
+		mdevice->devmem_capacity =3D new_capacity;
+		mdevice->devmem_chunks =3D new_chunks;
+	}
+
+	res =3D request_free_mem_region(&iomem_resource, DEVMEM_CHUNK_SIZE,
+					"hmm_dmirror");
+	if (IS_ERR(res))
+		goto err;
+
+	devmem =3D kzalloc(sizeof(*devmem), GFP_KERNEL);
+	if (!devmem)
+		goto err;
+
+	devmem->pagemap.type =3D MEMORY_DEVICE_PRIVATE;
+	devmem->pagemap.res =3D *res;
+	devmem->pagemap.ops =3D &dmirror_devmem_ops;
+
+	/* Numa node ID doesn't matter for ZONE_DEVICE private pages. */
+	ptr =3D memremap_pages(&devmem->pagemap, 0);
+	if (IS_ERR(ptr))
+		goto err_free;
+
+	devmem->mdevice =3D mdevice;
+	pfn_first =3D devmem->pagemap.res.start >> PAGE_SHIFT;
+	pfn_last =3D pfn_first +
+		(resource_size(&devmem->pagemap.res) >> PAGE_SHIFT);
+	mdevice->devmem_chunks[mdevice->devmem_count++] =3D devmem;
+
+	mutex_unlock(&mdevice->devmem_lock);
+
+	pr_info("added new %u MB chunk (total %u chunks, %u MB) PFNs [0x%lx 0x%lx=
)\n",
+		DEVMEM_CHUNK_SIZE / (1024 * 1024),
+		mdevice->devmem_count,
+		mdevice->devmem_count * (DEVMEM_CHUNK_SIZE / (1024 * 1024)),
+		pfn_first, pfn_last);
+
+	spin_lock(&mdevice->lock);
+	for (pfn =3D pfn_first; pfn < pfn_last; pfn++) {
+		struct page *page =3D pfn_to_page(pfn);
+
+		page->zone_device_data =3D mdevice->free_pages;
+		mdevice->free_pages =3D page;
+	}
+	if (ppage) {
+		*ppage =3D mdevice->free_pages;
+		mdevice->free_pages =3D (*ppage)->zone_device_data;
+		mdevice->calloc++;
+	}
+	spin_unlock(&mdevice->lock);
+
+	return true;
+
+err_free:
+	kfree(devmem);
+err:
+	mutex_unlock(&mdevice->devmem_lock);
+	return false;
+}
+
+static struct page *dmirror_devmem_alloc_page(struct dmirror_device *mdevi=
ce)
+{
+	struct page *dpage =3D NULL;
+	struct page *rpage;
+
+	/*
+	 * This is a fake device so we alloc real system memory to store
+	 * our device memory.
+	 */
+	rpage =3D alloc_page(GFP_HIGHUSER);
+	if (!rpage)
+		return NULL;
+
+	spin_lock(&mdevice->lock);
+
+	if (mdevice->free_pages) {
+		dpage =3D mdevice->free_pages;
+		mdevice->free_pages =3D dpage->zone_device_data;
+		mdevice->calloc++;
+		spin_unlock(&mdevice->lock);
+	} else {
+		spin_unlock(&mdevice->lock);
+		if (!dmirror_allocate_chunk(mdevice, &dpage))
+			goto error;
+	}
+
+	dpage->zone_device_data =3D rpage;
+	get_page(dpage);
+	lock_page(dpage);
+	return dpage;
+
+error:
+	__free_page(rpage);
+	return NULL;
+}
+
+static void dmirror_migrate_alloc_and_copy(struct migrate_vma *args,
+					   struct dmirror *dmirror)
+{
+	struct dmirror_device *mdevice =3D dmirror->mdevice;
+	const unsigned long *src =3D args->src;
+	unsigned long *dst =3D args->dst;
+	unsigned long addr;
+
+	for (addr =3D args->start; addr < args->end; addr +=3D PAGE_SIZE,
+						   src++, dst++) {
+		struct page *spage;
+		struct page *dpage;
+		struct page *rpage;
+
+		if (!(*src & MIGRATE_PFN_MIGRATE))
+			continue;
+
+		/*
+		 * Note that spage might be NULL which is OK since it is an
+		 * unallocated pte_none() or read-only zero page.
+		 */
+		spage =3D migrate_pfn_to_page(*src);
+
+		/*
+		 * Don't migrate device private pages from our own driver or
+		 * others. For our own we would do a device private memory copy
+		 * not a migration and for others, we would need to fault the
+		 * other device's page into system memory first.
+		 */
+		if (spage && is_zone_device_page(spage))
+			continue;
+
+		dpage =3D dmirror_devmem_alloc_page(mdevice);
+		if (!dpage)
+			continue;
+
+		rpage =3D dpage->zone_device_data;
+		if (spage)
+			copy_highpage(rpage, spage);
+		else
+			clear_highpage(rpage);
+
+		/*
+		 * Normally, a device would use the page->zone_device_data to
+		 * point to the mirror but here we use it to hold the page for
+		 * the simulated device memory and that page holds the pointer
+		 * to the mirror.
+		 */
+		rpage->zone_device_data =3D dmirror;
+
+		*dst =3D migrate_pfn(page_to_pfn(dpage)) |
+			    MIGRATE_PFN_LOCKED;
+		if ((*src & MIGRATE_PFN_WRITE) ||
+		    (!spage && args->vma->vm_flags & VM_WRITE))
+			*dst |=3D MIGRATE_PFN_WRITE;
+	}
+}
+
+struct dmirror_migrate {
+	struct hmm_dmirror_cmd		*cmd;
+	const unsigned long		*src;
+	const unsigned long		*dst;
+	unsigned long			start;
+};
+
+static int dmirror_do_migrate(struct dmirror *dmirror, unsigned long start=
,
+			      unsigned long end,
+			      struct dmirror_migrate *migrate)
+{
+	unsigned long idx =3D (start - migrate->start) >> PAGE_SHIFT;
+	const unsigned long *src =3D migrate->src + idx;
+	const unsigned long *dst =3D migrate->dst + idx;
+	unsigned long pfn;
+
+	for (pfn =3D start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++,
+								src++, dst++) {
+		struct page *page;
+		void *entry;
+
+		if (!(*src & MIGRATE_PFN_MIGRATE))
+			continue;
+
+		page =3D migrate_pfn_to_page(*dst);
+		if (!page)
+			continue;
+
+		/*
+		 * Store the page that holds the data so the page table
+		 * doesn't have to deal with ZONE_DEVICE private pages.
+		 */
+		entry =3D page->zone_device_data;
+		if (*dst & MIGRATE_PFN_WRITE)
+			entry =3D xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
+		entry =3D xa_store(&dmirror->pt, pfn, entry, GFP_KERNEL);
+		if (xa_is_err(entry))
+			return xa_err(entry);
+	}
+
+	return 0;
+}
+
+static void dmirror_migrate_finalize_and_map(struct migrate_vma *args,
+					     struct dmirror *dmirror,
+					     struct hmm_dmirror_cmd *cmd)
+{
+	struct dmirror_migrate migrate;
+
+	migrate.cmd =3D cmd;
+	migrate.src =3D args->src;
+	migrate.dst =3D args->dst;
+	migrate.start =3D args->start;
+
+	/* Map the migrated pages into the device's page tables. */
+	mutex_lock(&dmirror->mutex);
+	dmirror_do_migrate(dmirror, args->start, args->end, &migrate);
+	mutex_unlock(&dmirror->mutex);
+}
+
+static int dmirror_migrate(struct dmirror *dmirror,
+			   struct hmm_dmirror_cmd *cmd)
+{
+	unsigned long start, end, addr;
+	unsigned long size =3D cmd->npages << PAGE_SHIFT;
+	struct mm_struct *mm =3D dmirror->notifier.mm;
+	struct vm_area_struct *vma;
+	unsigned long src_pfns[64];
+	unsigned long dst_pfns[64];
+	struct dmirror_bounce bounce;
+	struct migrate_vma args;
+	unsigned long next;
+	int ret;
+
+	start =3D cmd->addr;
+	end =3D start + size;
+	if (end < start)
+		return -EINVAL;
+
+	/* Since the mm is for the mirrored process, get a reference first. */
+	if (!mmget_not_zero(mm))
+		return -EINVAL;
+
+	down_read(&mm->mmap_sem);
+	for (addr =3D start; addr < end; addr =3D next) {
+		vma =3D find_vma(mm, addr);
+		if (!vma || addr < vma->vm_start) {
+			ret =3D -EINVAL;
+			goto out;
+		}
+		next =3D min(end, addr + (ARRAY_SIZE(src_pfns) << PAGE_SHIFT));
+		if (next > vma->vm_end)
+			next =3D vma->vm_end;
+
+		args.vma =3D vma;
+		args.src =3D src_pfns;
+		args.dst =3D dst_pfns;
+		args.start =3D addr;
+		args.end =3D next;
+		ret =3D migrate_vma_setup(&args);
+		if (ret)
+			goto out;
+
+		dmirror_migrate_alloc_and_copy(&args, dmirror);
+		migrate_vma_pages(&args);
+		dmirror_migrate_finalize_and_map(&args, dmirror, cmd);
+		migrate_vma_finalize(&args);
+	}
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+
+	/* Return the migrated data for verification. */
+	ret =3D dmirror_bounce_init(&bounce, start, size);
+	if (ret)
+		return ret;
+	mutex_lock(&dmirror->mutex);
+	ret =3D dmirror_do_read(dmirror, start, end, &bounce);
+	mutex_unlock(&dmirror->mutex);
+	if (ret =3D=3D 0)
+		ret =3D dmirror_bounce_copy_to(&bounce, cmd->ptr);
+	cmd->cpages =3D bounce.cpages;
+	dmirror_bounce_fini(&bounce);
+	return ret;
+
+out:
+	up_read(&mm->mmap_sem);
+	return ret;
+}
+
+static void dmirror_mkentry(struct dmirror *dmirror, struct hmm_range *ran=
ge,
+			    unsigned char *perm, uint64_t entry)
+{
+	struct page *page;
+
+	if (entry =3D=3D range->values[HMM_PFN_ERROR]) {
+		*perm =3D HMM_DMIRROR_PROT_ERROR;
+		return;
+	}
+	page =3D hmm_device_entry_to_page(range, entry);
+	if (!page) {
+		*perm =3D HMM_DMIRROR_PROT_NONE;
+		return;
+	}
+	if (entry & range->flags[HMM_PFN_DEVICE_PRIVATE]) {
+		/* Is the page migrated to this device or some other? */
+		if (dmirror->mdevice =3D=3D dmirror_page_to_device(page))
+			*perm =3D HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL;
+		else
+			*perm =3D HMM_DMIRROR_PROT_DEV_PRIVATE_REMOTE;
+	} else if (is_zero_pfn(page_to_pfn(page)))
+		*perm =3D HMM_DMIRROR_PROT_ZERO;
+	else
+		*perm =3D HMM_DMIRROR_PROT_NONE;
+	if (entry & range->flags[HMM_PFN_WRITE])
+		*perm |=3D HMM_DMIRROR_PROT_WRITE;
+	else
+		*perm |=3D HMM_DMIRROR_PROT_READ;
+}
+
+static int dmirror_range_snapshot(struct dmirror *dmirror,
+				  struct hmm_range *range,
+				  unsigned char *perm)
+{
+	struct mm_struct *mm =3D dmirror->notifier.mm;
+	struct dmirror_notifier notifier;
+	unsigned long timeout =3D
+		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	unsigned long i;
+	unsigned long n;
+	int ret;
+
+	/* Since the mm is for the mirrored process, get a reference first. */
+	if (!mmget_not_zero(mm))
+		return 0;
+
+	notifier.dmirror =3D dmirror;
+	notifier.notifier.ops =3D &dmirror_mrn_ops;
+	range->notifier =3D &notifier.notifier;
+
+	ret =3D mmu_range_notifier_insert(&notifier.notifier, range->start,
+					range->end - range->start, mm);
+	if (ret)
+		return ret;
+
+	while (true) {
+		long count;
+
+		if (time_after(jiffies, timeout)) {
+			ret =3D -EBUSY;
+			goto out;
+		}
+
+		range->notifier_seq =3D mmu_range_read_begin(range->notifier);
+		down_read(&mm->mmap_sem);
+		count =3D hmm_range_fault(range, HMM_FAULT_SNAPSHOT);
+		up_read(&mm->mmap_sem);
+		if (count <=3D 0) {
+			if (count =3D=3D 0 || count =3D=3D -EBUSY)
+				continue;
+			ret =3D count;
+			goto out;
+		}
+
+		mutex_lock(&dmirror->mutex);
+		if (mmu_range_read_retry(range->notifier,
+					 range->notifier_seq)) {
+			mutex_unlock(&dmirror->mutex);
+			continue;
+		}
+		break;
+	}
+
+	n =3D (range->end - range->start) >> PAGE_SHIFT;
+	for (i =3D 0; i < n; i++)
+		dmirror_mkentry(dmirror, range, perm + i, range->pfns[i]);
+
+	mutex_unlock(&dmirror->mutex);
+out:
+	mmu_range_notifier_remove(&notifier.notifier);
+	mmput(mm);
+	return ret;
+}
+
+static int dmirror_snapshot(struct dmirror *dmirror,
+			    struct hmm_dmirror_cmd *cmd)
+{
+	struct mm_struct *mm =3D dmirror->notifier.mm;
+	unsigned long start, end;
+	unsigned long size =3D cmd->npages << PAGE_SHIFT;
+	unsigned long addr;
+	unsigned long next;
+	uint64_t pfns[64];
+	unsigned char perm[64];
+	char __user *uptr;
+	struct hmm_range range =3D {
+		.pfns =3D pfns,
+		.flags =3D dmirror_hmm_flags,
+		.values =3D dmirror_hmm_values,
+		.pfn_shift =3D DPT_SHIFT,
+		.pfn_flags_mask =3D ~0ULL,
+	};
+	int ret =3D 0;
+
+	start =3D cmd->addr;
+	end =3D start + size;
+	uptr =3D (void __user *)cmd->ptr;
+
+	/* Since the mm is for the mirrored process, get a reference first. */
+	if (!mmget_not_zero(mm))
+		return -EINVAL;
+
+	for (addr =3D start; addr < end; addr =3D next) {
+		unsigned long n;
+
+		next =3D min(addr + (ARRAY_SIZE(pfns) << PAGE_SHIFT), end);
+		range.start =3D addr;
+		range.end =3D next;
+
+		ret =3D dmirror_range_snapshot(dmirror, &range, perm);
+		if (ret)
+			break;
+
+		n =3D (range.end - range.start) >> PAGE_SHIFT;
+		ret =3D copy_to_user(uptr, perm, n);
+		if (ret)
+			break;
+
+		cmd->cpages +=3D n;
+		uptr +=3D n;
+	}
+	mmput(mm);
+
+	return ret;
+}
+
+static long dmirror_fops_unlocked_ioctl(struct file *filp,
+					unsigned int command,
+					unsigned long arg)
+{
+	void __user *uarg =3D (void __user *)arg;
+	struct hmm_dmirror_cmd cmd;
+	struct dmirror *dmirror;
+	int ret;
+
+	dmirror =3D filp->private_data;
+	if (!dmirror)
+		return -EINVAL;
+
+	ret =3D copy_from_user(&cmd, uarg, sizeof(cmd));
+	if (ret)
+		return ret;
+
+	if (cmd.addr & ~PAGE_MASK)
+		return -EINVAL;
+	if (cmd.addr >=3D (cmd.addr + (cmd.npages << PAGE_SHIFT)))
+		return -EINVAL;
+
+	cmd.cpages =3D 0;
+	cmd.faults =3D 0;
+
+	switch (command) {
+	case HMM_DMIRROR_READ:
+		ret =3D dmirror_read(dmirror, &cmd);
+		break;
+
+	case HMM_DMIRROR_WRITE:
+		ret =3D dmirror_write(dmirror, &cmd);
+		break;
+
+	case HMM_DMIRROR_MIGRATE:
+		ret =3D dmirror_migrate(dmirror, &cmd);
+		break;
+
+	case HMM_DMIRROR_SNAPSHOT:
+		ret =3D dmirror_snapshot(dmirror, &cmd);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	if (ret)
+		return ret;
+
+	return copy_to_user(uarg, &cmd, sizeof(cmd));
+}
+
+static const struct file_operations dmirror_fops =3D {
+	.open		=3D dmirror_fops_open,
+	.release	=3D dmirror_fops_release,
+	.unlocked_ioctl =3D dmirror_fops_unlocked_ioctl,
+	.llseek		=3D default_llseek,
+	.owner		=3D THIS_MODULE,
+};
+
+static void dmirror_devmem_free(struct page *page)
+{
+	struct page *rpage =3D page->zone_device_data;
+	struct dmirror_device *mdevice;
+
+	if (rpage)
+		__free_page(rpage);
+
+	mdevice =3D dmirror_page_to_device(page);
+
+	spin_lock(&mdevice->lock);
+	mdevice->cfree++;
+	page->zone_device_data =3D mdevice->free_pages;
+	mdevice->free_pages =3D page;
+	spin_unlock(&mdevice->lock);
+}
+
+static vm_fault_t dmirror_devmem_fault_alloc_and_copy(struct migrate_vma *=
args,
+						struct dmirror_device *mdevice)
+{
+	struct vm_area_struct *vma =3D args->vma;
+	const unsigned long *src =3D args->src;
+	unsigned long *dst =3D args->dst;
+	unsigned long start =3D args->start;
+	unsigned long end =3D args->end;
+	unsigned long addr;
+
+	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE,
+				       src++, dst++) {
+		struct page *dpage, *spage;
+
+		spage =3D migrate_pfn_to_page(*src);
+		if (!spage || !(*src & MIGRATE_PFN_MIGRATE))
+			continue;
+		if (!dmirror_device_is_mine(mdevice, spage))
+			continue;
+		spage =3D spage->zone_device_data;
+
+		dpage =3D alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, addr);
+		if (!dpage)
+			continue;
+
+		lock_page(dpage);
+		copy_highpage(dpage, spage);
+		*dst =3D migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
+		if (*src & MIGRATE_PFN_WRITE)
+			*dst |=3D MIGRATE_PFN_WRITE;
+	}
+	return 0;
+}
+
+static void dmirror_devmem_fault_finalize_and_map(struct migrate_vma *args=
,
+						  struct dmirror *dmirror)
+{
+	/* Invalidate the device's page table mapping. */
+	mutex_lock(&dmirror->mutex);
+	dmirror_do_update(dmirror, args->start, args->end);
+	mutex_unlock(&dmirror->mutex);
+}
+
+static vm_fault_t dmirror_devmem_fault(struct vm_fault *vmf)
+{
+	struct migrate_vma args;
+	unsigned long src_pfns;
+	unsigned long dst_pfns;
+	struct page *rpage;
+	struct dmirror *dmirror;
+	vm_fault_t ret;
+
+	/* FIXME demonstrate how we can adjust migrate range */
+	args.vma =3D vmf->vma;
+	args.start =3D vmf->address;
+	args.end =3D args.start + PAGE_SIZE;
+	args.src =3D &src_pfns;
+	args.dst =3D &dst_pfns;
+
+	if (migrate_vma_setup(&args))
+		return VM_FAULT_SIGBUS;
+
+	/*
+	 * Normally, a device would use the page->zone_device_data to point to
+	 * the mirror but here we use it to hold the page for the simulated
+	 * device memory and that page holds the pointer to the mirror.
+	 */
+	rpage =3D vmf->page->zone_device_data;
+	dmirror =3D rpage->zone_device_data;
+
+	ret =3D dmirror_devmem_fault_alloc_and_copy(&args, dmirror->mdevice);
+	if (ret)
+		return ret;
+	migrate_vma_pages(&args);
+	dmirror_devmem_fault_finalize_and_map(&args, dmirror);
+	migrate_vma_finalize(&args);
+	return 0;
+}
+
+static const struct dev_pagemap_ops dmirror_devmem_ops =3D {
+	.page_free	=3D dmirror_devmem_free,
+	.migrate_to_ram	=3D dmirror_devmem_fault,
+};
+
+static int dmirror_device_init(struct dmirror_device *mdevice, int id)
+{
+	dev_t dev;
+	int ret;
+
+	dev =3D MKDEV(MAJOR(dmirror_dev), id);
+	mutex_init(&mdevice->devmem_lock);
+	spin_lock_init(&mdevice->lock);
+
+	cdev_init(&mdevice->cdevice, &dmirror_fops);
+	ret =3D cdev_add(&mdevice->cdevice, dev, 1);
+	if (ret)
+		return ret;
+
+	/* Build a list of free ZONE_DEVICE private struct pages */
+	dmirror_allocate_chunk(mdevice, NULL);
+
+	return 0;
+}
+
+static void dmirror_device_remove(struct dmirror_device *mdevice)
+{
+	unsigned int i;
+
+	if (mdevice->devmem_chunks) {
+		for (i =3D 0; i < mdevice->devmem_count; i++) {
+			struct dmirror_chunk *devmem =3D
+				mdevice->devmem_chunks[i];
+
+			memunmap_pages(&devmem->pagemap);
+			kfree(devmem);
+		}
+		kfree(mdevice->devmem_chunks);
+	}
+
+	cdev_del(&mdevice->cdevice);
+}
+
+static int __init hmm_dmirror_init(void)
+{
+	int ret;
+	int id;
+
+	ret =3D alloc_chrdev_region(&dmirror_dev, 0, DMIRROR_NDEVICES,
+				  "HMM_DMIRROR");
+	if (ret)
+		goto err_unreg;
+
+	for (id =3D 0; id < DMIRROR_NDEVICES; id++) {
+		ret =3D dmirror_device_init(dmirror_devices + id, id);
+		if (ret)
+			goto err_chrdev;
+	}
+
+	/*
+	 * Allocate a zero page to simulate a reserved page of device private
+	 * memory which is always zero. The zero_pfn page isn't used just to
+	 * make the code here simpler (i.e., we need a struct page for it).
+	 */
+	dmirror_zero_page =3D alloc_page(GFP_HIGHUSER | __GFP_ZERO);
+	if (!dmirror_zero_page)
+		goto err_chrdev;
+
+	pr_info("HMM test module loaded. This is only for testing HMM.\n");
+	return 0;
+
+err_chrdev:
+	while (--id >=3D 0)
+		dmirror_device_remove(dmirror_devices + id);
+	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
+err_unreg:
+	return ret;
+}
+
+static void __exit hmm_dmirror_exit(void)
+{
+	int id;
+
+	if (dmirror_zero_page)
+		__free_page(dmirror_zero_page);
+	for (id =3D 0; id < DMIRROR_NDEVICES; id++)
+		dmirror_device_remove(dmirror_devices + id);
+	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
+	mmu_notifier_synchronize();
+}
+
+module_init(hmm_dmirror_init);
+module_exit(hmm_dmirror_exit);
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftest=
s/vm/.gitignore
index 31b3c98b6d34..3054565b3f07 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -14,3 +14,4 @@ virtual_address_range
 gup_benchmark
 va_128TBswitch
 map_fixed_noreplace
+hmm-tests
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/=
vm/Makefile
index 9534dc2bc929..5643cfb5e3d6 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -5,6 +5,7 @@ CFLAGS =3D -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
 LDLIBS =3D -lrt
 TEST_GEN_FILES =3D compaction_test
 TEST_GEN_FILES +=3D gup_benchmark
+TEST_GEN_FILES +=3D hmm-tests
 TEST_GEN_FILES +=3D hugepage-mmap
 TEST_GEN_FILES +=3D hugepage-shm
 TEST_GEN_FILES +=3D map_hugetlb
@@ -26,6 +27,8 @@ TEST_FILES :=3D test_vmalloc.sh
 KSFT_KHDR_INSTALL :=3D 1
 include ../lib.mk
=20
+$(OUTPUT)/hmm-tests: LDLIBS +=3D -lhugetlbfs -lpthread
+
 $(OUTPUT)/userfaultfd: LDLIBS +=3D -lpthread
=20
 $(OUTPUT)/mlock-random-test: LDLIBS +=3D -lcap
diff --git a/tools/testing/selftests/vm/config b/tools/testing/selftests/vm=
/config
index 1c0d76cb5adf..7fd96113575e 100644
--- a/tools/testing/selftests/vm/config
+++ b/tools/testing/selftests/vm/config
@@ -1,2 +1,4 @@
 CONFIG_SYSVIPC=3Dy
 CONFIG_USERFAULTFD=3Dy
+CONFIG_HMM_MIRROR=3Dy
+CONFIG_DEVICE_PRIVATE=3Dy
diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftes=
ts/vm/hmm-tests.c
new file mode 100644
index 000000000000..f1e530353bcd
--- /dev/null
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -0,0 +1,1295 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HMM stands for Heterogeneous Memory Management, it is a helper layer in=
side
+ * the linux kernel to help device drivers mirror a process address space =
in
+ * the device. This allows the device to use the same address space which
+ * makes communication and data exchange a lot easier.
+ *
+ * This framework's sole purpose is to exercise various code paths inside
+ * the kernel to make sure that HMM performs as expected and to flush out =
any
+ * bugs.
+ */
+
+#include "../kselftest_harness.h"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <strings.h>
+#include <time.h>
+#include <pthread.h>
+#include <hugetlbfs.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+#include <linux/test_hmm.h>
+
+struct hmm_buffer {
+	void		*ptr;
+	void		*mirror;
+	unsigned long	size;
+	int		fd;
+	uint64_t	cpages;
+	uint64_t	faults;
+};
+
+#define TWOMEG		(1 << 21)
+#define HMM_BUFFER_SIZE (1024 << 12)
+#define HMM_PATH_MAX    64
+#define NTIMES		256
+
+#define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
+
+FIXTURE(hmm)
+{
+	int		fd;
+	unsigned int	page_size;
+	unsigned int	page_shift;
+};
+
+FIXTURE(hmm2)
+{
+	int		fd0;
+	int		fd1;
+	unsigned int	page_size;
+	unsigned int	page_shift;
+};
+
+static int hmm_open(int unit)
+{
+	char pathname[HMM_PATH_MAX];
+	int fd;
+
+	snprintf(pathname, sizeof(pathname), "/dev/hmm_dmirror%d", unit);
+	fd =3D open(pathname, O_RDWR, 0);
+	if (fd < 0)
+		fprintf(stderr, "could not open hmm dmirror driver (%s)\n",
+			pathname);
+	return fd;
+}
+
+FIXTURE_SETUP(hmm)
+{
+	self->page_size =3D sysconf(_SC_PAGE_SIZE);
+	self->page_shift =3D ffs(self->page_size) - 1;
+
+	self->fd =3D hmm_open(0);
+	ASSERT_GE(self->fd, 0);
+}
+
+FIXTURE_SETUP(hmm2)
+{
+	self->page_size =3D sysconf(_SC_PAGE_SIZE);
+	self->page_shift =3D ffs(self->page_size) - 1;
+
+	self->fd0 =3D hmm_open(0);
+	ASSERT_GE(self->fd0, 0);
+	self->fd1 =3D hmm_open(1);
+	ASSERT_GE(self->fd1, 0);
+}
+
+FIXTURE_TEARDOWN(hmm)
+{
+	int ret =3D close(self->fd);
+
+	ASSERT_EQ(ret, 0);
+	self->fd =3D -1;
+}
+
+FIXTURE_TEARDOWN(hmm2)
+{
+	int ret =3D close(self->fd0);
+
+	ASSERT_EQ(ret, 0);
+	self->fd0 =3D -1;
+
+	ret =3D close(self->fd1);
+	ASSERT_EQ(ret, 0);
+	self->fd1 =3D -1;
+}
+
+static int hmm_dmirror_cmd(int fd,
+			   unsigned long request,
+			   struct hmm_buffer *buffer,
+			   unsigned long npages)
+{
+	struct hmm_dmirror_cmd cmd;
+	int ret;
+
+	/* Simulate a device reading system memory. */
+	cmd.addr =3D (__u64)buffer->ptr;
+	cmd.ptr =3D (__u64)buffer->mirror;
+	cmd.npages =3D npages;
+
+	for (;;) {
+		ret =3D ioctl(fd, request, &cmd);
+		if (ret =3D=3D 0)
+			break;
+		if (errno =3D=3D EINTR)
+			continue;
+		return -errno;
+	}
+	buffer->cpages =3D cmd.cpages;
+	buffer->faults =3D cmd.faults;
+
+	return 0;
+}
+
+static void hmm_buffer_free(struct hmm_buffer *buffer)
+{
+	if (buffer =3D=3D NULL)
+		return;
+
+	if (buffer->ptr)
+		munmap(buffer->ptr, buffer->size);
+	free(buffer->mirror);
+	free(buffer);
+}
+
+/*
+ * Create a temporary file that will be deleted on close.
+ */
+static int hmm_create_file(unsigned long size)
+{
+	char path[HMM_PATH_MAX];
+	int fd;
+
+	strcpy(path, "/tmp");
+	fd =3D open(path, O_TMPFILE | O_EXCL | O_RDWR, 0600);
+	if (fd >=3D 0) {
+		int r;
+
+		do {
+			r =3D ftruncate(fd, size);
+		} while (r =3D=3D -1 && errno =3D=3D EINTR);
+		if (!r)
+			return fd;
+		close(fd);
+	}
+	return -1;
+}
+
+/*
+ * Return a random unsigned number.
+ */
+static unsigned int hmm_random(void)
+{
+	static int fd =3D -1;
+	unsigned int r;
+
+	if (fd < 0) {
+		fd =3D open("/dev/urandom", O_RDONLY);
+		if (fd < 0) {
+			fprintf(stderr, "%s:%d failed to open /dev/urandom\n",
+					__FILE__, __LINE__);
+			return ~0U;
+		}
+	}
+	read(fd, &r, sizeof(r));
+	return r;
+}
+
+static void hmm_nanosleep(unsigned int n)
+{
+	struct timespec t;
+
+	t.tv_sec =3D 0;
+	t.tv_nsec =3D n;
+	nanosleep(&t, NULL);
+}
+
+/*
+ * Simple NULL test of device open/close.
+ */
+TEST_F(hmm, open_close)
+{
+}
+
+/*
+ * Read private anonymous memory.
+ */
+TEST_F(hmm, anon_read)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+	int val;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/*
+	 * Initialize buffer in system memory but leave the first two pages
+	 * zero (pte_none and pfn_zero).
+	 */
+	i =3D 2 * self->page_size / sizeof(*ptr);
+	for (ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Set buffer permission to read-only. */
+	ret =3D mprotect(buffer->ptr, size, PROT_READ);
+	ASSERT_EQ(ret, 0);
+
+	/* Populate the CPU page table with a special zero page. */
+	val =3D *(int *)(buffer->ptr + self->page_size);
+	ASSERT_EQ(val, 0);
+
+	/* Simulate a device reading system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device read. */
+	ptr =3D buffer->mirror;
+	for (i =3D 0; i < 2 * self->page_size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], 0);
+	for (; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Read private anonymous memory which has been protected with
+ * mprotect() PROT_NONE.
+ */
+TEST_F(hmm, anon_read_prot)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer in system memory. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Initialize mirror buffer so we can verify it isn't written. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D -i;
+
+	/* Protect buffer from reading. */
+	ret =3D mprotect(buffer->ptr, size, PROT_NONE);
+	ASSERT_EQ(ret, 0);
+
+	/* Simulate a device reading system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer, npages);
+	ASSERT_EQ(ret, -EFAULT);
+
+	/* Allow CPU to read the buffer so we can check it. */
+	ret =3D mprotect(buffer->ptr, size, PROT_READ);
+	ASSERT_EQ(ret, 0);
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], -i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Write private anonymous memory.
+ */
+TEST_F(hmm, anon_write)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize data that the device will write to buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Write private anonymous memory which has been protected with
+ * mprotect() PROT_READ.
+ */
+TEST_F(hmm, anon_write_prot)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Simulate a device reading a zero page of memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer, 1);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, 1);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Initialize data that the device will write to buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, -EPERM);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], 0);
+
+	/* Now allow writing and see that the zero page is replaced. */
+	ret =3D mprotect(buffer->ptr, size, PROT_WRITE | PROT_READ);
+	ASSERT_EQ(ret, 0);
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Check that a device writing an anonymous private mapping
+ * will copy-on-write if a child process inherits the mapping.
+ */
+TEST_F(hmm, anon_write_child)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	pid_t pid;
+	int child_fd;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer->ptr so we can tell if it is written. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Initialize data that the device will write to buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D -i;
+
+	pid =3D fork();
+	if (pid =3D=3D -1)
+		ASSERT_EQ(pid, 0);
+	if (pid !=3D 0) {
+		waitpid(pid, &ret, 0);
+		ASSERT_EQ(WIFEXITED(ret), 1);
+
+		/* Check that the parent's buffer did not change. */
+		for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+			ASSERT_EQ(ptr[i], i);
+		return;
+	}
+
+	/* Check that we see the parent's values. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], -i);
+
+	/* The child process needs its own mirror to its own mm. */
+	child_fd =3D hmm_open(0);
+	ASSERT_GE(child_fd, 0);
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(child_fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], -i);
+
+	close(child_fd);
+	exit(0);
+}
+
+/*
+ * Check that a device writing an anonymous shared mapping
+ * will not copy-on-write if a child process inherits the mapping.
+ */
+TEST_F(hmm, anon_write_child_shared)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	pid_t pid;
+	int child_fd;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_SHARED | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer->ptr so we can tell if it is written. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Initialize data that the device will write to buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D -i;
+
+	pid =3D fork();
+	if (pid =3D=3D -1)
+		ASSERT_EQ(pid, 0);
+	if (pid !=3D 0) {
+		waitpid(pid, &ret, 0);
+		ASSERT_EQ(WIFEXITED(ret), 1);
+
+		/* Check that the parent's buffer did change. */
+		for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+			ASSERT_EQ(ptr[i], -i);
+		return;
+	}
+
+	/* Check that we see the parent's values. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], -i);
+
+	/* The child process needs its own mirror to its own mm. */
+	child_fd =3D hmm_open(0);
+	ASSERT_GE(child_fd, 0);
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(child_fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], -i);
+
+	close(child_fd);
+	exit(0);
+}
+
+/*
+ * Write private anonymous huge page.
+ */
+TEST_F(hmm, anon_write_huge)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	void *old_ptr;
+	void *map;
+	int *ptr;
+	int ret;
+
+	size =3D 2 * TWOMEG;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	size =3D TWOMEG;
+	npages =3D size >> self->page_shift;
+	map =3D (void *)ALIGN((uintptr_t)buffer->ptr, size);
+	ret =3D madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	old_ptr =3D buffer->ptr;
+	buffer->ptr =3D map;
+
+	/* Initialize data that the device will write to buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	buffer->ptr =3D old_ptr;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Write huge TLBFS page.
+ */
+TEST_F(hmm, anon_write_hugetlbfs)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+	long pagesizes[4];
+	int n, idx;
+
+	/* Skip test if we can't allocate a hugetlbfs page. */
+
+	n =3D gethugepagesizes(pagesizes, 4);
+	if (n <=3D 0)
+		return;
+	for (idx =3D 0; --n > 0; ) {
+		if (pagesizes[n] < pagesizes[idx])
+			idx =3D n;
+	}
+	size =3D ALIGN(TWOMEG, pagesizes[idx]);
+	npages =3D size >> self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->ptr =3D get_hugepage_region(size, GHR_STRICT);
+	if (buffer->ptr =3D=3D NULL) {
+		free(buffer);
+		return;
+	}
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	/* Initialize data that the device will write to buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	free_hugepage_region(buffer->ptr);
+	buffer->ptr =3D NULL;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Read mmap'ed file memory.
+ */
+TEST_F(hmm, file_read)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+	int fd;
+	off_t off;
+	ssize_t len;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	fd =3D hmm_create_file(size);
+	ASSERT_GE(fd, 0);
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D fd;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	/* Write initial contents of the file. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+	off =3D lseek(fd, 0, SEEK_SET);
+	ASSERT_EQ(off, 0);
+	len =3D write(fd, buffer->mirror, size);
+	ASSERT_EQ(len, size);
+	memset(buffer->mirror, 0, size);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ,
+			   MAP_SHARED,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Simulate a device reading system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Write mmap'ed file memory.
+ */
+TEST_F(hmm, file_write)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+	int fd;
+	off_t off;
+	ssize_t len;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	fd =3D hmm_create_file(size);
+	ASSERT_GE(fd, 0);
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D fd;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_SHARED,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize data that the device will write to buffer->ptr. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Simulate a device writing system memory. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_WRITE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	ASSERT_EQ(buffer->faults, 1);
+
+	/* Check what the device wrote. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Check that the device also wrote the file. */
+	off =3D lseek(fd, 0, SEEK_SET);
+	ASSERT_EQ(off, 0);
+	len =3D read(fd, buffer->mirror, size);
+	ASSERT_EQ(len, size);
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate anonymous memory to device private memory.
+ */
+TEST_F(hmm, migrate)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer in system memory. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Migrate memory to device. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate anonymous memory to device private memory and fault it back to =
system
+ * memory.
+ */
+TEST_F(hmm, migrate_fault)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer in system memory. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] =3D i;
+
+	/* Migrate memory to device. */
+	ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Fault pages back to system memory and check them. */
+	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Try to migrate various memory types to device private memory.
+ */
+TEST_F(hmm2, migrate_mixed)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	int *ptr;
+	unsigned char *p;
+	int ret;
+	int val;
+
+	npages =3D 6;
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	/* Reserve a range of addresses. */
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_NONE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+	p =3D buffer->ptr;
+
+	/* Now try to migrate everything to device 1. */
+	ret =3D hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, 6);
+
+	/* Punch a hole after the first page address. */
+	ret =3D munmap(buffer->ptr + self->page_size, self->page_size);
+	ASSERT_EQ(ret, 0);
+
+	/* We expect an error if the vma doesn't cover the range. */
+	ret =3D hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, 3);
+	ASSERT_EQ(ret, -EINVAL);
+
+	/* Page 2 will be a read-only zero page. */
+	ret =3D mprotect(buffer->ptr + 2 * self->page_size, self->page_size,
+				PROT_READ);
+	ASSERT_EQ(ret, 0);
+	ptr =3D (int *)(buffer->ptr + 2 * self->page_size);
+	val =3D *ptr + 3;
+	ASSERT_EQ(val, 3);
+
+	/* Page 3 will be read-only. */
+	ret =3D mprotect(buffer->ptr + 3 * self->page_size, self->page_size,
+				PROT_READ | PROT_WRITE);
+	ASSERT_EQ(ret, 0);
+	ptr =3D (int *)(buffer->ptr + 3 * self->page_size);
+	*ptr =3D val;
+	ret =3D mprotect(buffer->ptr + 3 * self->page_size, self->page_size,
+				PROT_READ);
+	ASSERT_EQ(ret, 0);
+
+	/* Page 4 will be read-write. */
+	ret =3D mprotect(buffer->ptr + 4 * self->page_size, self->page_size,
+				PROT_READ | PROT_WRITE);
+	ASSERT_EQ(ret, 0);
+	ptr =3D (int *)(buffer->ptr + 4 * self->page_size);
+	*ptr =3D val;
+
+	/* Page 5 won't be migrated to device 0 because it's on device 1. */
+	buffer->ptr =3D p + 5 * self->page_size;
+	ret =3D hmm_dmirror_cmd(self->fd0, HMM_DMIRROR_MIGRATE, buffer, 1);
+	ASSERT_EQ(ret, -ENOENT);
+	buffer->ptr =3D p;
+
+	/* Now try to migrate pages 2-3 to device 1. */
+	buffer->ptr =3D p + 2 * self->page_size;
+	ret =3D hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, 2);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, 2);
+	buffer->ptr =3D p;
+
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate anonymous memory to device private memory and fault it back to =
system
+ * memory multiple times.
+ */
+TEST_F(hmm, migrate_multiple)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	unsigned long c;
+	int *ptr;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	for (c =3D 0; c < NTIMES; c++) {
+		buffer =3D malloc(sizeof(*buffer));
+		ASSERT_NE(buffer, NULL);
+
+		buffer->fd =3D -1;
+		buffer->size =3D size;
+		buffer->mirror =3D malloc(size);
+		ASSERT_NE(buffer->mirror, NULL);
+
+		buffer->ptr =3D mmap(NULL, size,
+				   PROT_READ | PROT_WRITE,
+				   MAP_PRIVATE | MAP_ANONYMOUS,
+				   buffer->fd, 0);
+		ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+		/* Initialize buffer in system memory. */
+		for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+			ptr[i] =3D i;
+
+		/* Migrate memory to device. */
+		ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_MIGRATE, buffer,
+				      npages);
+		ASSERT_EQ(ret, 0);
+		ASSERT_EQ(buffer->cpages, npages);
+
+		/* Check what the device read. */
+		for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+			ASSERT_EQ(ptr[i], i);
+
+		/* Fault pages back to system memory and check them. */
+		for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+			ASSERT_EQ(ptr[i], i);
+
+		hmm_buffer_free(buffer);
+	}
+}
+
+/*
+ * Read anonymous memory multiple times.
+ */
+TEST_F(hmm, anon_read_multiple)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	unsigned long c;
+	int *ptr;
+	int ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	for (c =3D 0; c < NTIMES; c++) {
+		buffer =3D malloc(sizeof(*buffer));
+		ASSERT_NE(buffer, NULL);
+
+		buffer->fd =3D -1;
+		buffer->size =3D size;
+		buffer->mirror =3D malloc(size);
+		ASSERT_NE(buffer->mirror, NULL);
+
+		buffer->ptr =3D mmap(NULL, size,
+				   PROT_READ | PROT_WRITE,
+				   MAP_PRIVATE | MAP_ANONYMOUS,
+				   buffer->fd, 0);
+		ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+		/* Initialize buffer in system memory. */
+		for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+			ptr[i] =3D i + c;
+
+		/* Simulate a device reading system memory. */
+		ret =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer,
+				      npages);
+		ASSERT_EQ(ret, 0);
+		ASSERT_EQ(buffer->cpages, npages);
+		ASSERT_EQ(buffer->faults, 1);
+
+		/* Check what the device read. */
+		for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
+			ASSERT_EQ(ptr[i], i + c);
+
+		hmm_buffer_free(buffer);
+	}
+}
+
+void *unmap_buffer(void *p)
+{
+	struct hmm_buffer *buffer =3D p;
+
+	/* Delay for a bit and then unmap buffer while it is being read. */
+	hmm_nanosleep(hmm_random() % 32000);
+	munmap(buffer->ptr + buffer->size / 2, buffer->size / 2);
+	buffer->ptr =3D NULL;
+
+	return NULL;
+}
+
+/*
+ * Try reading anonymous memory while it is being unmapped.
+ */
+TEST_F(hmm, anon_teardown)
+{
+	unsigned long npages;
+	unsigned long size;
+	unsigned long c;
+	void *ret;
+
+	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
+	ASSERT_NE(npages, 0);
+	size =3D npages << self->page_shift;
+
+	for (c =3D 0; c < NTIMES; ++c) {
+		pthread_t thread;
+		struct hmm_buffer *buffer;
+		unsigned long i;
+		int *ptr;
+		int rc;
+
+		buffer =3D malloc(sizeof(*buffer));
+		ASSERT_NE(buffer, NULL);
+
+		buffer->fd =3D -1;
+		buffer->size =3D size;
+		buffer->mirror =3D malloc(size);
+		ASSERT_NE(buffer->mirror, NULL);
+
+		buffer->ptr =3D mmap(NULL, size,
+				   PROT_READ | PROT_WRITE,
+				   MAP_PRIVATE | MAP_ANONYMOUS,
+				   buffer->fd, 0);
+		ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+		/* Initialize buffer in system memory. */
+		for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
+			ptr[i] =3D i + c;
+
+		rc =3D pthread_create(&thread, NULL, unmap_buffer, buffer);
+		ASSERT_EQ(rc, 0);
+
+		/* Simulate a device reading system memory. */
+		rc =3D hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ, buffer,
+				     npages);
+		if (rc =3D=3D 0) {
+			ASSERT_EQ(buffer->cpages, npages);
+			ASSERT_EQ(buffer->faults, 1);
+
+			/* Check what the device read. */
+			for (i =3D 0, ptr =3D buffer->mirror;
+			     i < size / sizeof(*ptr);
+			     ++i)
+				ASSERT_EQ(ptr[i], i + c);
+		}
+
+		pthread_join(thread, &ret);
+		hmm_buffer_free(buffer);
+	}
+}
+
+/*
+ * Test memory snapshot without faulting in pages accessed by the device.
+ */
+TEST_F(hmm2, snapshot)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	int *ptr;
+	unsigned char *p;
+	unsigned char *m;
+	int ret;
+	int val;
+
+	npages =3D 7;
+	size =3D npages << self->page_shift;
+
+	buffer =3D malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd =3D -1;
+	buffer->size =3D size;
+	buffer->mirror =3D malloc(npages);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	/* Reserve a range of addresses. */
+	buffer->ptr =3D mmap(NULL, size,
+			   PROT_NONE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+	p =3D buffer->ptr;
+
+	/* Punch a hole after the first page address. */
+	ret =3D munmap(buffer->ptr + self->page_size, self->page_size);
+	ASSERT_EQ(ret, 0);
+
+	/* Page 2 will be read-only zero page. */
+	ret =3D mprotect(buffer->ptr + 2 * self->page_size, self->page_size,
+				PROT_READ);
+	ASSERT_EQ(ret, 0);
+	ptr =3D (int *)(buffer->ptr + 2 * self->page_size);
+	val =3D *ptr + 3;
+	ASSERT_EQ(val, 3);
+
+	/* Page 3 will be read-only. */
+	ret =3D mprotect(buffer->ptr + 3 * self->page_size, self->page_size,
+				PROT_READ | PROT_WRITE);
+	ASSERT_EQ(ret, 0);
+	ptr =3D (int *)(buffer->ptr + 3 * self->page_size);
+	*ptr =3D val;
+	ret =3D mprotect(buffer->ptr + 3 * self->page_size, self->page_size,
+				PROT_READ);
+	ASSERT_EQ(ret, 0);
+
+	/* Page 4-6 will be read-write. */
+	ret =3D mprotect(buffer->ptr + 4 * self->page_size, 3 * self->page_size,
+				PROT_READ | PROT_WRITE);
+	ASSERT_EQ(ret, 0);
+	ptr =3D (int *)(buffer->ptr + 4 * self->page_size);
+	*ptr =3D val;
+
+	/* Page 5 will be migrated to device 0. */
+	buffer->ptr =3D p + 5 * self->page_size;
+	ret =3D hmm_dmirror_cmd(self->fd0, HMM_DMIRROR_MIGRATE, buffer, 1);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, 1);
+
+	/* Page 6 will be migrated to device 1. */
+	buffer->ptr =3D p + 6 * self->page_size;
+	ret =3D hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, 1);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, 1);
+
+	/* Simulate a device snapshotting CPU pagetables. */
+	buffer->ptr =3D p;
+	ret =3D hmm_dmirror_cmd(self->fd0, HMM_DMIRROR_SNAPSHOT, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device saw. */
+	m =3D buffer->mirror;
+	ASSERT_EQ(m[0], HMM_DMIRROR_PROT_NONE);
+	ASSERT_EQ(m[1], HMM_DMIRROR_PROT_NONE);
+	ASSERT_EQ(m[2], HMM_DMIRROR_PROT_ZERO | HMM_DMIRROR_PROT_READ);
+	ASSERT_EQ(m[3], HMM_DMIRROR_PROT_READ);
+	ASSERT_EQ(m[4], HMM_DMIRROR_PROT_WRITE);
+	ASSERT_EQ(m[5], HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL |
+			HMM_DMIRROR_PROT_WRITE);
+	ASSERT_EQ(m[6], HMM_DMIRROR_PROT_DEV_PRIVATE_REMOTE |
+			HMM_DMIRROR_PROT_WRITE);
+
+	hmm_buffer_free(buffer);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftes=
ts/vm/run_vmtests
index 951c507a27f7..634cfefdaffd 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -227,4 +227,20 @@ else
 	exitcode=3D1
 fi
=20
+echo "------------------------------------"
+echo "running HMM smoke test"
+echo "------------------------------------"
+./test_hmm.sh smoke
+ret_val=3D$?
+
+if [ $ret_val -eq 0 ]; then
+	echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	echo "[SKIP]"
+	exitcode=3D$ksft_skip
+else
+	echo "[FAIL]"
+	exitcode=3D1
+fi
+
 exit $exitcode
diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftes=
ts/vm/test_hmm.sh
new file mode 100755
index 000000000000..461e4a99a362
--- /dev/null
+++ b/tools/testing/selftests/vm/test_hmm.sh
@@ -0,0 +1,97 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2018 Uladzislau Rezki (Sony) <urezki@gmail.com>
+#
+# This is a test script for the kernel test driver to analyse vmalloc
+# allocator. Therefore it is just a kernel module loader. You can specify
+# and pass different parameters in order to:
+#     a) analyse performance of vmalloc allocations;
+#     b) stressing and stability check of vmalloc subsystem.
+
+TEST_NAME=3D"test_hmm"
+DRIVER=3D"test_hmm"
+
+# 1 if fails
+exitcode=3D1
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=3D4
+
+check_test_requirements()
+{
+	uid=3D$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo "$0: Must be run as root"
+		exit $ksft_skip
+	fi
+
+	if ! which modprobe > /dev/null 2>&1; then
+		echo "$0: You need modprobe installed"
+		exit $ksft_skip
+	fi
+
+	if ! modinfo $DRIVER > /dev/null 2>&1; then
+		echo "$0: You must have the following enabled in your kernel:"
+		echo "CONFIG_TEST_HMM=3Dm"
+		exit $ksft_skip
+	fi
+}
+
+load_driver()
+{
+	modprobe $DRIVER > /dev/null 2>&1
+	if [ $? =3D=3D 0 ]; then
+		major=3D$(awk "\$2=3D=3D\"HMM_DMIRROR\" {print \$1}" /proc/devices)
+		mknod /dev/hmm_dmirror0 c $major 0
+		mknod /dev/hmm_dmirror1 c $major 1
+	fi
+}
+
+unload_driver()
+{
+	modprobe -r $DRIVER > /dev/null 2>&1
+	rm -f /dev/hmm_dmirror?
+}
+
+run_smoke()
+{
+	echo "Running smoke test. Note, this test provides basic coverage."
+
+	load_driver
+	./hmm-tests
+	unload_driver
+}
+
+usage()
+{
+	echo -n "Usage: $0"
+	echo
+	echo "Example usage:"
+	echo
+	echo "# Shows help message"
+	echo "./${TEST_NAME}.sh"
+	echo
+	echo "# Smoke testing"
+	echo "./${TEST_NAME}.sh smoke"
+	echo
+	exit 0
+}
+
+function run_test()
+{
+	if [ $# -eq 0 ]; then
+		usage
+	else
+		if [ "$1" =3D "smoke" ]; then
+			run_smoke
+		else
+			usage
+		fi
+	fi
+}
+
+check_test_requirements
+run_test $@
+
+exit 0
--=20
2.20.1

