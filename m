Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F98A29A37E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 04:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505303AbgJ0D53 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 23:57:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4589 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505305AbgJ0D53 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 23:57:29 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CKyZz2rsMzhb70;
        Tue, 27 Oct 2020 11:57:31 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.177) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 11:57:16 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <iommu@lists.linux-foundation.org>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <shuah@kernel.org>,
        <linuxarm@huawei.com>, <linux-kselftest@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH 1/2] dma-mapping: add benchmark support for streaming DMA APIs
Date:   Tue, 27 Oct 2020 16:53:29 +1300
Message-ID: <20201027035330.29612-2-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20201027035330.29612-1-song.bao.hua@hisilicon.com>
References: <20201027035330.29612-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.177]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Nowadays, there are increasing requirements to benchmark the performance
of dma_map and dma_unmap particually while the device is attached to an
IOMMU.

This patch enables the support. Users can run specified number of threads
to do dma_map_page and dma_unmap_page on a specific NUMA node with the
specified duration. Then dma_map_benchmark will calculate the average
latency for map and unmap.

A difficulity for this benchmark is that dma_map/unmap APIs must run on
a particular device. Each device might have different backend of IOMMU or
non-IOMMU.

So we use the driver_override to bind dma_map_benchmark to a particual
device by:
echo dma_map_benchmark > /sys/bus/platform/devices/xxx/driver_override
echo xxx > /sys/bus/platform/drivers/xxx/unbind
echo xxx > /sys/bus/platform/drivers/dma_map_benchmark/bind

For this moment, it supports platform device only, PCI device will also
be supported afterwards.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 kernel/dma/Kconfig         |   8 ++
 kernel/dma/Makefile        |   1 +
 kernel/dma/map_benchmark.c | 202 +++++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)
 create mode 100644 kernel/dma/map_benchmark.c

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index c99de4a21458..949c53da5991 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -225,3 +225,11 @@ config DMA_API_DEBUG_SG
 	  is technically out-of-spec.
 
 	  If unsure, say N.
+
+config DMA_MAP_BENCHMARK
+	bool "Enable benchmarking of streaming DMA mapping"
+	help
+	  Provides /sys/kernel/debug/dma_map_benchmark that helps with testing
+	  performance of dma_(un)map_page.
+
+	  See tools/testing/selftests/dma/dma_map_benchmark.c
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index dc755ab68aab..7aa6b26b1348 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
 obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
 obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
 obj-$(CONFIG_DMA_REMAP)			+= remap.o
+obj-$(CONFIG_DMA_MAP_BENCHMARK)		+= map_benchmark.o
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
new file mode 100644
index 000000000000..16a5d7779d67
--- /dev/null
+++ b/kernel/dma/map_benchmark.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Hisilicon Limited.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/kthread.h>
+#include <linux/slab.h>
+#include <linux/debugfs.h>
+#include <linux/dma-mapping.h>
+#include <linux/timekeeping.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+
+#define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
+
+struct map_benchmark {
+	__u64 map_nsec;
+	__u64 unmap_nsec;
+	__u32 threads; /* how many threads will do map/unmap in parallel */
+	__u32 seconds; /* how long the test will last */
+	int node; /* which numa node this benchmark will run on */
+	__u64 expansion[10];	/* For future use */
+};
+
+struct map_benchmark_data {
+	struct map_benchmark bparam;
+	struct device *dev;
+	struct dentry  *debugfs;
+	atomic64_t total_map_nsecs;
+	atomic64_t total_map_loops;
+	atomic64_t total_unmap_nsecs;
+	atomic64_t total_unmap_loops;
+};
+
+static int map_benchmark_thread(void *data)
+{
+	struct page *page;
+	dma_addr_t dma_addr;
+	struct map_benchmark_data *map = data;
+	int ret = 0;
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	while (!kthread_should_stop())  {
+		ktime_t map_stime, map_etime, unmap_stime, unmap_etime;
+
+		map_stime = ktime_get();
+		dma_addr = dma_map_page(map->dev, page, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
+		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
+			dev_err(map->dev, "dma_map_page failed\n");
+			ret = -ENOMEM;
+			goto out;
+		}
+		map_etime = ktime_get();
+
+		unmap_stime = ktime_get();
+		dma_unmap_single(map->dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
+		unmap_etime = ktime_get();
+
+		atomic64_add((long long)ktime_to_ns(ktime_sub(map_etime, map_stime)),
+				&map->total_map_nsecs);
+		atomic64_add((long long)ktime_to_ns(ktime_sub(unmap_etime, unmap_stime)),
+				&map->total_unmap_nsecs);
+		atomic64_inc(&map->total_map_loops);
+		atomic64_inc(&map->total_unmap_loops);
+	}
+
+out:
+	__free_page(page);
+	return ret;
+}
+
+static int do_map_benchmark(struct map_benchmark_data *map)
+{
+	struct task_struct **tsk;
+	int threads = map->bparam.threads;
+	int node = map->bparam.node;
+	const cpumask_t *cpu_mask = cpumask_of_node(node);
+	int ret = 0;
+	int i;
+
+	tsk = kmalloc_array(threads, sizeof(tsk), GFP_KERNEL);
+	if (!tsk)
+		return -ENOMEM;
+
+	get_device(map->dev);
+
+	for (i = 0; i < threads; i++) {
+		tsk[i] = kthread_create_on_node(map_benchmark_thread, map,
+				map->bparam.node, "dma-map-benchmark/%d", i);
+		if (IS_ERR(tsk[i])) {
+			dev_err(map->dev, "create dma_map thread failed\n");
+			return PTR_ERR(tsk[i]);
+		}
+
+		if (node != NUMA_NO_NODE && node_online(node))
+			kthread_bind_mask(tsk[i], cpu_mask);
+
+		wake_up_process(tsk[i]);
+	}
+
+	ssleep(map->bparam.seconds);
+
+	/* wait for the completion of benchmark threads */
+	for (i = 0; i < threads; i++) {
+		ret = kthread_stop(tsk[i]);
+		if (ret)
+			goto out;
+	}
+
+	/* average map nsec and unmap nsec */
+	map->bparam.map_nsec = atomic64_read(&map->total_map_nsecs) /
+				atomic64_read(&map->total_map_loops);
+	map->bparam.unmap_nsec = atomic64_read(&map->total_unmap_nsecs) /
+				atomic64_read(&map->total_unmap_loops);
+
+out:
+	put_device(map->dev);
+	kfree(tsk);
+	return ret;
+}
+
+static long map_benchmark_ioctl(struct file *filep, unsigned int cmd,
+		unsigned long arg)
+{
+	struct map_benchmark_data *map = filep->private_data;
+	int ret;
+
+	if (copy_from_user(&map->bparam, (void __user *)arg, sizeof(map->bparam)))
+		return -EFAULT;
+
+	switch (cmd) {
+	case DMA_MAP_BENCHMARK:
+		ret = do_map_benchmark(map);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (copy_to_user((void __user *)arg, &map->bparam, sizeof(map->bparam)))
+		return -EFAULT;
+
+	return ret;
+}
+
+static const struct file_operations map_benchmark_fops = {
+	.open = simple_open,
+	.unlocked_ioctl = map_benchmark_ioctl,
+};
+
+static int map_benchmark_probe(struct platform_device *pdev)
+{
+	struct dentry *entry;
+	struct map_benchmark_data *map;
+
+	map = devm_kzalloc(&pdev->dev, sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	map->dev = &pdev->dev;
+	platform_set_drvdata(pdev, map);
+
+	/*
+	 * we only permit a device bound with this driver, 2nd probe
+	 * will fail
+	 */
+	entry = debugfs_create_file("dma_map_benchmark", 0600, NULL, map,
+			&map_benchmark_fops);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+	map->debugfs = entry;
+
+	return 0;
+}
+
+static int map_benchmark_remove(struct platform_device *pdev)
+{
+	struct map_benchmark_data *map = platform_get_drvdata(pdev);
+
+	debugfs_remove(map->debugfs);
+
+	return 0;
+}
+
+static struct platform_driver map_benchmark_driver = {
+	.driver		= {
+		.name	= "dma_map_benchmark",
+	},
+	.probe		= map_benchmark_probe,
+	.remove		= map_benchmark_remove,
+};
+
+module_platform_driver(map_benchmark_driver);
+
+MODULE_AUTHOR("Barry Song <song.bao.hua@hisilicon.com>");
+MODULE_DESCRIPTION("dma_map benchmark driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

