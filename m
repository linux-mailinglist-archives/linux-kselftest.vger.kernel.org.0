Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8893D350990
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 23:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhCaVfH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 17:35:07 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3926 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhCaVe6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 17:34:58 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F9fg66FHCz5kbM;
        Thu,  1 Apr 2021 05:32:50 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 1 Apr 2021 05:34:56 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpeml500008.china.huawei.com (7.185.36.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Thu, 1 Apr 2021 05:34:55 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Thu, 1 Apr 2021 05:34:55 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "fanghao (A)" <fanghao11@huawei.com>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH] dma-mapping: benchmark: use the correct HiSilicon
 copyright
Thread-Topic: [PATCH] dma-mapping: benchmark: use the correct HiSilicon
 copyright
Thread-Index: AQHXJS8F+iJ+5bI0VEyNwDk2aU6XPKqenpRw
Date:   Wed, 31 Mar 2021 21:34:55 +0000
Message-ID: <becc61ba065644c29da60e031ce88553@hisilicon.com>
References: <1617086028-18986-1-git-send-email-fanghao11@huawei.com>
In-Reply-To: <1617086028-18986-1-git-send-email-fanghao11@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: fanghao (A)
> Sent: Tuesday, March 30, 2021 7:34 PM
> To: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com; Song Bao Hua
> (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: iommu@lists.linux-foundation.org; linuxarm@openeuler.org;
> linux-kselftest@vger.kernel.org; fanghao (A) <fanghao11@huawei.com>
> Subject: [PATCH] dma-mapping: benchmark: use the correct HiSilicon copyright
> 
> s/Hisilicon/HiSilicon/g.
> It should use capital S, according to
> https://www.hisilicon.com/en/terms-of-use.
> 

My bad. Thanks.

Acked-by: Barry Song <song.bao.hua@hisilicon.com>

> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> ---
>  kernel/dma/map_benchmark.c                      | 2 +-
>  tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index e0e64f8..00d6549 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (C) 2020 Hisilicon Limited.
> + * Copyright (C) 2020 HiSilicon Limited.
>   */
> 
>  #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c
> b/tools/testing/selftests/dma/dma_map_benchmark.c
> index fb23ce9..b492bed 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (C) 2020 Hisilicon Limited.
> + * Copyright (C) 2020 HiSilicon Limited.
>   */
> 
>  #include <fcntl.h>
> --
> 2.8.1

