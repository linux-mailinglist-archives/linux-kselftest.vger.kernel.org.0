Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6917A340238
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Mar 2021 10:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCRJiI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Mar 2021 05:38:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5098 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhCRJhy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Mar 2021 05:37:54 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F1MN60wZczYKr5;
        Thu, 18 Mar 2021 17:36:06 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 18 Mar 2021 17:37:51 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Thu, 18 Mar 2021 17:37:51 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH] dma-mapping: benchmark: Add support for multi-pages
 map/unmap
Thread-Topic: [PATCH] dma-mapping: benchmark: Add support for multi-pages
 map/unmap
Thread-Index: AQHXG9nF/iGVH6MKnEOjnPZFSsLif6qJetig
Date:   Thu, 18 Mar 2021 09:37:50 +0000
Message-ID: <20e5b1af9de0437eb4fd7d133eb533f0@hisilicon.com>
References: <1616059770-194515-1-git-send-email-chenxiang66@hisilicon.com>
In-Reply-To: <1616059770-194515-1-git-send-email-chenxiang66@hisilicon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.21]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: chenxiang (M)
> Sent: Thursday, March 18, 2021 10:30 PM
> To: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com; Song Bao Hua
> (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: iommu@lists.linux-foundation.org; linuxarm@openeuler.org;
> linux-kselftest@vger.kernel.org; chenxiang (M) <chenxiang66@hisilicon.com>
> Subject: [PATCH] dma-mapping: benchmark: Add support for multi-pages map/unmap
> 
> From: Xiang Chen <chenxiang66@hisilicon.com>
> 
> Currently it only support one page map/unmap once a time for dma-map
> benchmark, but there are some other scenaries which need to support for
> multi-page map/unmap: for those multi-pages interfaces such as
> dma_alloc_coherent() and dma_map_sg(), the time spent on multi-pages
> map/unmap is not the time of a single page * npages (not linear) as it
> may use block description instead of page description when it is satified
> with the size such as 2M/1G, and also it can send a single TLB invalidation
> command to invalidate multi-pages instead of multi-times when RIL is
> enabled (which will short the time of unmap). So it is necessary to add
> support for multi-pages map/unmap.
> 
> Add a parameter "-g" to support multi-pages map/unmap.
> 
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> ---

Acked-by: Barry Song <song.bao.hua@hisilicon.com>

>  kernel/dma/map_benchmark.c                      | 21 ++++++++++++++-------
>  tools/testing/selftests/dma/dma_map_benchmark.c | 20 ++++++++++++++++----
>  2 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index e0e64f8..a5c1b01 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -38,7 +38,8 @@ struct map_benchmark {
>  	__u32 dma_bits; /* DMA addressing capability */
>  	__u32 dma_dir; /* DMA data direction */
>  	__u32 dma_trans_ns; /* time for DMA transmission in ns */
> -	__u8 expansion[80];	/* For future use */
> +	__u32 granule;	/* how many PAGE_SIZE will do map/unmap once a time */
> +	__u8 expansion[76];	/* For future use */
>  };
> 
>  struct map_benchmark_data {
> @@ -58,9 +59,11 @@ static int map_benchmark_thread(void *data)
>  	void *buf;
>  	dma_addr_t dma_addr;
>  	struct map_benchmark_data *map = data;
> +	int npages = map->bparam.granule;
> +	u64 size = npages * PAGE_SIZE;
>  	int ret = 0;
> 
> -	buf = (void *)__get_free_page(GFP_KERNEL);
> +	buf = alloc_pages_exact(size, GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
> 
> @@ -76,10 +79,10 @@ static int map_benchmark_thread(void *data)
>  		 * 66 means evertything goes well! 66 is lucky.
>  		 */
>  		if (map->dir != DMA_FROM_DEVICE)
> -			memset(buf, 0x66, PAGE_SIZE);
> +			memset(buf, 0x66, size);
> 
>  		map_stime = ktime_get();
> -		dma_addr = dma_map_single(map->dev, buf, PAGE_SIZE, map->dir);
> +		dma_addr = dma_map_single(map->dev, buf, size, map->dir);
>  		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
>  			pr_err("dma_map_single failed on %s\n",
>  				dev_name(map->dev));
> @@ -93,7 +96,7 @@ static int map_benchmark_thread(void *data)
>  		ndelay(map->bparam.dma_trans_ns);
> 
>  		unmap_stime = ktime_get();
> -		dma_unmap_single(map->dev, dma_addr, PAGE_SIZE, map->dir);
> +		dma_unmap_single(map->dev, dma_addr, size, map->dir);
>  		unmap_etime = ktime_get();
>  		unmap_delta = ktime_sub(unmap_etime, unmap_stime);
> 
> @@ -112,7 +115,7 @@ static int map_benchmark_thread(void *data)
>  	}
> 
>  out:
> -	free_page((unsigned long)buf);
> +	free_pages_exact(buf, size);
>  	return ret;
>  }
> 
> @@ -203,7 +206,6 @@ static long map_benchmark_ioctl(struct file *file, unsigned
> int cmd,
>  	struct map_benchmark_data *map = file->private_data;
>  	void __user *argp = (void __user *)arg;
>  	u64 old_dma_mask;
> -
>  	int ret;
> 
>  	if (copy_from_user(&map->bparam, argp, sizeof(map->bparam)))
> @@ -234,6 +236,11 @@ static long map_benchmark_ioctl(struct file *file, unsigned
> int cmd,
>  			return -EINVAL;
>  		}
> 
> +		if (map->bparam.granule < 1 || map->bparam.granule > 1024) {
> +			pr_err("invalid granule size\n");
> +			return -EINVAL;
> +		}
> +
>  		switch (map->bparam.dma_dir) {
>  		case DMA_MAP_BIDIRECTIONAL:
>  			map->dir = DMA_BIDIRECTIONAL;
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c
> b/tools/testing/selftests/dma/dma_map_benchmark.c
> index fb23ce9..6f2caa6 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -40,7 +40,8 @@ struct map_benchmark {
>  	__u32 dma_bits; /* DMA addressing capability */
>  	__u32 dma_dir; /* DMA data direction */
>  	__u32 dma_trans_ns; /* time for DMA transmission in ns */
> -	__u8 expansion[80];	/* For future use */
> +	__u32 granule; /* how many PAGE_SIZE will do map/unmap once a time */
> +	__u8 expansion[76];	/* For future use */
>  };
> 
>  int main(int argc, char **argv)
> @@ -51,11 +52,13 @@ int main(int argc, char **argv)
>  	int threads = 1, seconds = 20, node = -1;
>  	/* default dma mask 32bit, bidirectional DMA */
>  	int bits = 32, xdelay = 0, dir = DMA_MAP_BIDIRECTIONAL;
> +	/* default granule 1 PAGESIZE */
> +	int granule = 1;
> 
>  	int cmd = DMA_MAP_BENCHMARK;
>  	char *p;
> 
> -	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:")) != -1) {
> +	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:")) != -1) {
>  		switch (opt) {
>  		case 't':
>  			threads = atoi(optarg);
> @@ -75,6 +78,9 @@ int main(int argc, char **argv)
>  		case 'x':
>  			xdelay = atoi(optarg);
>  			break;
> +		case 'g':
> +			granule = atoi(optarg);
> +			break;
>  		default:
>  			return -1;
>  		}
> @@ -110,6 +116,11 @@ int main(int argc, char **argv)
>  		exit(1);
>  	}
> 
> +	if (granule < 1 || granule > 1024) {
> +		fprintf(stderr, "invalid granule size\n");
> +		exit(1);
> +	}
> +
>  	fd = open("/sys/kernel/debug/dma_map_benchmark", O_RDWR);
>  	if (fd == -1) {
>  		perror("open");
> @@ -123,14 +134,15 @@ int main(int argc, char **argv)
>  	map.dma_bits = bits;
>  	map.dma_dir = dir;
>  	map.dma_trans_ns = xdelay;
> +	map.granule = granule;
> 
>  	if (ioctl(fd, cmd, &map)) {
>  		perror("ioctl");
>  		exit(1);
>  	}
> 
> -	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s\n",
> -			threads, seconds, node, dir[directions]);
> +	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s
> granule: %d\n",
> +			threads, seconds, node, dir[directions], granule);
>  	printf("average map latency(us):%.1f standard deviation:%.1f\n",
>  			map.avg_map_100ns/10.0, map.map_stddev/10.0);
>  	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
> --
> 2.8.1

Thanks
Barry

