Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E64E139CC0
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 23:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgAMWo5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 17:44:57 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8219 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgAMWo5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 17:44:57 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1cf2d40000>; Mon, 13 Jan 2020 14:44:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 14:44:56 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jan 2020 14:44:56 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan
 2020 22:44:52 +0000
Subject: Re: [PATCH v5 1/2] mm/mmu_notifier: make interval notifier updates
 safe
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <20191216195733.28353-1-rcampbell@nvidia.com>
 <20191216195733.28353-2-rcampbell@nvidia.com>
 <20200109194805.GK20978@mellanox.com>
 <73225ded-c22d-33f2-ebcb-b9e9aa95266b@nvidia.com>
 <20200109232548.GO20978@mellanox.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <633a3dda-d4d7-1233-b290-53d36fb8fda1@nvidia.com>
Date:   Mon, 13 Jan 2020 14:44:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200109232548.GO20978@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578955476; bh=7TMyQAyBFp1DtzmW42ZsabWDd5djN+Ro8smtOwxU9Io=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nCIqkg8KqZuotUvu9Aohq0Eqq1R11k/IujyaARjsUtTmEQ+oJFnZSznlQL3rSn3cc
         ck/eSXnhIskrTlONTXLdl+xOh/MrdimK0KW7NfqJda9zFw6QDqXrZfnU2TSO+vkd05
         az4WyUQFkBEUE44bnRtJVpDnV8GrLIyOp/suwFfQy4twnc6wDIuKmfKFU0Q/SPVtqi
         IePaGmTg5Qa14Uzyt0sHQ/ALx1JrlbL3PFBrZ4fornOqXG58M3PWtnvlwNHb4Jr4Bf
         2wnuwAFo2iHk3P8Pgq2ZVriDZI9aYnXIBzWYLd9cdKi4OvDPvlU7q+kxacwLHv8AoM
         VQhn5irDhqygA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 1/9/20 3:25 PM, Jason Gunthorpe wrote:
> On Thu, Jan 09, 2020 at 02:01:21PM -0800, Ralph Campbell wrote:
> 
>>> I'd write it more like
>>>
>>> if (mni->updated_start == mni->updated_end)
>>>       insert
>>> else
>>>       remove
>>
>> OK, but I'm using updated_end == 0, not updated_start, and the end can't be zero.
> 
> Tricky..
>   
>>> ie an empty interval can't get a notification so it should be removed
>>> from the tree.
>>>
>>> I also like the name 'updated' better than deferred, it is a bit
>>> clearer..
>>
>> OK.
>>
>>> Adding release should it's own patch.
>>
>> The release callback is associated with mmu_interval_notifier_put()
>> (i.e., async remove). Otherwise, there is no way to know when the
>> interval can be freed.
> 
> Okay, but this patch is just trying to add update?
> 
>>> So why do we need this? You can't call hmm_range_fault from a
>>> notifier. You just can't.
>>>
>>> So there should be no reason to create an interval from the notifier,
>>> do it from where you call hmm_range_fault, and it must be safe to
>>> obtain the mmap_sem from that thread.
>>
>> I was thinking of the case where munmap() creates a hole in the interval.
>> The invalidate callback would need to update the interval to cover the
>> left side of the remaining interval and an insert to cover the right
>> side. Otherwise, the HW invalidation has to be extended to cover the
>> right side and rely on a fault to re-establish the right side interval.
> 
> This is very tricky because this algorithm can only work correctly if
> done atomically as a batch entirely under the spinlock. Forcing it
> into the defered list while holding the lock is the only way to do
> something like that sensibly..
> 
> So 'update' is not some generic API you can call, it can only be done
> while the interval tree is locked for reading. Thus 'safe' is probably
> the wrong name, it is actually 'interval tree locked for read'
> 
> At the minimum this needs to be comprehensively documented and we need
> a lockdep style assertion that we are locked when doing it..
> 
> And if we are defining things like that then it might as well be
> expressed as a remove/insert/insert batch operation rather than
> a somewhat confusing update.
> 
>> Now the plan for v6 is to leave mmu_interval_notifier_remove() unchanged,
>> add mmu_interval_notifier_put() for async/safe removal and make 'update'
>> be asynchronous only and, as you say, rely on mmu_interval_read_begin()
>> to be sure all delayed add/remove/updates are complete.
> 
> Hm, we can see what injecting reference counts would look like.
> 
>> I'm also planning to add a mmu_interval_notifier_find() so that nouveau
>> and the self tests don't need to create a duplicate interval range tree
>> to track the intervals that they have registered. There isn't an existing
>> structure that the struct mmu_interval_notifier can just be added to so
>> it ends up being a separately allocated structure and would need to be
>> stored in some sort of table so I thought why not just use the itree.
> 
> Okay, but for locking reasons find is also a little tricky. I suppose
> find can obtain the read side lock on the interval tree and then the
> caller would have to find_unlock once it has refcounted or finished
> accessing the object. Much like how the invalidate callback is locked.
> 
>> This is all useful feedback. I am working on v6 which addresses your concerns
>> and updates nouveau to use the new API. I'm somewhat sidetracked by the lockdep
>> issue I posted about nouveau calling kmalloc(GFP_KERNEL) from the invalidation
>> callback so it may take me awhile to sort that out.
>> Since we are at -rc5, I'm guessing this won't have enough soak time to make 5.6.
> 
> Yes, sorry for the delay, lots of travel and a mountain of emails. I
> am almost caught up now. But you can post it at least.
> 
> Jason
> 
I'm using the device driver lock to serialize find/insert/update/remove
changes to the interval tree. The important thing is to have a registered
interval covering any shadow PTEs in the hardware and the driver lock that
protects the updates to the HW and sequence number also protects updates
to the registered intervals.
Hopefully, this will be easier to understand with v6 which I'm posting
for review.
