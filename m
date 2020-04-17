Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100BF1AE8CB
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 01:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgDQXzq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Apr 2020 19:55:46 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15711 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgDQXzQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Apr 2020 19:55:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9a41a50000>; Fri, 17 Apr 2020 16:54:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 Apr 2020 16:55:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 Apr 2020 16:55:12 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 23:55:09 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 17 Apr 2020 23:55:09 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e9a41dc0008>; Fri, 17 Apr 2020 16:55:08 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v9 1/3] mm/hmm/test: add selftest driver for HMM
Date:   Fri, 17 Apr 2020 16:54:56 -0700
Message-ID: <20200417235458.13462-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200417235458.13462-1-rcampbell@nvidia.com>
References: <20200417235458.13462-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587167653; bh=+wvAJvulGkyCLt6TAg74ZQu/vSh9omWQfvNLXL73j/U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=pyR9nMIZeu+0zuU5mwboYpV6VfOilNY8B2lhh9ohMQCQ4qVTAbDvPHntPJ4t3Kt7c
         r2SVmrzFbocF0r3UwtQAcl4JIDqSCfctzC8nqOu9DuKjYQ3ILUyvMQuGOT9mHWqO8F
         JN0GSP+0cnGzp10zIVm0zKlkCmg0yC7D8NNeN83/wIuZOVjM4B4AxWggsMXbhM65T1
         4TgcNUHbArjoKe3N2HxUCcelQTeb9vtp1s/dzauxV/aGvRW0+GGZVMy50FUY5WPitw
         2QqQD904TuWhRp0TgTGn/SsQfhKK9Ibw73pgxV/vxj5Gb7j53Bofgiyq0J6FMgqkyh
         kQuNi6CFuAW1g==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This driver is for testing device private memory migration and devices
which use hmm_range_fault() to access system memory via device page tables.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
---
 lib/Kconfig.debug   |   13 +
 lib/Makefile        |    1 +
 lib/test_hmm.c      | 1175 +++++++++++++++++++++++++++++++++++++++++++
 lib/test_hmm_uapi.h |   59 +++
 4 files changed, 1248 insertions(+)
 create mode 100644 lib/test_hmm.c
 create mode 100644 lib/test_hmm_uapi.h

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 50c1f5f08e6f..ac7751e640e9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2199,6 +2199,19 @@ config TEST_MEMINIT
=20
 	  If unsure, say N.
=20
+config TEST_HMM
+	tristate "Test HMM (Heterogeneous Memory Management)"
+	depends on TRANSPARENT_HUGEPAGE
+	select DEVICE_PRIVATE
+	select HMM_MIRROR
+	select MMU_NOTIFIER
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
index 685aee60de1d..93d8ad358b44 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_TEST_STACKINIT) +=3D test_stackinit.o
 obj-$(CONFIG_TEST_BLACKHOLE_DEV) +=3D test_blackhole_dev.o
 obj-$(CONFIG_TEST_MEMINIT) +=3D test_meminit.o
 obj-$(CONFIG_TEST_LOCKUP) +=3D test_lockup.o
+obj-$(CONFIG_TEST_HMM) +=3D test_hmm.o
=20
 obj-$(CONFIG_TEST_LIVEPATCH) +=3D livepatch/
=20
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
new file mode 100644
index 000000000000..621d33b0711a
--- /dev/null
+++ b/lib/test_hmm.c
@@ -0,0 +1,1175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This is a module to test the HMM (Heterogeneous Memory Management)
+ * mirror and zone device private memory migration APIs of the kernel.
+ * Userspace programs can register with the driver to mirror their own add=
ress
+ * space and can use the device to read/write any valid virtual address.
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
+#include "test_hmm_uapi.h"
+
+#define DMIRROR_NDEVICES		2
+#define DMIRROR_RANGE_FAULT_TIMEOUT	1000
+#define DEVMEM_CHUNK_SIZE		(256 * 1024 * 1024U)
+#define DEVMEM_CHUNKS_RESERVE		16
+
+static const struct dev_pagemap_ops dmirror_devmem_ops;
+static const struct mmu_interval_notifier_ops dmirror_min_ops;
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
+
+#define DPT_XA_TAG_WRITE 3UL
+
+static const uint64_t dmirror_hmm_flags[HMM_PFN_FLAG_MAX] =3D {
+	[HMM_PFN_VALID] =3D DPT_VALID,
+	[HMM_PFN_WRITE] =3D DPT_WRITE,
+};
+
+static const uint64_t dmirror_hmm_values[HMM_PFN_VALUE_MAX] =3D {
+	[HMM_PFN_NONE]    =3D 0,
+	[HMM_PFN_ERROR]   =3D 0x10,
+	[HMM_PFN_SPECIAL] =3D 0x10,
+};
+
+/*
+ * Data structure to track address ranges and register for mmu interval
+ * notifier updates.
+ */
+struct dmirror_interval {
+	struct mmu_interval_notifier	notifier;
+	struct dmirror			*dmirror;
+};
+
+/*
+ * Data attached to the open device file.
+ * Note that it might be shared after a fork().
+ */
+struct dmirror {
+	struct dmirror_device		*mdevice;
+	struct xarray			pt;
+	struct mmu_interval_notifier	notifier;
+	struct mutex			mutex;
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
+static void dmirror_bounce_fini(struct dmirror_bounce *bounce)
+{
+	vfree(bounce->ptr);
+}
+
+static int dmirror_fops_open(struct inode *inode, struct file *filp)
+{
+	struct cdev *cdev =3D inode->i_cdev;
+	struct dmirror *dmirror;
+	int ret;
+
+	/* Mirror this process address space */
+	dmirror =3D kzalloc(sizeof(*dmirror), GFP_KERNEL);
+	if (dmirror =3D=3D NULL)
+		return -ENOMEM;
+
+	dmirror->mdevice =3D container_of(cdev, struct dmirror_device, cdevice);
+	mutex_init(&dmirror->mutex);
+	xa_init(&dmirror->pt);
+
+	ret =3D mmu_interval_notifier_insert(&dmirror->notifier, current->mm,
+				0, ULONG_MAX & PAGE_MASK, &dmirror_min_ops);
+	if (ret) {
+		kfree(dmirror);
+		return ret;
+	}
+
+	filp->private_data =3D dmirror;
+	return 0;
+}
+
+static int dmirror_fops_release(struct inode *inode, struct file *filp)
+{
+	struct dmirror *dmirror =3D filp->private_data;
+
+	mmu_interval_notifier_remove(&dmirror->notifier);
+	xa_destroy(&dmirror->pt);
+	kfree(dmirror);
+	return 0;
+}
+
+static struct dmirror_device *dmirror_page_to_device(struct page *page)
+
+{
+	return container_of(page->pgmap, struct dmirror_chunk,
+			    pagemap)->mdevice;
+}
+
+static int dmirror_do_fault(struct dmirror *dmirror, struct hmm_range *ran=
ge)
+{
+	uint64_t *pfns =3D range->pfns;
+	unsigned long pfn;
+
+	for (pfn =3D (range->start >> PAGE_SHIFT);
+	     pfn < (range->end >> PAGE_SHIFT);
+	     pfn++, pfns++) {
+		struct page *page;
+		void *entry;
+
+		/*
+		 * Since we asked for hmm_range_fault() to populate pages,
+		 * it shouldn't return an error entry on success.
+		 */
+		WARN_ON(*pfns =3D=3D range->values[HMM_PFN_ERROR]);
+
+		page =3D hmm_device_entry_to_page(range, *pfns);
+		WARN_ON(!page);
+
+		entry =3D page;
+		if (*pfns & range->flags[HMM_PFN_WRITE])
+			entry =3D xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
+		else if (range->default_flags & range->flags[HMM_PFN_WRITE])
+			return -EFAULT;
+		entry =3D xa_store(&dmirror->pt, pfn, entry, GFP_ATOMIC);
+		if (xa_is_err(entry))
+			return xa_err(entry);
+	}
+
+	return 0;
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
+	 * the mmu notifier to clear page pointers when they become stale.
+	 * Therefore, it is OK to just clear the entry.
+	 */
+	for (pfn =3D start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++)
+		xa_erase(&dmirror->pt, pfn);
+}
+
+static bool dmirror_interval_invalidate(struct mmu_interval_notifier *mni,
+				const struct mmu_notifier_range *range,
+				unsigned long cur_seq)
+{
+	struct dmirror *dmirror =3D container_of(mni, struct dmirror, notifier);
+
+	if (mmu_notifier_range_blockable(range))
+		mutex_lock(&dmirror->mutex);
+	else if (!mutex_trylock(&dmirror->mutex))
+		return false;
+
+	mmu_interval_set_seq(mni, cur_seq);
+	dmirror_do_update(dmirror, range->start, range->end);
+
+	mutex_unlock(&dmirror->mutex);
+	return true;
+}
+
+static const struct mmu_interval_notifier_ops dmirror_min_ops =3D {
+	.invalidate =3D dmirror_interval_invalidate,
+};
+
+static int dmirror_range_fault(struct dmirror *dmirror,
+				struct hmm_range *range)
+{
+	struct mm_struct *mm =3D dmirror->notifier.mm;
+	unsigned long timeout =3D
+		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	int ret;
+
+	while (true) {
+		long count;
+
+		if (time_after(jiffies, timeout)) {
+			ret =3D -EBUSY;
+			goto out;
+		}
+
+		range->notifier_seq =3D mmu_interval_read_begin(range->notifier);
+		down_read(&mm->mmap_sem);
+		count =3D hmm_range_fault(range);
+		up_read(&mm->mmap_sem);
+		if (count <=3D 0) {
+			if (count =3D=3D 0 || count =3D=3D -EBUSY)
+				continue;
+			ret =3D count;
+			goto out;
+		}
+
+		mutex_lock(&dmirror->mutex);
+		if (mmu_interval_read_retry(range->notifier,
+					    range->notifier_seq)) {
+			mutex_unlock(&dmirror->mutex);
+			continue;
+		}
+		break;
+	}
+
+	ret =3D dmirror_do_fault(dmirror, range);
+
+	mutex_unlock(&dmirror->mutex);
+out:
+	return ret;
+}
+
+static int dmirror_fault(struct dmirror *dmirror, unsigned long start,
+			 unsigned long end, bool write)
+{
+	struct mm_struct *mm =3D dmirror->notifier.mm;
+	unsigned long addr;
+	uint64_t pfns[64];
+	struct hmm_range range =3D {
+		.notifier =3D &dmirror->notifier,
+		.pfns =3D pfns,
+		.flags =3D dmirror_hmm_flags,
+		.values =3D dmirror_hmm_values,
+		.pfn_shift =3D DPT_SHIFT,
+		.pfn_flags_mask =3D 0,
+		.default_flags =3D dmirror_hmm_flags[HMM_PFN_VALID] |
+				(write ? dmirror_hmm_flags[HMM_PFN_WRITE] : 0),
+		.dev_private_owner =3D dmirror->mdevice,
+	};
+	int ret =3D 0;
+
+	/* Since the mm is for the mirrored process, get a reference first. */
+	if (!mmget_not_zero(mm))
+		return 0;
+
+	for (addr =3D start; addr < end; addr =3D range.end) {
+		range.start =3D addr;
+		range.end =3D min(addr + (ARRAY_SIZE(pfns) << PAGE_SHIFT), end);
+
+		ret =3D dmirror_range_fault(dmirror, &range);
+		if (ret)
+			break;
+	}
+
+	mmput(mm);
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
+	while (1) {
+		mutex_lock(&dmirror->mutex);
+		ret =3D dmirror_do_read(dmirror, start, end, &bounce);
+		mutex_unlock(&dmirror->mutex);
+		if (ret !=3D -ENOENT)
+			break;
+
+		start =3D cmd->addr + (bounce.cpages << PAGE_SHIFT);
+		ret =3D dmirror_fault(dmirror, start, end, false);
+		if (ret)
+			break;
+		cmd->faults++;
+	}
+
+	if (ret =3D=3D 0)
+		ret =3D copy_to_user(u64_to_user_ptr(cmd->ptr), bounce.ptr,
+					bounce.size);
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
+	ret =3D copy_from_user(bounce.ptr, u64_to_user_ptr(cmd->ptr),
+				bounce.size);
+	if (ret)
+		return ret;
+
+	while (1) {
+		mutex_lock(&dmirror->mutex);
+		ret =3D dmirror_do_write(dmirror, start, end, &bounce);
+		mutex_unlock(&dmirror->mutex);
+		if (ret !=3D -ENOENT)
+			break;
+
+		start =3D cmd->addr + (bounce.cpages << PAGE_SHIFT);
+		ret =3D dmirror_fault(dmirror, start, end, true);
+		if (ret)
+			break;
+		cmd->faults++;
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
+		goto err_release;
+
+	devmem->pagemap.type =3D MEMORY_DEVICE_PRIVATE;
+	devmem->pagemap.res =3D *res;
+	devmem->pagemap.ops =3D &dmirror_devmem_ops;
+	devmem->pagemap.owner =3D mdevice;
+
+	ptr =3D memremap_pages(&devmem->pagemap, numa_node_id());
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
+err_release:
+	release_mem_region(devmem->pagemap.res.start,
+			   resource_size(&devmem->pagemap.res));
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
+static int dmirror_migrate_finalize_and_map(struct migrate_vma *args,
+					    struct dmirror *dmirror)
+{
+	unsigned long start =3D args->start;
+	unsigned long end =3D args->end;
+	const unsigned long *src =3D args->src;
+	const unsigned long *dst =3D args->dst;
+	unsigned long pfn;
+
+	/* Map the migrated pages into the device's page tables. */
+	mutex_lock(&dmirror->mutex);
+
+	for (pfn =3D start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++,
+								src++, dst++) {
+		struct page *dpage;
+		void *entry;
+
+		if (!(*src & MIGRATE_PFN_MIGRATE))
+			continue;
+
+		dpage =3D migrate_pfn_to_page(*dst);
+		if (!dpage)
+			continue;
+
+		/*
+		 * Store the page that holds the data so the page table
+		 * doesn't have to deal with ZONE_DEVICE private pages.
+		 */
+		entry =3D dpage->zone_device_data;
+		if (*dst & MIGRATE_PFN_WRITE)
+			entry =3D xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
+		entry =3D xa_store(&dmirror->pt, pfn, entry, GFP_ATOMIC);
+		if (xa_is_err(entry))
+			return xa_err(entry);
+	}
+
+	mutex_unlock(&dmirror->mutex);
+	return 0;
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
+		if (!vma || addr < vma->vm_start ||
+		    !(vma->vm_flags & VM_READ)) {
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
+		args.src_owner =3D NULL;
+		ret =3D migrate_vma_setup(&args);
+		if (ret)
+			goto out;
+
+		dmirror_migrate_alloc_and_copy(&args, dmirror);
+		migrate_vma_pages(&args);
+		dmirror_migrate_finalize_and_map(&args, dmirror);
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
+		ret =3D copy_to_user(u64_to_user_ptr(cmd->ptr), bounce.ptr,
+					bounce.size);
+	cmd->cpages =3D bounce.cpages;
+	dmirror_bounce_fini(&bounce);
+	return ret;
+
+out:
+	up_read(&mm->mmap_sem);
+	mmput(mm);
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
+	if (is_device_private_page(page)) {
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
+static bool dmirror_snapshot_invalidate(struct mmu_interval_notifier *mni,
+				const struct mmu_notifier_range *range,
+				unsigned long cur_seq)
+{
+	struct dmirror_interval *dmi =3D
+		container_of(mni, struct dmirror_interval, notifier);
+	struct dmirror *dmirror =3D dmi->dmirror;
+
+	if (mmu_notifier_range_blockable(range))
+		mutex_lock(&dmirror->mutex);
+	else if (!mutex_trylock(&dmirror->mutex))
+		return false;
+
+	/*
+	 * Snapshots only need to set the sequence number since any
+	 * invalidation in the interval invalidates the whole snapshot.
+	 */
+	mmu_interval_set_seq(mni, cur_seq);
+
+	mutex_unlock(&dmirror->mutex);
+	return true;
+}
+
+static const struct mmu_interval_notifier_ops dmirror_mrn_ops =3D {
+	.invalidate =3D dmirror_snapshot_invalidate,
+};
+
+static int dmirror_range_snapshot(struct dmirror *dmirror,
+				  struct hmm_range *range,
+				  unsigned char *perm)
+{
+	struct mm_struct *mm =3D dmirror->notifier.mm;
+	struct dmirror_interval notifier;
+	unsigned long timeout =3D
+		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	unsigned long i;
+	unsigned long n;
+	int ret =3D 0;
+
+	notifier.dmirror =3D dmirror;
+	range->notifier =3D &notifier.notifier;
+
+	ret =3D mmu_interval_notifier_insert(range->notifier, mm,
+			range->start, range->end - range->start,
+			&dmirror_mrn_ops);
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
+		range->notifier_seq =3D mmu_interval_read_begin(range->notifier);
+
+		down_read(&mm->mmap_sem);
+		count =3D hmm_range_fault(range);
+		up_read(&mm->mmap_sem);
+		if (count <=3D 0) {
+			if (count =3D=3D 0 || count =3D=3D -EBUSY)
+				continue;
+			ret =3D count;
+			goto out;
+		}
+
+		mutex_lock(&dmirror->mutex);
+		if (mmu_interval_read_retry(range->notifier,
+					    range->notifier_seq)) {
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
+	mmu_interval_notifier_remove(range->notifier);
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
+		.pfn_flags_mask =3D 0,
+		.dev_private_owner =3D dmirror->mdevice,
+	};
+	int ret =3D 0;
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
+	/*
+	 * Register a temporary notifier to detect invalidations even if it
+	 * overlaps with other mmu_interval_notifiers.
+	 */
+	uptr =3D u64_to_user_ptr(cmd->ptr);
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
+		spage =3D spage->zone_device_data;
+
+		dpage =3D alloc_page_vma(GFP_HIGHUSER_MOVABLE, args->vma, addr);
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
+	/*
+	 * Normally, a device would use the page->zone_device_data to point to
+	 * the mirror but here we use it to hold the page for the simulated
+	 * device memory and that page holds the pointer to the mirror.
+	 */
+	rpage =3D vmf->page->zone_device_data;
+	dmirror =3D rpage->zone_device_data;
+
+	/* FIXME demonstrate how we can adjust migrate range */
+	args.vma =3D vmf->vma;
+	args.start =3D vmf->address;
+	args.end =3D args.start + PAGE_SIZE;
+	args.src =3D &src_pfns;
+	args.dst =3D &dst_pfns;
+	args.src_owner =3D dmirror->mdevice;
+
+	if (migrate_vma_setup(&args))
+		return VM_FAULT_SIGBUS;
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
+	mdevice->cdevice.owner =3D THIS_MODULE;
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
+			release_mem_region(devmem->pagemap.res.start,
+					   resource_size(&devmem->pagemap.res));
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
+}
+
+module_init(hmm_dmirror_init);
+module_exit(hmm_dmirror_exit);
+MODULE_LICENSE("GPL");
diff --git a/lib/test_hmm_uapi.h b/lib/test_hmm_uapi.h
new file mode 100644
index 000000000000..67b3b2e6ff5d
--- /dev/null
+++ b/lib/test_hmm_uapi.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * This is a module to test the HMM (Heterogeneous Memory Management) API
+ * of the kernel. It allows a userspace program to expose its entire addre=
ss
+ * space through the HMM test module device file.
+ */
+#ifndef _LIB_TEST_HMM_UAPI_H
+#define _LIB_TEST_HMM_UAPI_H
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
+#endif /* _LIB_TEST_HMM_UAPI_H */
--=20
2.25.2

