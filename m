Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14BD2A1D33
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Nov 2020 11:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgKAKTR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Nov 2020 05:19:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7004 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgKAKTP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Nov 2020 05:19:15 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CPBq62sr9zhfCj;
        Sun,  1 Nov 2020 18:19:14 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.128) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 1 Nov 2020 18:19:06 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <iommu@lists.linux-foundation.org>, <hch@lst.de>,
        <robin.murphy@arm.com>, <m.szyprowski@samsung.com>
CC:     <linuxarm@huawei.com>, <linux-kselftest@vger.kernel.org>,
        <xuwei5@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 1/2] dma-mapping: add benchmark support for streaming DMA APIs
Date:   Sun, 1 Nov 2020 23:15:13 +1300
Message-ID: <20201101101514.18840-2-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20201101101514.18840-1-song.bao.hua@hisilicon.com>
References: <20201101101514.18840-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.128]
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
For platform devices:
echo dma_map_benchmark > /sys/bus/platform/devices/xxx/driver_override
echo xxx > /sys/bus/platform/drivers/xxx/unbind
echo xxx > /sys/bus/platform/drivers/dma_map_benchmark/bind

For PCI devices:
echo dma_map_benchmark > /sys/bus/pci/devices/0000:00:01.0/driver_override
echo 0000:00:01.0 > /sys/bus/pci/drivers/xxx/unbind
echo 0000:00:01.0 > /sys/bus/pci/drivers/dma_map_benchmark/bind

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
-v2:
  * add PCI support; v1 supported platform devices only
  * replace ssleep by msleep_interruptible() to permit users to exit
    benchmark before it is completed
  * many changes according to Robin's suggestions, thanks! Robin
    - add standard deviation output to reflect the worst case
    - check users' parameters strictly like the number of threads
    - make cache dirty before dma_map
    - fix unpaired dma_map_page and dma_unmap_single;
    - remove redundant "long long" before ktime_to_ns();
    - use devm_add_action();
    - wakeup all threads together after they are ready

 kernel/dma/Kconfig         |   8 +
 kernel/dma/Makefile        |   1 +
 kernel/dma/map_benchmark.c | 295 +++++++++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+)
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
index 000000000000..ac397758087b
--- /dev/null
+++ b/kernel/dma/map_benchmark.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Hisilicon Limited.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/timekeeping.h>
+
+#define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
+#define DMA_MAP_MAX_THREADS	1024
+#define DMA_MAP_MAX_SECONDS	300
+
+struct map_benchmark {
+	__u64 avg_map_100ns; /* average map latency in 100ns */
+	__u64 map_stddev; /* standard deviation of map latency */
+	__u64 avg_unmap_100ns; /* as above */
+	__u64 unmap_stddev;
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
+	atomic64_t sum_map_100ns;
+	atomic64_t sum_unmap_100ns;
+	atomic64_t sum_square_map;
+	atomic64_t sum_square_unmap;
+	atomic64_t loops;
+};
+
+static int map_benchmark_thread(void *data)
+{
+	void *buf;
+	dma_addr_t dma_addr;
+	struct map_benchmark_data *map = data;
+	int ret = 0;
+
+	buf = (void *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	while (!kthread_should_stop())  {
+		__u64 map_100ns, unmap_100ns, map_square, unmap_square;
+		ktime_t map_stime, map_etime, unmap_stime, unmap_etime;
+
+		/*
+		 * for a non-coherent device, if we don't stain them in the cache,
+		 * this will give an underestimate of the real-world overhead of
+		 * BIDIRECTIONAL or TO_DEVICE mappings
+		 * 66 means evertything goes well! 66 is lucky.
+		 */
+		memset(buf, 0x66, PAGE_SIZE);
+
+		map_stime = ktime_get();
+		dma_addr = dma_map_single(map->dev, buf, PAGE_SIZE, DMA_BIDIRECTIONAL);
+		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
+			pr_err("dma_map_single failed on %s\n", dev_name(map->dev));
+			ret = -ENOMEM;
+			goto out;
+		}
+		map_etime = ktime_get();
+
+		unmap_stime = ktime_get();
+		dma_unmap_single(map->dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
+		unmap_etime = ktime_get();
+
+		/* calculate sum and sum of squares */
+		map_100ns = ktime_to_ns(ktime_sub(map_etime, map_stime)) / 100;
+		unmap_100ns = ktime_to_ns(ktime_sub(unmap_etime, unmap_stime)) / 100;
+		map_square = map_100ns * map_100ns;
+		unmap_square = unmap_100ns * unmap_100ns;
+
+		atomic64_add(map_100ns, &map->sum_map_100ns);
+		atomic64_add(unmap_100ns, &map->sum_unmap_100ns);
+		atomic64_add(map_square, &map->sum_square_map);
+		atomic64_add(unmap_square, &map->sum_square_unmap);
+		atomic64_inc(&map->loops);
+	}
+
+out:
+	free_page((unsigned long)buf);
+	return ret;
+}
+
+static int do_map_benchmark(struct map_benchmark_data *map)
+{
+	struct task_struct **tsk;
+	int threads = map->bparam.threads;
+	int node = map->bparam.node;
+	const cpumask_t *cpu_mask = cpumask_of_node(node);
+	__u64 loops;
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
+			pr_err("create dma_map thread failed\n");
+			ret = PTR_ERR(tsk[i]);
+			goto out;
+		}
+
+		if (node != NUMA_NO_NODE && node_online(node))
+			kthread_bind_mask(tsk[i], cpu_mask);
+	}
+
+	/* clear the old value in the previous benchmark */
+	atomic64_set(&map->sum_map_100ns, 0);
+	atomic64_set(&map->sum_unmap_100ns, 0);
+	atomic64_set(&map->sum_square_map, 0);
+	atomic64_set(&map->sum_square_unmap, 0);
+	atomic64_set(&map->loops, 0);
+
+	for (i = 0; i < threads; i++)
+		wake_up_process(tsk[i]);
+
+	msleep_interruptible(map->bparam.seconds * 1000);
+
+	/* wait for the completion of benchmark threads */
+	for (i = 0; i < threads; i++) {
+		ret = kthread_stop(tsk[i]);
+		if (ret)
+			goto out;
+	}
+
+	loops = atomic64_read(&map->loops);
+	if (likely(loops > 0)) {
+		__u64 map_variance, unmap_variance;
+
+		/* average latency */
+		map->bparam.avg_map_100ns = atomic64_read(&map->sum_map_100ns) / loops;
+		map->bparam.avg_unmap_100ns = atomic64_read(&map->sum_unmap_100ns) / loops;
+
+		/* standard deviation of latency */
+		map_variance = atomic64_read(&map->sum_square_map) / loops -
+			map->bparam.avg_map_100ns * map->bparam.avg_map_100ns;
+		unmap_variance = atomic64_read(&map->sum_square_unmap) / loops -
+			map->bparam.avg_unmap_100ns * map->bparam.avg_unmap_100ns;
+		map->bparam.map_stddev = int_sqrt64(map_variance);
+		map->bparam.unmap_stddev = int_sqrt64(unmap_variance);
+	}
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
+		if (map->bparam.threads == 0 || map->bparam.threads > DMA_MAP_MAX_THREADS) {
+			pr_err("invalid thread number\n");
+			return -EINVAL;
+		}
+		if (map->bparam.seconds == 0 || map->bparam.seconds > DMA_MAP_MAX_SECONDS) {
+			pr_err("invalid duration seconds\n");
+			return -EINVAL;
+		}
+
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
+static void map_benchmark_remove_debugfs(void *data)
+{
+	struct map_benchmark_data *map = (struct map_benchmark_data *)data;
+
+	debugfs_remove(map->debugfs);
+}
+
+static int __map_benchmark_probe(struct device *dev)
+{
+	struct dentry *entry;
+	struct map_benchmark_data *map;
+	int ret;
+
+	map = devm_kzalloc(dev, sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+	map->dev = dev;
+
+	ret = devm_add_action(dev, map_benchmark_remove_debugfs, map);
+	if (ret) {
+		pr_err("Can't add debugfs remove action\n");
+		return ret;
+	}
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
+static int map_benchmark_platform_probe(struct platform_device *pdev)
+{
+	return __map_benchmark_probe(&pdev->dev);
+}
+
+static struct platform_driver map_benchmark_platform_driver = {
+	.driver		= {
+		.name	= "dma_map_benchmark",
+	},
+	.probe = map_benchmark_platform_probe,
+};
+
+static int map_benchmark_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	return __map_benchmark_probe(&pdev->dev);
+}
+
+static struct pci_driver map_benchmark_pci_driver = {
+	.name	= "dma_map_benchmark",
+	.probe	= map_benchmark_pci_probe,
+};
+
+static int __init map_benchmark_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&map_benchmark_pci_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&map_benchmark_platform_driver);
+	if (ret) {
+		pci_unregister_driver(&map_benchmark_pci_driver);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit map_benchmark_cleanup(void)
+{
+	platform_driver_unregister(&map_benchmark_platform_driver);
+	pci_unregister_driver(&map_benchmark_pci_driver);
+}
+
+module_init(map_benchmark_init);
+module_exit(map_benchmark_cleanup);
+
+MODULE_AUTHOR("Barry Song <song.bao.hua@hisilicon.com>");
+MODULE_DESCRIPTION("dma_map benchmark driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

