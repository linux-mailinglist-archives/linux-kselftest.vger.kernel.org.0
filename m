Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A142B39BF
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Nov 2020 22:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgKOVyx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Nov 2020 16:54:53 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2306 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKOVyx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Nov 2020 16:54:53 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CZ5Zk1rpTz13QFJ;
        Mon, 16 Nov 2020 05:54:22 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 16 Nov 2020 05:54:45 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Mon, 16 Nov 2020 05:54:45 +0800
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
Thread-Index: AQHWuqaxiT3rvc8AvUKektYgWKvLn6nIS8nQgAAQE4CAAVfXkA==
Date:   Sun, 15 Nov 2020 21:54:45 +0000
Message-ID: <cb7a42bd21f8488f861ebfd7fa46cef6@hisilicon.com>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
 <20201102080646.2180-2-song.bao.hua@hisilicon.com>
 <20201114165336.GA24844@lst.de>
 <5c4488dd28fc4869b7e67dd842ffa208@hisilicon.com>
 <20201115084515.GA18411@lst.de>
In-Reply-To: <20201115084515.GA18411@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.73]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Sunday, November 15, 2020 9:45 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Christoph Hellwig <hch@lst.de>; iommu@lists.linux-foundation.org;
> robin.murphy@arm.com; m.szyprowski@samsung.com; Linuxarm
> <linuxarm@huawei.com>; linux-kselftest@vger.kernel.org; xuwei (O)
> <xuwei5@huawei.com>; Joerg Roedel <joro@8bytes.org>; Will Deacon
> <will@kernel.org>; Shuah Khan <shuah@kernel.org>
> Subject: Re: [PATCH v3 1/2] dma-mapping: add benchmark support for
> streaming DMA APIs
> 
> On Sun, Nov 15, 2020 at 12:11:15AM +0000, Song Bao Hua (Barry Song)
> wrote:
> >
> > Checkpatch has changed 80 to 100. That's probably why my local checkpatch
> didn't report any warning:
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=
> bdc48fa11e46f867ea4d
> >
> > I am happy to change them to be less than 80 if you like.
> 
> Don't rely on checkpath, is is broken.  Look at the codingstyle document.
> 
> > > I think this needs to set a dma mask as behavior for unlimited dma
> > > mask vs the default 32-bit one can be very different.
> >
> > I actually prefer users bind real devices with real dma_mask to test rather
> than force to change
> > the dma_mask in this benchmark.
> 
> The mask is set by the driver, not the device.  So you need to set when
> when you bind, real device or not.

Yep while it is a little bit tricky.

Sometimes, it is done by "device" in architectures, e.g. there are lots of
dma_mask configuration code in arch/arm/mach-xxx.
arch/arm/mach-davinci/da850.c
static u64 da850_vpif_dma_mask = DMA_BIT_MASK(32);
static struct platform_device da850_vpif_dev = {
	.name		= "vpif",
	.id		= -1,
	.dev		= {
		.dma_mask		= &da850_vpif_dma_mask,
		.coherent_dma_mask	= DMA_BIT_MASK(32),
	},
	.resource	= da850_vpif_resource,
	.num_resources	= ARRAY_SIZE(da850_vpif_resource),
};

Sometimes, it is done by "of" or "acpi", for example:
drivers/acpi/arm64/iort.c
void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
{
	u64 end, mask, dmaaddr = 0, size = 0, offset = 0;
	int ret;

	...

	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
	if (!ret) {
		/*
		 * Limit coherent and dma mask based on size retrieved from
		 * firmware.
		 */
		end = dmaaddr + size - 1;
		mask = DMA_BIT_MASK(ilog2(end) + 1);
		dev->bus_dma_limit = end;
		dev->coherent_dma_mask = mask;
		*dev->dma_mask = mask;
	}
	...
}

Sometimes, it is done by "bus", for example, ISA:
		isa_dev->dev.coherent_dma_mask = DMA_BIT_MASK(24);
		isa_dev->dev.dma_mask = &isa_dev->dev.coherent_dma_mask;

		error = device_register(&isa_dev->dev);
		if (error) {
			put_device(&isa_dev->dev);
			break;
		}

And in many cases, it is done by driver. On the ARM64 server platform I am testing,
actually rarely drivers set dma_mask.

So to make the dma benchmark work on all platforms, it seems it is worth
to add a dma_mask_bit parameter. But, in order to avoid breaking the
dma_mask of those devices whose dma_mask are set by architectures, 
acpi and bus, it seems we need to do the below in dma_benchmark:

u64 old_mask;

old_mask = dma_get_mask(dev);

dma_set_mask(dev, &new_mask);

do_map_benchmark();

/* restore old dma_mask so that the dma_mask of the device is not changed due to
benchmark when it is bound back to its original driver */
dma_set_mask(dev, &old_mask);

Thanks
Barry

