Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC84813CFCE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2020 23:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgAOWJu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jan 2020 17:09:50 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18556 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgAOWJu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jan 2020 17:09:50 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1f8d750000>; Wed, 15 Jan 2020 14:08:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Jan 2020 14:09:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Jan 2020 14:09:49 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jan
 2020 22:09:47 +0000
Subject: Re: [PATCH v6 5/6] nouveau: use new mmu interval notifiers
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>
References: <20200113224703.5917-1-rcampbell@nvidia.com>
 <20200113224703.5917-6-rcampbell@nvidia.com>
 <20200114125957.GO20978@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <5845f50e-8bc0-8068-ee21-4f910beb1255@nvidia.com>
Date:   Wed, 15 Jan 2020 14:09:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200114125957.GO20978@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579126133; bh=MrPAo3JYk8FBujvLNtKq6DWwwZ/JG+mRPmzFu/yBjJw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KCgZjjbOGVCpUcfnChF384KmkaGikg8T6aZB4wVHsbXn2C1/0pliAetYAxMgTQMxD
         B8vI2r9Qjv0bebJ9qS1kn0pd8cz4DE+kdv8w/JUkHof0rlVOouItkJRdwz8sjDOF9J
         yHHiUVDAENAhVABED5w96PCfcvNcGIMS1+C8RqSjhzNhSXeBFRLndK7yGHhnP0hxEB
         RPu6UY+B29DHxqrWT8mmwyVbptzp3vhtO3RRPBv8epmEnBWwFC5TCvJGTK+5KMOZmP
         y1by/vT2WwyWkWLuhsg5hHukOep6w2LcD2b6p4l2Tx2rrjqpELpD9l7ehajJyG8mG0
         CojieB3MGsX5g==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 1/14/20 5:00 AM, Jason Gunthorpe wrote:
> On Mon, Jan 13, 2020 at 02:47:02PM -0800, Ralph Campbell wrote:
>>   void
>>   nouveau_svmm_fini(struct nouveau_svmm **psvmm)
>>   {
>>   	struct nouveau_svmm *svmm = *psvmm;
>> +	struct mmu_interval_notifier *mni;
>> +
>>   	if (svmm) {
>>   		mutex_lock(&svmm->mutex);
>> +		while (true) {
>> +			mni = mmu_interval_notifier_find(svmm->mm,
>> +					&nouveau_svm_mni_ops, 0UL, ~0UL);
>> +			if (!mni)
>> +				break;
>> +			mmu_interval_notifier_put(mni);
> 
> Oh, now I really don't like the name 'put'. It looks like mni is
> refcounted here, and it isn't. put should be called 'remove_deferred'

OK.

> And then you also need a way to barrier this scheme on driver unload.

Good point. I can add something like
void mmu_interval_notifier_synchronize(struct mm_struct *mm)
that waits for deferred operations to complete similar to
mmu_interval_read_begin().

>> +		}
>>   		svmm->vmm = NULL;
>>   		mutex_unlock(&svmm->mutex);
>> -		mmu_notifier_put(&svmm->notifier);
> 
> While here it was actually a refcount.
> 
>> +static void nouveau_svmm_do_unmap(struct mmu_interval_notifier *mni,
>> +				 const struct mmu_notifier_range *range)
>> +{
>> +	struct svmm_interval *smi =
>> +		container_of(mni, struct svmm_interval, notifier);
>> +	struct nouveau_svmm *svmm = smi->svmm;
>> +	unsigned long start = mmu_interval_notifier_start(mni);
>> +	unsigned long last = mmu_interval_notifier_last(mni);
> 
> This whole algorithm only works if it is protected by the read side of
> the interval tree lock. Deserves at least a comment if not an
> assertion too.

This is called from the invalidate() callback and while holding the
driver page table lock so the struct mmu_interval_notifier and
the interval tree can't change.
I will add comments for v7.

>>   static int nouveau_range_fault(struct nouveau_svmm *svmm,
>>   			       struct nouveau_drm *drm, void *data, u32 size,
>> -			       u64 *pfns, struct svm_notifier *notifier)
>> +			       u64 *pfns, u64 start, u64 end)
>>   {
>>   	unsigned long timeout =
>>   		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>>   	/* Have HMM fault pages within the fault window to the GPU. */
>>   	struct hmm_range range = {
>> -		.notifier = &notifier->notifier,
>> -		.start = notifier->notifier.interval_tree.start,
>> -		.end = notifier->notifier.interval_tree.last + 1,
>> +		.start = start,
>> +		.end = end,
>>   		.pfns = pfns,
>>   		.flags = nouveau_svm_pfn_flags,
>>   		.values = nouveau_svm_pfn_values,
>> +		.default_flags = 0,
>> +		.pfn_flags_mask = ~0UL,
>>   		.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT,
>>   	};
>> -	struct mm_struct *mm = notifier->notifier.mm;
>> +	struct mm_struct *mm = svmm->mm;
>>   	long ret;
>>   
>>   	while (true) {
>>   		if (time_after(jiffies, timeout))
>>   			return -EBUSY;
>>   
>> -		range.notifier_seq = mmu_interval_read_begin(range.notifier);
>> -		range.default_flags = 0;
>> -		range.pfn_flags_mask = -1UL;
>>   		down_read(&mm->mmap_sem);
> 
> mmap sem doesn't have to be held for the interval search, and again we
> have lifetime issues with the membership here.

I agree mmap_sem isn't needed for the interval search, it is needed if
the search doesn't find a registered interval and one needs to be created
to cover the underlying VMA. If an arbitrary size interval was created
instead, then mmap_sem wouldn't be needed.
I don't understand the lifetime/membership issue. The driver is the only thing
that allocates, inserts, or removes struct mmu_interval_notifier and thus
completely controls the lifetime.

>> +		ret = nouveau_svmm_interval_find(svmm, &range);
>> +		if (ret) {
>> +			up_read(&mm->mmap_sem);
>> +			return ret;
>> +		}
>> +		range.notifier_seq = mmu_interval_read_begin(range.notifier);
>>   		ret = hmm_range_fault(&range, 0);
>>   		up_read(&mm->mmap_sem);
>>   		if (ret <= 0) {
> 
> I'm still not sure this is a better approach than what ODP does. It
> looks very expensive on the fault path..
> 
> Jason
> 

ODP doesn't have this problem because users have to call ib_reg_mr()
before any I/O can happen to the process address space. That is when
mmu_interval_notifier_insert() / mmu_interval_notifier_remove() can
be called and the driver doesn't have to worry about the interval
changing sizes or being removed while I/O is happening.
For GPU like devices, I'm trying to allow hardware access to any user
level address without pre-registering it. That means inserting mmu
interval notifiers for the ranges the GPU page faults on and updating
the intervals as munmap() calls remove parts of the address space.
I don't want to register an interval per page so the logical range
is the underlying VMA.

It isn't that expensive, there is an extra driver lock/unlock as
part of the lookup and possibly a find_vma() and kmalloc(GFP_ATOMIC)
for new intervals. Also, the deferred interval updates for munmap().
Compared to the cost of updating PTEs in the device and GPU fault
handling, this is minimal overhead.

