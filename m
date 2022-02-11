Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E704B1D53
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 05:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiBKEWv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 23:22:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiBKEWu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 23:22:50 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F4025C2
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 20:22:49 -0800 (PST)
Received: from dggeme710-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jw0n52fbkzbjhR;
        Fri, 11 Feb 2022 12:21:45 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggeme710-chm.china.huawei.com (10.1.199.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 11 Feb 2022 12:22:47 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2308.021;
 Fri, 11 Feb 2022 12:22:47 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "tiantao (H)" <tiantao6@hisilicon.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "hch@lst.de" <hch@lst.de>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [PATCH] dma-mapping: benchmark: Extract a common header file for
 map_benchmark definition
Thread-Topic: [PATCH] dma-mapping: benchmark: Extract a common header file for
 map_benchmark definition
Thread-Index: AQHYHvWApYD8MtmT3EOTxi6q+ybr5ayNvbrw
Date:   Fri, 11 Feb 2022 04:22:47 +0000
Message-ID: <d3dd5f61efcb41c981b0971e128da907@hisilicon.com>
References: <20220211031441.41126-1-tiantao6@hisilicon.com>
In-Reply-To: <20220211031441.41126-1-tiantao6@hisilicon.com>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.29]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: tiantao (H)
> Sent: Friday, February 11, 2022 4:15 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; shuah@kernel.org;
> chenxiang (M) <chenxiang66@hisilicon.com>
> Cc: iommu@lists.linux-foundation.org; linux-kselftest@vger.kernel.org;
> linuxarm@openeuler.org
> Subject: [PATCH] dma-mapping: benchmark: Extract a common header file for
> map_benchmark definition
> 
> kernel/dma/map_benchmark.c and selftests/dma/dma_map_benchmark.c
> have duplicate map_benchmark definitions, which tends to lead to
> inconsistent changes to map_benchmark on both sides, extract a
> common header file to avoid this problem.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

+To: Christoph

Looks like a right cleanup. This will help decrease the maintain
overhead in the future. Other similar selftests tools are also
doing this.

Acked-by: Barry Song <song.bao.hua@hisilicon.com>

> ---
>  kernel/dma/map_benchmark.c                    | 24 +-------------
>  kernel/dma/map_benchmark.h                    | 31 +++++++++++++++++++
>  .../testing/selftests/dma/dma_map_benchmark.c | 25 +--------------
>  3 files changed, 33 insertions(+), 47 deletions(-)
>  create mode 100644 kernel/dma/map_benchmark.h
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 9b9af1bd6be3..c05f4e242991 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -18,29 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/timekeeping.h>
> 
> -#define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
> -#define DMA_MAP_MAX_THREADS	1024
> -#define DMA_MAP_MAX_SECONDS	300
> -#define DMA_MAP_MAX_TRANS_DELAY	(10 * NSEC_PER_MSEC)
> -
> -#define DMA_MAP_BIDIRECTIONAL	0
> -#define DMA_MAP_TO_DEVICE	1
> -#define DMA_MAP_FROM_DEVICE	2
> -
> -struct map_benchmark {
> -	__u64 avg_map_100ns; /* average map latency in 100ns */
> -	__u64 map_stddev; /* standard deviation of map latency */
> -	__u64 avg_unmap_100ns; /* as above */
> -	__u64 unmap_stddev;
> -	__u32 threads; /* how many threads will do map/unmap in parallel */
> -	__u32 seconds; /* how long the test will last */
> -	__s32 node; /* which numa node this benchmark will run on */
> -	__u32 dma_bits; /* DMA addressing capability */
> -	__u32 dma_dir; /* DMA data direction */
> -	__u32 dma_trans_ns; /* time for DMA transmission in ns */
> -	__u32 granule;	/* how many PAGE_SIZE will do map/unmap once a time */
> -	__u8 expansion[76];	/* For future use */
> -};
> +#include "map_benchmark.h"
> 
>  struct map_benchmark_data {
>  	struct map_benchmark bparam;
> diff --git a/kernel/dma/map_benchmark.h b/kernel/dma/map_benchmark.h
> new file mode 100644
> index 000000000000..62674c83bde4
> --- /dev/null
> +++ b/kernel/dma/map_benchmark.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2022 HiSilicon Limited.
> + */
> +
> +#ifndef _KERNEL_DMA_BENCHMARK_H
> +#define _KERNEL_DMA_BENCHMARK_H
> +
> +#define DMA_MAP_BENCHMARK       _IOWR('d', 1, struct map_benchmark)
> +#define DMA_MAP_MAX_THREADS     1024
> +#define DMA_MAP_MAX_SECONDS     300
> +#define DMA_MAP_MAX_TRANS_DELAY (10 * NSEC_PER_MSEC)
> +
> +#define DMA_MAP_BIDIRECTIONAL   0
> +#define DMA_MAP_TO_DEVICE       1
> +#define DMA_MAP_FROM_DEVICE     2
> +
> +struct map_benchmark {
> +	__u64 avg_map_100ns; /* average map latency in 100ns */
> +	__u64 map_stddev; /* standard deviation of map latency */
> +	__u64 avg_unmap_100ns; /* as above */
> +	__u64 unmap_stddev;
> +	__u32 threads; /* how many threads will do map/unmap in parallel */
> +	__u32 seconds; /* how long the test will last */
> +	__s32 node; /* which numa node this benchmark will run on */
> +	__u32 dma_bits; /* DMA addressing capability */
> +	__u32 dma_dir; /* DMA data direction */
> +	__u32 dma_trans_ns; /* time for DMA transmission in ns */
> +	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
> +};
> +#endif /* _KERNEL_DMA_BENCHMARK_H */
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c
> b/tools/testing/selftests/dma/dma_map_benchmark.c
> index 485dff51bad2..33bf073071aa 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -11,39 +11,16 @@
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
>  #include <linux/types.h>
> +#include "../../../../kernel/dma/map_benchmark.h"
> 
>  #define NSEC_PER_MSEC	1000000L
> 
> -#define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
> -#define DMA_MAP_MAX_THREADS	1024
> -#define DMA_MAP_MAX_SECONDS     300
> -#define DMA_MAP_MAX_TRANS_DELAY	(10 * NSEC_PER_MSEC)
> -
> -#define DMA_MAP_BIDIRECTIONAL	0
> -#define DMA_MAP_TO_DEVICE	1
> -#define DMA_MAP_FROM_DEVICE	2
> -
>  static char *directions[] = {
>  	"BIDIRECTIONAL",
>  	"TO_DEVICE",
>  	"FROM_DEVICE",
>  };
> 
> -struct map_benchmark {
> -	__u64 avg_map_100ns; /* average map latency in 100ns */
> -	__u64 map_stddev; /* standard deviation of map latency */
> -	__u64 avg_unmap_100ns; /* as above */
> -	__u64 unmap_stddev;
> -	__u32 threads; /* how many threads will do map/unmap in parallel */
> -	__u32 seconds; /* how long the test will last */
> -	__s32 node; /* which numa node this benchmark will run on */
> -	__u32 dma_bits; /* DMA addressing capability */
> -	__u32 dma_dir; /* DMA data direction */
> -	__u32 dma_trans_ns; /* time for DMA transmission in ns */
> -	__u32 granule; /* how many PAGE_SIZE will do map/unmap once a time */
> -	__u8 expansion[76];	/* For future use */
> -};
> -
>  int main(int argc, char **argv)
>  {
>  	struct map_benchmark map;
> --
> 2.33.0

Thanks
Barry

