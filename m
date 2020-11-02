Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600462A26E4
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Nov 2020 10:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgKBJW0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Nov 2020 04:22:26 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:3014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728078AbgKBJW0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Nov 2020 04:22:26 -0500
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 514D0E9FB9041C93B2E0;
        Mon,  2 Nov 2020 09:22:24 +0000 (GMT)
Received: from [10.47.5.1] (10.47.5.1) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 2 Nov 2020
 09:22:23 +0000
Subject: Re: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
To:     Barry Song <song.bao.hua@hisilicon.com>,
        <iommu@lists.linux-foundation.org>, <hch@lst.de>,
        <robin.murphy@arm.com>, <m.szyprowski@samsung.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, <linuxarm@huawei.com>,
        <xuwei5@huawei.com>, Will Deacon <will@kernel.org>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
 <20201102080646.2180-2-song.bao.hua@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <184797b8-512e-e3da-fae7-25c7d662648b@huawei.com>
Date:   Mon, 2 Nov 2020 09:18:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201102080646.2180-2-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.5.1]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/11/2020 08:06, Barry Song wrote:
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
> For platform devices:
> echo dma_map_benchmark > /sys/bus/platform/devices/xxx/driver_override
> echo xxx > /sys/bus/platform/drivers/xxx/unbind
> echo xxx > /sys/bus/platform/drivers/dma_map_benchmark/bind
> 
> For PCI devices:
> echo dma_map_benchmark > /sys/bus/pci/devices/0000:00:01.0/driver_override
> echo 0000:00:01.0 > /sys/bus/pci/drivers/xxx/unbind
> echo 0000:00:01.0 > /sys/bus/pci/drivers/dma_map_benchmark/bind
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
> -v3:
>    * fix build issues reported by 0day kernel test robot
> -v2:
>    * add PCI support; v1 supported platform devices only
>    * replace ssleep by msleep_interruptible() to permit users to exit
>      benchmark before it is completed
>    * many changes according to Robin's suggestions, thanks! Robin
>      - add standard deviation output to reflect the worst case
>      - check users' parameters strictly like the number of threads
>      - make cache dirty before dma_map
>      - fix unpaired dma_map_page and dma_unmap_single;
>      - remove redundant "long long" before ktime_to_ns();
>      - use devm_add_action()
> 
>   kernel/dma/Kconfig         |   8 +
>   kernel/dma/Makefile        |   1 +
>   kernel/dma/map_benchmark.c | 296 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 305 insertions(+)
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

Since this is a driver, any reason for which it cannot be loadable? If 
so, it seems any functionality would depend on DEBUG FS, I figure that's 
just how we work for debugfs.

Thanks,
John

> +
> +	  See tools/testing/selftests/dma/dma_map_benchmark.c
> diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
> index dc755ab68aab..7aa6b26b1348 100644
> --- a/kernel/dma/Makefile
> +++ b/kernel/dma/Makefile
