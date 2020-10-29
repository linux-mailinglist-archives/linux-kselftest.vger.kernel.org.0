Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C2129F579
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 20:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgJ2TiJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Oct 2020 15:38:09 -0400
Received: from foss.arm.com ([217.140.110.172]:43098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgJ2TiI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Oct 2020 15:38:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BB26139F;
        Thu, 29 Oct 2020 12:38:07 -0700 (PDT)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E13EC3F719;
        Thu, 29 Oct 2020 12:38:05 -0700 (PDT)
Subject: Re: [PATCH 1/2] dma-mapping: add benchmark support for streaming DMA
 APIs
To:     Barry Song <song.bao.hua@hisilicon.com>,
        iommu@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com
Cc:     joro@8bytes.org, will@kernel.org, shuah@kernel.org,
        linuxarm@huawei.com, linux-kselftest@vger.kernel.org
References: <20201027035330.29612-1-song.bao.hua@hisilicon.com>
 <20201027035330.29612-2-song.bao.hua@hisilicon.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f9aebee4-5081-da8c-930c-c36617ab57c4@arm.com>
Date:   Thu, 29 Oct 2020 19:38:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027035330.29612-2-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020-10-27 03:53, Barry Song wrote:
> Nowadays, there are increasing requirements to benchmark the performance
> of dma_map and dma_unmap particually while the device is attached to an
> IOMMU.
> 
> This patch enables the support. Users can run specified number of threads
> to do dma_map_page and dma_unmap_page on a specific NUMA node with the
> specified duration. Then dma_map_benchmark will calculate the average
> latency for map and unmap.
> 
> A difficulity for this benchmark is that dma_map/unmap APIs must run on
> a particular device. Each device might have different backend of IOMMU or
> non-IOMMU.
> 
> So we use the driver_override to bind dma_map_benchmark to a particual
> device by:
> echo dma_map_benchmark > /sys/bus/platform/devices/xxx/driver_override
> echo xxx > /sys/bus/platform/drivers/xxx/unbind
> echo xxx > /sys/bus/platform/drivers/dma_map_benchmark/bind
> 
> For this moment, it supports platform device only, PCI device will also
> be supported afterwards.

Neat! This is something I've thought about many times, but never got 
round to attempting :)

I think the basic latency measurement for mapping and unmapping pages is 
enough to start with, but there are definitely some more things that 
would be interesting to look into for future enhancements:

  - a choice of mapping sizes, both smaller and larger than one page, to 
help characterise stuff like cache maintenance overhead and bounce 
buffer/IOVA fragmentation.
  - alternative allocation patterns like doing lots of maps first, then 
all their corresponding unmaps (to provoke things like the worst-case 
IOVA rcache behaviour).
  - ways to exercise a range of those parameters at once across 
different threads in a single test.

But let's get a basic framework nailed down first...

> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   kernel/dma/Kconfig         |   8 ++
>   kernel/dma/Makefile        |   1 +
>   kernel/dma/map_benchmark.c | 202 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 211 insertions(+)
>   create mode 100644 kernel/dma/map_benchmark.c
> 
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index c99de4a21458..949c53da5991 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -225,3 +225,11 @@ config DMA_API_DEBUG_SG
>   	  is technically out-of-spec.
>   
>   	  If unsure, say N.
> +
> +config DMA_MAP_BENCHMARK
> +	bool "Enable benchmarking of streaming DMA mapping"
> +	help
> +	  Provides /sys/kernel/debug/dma_map_benchmark that helps with testing
> +	  performance of dma_(un)map_page.
> +
> +	  See tools/testing/selftests/dma/dma_map_benchmark.c
> diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
> index dc755ab68aab..7aa6b26b1348 100644
> --- a/kernel/dma/Makefile
> +++ b/kernel/dma/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
>   obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
>   obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
>   obj-$(CONFIG_DMA_REMAP)			+= remap.o
> +obj-$(CONFIG_DMA_MAP_BENCHMARK)		+= map_benchmark.o
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> new file mode 100644
> index 000000000000..16a5d7779d67
> --- /dev/null
> +++ b/kernel/dma/map_benchmark.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 Hisilicon Limited.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/kthread.h>
> +#include <linux/slab.h>
> +#include <linux/debugfs.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/timekeeping.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>

Nit: alphabetical order is always nice, when there's not an existing 
precedent of a complete mess...

> +
> +#define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
> +
> +struct map_benchmark {
> +	__u64 map_nsec;
> +	__u64 unmap_nsec;
> +	__u32 threads; /* how many threads will do map/unmap in parallel */
> +	__u32 seconds; /* how long the test will last */
> +	int node; /* which numa node this benchmark will run on */
> +	__u64 expansion[10];	/* For future use */
> +};

I'm no expert on userspace ABIs (and what little experience I do have is 
mostly of Win32...), so hopefully someone else will comment if there's 
anything of concern here. One thing I wonder is that there's a fair 
likelihood of functionality evolving here over time, so might it be 
appropriate to have some sort of explicit versioning parameter for 
robustness?

> +struct map_benchmark_data {
> +	struct map_benchmark bparam;
> +	struct device *dev;
> +	struct dentry  *debugfs;
> +	atomic64_t total_map_nsecs;
> +	atomic64_t total_map_loops;
> +	atomic64_t total_unmap_nsecs;
> +	atomic64_t total_unmap_loops;
> +};
> +
> +static int map_benchmark_thread(void *data)
> +{
> +	struct page *page;
> +	dma_addr_t dma_addr;
> +	struct map_benchmark_data *map = data;
> +	int ret = 0;
> +
> +	page = alloc_page(GFP_KERNEL);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	while (!kthread_should_stop())  {
> +		ktime_t map_stime, map_etime, unmap_stime, unmap_etime;
> +
> +		map_stime = ktime_get();
> +		dma_addr = dma_map_page(map->dev, page, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);

Note that for a non-coherent device, this will give an underestimate of 
the real-world overhead of BIDIRECTIONAL or TO_DEVICE mappings, since 
the page will never be dirty in the cache (except possibly the very 
first time through).

> +		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
> +			dev_err(map->dev, "dma_map_page failed\n");
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		map_etime = ktime_get();
> +
> +		unmap_stime = ktime_get();
> +		dma_unmap_single(map->dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);

Ahem, dma_map_page() pairs with dma_unmap_page(). Unfortunately 
DMA_API_DEBUG is unable to shout at you for that...

However, maybe changing the other end to dma_map_single() might make 
more sense, since you're not allocating highmem pages or anything wacky, 
and that'll be easier to expand in future.

> +		unmap_etime = ktime_get();
> +
> +		atomic64_add((long long)ktime_to_ns(ktime_sub(map_etime, map_stime)),
> +				&map->total_map_nsecs);

ktime_to_ns() returns s64, which is already long long.

> +		atomic64_add((long long)ktime_to_ns(ktime_sub(unmap_etime, unmap_stime)),
> +				&map->total_unmap_nsecs);
> +		atomic64_inc(&map->total_map_loops);
> +		atomic64_inc(&map->total_unmap_loops);

I think it would be worth keeping track of the variances as well - it 
can be hard to tell if a reasonable-looking average is hiding terrible 
worst-case behaviour.

> +	}
> +
> +out:
> +	__free_page(page);
> +	return ret;
> +}
> +
> +static int do_map_benchmark(struct map_benchmark_data *map)
> +{
> +	struct task_struct **tsk;
> +	int threads = map->bparam.threads;

I know it's debugfs, but maybe a bit of parameter validation wouldn't go 
amiss? I'm already imaginging that sinking feeling when the SSH 
connection stops responding and you realise you've just inadvertently 
launched INT_MAX threads...

> +	int node = map->bparam.node;
> +	const cpumask_t *cpu_mask = cpumask_of_node(node);
> +	int ret = 0;
> +	int i;
> +
> +	tsk = kmalloc_array(threads, sizeof(tsk), GFP_KERNEL);
> +	if (!tsk)
> +		return -ENOMEM;
> +
> +	get_device(map->dev);
> +
> +	for (i = 0; i < threads; i++) {
> +		tsk[i] = kthread_create_on_node(map_benchmark_thread, map,
> +				map->bparam.node, "dma-map-benchmark/%d", i);
> +		if (IS_ERR(tsk[i])) {
> +			dev_err(map->dev, "create dma_map thread failed\n");
> +			return PTR_ERR(tsk[i]);
> +		}
> +
> +		if (node != NUMA_NO_NODE && node_online(node))
> +			kthread_bind_mask(tsk[i], cpu_mask);
> +
> +		wake_up_process(tsk[i]);

Might it be better to create all the threads first, *then* start kicking 
them?

> +	}
> +
> +	ssleep(map->bparam.seconds);
> +
> +	/* wait for the completion of benchmark threads */
> +	for (i = 0; i < threads; i++) {
> +		ret = kthread_stop(tsk[i]);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	/* average map nsec and unmap nsec */
> +	map->bparam.map_nsec = atomic64_read(&map->total_map_nsecs) /
> +				atomic64_read(&map->total_map_loops);
> +	map->bparam.unmap_nsec = atomic64_read(&map->total_unmap_nsecs) /
> +				atomic64_read(&map->total_unmap_loops);
> +
> +out:
> +	put_device(map->dev);
> +	kfree(tsk);
> +	return ret;
> +}
> +
> +static long map_benchmark_ioctl(struct file *filep, unsigned int cmd,
> +		unsigned long arg)
> +{
> +	struct map_benchmark_data *map = filep->private_data;
> +	int ret;
> +
> +	if (copy_from_user(&map->bparam, (void __user *)arg, sizeof(map->bparam)))
> +		return -EFAULT;
> +
> +	switch (cmd) {
> +	case DMA_MAP_BENCHMARK:
> +		ret = do_map_benchmark(map);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (copy_to_user((void __user *)arg, &map->bparam, sizeof(map->bparam)))
> +		return -EFAULT;
> +
> +	return ret;
> +}
> +
> +static const struct file_operations map_benchmark_fops = {
> +	.open = simple_open,
> +	.unlocked_ioctl = map_benchmark_ioctl,
> +};
> +
> +static int map_benchmark_probe(struct platform_device *pdev)
> +{
> +	struct dentry *entry;
> +	struct map_benchmark_data *map;
> +
> +	map = devm_kzalloc(&pdev->dev, sizeof(*map), GFP_KERNEL);
> +	if (!map)
> +		return -ENOMEM;
> +
> +	map->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, map);
> +
> +	/*
> +	 * we only permit a device bound with this driver, 2nd probe
> +	 * will fail
> +	 */
> +	entry = debugfs_create_file("dma_map_benchmark", 0600, NULL, map,
> +			&map_benchmark_fops);
> +	if (IS_ERR(entry))
> +		return PTR_ERR(entry);
> +	map->debugfs = entry;
> +
> +	return 0;
> +}
> +
> +static int map_benchmark_remove(struct platform_device *pdev)
> +{
> +	struct map_benchmark_data *map = platform_get_drvdata(pdev);
> +
> +	debugfs_remove(map->debugfs);

Consider a trivial 3-line wrapper plus a devm_add_action() call ;)

Robin.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver map_benchmark_driver = {
> +	.driver		= {
> +		.name	= "dma_map_benchmark",
> +	},
> +	.probe		= map_benchmark_probe,
> +	.remove		= map_benchmark_remove,
> +};
> +
> +module_platform_driver(map_benchmark_driver);
> +
> +MODULE_AUTHOR("Barry Song <song.bao.hua@hisilicon.com>");
> +MODULE_DESCRIPTION("dma_map benchmark driver");
> +MODULE_LICENSE("GPL");
> 
