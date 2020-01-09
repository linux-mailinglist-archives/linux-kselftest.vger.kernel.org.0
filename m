Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE361362F9
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2020 23:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAIWB2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jan 2020 17:01:28 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13075 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgAIWB1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jan 2020 17:01:27 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e17a2830000>; Thu, 09 Jan 2020 14:00:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Jan 2020 14:01:25 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Jan 2020 14:01:25 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jan
 2020 22:01:21 +0000
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
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <73225ded-c22d-33f2-ebcb-b9e9aa95266b@nvidia.com>
Date:   Thu, 9 Jan 2020 14:01:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200109194805.GK20978@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578607235; bh=KaksIUJ+tJMmTfssXJrk0OMEZdzZpEYh9yhbZD0uQ5M=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JBOBHgqGagmi5BRElHk+8l5MwnHbB0tI1r7vDDY7N65qIbTuvCpx8i2F7w8GiH1Ms
         2rKB4OkILpw69QB6NKeSEaC4GET7r/T/n8782F1nvDlp9qTBB7Ewn49A5byutzJun5
         idfceaYSZetMqO6j580Hd49QUmUO3OS73vjL6oSd1qp7r0bHBlPggWiGvVrr6V6ENr
         724DazD08lPhuySfz8ycvnpiWXGfszcbMOqgeLM/qOhYW/evz2VKtS3ihtqVa7oyhA
         IVNCITCmgD5PxX2V9EqpdK8S0JXIHXwenRK68qMW/IDnPZHY1zbxirx3DvwOp5wJra
         J1fVqDLZDSGGA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 1/9/20 11:48 AM, Jason Gunthorpe wrote:
> On Mon, Dec 16, 2019 at 11:57:32AM -0800, Ralph Campbell wrote:
>> mmu_interval_notifier_insert() and mmu_interval_notifier_remove() can't
>> be called safely from inside the invalidate() callback. This is fine for
>> devices with explicit memory region register and unregister calls but it
>> is desirable from a programming model standpoint to not require explicit
>> memory region registration. Regions can be registered based on device
>> address faults but without a mechanism for updating or removing the mmu
>> interval notifiers in response to munmap(), the invalidation callbacks
>> will be for regions that are stale or apply to different mmaped regions.
>>
>> The invalidate() callback provides the necessary information (i.e.,
>> the event type MMU_NOTIFY_UNMAP) so add insert, remove, and update
>> functions that are safe to call from the invalidate() callback by
>> extending the work done in mn_itree_inv_end() to update the interval tree
>> when it is not being traversed.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>>   include/linux/mmu_notifier.h |  15 +++
>>   mm/mmu_notifier.c            | 196 ++++++++++++++++++++++++++++++-----
>>   2 files changed, 186 insertions(+), 25 deletions(-)
>>
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
>>   };
>>   
>>   #ifdef CONFIG_MMU_NOTIFIER
>> @@ -299,7 +308,13 @@ int mmu_interval_notifier_insert_locked(
>>   	struct mmu_interval_notifier *mni, struct mm_struct *mm,
>>   	unsigned long start, unsigned long length,
>>   	const struct mmu_interval_notifier_ops *ops);
>> +int mmu_interval_notifier_insert_safe(
>> +	struct mmu_interval_notifier *mni, struct mm_struct *mm,
>> +	unsigned long start, unsigned long length,
>> +	const struct mmu_interval_notifier_ops *ops);
>>   void mmu_interval_notifier_remove(struct mmu_interval_notifier *mni);
>> +int mmu_interval_notifier_update(struct mmu_interval_notifier *mni,
>> +				 unsigned long start, unsigned long length);
>>   
>>   /**
>>    * mmu_interval_set_seq - Save the invalidation sequence
>> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
>> index f76ea05b1cb0..c303285750b2 100644
>> +++ b/mm/mmu_notifier.c
>> @@ -129,6 +129,7 @@ static void mn_itree_inv_end(struct mmu_notifier_mm *mmn_mm)
>>   {
>>   	struct mmu_interval_notifier *mni;
>>   	struct hlist_node *next;
>> +	struct hlist_head removed_list;
>>   
>>   	spin_lock(&mmn_mm->lock);
>>   	if (--mmn_mm->active_invalidate_ranges ||
>> @@ -144,21 +145,47 @@ static void mn_itree_inv_end(struct mmu_notifier_mm *mmn_mm)
>>   	 * The inv_end incorporates a deferred mechanism like rtnl_unlock().
>>   	 * Adds and removes are queued until the final inv_end happens then
>>   	 * they are progressed. This arrangement for tree updates is used to
>> -	 * avoid using a blocking lock during invalidate_range_start.
>> +	 * avoid using a blocking lock while walking the interval tree.
>>   	 */
>> +	INIT_HLIST_HEAD(&removed_list);
>>   	hlist_for_each_entry_safe(mni, next, &mmn_mm->deferred_list,
>>   				  deferred_item) {
>> +		hlist_del(&mni->deferred_item);
>>   		if (RB_EMPTY_NODE(&mni->interval_tree.rb))
>>   			interval_tree_insert(&mni->interval_tree,
>>   					     &mmn_mm->itree);
>> -		else
>> +		else {
>>   			interval_tree_remove(&mni->interval_tree,
>>   					     &mmn_mm->itree);
>> -		hlist_del(&mni->deferred_item);
>> +			if (mni->deferred_last) {
>> +				mni->interval_tree.start = mni->deferred_start;
>> +				mni->interval_tree.last = mni->deferred_last;
>> +				mni->deferred_last = 0;
> 
> Technicaly we can have an interval starting at zero.
> 
> I'd write it more like
> 
> if (mni->updated_start == mni->updated_end)
>      insert
> else
>      remove

OK, but I'm using updated_end == 0, not updated_start, and the end can't be zero.

> ie an empty interval can't get a notification so it should be removed
> from the tree.
> 
> I also like the name 'updated' better than deferred, it is a bit
> clearer..

OK.

> Adding release should it's own patch.

The release callback is associated with mmu_interval_notifier_put()
(i.e., async remove). Otherwise, there is no way to know when the
interval can be freed.

>> @@ -970,14 +999,52 @@ int mmu_interval_notifier_insert_locked(
>>   EXPORT_SYMBOL_GPL(mmu_interval_notifier_insert_locked);
>>   
>>   /**
>> - * mmu_interval_notifier_remove - Remove a interval notifier
>> - * @mni: Interval notifier to unregister
>> + * mmu_interval_notifier_insert_safe - Insert an interval notifier
>> + * @mni: Interval notifier to register
>> + * @mm : mm_struct to attach to
>> + * @start: Starting virtual address to monitor
>> + * @length: Length of the range to monitor
>> + * @ops: Interval notifier callback operations
>>    *
>> - * This function must be paired with mmu_interval_notifier_insert(). It cannot
>> - * be called from any ops callback.
>> + * Return: -EINVAL if @mm hasn't been initialized for interval notifiers
>> + *	by calling mmu_notifier_register(NULL, mm) or
>> + *	__mmu_notifier_register(NULL, mm).
>>    *
>> - * Once this returns ops callbacks are no longer running on other CPUs and
>> - * will not be called in future.
>> + * This function subscribes the interval notifier for notifications from the
>> + * mm.  Upon return, the ops related to mmu_interval_notifier will be called
>> + * whenever an event that intersects with the given range occurs.
>> + *
>> + * This function is safe to call from the ops->invalidate() function.
>> + * Upon return, the mmu_interval_notifier may not be present in the interval
>> + * tree yet.  The caller must use the normal interval notifier read flow via
>> + * mmu_interval_read_begin() to establish SPTEs for this range.
> 
> So why do we need this? You can't call hmm_range_fault from a
> notifier. You just can't.
> 
> So there should be no reason to create an interval from the notifier,
> do it from where you call hmm_range_fault, and it must be safe to
> obtain the mmap_sem from that thread.

I was thinking of the case where munmap() creates a hole in the interval.
The invalidate callback would need to update the interval to cover the
left side of the remaining interval and an insert to cover the right
side. Otherwise, the HW invalidation has to be extended to cover the
right side and rely on a fault to re-establish the right side interval.

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
>> +	struct mm_struct *mm = mni->mm;
>> +	struct mmu_notifier_mm *mmn_mm = mm->mmu_notifier_mm;
>> +	unsigned long seq = 0;
>> +	unsigned long last;
>> +
>> +	if (length == 0 || check_add_overflow(start, length - 1, &last))
>> +		return -EOVERFLOW;
>> +
>> +	spin_lock(&mmn_mm->lock);
>> +	if (mn_itree_is_invalidating(mmn_mm)) {
>> +		/*
>> +		 * Update is being called after insert put this on the
>> +		 * deferred list, but before the deferred list was processed.
>> +		 */
>> +		if (RB_EMPTY_NODE(&mni->interval_tree.rb)) {
>> +			mni->interval_tree.start = start;
>> +			mni->interval_tree.last = last;
>> +		} else {
>> +			if (!mni->deferred_last)
>> +				hlist_add_head(&mni->deferred_item,
>> +					       &mmn_mm->deferred_list);
>> +			mni->deferred_start = start;
>> +			mni->deferred_last = last;
>> +		}
>> +		seq = mmn_mm->invalidate_seq;
>> +	} else {
>> +		WARN_ON(RB_EMPTY_NODE(&mni->interval_tree.rb));
>> +		interval_tree_remove(&mni->interval_tree, &mmn_mm->itree);
>> +		mni->interval_tree.start = start;
>> +		mni->interval_tree.last = last;
>> +		interval_tree_insert(&mni->interval_tree, &mmn_mm->itree);
>> +	}
>> +	spin_unlock(&mmn_mm->lock);
>> +
>> +	if (!mni->ops->release && seq) {
>> +		/*
>> +		 * The possible sleep on progress in the invalidation requires
>> +		 * the caller not hold any locks held by invalidation
>> +		 * callbacks.
>> +		 */
>> +		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
>> +		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
>>   		wait_event(mmn_mm->wq,
>>   			   READ_ONCE(mmn_mm->invalidate_seq) != seq);
>> +	}
>>   
>> -	/* pairs with mmgrab in mmu_interval_notifier_insert() */
>> -	mmdrop(mm);
>> +	return 0;
>>   }
>> -EXPORT_SYMBOL_GPL(mmu_interval_notifier_remove);
>> +EXPORT_SYMBOL_GPL(mmu_interval_notifier_update);
> 
> A 'update' should probably be the same as insert, it doesn't
> necessarily take effect until mmu_interval_read_begin(), so nothing
> contingent on release.

Agreed. I was trying to keep mmu_interval_notifier_remove() unchanged
and use whether ops->release() was defined to indicate if it should be
synchronous or asynchronous.
The test for release in the update case was intended to be similar.

Now the plan for v6 is to leave mmu_interval_notifier_remove() unchanged,
add mmu_interval_notifier_put() for async/safe removal and make 'update'
be asynchronous only and, as you say, rely on mmu_interval_read_begin()
to be sure all delayed add/remove/updates are complete.

I'm also planning to add a mmu_interval_notifier_find() so that nouveau
and the self tests don't need to create a duplicate interval range tree
to track the intervals that they have registered. There isn't an existing
structure that the struct mmu_interval_notifier can just be added to so
it ends up being a separately allocated structure and would need to be
stored in some sort of table so I thought why not just use the itree.

So I guess the patch series will be insert_safe, put+release, update,
find, nouveau, and tests.

> As before, I'm not sure what to do with this. We need an in-kernel
> user for new apis, and I don't see a reason to make this more
> complicated for a test program.

I agree.

> The test program should match one of the existing driver flows, so use
> the page table like scheme from ODP or the fixed lifetime scheme from
> AMDGPU/ODP
> 
> Jason

This is all useful feedback. I am working on v6 which addresses your concerns
and updates nouveau to use the new API. I'm somewhat sidetracked by the lockdep
issue I posted about nouveau calling kmalloc(GFP_KERNEL) from the invalidation
callback so it may take me awhile to sort that out.
Since we are at -rc5, I'm guessing this won't have enough soak time to make 5.6.
