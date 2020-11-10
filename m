Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87EB2AD165
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 09:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgKJIin (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 03:38:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2079 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJIim (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 03:38:42 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CVh7K19MDz67DbT;
        Tue, 10 Nov 2020 16:37:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 10 Nov 2020 09:38:39 +0100
Received: from [10.210.169.2] (10.210.169.2) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 10 Nov
 2020 08:38:38 +0000
Subject: Re: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "hch@lst.de" <hch@lst.de>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>,
        Shuah Khan <shuah@kernel.org>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
 <20201102080646.2180-2-song.bao.hua@hisilicon.com>
 <eb317e5050b944c3aec97c5fb64a74cb@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0658ee16-d539-61c5-1d39-77d50f559803@huawei.com>
Date:   Tue, 10 Nov 2020 08:38:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <eb317e5050b944c3aec97c5fb64a74cb@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.2]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/11/2020 08:10, Song Bao Hua (Barry Song) wrote:
> Hello Robin, Christoph,
> Any further comment? John suggested that "depends on DEBUG_FS" should be added in Kconfig.
> I am collecting more comments to send v4 together with fixing this minor issue :-)
> 
> Thanks
> Barry
> 
>> -----Original Message-----
>> From: Song Bao Hua (Barry Song)
>> Sent: Monday, November 2, 2020 9:07 PM
>> To: iommu@lists.linux-foundation.org; hch@lst.de; robin.murphy@arm.com;
>> m.szyprowski@samsung.com
>> Cc: Linuxarm <linuxarm@huawei.com>; linux-kselftest@vger.kernel.org; xuwei
>> (O) <xuwei5@huawei.com>; Song Bao Hua (Barry Song)
>> <song.bao.hua@hisilicon.com>; Joerg Roedel <joro@8bytes.org>; Will Deacon
>> <will@kernel.org>; Shuah Khan <shuah@kernel.org>
>> Subject: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
>> DMA APIs
>>
>> Nowadays, there are increasing requirements to benchmark the performance
>> of dma_map and dma_unmap particually while the device is attached to an
>> IOMMU.
>>
>> This patch enables the support. Users can run specified number of threads to
>> do dma_map_page and dma_unmap_page on a specific NUMA node with the
>> specified duration. Then dma_map_benchmark will calculate the average
>> latency for map and unmap.
>>
>> A difficulity for this benchmark is that dma_map/unmap APIs must run on a
>> particular device. Each device might have different backend of IOMMU or
>> non-IOMMU.
>>
>> So we use the driver_override to bind dma_map_benchmark to a particual
>> device by:
>> For platform devices:
>> echo dma_map_benchmark > /sys/bus/platform/devices/xxx/driver_override
>> echo xxx > /sys/bus/platform/drivers/xxx/unbind
>> echo xxx > /sys/bus/platform/drivers/dma_map_benchmark/bind
>>

Hi Barry,

>> For PCI devices:
>> echo dma_map_benchmark >
>> /sys/bus/pci/devices/0000:00:01.0/driver_override
>> echo 0000:00:01.0 > /sys/bus/pci/drivers/xxx/unbind echo 0000:00:01.0 >
>> /sys/bus/pci/drivers/dma_map_benchmark/bind

Do we need to check if the device to which we attach actually has DMA 
mapping capability?

>>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>> ---

Thanks,
John
