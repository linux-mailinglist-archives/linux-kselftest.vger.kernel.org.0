Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C2F1AAFAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 19:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411078AbgDOR2o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 13:28:44 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3196 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411067AbgDOR2b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 13:28:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9743cf0000>; Wed, 15 Apr 2020 10:26:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 10:28:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Apr 2020 10:28:28 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 17:28:28 +0000
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 15 Apr 2020 17:28:23 +0000
Subject: Re: [PATCH v8 0/3] mm/hmm/test: add self tests for HMM
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <20200321003108.22941-1-rcampbell@nvidia.com>
 <20200415144125.GU11945@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <6d7adb28-96a0-5dc5-e85e-68fca2db403a@nvidia.com>
Date:   Wed, 15 Apr 2020 10:28:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200415144125.GU11945@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586971599; bh=dqlcMJl24ki/evoHvr/O4JoODiicyWi8Sw0LjbvxTvI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TuSrV2IsUaLFPSBBuyEzLITMxYVaL+ZGWD/29n2/5zxMAGCt8AFyzMstB7sbQ4ffN
         UoVgp2iLlLj55PlXTvsW2ckwc0ZH3UeDStag9jQVm3MMmjmYXvhNk4k1/jN1WdlF8y
         KlMdAJh36AB7Oa1ntTlfMPxz/lkXKs/fxSJqesbZPw8R7TSWBNMaWIlCDtE7WpDdxJ
         ILyI0u2vuNk2k+tepYOP6DJ5oic+Tjj99uI+MX11sLbMiC2JJCuvfFJ1UW7t37kw2G
         TSPYbNDD0pgysPSGkU7I6q2Gs0POH5MyLY9ujSSXbjnSMc4WEG74xtVR+SXknlLCa/
         evkqAuEz7eDDw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/15/20 7:41 AM, Jason Gunthorpe wrote:
> On Fri, Mar 20, 2020 at 05:31:05PM -0700, Ralph Campbell wrote:
>> This series adds basic self tests for HMM and are intended for Jason
>> Gunthorpe's rdma tree which has a number of HMM patches applied.
> 
> Here are some hunks I noticed while testing this:
> 
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2201,7 +2201,8 @@ config TEST_MEMINIT
>   
>   config TEST_HMM
>   	tristate "Test HMM (Heterogeneous Memory Management)"
> -	depends on DEVICE_PRIVATE
> +	depends on TRANSPARENT_HUGEPAGE
> +	select DEVICE_PRIVATE
>   	select HMM_MIRROR
>   	select MMU_NOTIFIER
>   	help
> 
> It fails testing if TRANSPARENT_HUGEPAGE is not on
> 
> @@ -1097,6 +1071,7 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
>   	spin_lock_init(&mdevice->lock);
>   
>   	cdev_init(&mdevice->cdevice, &dmirror_fops);
> +	mdevice->cdevice.owner = THIS_MODULE;
>   	ret = cdev_add(&mdevice->cdevice, dev, 1);
>   	if (ret)
>   		return ret;
> 
> The use of cdev without a struct device is super weird, but it still
> needs this
> 
> diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
> index 461e4a99a362cf..0647b525a62564 100755
> --- a/tools/testing/selftests/vm/test_hmm.sh
> +++ b/tools/testing/selftests/vm/test_hmm.sh
> @@ -59,7 +59,7 @@ run_smoke()
>   	echo "Running smoke test. Note, this test provides basic coverage."
>   
>   	load_driver
> -	./hmm-tests
> +	$(dirname "${BASH_SOURCE[0]}")/hmm-tests
>   	unload_driver
>   }
> 
> Make it runnably reliably
> 
> Jason

Thanks for the fixes. I'll apply these and send a v9.
I will also add missing calls to release_mem_region() to free the reserved device private
addresses.
