Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F27D1AB1EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 21:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438305AbgDOTjx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 15:39:53 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7973 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438414AbgDOTju (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 15:39:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9762f70000>; Wed, 15 Apr 2020 12:39:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 12:39:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Apr 2020 12:39:48 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 19:39:48 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 19:39:45 +0000
Subject: Re: [PATCH v8 0/3] mm/hmm/test: add self tests for HMM
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <20200321003108.22941-1-rcampbell@nvidia.com>
 <20200415144125.GU11945@mellanox.com>
 <6d7adb28-96a0-5dc5-e85e-68fca2db403a@nvidia.com>
 <20200415192952.GA1309273@unreal>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <1b94e41d-2335-0cb4-9605-cf9f404900c9@nvidia.com>
Date:   Wed, 15 Apr 2020 12:39:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200415192952.GA1309273@unreal>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586979576; bh=CdwI3TE7mjxq3Xc5avzMiLVH9J/fDrvWtdvamz5cGWs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=G8tE/bID65F9EsfeKZ8G28VAMO3LtN+g9x5yin4doG9IcneSAWmCCsnD3fbqhtr/f
         S4pf0Z21NzvjFYRSlWSsLTTHkTSU6apnjP+DC0NkcJFaef0vV8zx2LF8YANXfsXV1a
         jBvjjFTQ2ce0UC00L2OX+HRt1UGvpLti9fJoKCezjOUPo0iaZ0OP+c0iPB3DYHNSOY
         3theRn7BAu6deEEZAXw49I3MgR4Ld2hKXHlxOQBZM2eekpET8umEcCeg4MoJ8z+fXu
         eixnTA1GBUVdGyrdBh362h8YZ03CRPl8kD7Zegx536S67u38diFxKDZ94Ir5Dg8QgN
         tcE8AYOottc0Q==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/15/20 12:29 PM, Leon Romanovsky wrote:
> On Wed, Apr 15, 2020 at 10:28:23AM -0700, Ralph Campbell wrote:
>>
>> On 4/15/20 7:41 AM, Jason Gunthorpe wrote:
>>> On Fri, Mar 20, 2020 at 05:31:05PM -0700, Ralph Campbell wrote:
>>>> This series adds basic self tests for HMM and are intended for Jason
>>>> Gunthorpe's rdma tree which has a number of HMM patches applied.
>>>
>>> Here are some hunks I noticed while testing this:
>>>
>>> --- a/lib/Kconfig.debug
>>> +++ b/lib/Kconfig.debug
>>> @@ -2201,7 +2201,8 @@ config TEST_MEMINIT
>>>    config TEST_HMM
>>>    	tristate "Test HMM (Heterogeneous Memory Management)"
>>> -	depends on DEVICE_PRIVATE
>>> +	depends on TRANSPARENT_HUGEPAGE
>>> +	select DEVICE_PRIVATE
>>>    	select HMM_MIRROR
>>>    	select MMU_NOTIFIER
>>>    	help
>>>
>>> It fails testing if TRANSPARENT_HUGEPAGE is not on
>>>
>>> @@ -1097,6 +1071,7 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
>>>    	spin_lock_init(&mdevice->lock);
>>>    	cdev_init(&mdevice->cdevice, &dmirror_fops);
>>> +	mdevice->cdevice.owner = THIS_MODULE;
>>>    	ret = cdev_add(&mdevice->cdevice, dev, 1);
>>>    	if (ret)
>>>    		return ret;
>>>
>>> The use of cdev without a struct device is super weird, but it still
>>> needs this
>>>
>>> diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
>>> index 461e4a99a362cf..0647b525a62564 100755
>>> --- a/tools/testing/selftests/vm/test_hmm.sh
>>> +++ b/tools/testing/selftests/vm/test_hmm.sh
>>> @@ -59,7 +59,7 @@ run_smoke()
>>>    	echo "Running smoke test. Note, this test provides basic coverage."
>>>    	load_driver
>>> -	./hmm-tests
>>> +	$(dirname "${BASH_SOURCE[0]}")/hmm-tests
>>>    	unload_driver
>>>    }
>>>
>>> Make it runnably reliably
>>>
>>> Jason
>>
>> Thanks for the fixes. I'll apply these and send a v9.
>> I will also add missing calls to release_mem_region() to free the reserved device private
>> addresses.
> 
> If you decide to ignore my request to avoid addition of special header
> file to UAPI, at least don't copy and install that file without some
> special CONFIG option (TEST_HMM ???) requested by the users. It also
> will be good to get Acked-by on this change from HMM people.
> 
> However, I still think that include/uapi/linux/test_hmm.h opens
> pandora box of having UAPI files without real promise to keep it
> backward compatible.
> 
> Thanks

I think that is a valid point. I would expect the test<->driver UAPI to track the kernel
version since the sources are "released" together. I suppose a version number could be
included in the request structure to handle mismatch driver and test program but that
may be overkill.
Are you suggesting that include/linux/test_hmm.h is a better location?
