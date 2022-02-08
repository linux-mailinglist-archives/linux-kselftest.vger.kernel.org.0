Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDCE4AD4AB
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 10:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349319AbiBHJWg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 04:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347495AbiBHJWf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 04:22:35 -0500
X-Greylist: delayed 1115 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 01:22:34 PST
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5A5C0401F0
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 01:22:34 -0800 (PST)
Received: from dggeme707-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JtH6Q1xHLzdZVv;
        Tue,  8 Feb 2022 17:00:46 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggeme707-chm.china.huawei.com (10.1.199.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 8 Feb 2022 17:03:56 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2308.021;
 Tue, 8 Feb 2022 17:03:56 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        Linuxarm <linuxarm@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Update maintainer list of DMA MAPPING
 BENCHMARK
Thread-Topic: [PATCH] MAINTAINERS: Update maintainer list of DMA MAPPING
 BENCHMARK
Thread-Index: AQHYHLrvrY3eKSxYwEOdonQA5mzelKyJWKQg
Date:   Tue, 8 Feb 2022 09:03:56 +0000
Message-ID: <2f855d6e368a49bc965ca5c3188d35a8@hisilicon.com>
References: <1644303891-81063-1-git-send-email-chenxiang66@hisilicon.com>
In-Reply-To: <1644303891-81063-1-git-send-email-chenxiang66@hisilicon.com>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.61]
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
> From: chenxiang (M)
> Sent: Tuesday, February 8, 2022 8:05 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; hch@lst.de;
> m.szyprowski@samsung.com; robin.murphy@arm.com
> Cc: linuxarm@openeuler.org; Linuxarm <linuxarm@huawei.com>;
> iommu@lists.linux-foundation.org; linux-kselftest@vger.kernel.org;
> chenxiang (M) <chenxiang66@hisilicon.com>
> Subject: [PATCH] MAINTAINERS: Update maintainer list of DMA MAPPING BENCHMARK
> 
> From: Xiang Chen <chenxiang66@hisilicon.com>
> 
> Barry Song will not focus on this area, and Xiang Chen will continue his
> work to maintain this module.
> 
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>

Acked-by: Barry Song <song.bao.hua@hisilicon.com>

Xiang has been an user of this module and has made substantial
contributions not only to this module and but also to related
modules such as iommu/arm-smmu-v3.
My this email account will be unreachable in this month. And
probably I will rarely work on this module afterwards. So I
am happy Xiang will take care of it. Thanks!

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..48335022b0e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5765,7 +5765,7 @@ F:	include/linux/dma-map-ops.h
>  F:	kernel/dma/
> 
>  DMA MAPPING BENCHMARK
> -M:	Barry Song <song.bao.hua@hisilicon.com>
> +M:	Xiang Chen <chenxiang66@hisilicon.com>
>  L:	iommu@lists.linux-foundation.org
>  F:	kernel/dma/map_benchmark.c
>  F:	tools/testing/selftests/dma/
> --
> 2.33.0

Best Regards,
Barry
