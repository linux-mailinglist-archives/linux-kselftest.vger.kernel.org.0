Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33BC2B318D
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Nov 2020 01:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgKOALS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 14 Nov 2020 19:11:18 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2434 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgKOALS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 14 Nov 2020 19:11:18 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CYXfw0Rmtz52lf;
        Sun, 15 Nov 2020 08:11:04 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sun, 15 Nov 2020 08:11:15 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sun, 15 Nov 2020 08:11:15 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "xuwei (O)" <xuwei5@huawei.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: RE: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
Thread-Topic: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
Thread-Index: AQHWuqaxiT3rvc8AvUKektYgWKvLn6nIS8nQ
Date:   Sun, 15 Nov 2020 00:11:15 +0000
Message-ID: <5c4488dd28fc4869b7e67dd842ffa208@hisilicon.com>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
 <20201102080646.2180-2-song.bao.hua@hisilicon.com>
 <20201114165336.GA24844@lst.de>
In-Reply-To: <20201114165336.GA24844@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.148]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Sunday, November 15, 2020 5:54 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: iommu@lists.linux-foundation.org; hch@lst.de; robin.murphy@arm.com;
> m.szyprowski@samsung.com; Linuxarm <linuxarm@huawei.com>;
> linux-kselftest@vger.kernel.org; xuwei (O) <xuwei5@huawei.com>; Joerg
> Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Shuah Khan
> <shuah@kernel.org>
> Subject: Re: [PATCH v3 1/2] dma-mapping: add benchmark support for
> streaming DMA APIs
> 
> Lots of > 80 char lines.  Please fix up the style.

Checkpatch has changed 80 to 100. That's probably why my local checkpatch didn't report any warning:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d

I am happy to change them to be less than 80 if you like.

> 
> I think this needs to set a dma mask as behavior for unlimited dma
> mask vs the default 32-bit one can be very different. 

I actually prefer users bind real devices with real dma_mask to test rather than force to change
the dma_mask in this benchmark.

Some device might have 32bit dma_mask while some others might have unlimited. But both of
them can bind to this driver or unbind from it after the test is done. So users just need to bind
those different real devices with different real dma_mask to dma_benchmark.

This can reflect the real performance of the real device better, I think.

> I also think you need to be able to pass the direction or have different tests
> for directions.  bidirectional is not exactly heavily used and pays
> more cache management penality.

For this, I'd like to increase a direction option in the test app and pass the option to the benchmark
driver.

Thanks
Barry

