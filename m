Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B914F1238DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2019 22:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLQVuc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Dec 2019 16:50:32 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2035 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfLQVub (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Dec 2019 16:50:31 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df94d9d0001>; Tue, 17 Dec 2019 13:50:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 17 Dec 2019 13:50:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 17 Dec 2019 13:50:30 -0800
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Dec
 2019 21:50:25 +0000
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
 <20191217205147.GI16762@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <59d4ea9e-3f6b-11c2-75d1-5baecd5b4ae2@nvidia.com>
Date:   Tue, 17 Dec 2019 13:50:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191217205147.GI16762@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576619421; bh=ubRwwOL58AcjmKU930Mo4/AFRBsWefx09sMu3dEEirc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=o9X58MhU1lozHt8qde/Q5U6KjYd3qMmrQyCLe2/+dszqfziDR3n8ceyKtdUt/KX2T
         TqANXJM1PO5DhmjicCs066E7UMKoUTge6kuelmVtI2V9U/sGPLHcT03CF66JpnjXip
         enuLbXhSPdGSMkoV24owjgKJgocKN8sCz5K5vOie5/e5qQDxECTI6zFOuSfSwGJhVo
         8zFisarGWYrEei1T7nwS6gVgSyZ7TWeD3NMJnTuAWn1zGKaZPOjLQvlqMmJtbUg9Pi
         kGfdoBRjEL93SOfMYpJQYz1+bIA1eSUOemZh5H0qWX7H3nPekrmfWwJMbg4pMuWy7r
         BUPx+RMAK+nOA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 12/17/19 12:51 PM, Jason Gunthorpe wrote:
> On Mon, Dec 16, 2019 at 11:57:32AM -0800, Ralph Campbell wrote:
>> mmu_interval_notifier_insert() and mmu_interval_notifier_remove() can't
>> be called safely from inside the invalidate() callback. This is fine for
>> devices with explicit memory region register and unregister calls but it
>> is desirable from a programming model standpoint to not require explicit
>> memory region registration. Regions can be registered based on device
>> address faults but without a mechanism for updating or removing the mmu
>> interval notifiers in response to munmap(), the invalidation callbacks
>> will be for regions that are stale or apply to different mmaped regions.
> 
> What we do in RDMA is drive the removal from a work queue, as we need
> a synchronize_srcu anyhow to serialize everything to do with
> destroying a part of the address space mirror.
> 
> Is it really necessary to have all this stuff just to save doing
> something like a work queue?

Well, the invalidates already have to use the driver lock to synchronize
so handling the range tracking updates semi-synchronously seems more
straightforward to me.

Do you feel strongly that adding a work queue is the right way to handle
this?

> Also, I think we are not taking core kernel APIs like this with out an
> in-kernel user??

Right. I was looking for feedback before updating nouveau to use it.

>> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
>> index 9e6caa8ecd19..55fbefcdc564 100644
>> +++ b/include/linux/mmu_notifier.h
>> @@ -233,11 +233,18 @@ struct mmu_notifier {
>>    * @invalidate: Upon return the caller must stop using any SPTEs within this
>>    *              range. This function can sleep. Return false only if sleeping
>>    *              was required but mmu_notifier_range_blockable(range) is false.
>> + * @release:	This function will be called when the mmu_interval_notifier
>> + *		is removed from the interval tree. Defining this function also
>> + *		allows mmu_interval_notifier_remove() and
>> + *		mmu_interval_notifier_update() to be called from the
>> + *		invalidate() callback function (i.e., they won't block waiting
>> + *		for invalidations to finish.
> 
> Having a function called remove that doesn't block seems like very
> poor choice of language, we've tended to use put to describe that
> operation.
> 
> The difference is meaningful as people often create use after free
> bugs in drivers when presented with interfaces named 'remove' or
> 'destroy' that don't actually guarentee there is not going to be
> continued accesses to the memory.

OK. I can rename it put().

>>    */
>>   struct mmu_interval_notifier_ops {
>>   	bool (*invalidate)(struct mmu_interval_notifier *mni,
>>   			   const struct mmu_notifier_range *range,
>>   			   unsigned long cur_seq);
>> +	void (*release)(struct mmu_interval_notifier *mni);
>>   };
>>   
>>   struct mmu_interval_notifier {
>> @@ -246,6 +253,8 @@ struct mmu_interval_notifier {
>>   	struct mm_struct *mm;
>>   	struct hlist_node deferred_item;
>>   	unsigned long invalidate_seq;
>> +	unsigned long deferred_start;
>> +	unsigned long deferred_last;
> 
> I couldn't quite understand how something like this can work, what is
> preventing parallel updates?

It is serialized by the struct mmu_notifier_mm lock.
If there are no tasks walking the interval tree, the update
happens synchronously under the lock. If there are walkers,
the start/last values are stored under the lock and the last caller's
values are used to update the interval tree when the last walker
finishes (under the lock again).

>> +/**
>> + * mmu_interval_notifier_update - Update interval notifier end
>> + * @mni: Interval notifier to update
>> + * @start: New starting virtual address to monitor
>> + * @length: New length of the range to monitor
>> + *
>> + * This function updates the range being monitored.
>> + * If there is no release() function defined, the call will wait for the
>> + * update to finish before returning.
>> + */
>> +int mmu_interval_notifier_update(struct mmu_interval_notifier *mni,
>> +				 unsigned long start, unsigned long length)
>> +{
> 
> Update should probably be its own patch
> 
> Jason

OK.
Thanks for the review.
