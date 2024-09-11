Return-Path: <linux-kselftest+bounces-17721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 012C5974BB2
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 09:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B641F24F9A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77C513A86C;
	Wed, 11 Sep 2024 07:44:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11A824A3;
	Wed, 11 Sep 2024 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040678; cv=none; b=qiHKZPQnq1xi32i5Yt6kGwjSMrFx/SPHE2YdOXqDD/x25g+8IjD7fWU/nWYCACZ1E2Ete7Zov3x5H/hFuE2w5ZL3ccRVQyA4MbWiPWb2Yc40aoGk6vg1KLZutk8/eMRe6EJ3tSnhAKnhZZfY0qjy0re000RtPWKRtuJ1vuKFfqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040678; c=relaxed/simple;
	bh=626R2fzsP47kzAH1OkD+L9mKfeje70BHsaROh9Po6tQ=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZzNFzkANPCJ2r/4MmuuCgkLb9mqK/8+NvHH9CVLFNhgotYmP4ooN9/CV2njDdUyCtLXXcK8MN+/DU2PFpJvXghXnuqztJzm1yrb2l25jTgJJ2G7XpwzVhwhWXSd/rczyFI97dnp8gxIZ/U5IEKQr/jiK6Snx5Z+3dyBuiY5obek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X3Xdb0Gbzz69Jn;
	Wed, 11 Sep 2024 15:44:19 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 1917B18010F;
	Wed, 11 Sep 2024 15:44:25 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Sep 2024 15:44:24 +0800
Subject: Re: [PATCH 3/3] debugobjects: Use hlist_cut_number() to optimize
 performance and improve readability
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, David Gow
	<davidgow@google.com>, <linux-kselftest@vger.kernel.org>,
	<kunit-dev@googlegroups.com>
References: <20240904134152.2141-1-thunder.leizhen@huawei.com>
 <20240904134152.2141-4-thunder.leizhen@huawei.com> <87jzfkbrgf.ffs@tglx>
 <5333927d-3f21-b7cc-8c57-6e21f1b4a3e5@huawei.com> <87bk0vbumx.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <85a8aa26-f135-fdde-fadf-c2b38a563805@huawei.com>
Date: Wed, 11 Sep 2024 15:44:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87bk0vbumx.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/10 19:44, Thomas Gleixner wrote:
> On Tue, Sep 10 2024 at 12:00, Leizhen wrote:
>> On 2024/9/10 2:41, Thomas Gleixner wrote:
>>> All related functions have this problem and all of this code is very
>>> strict about boundaries. Instead of accurately doing the refill, purge
>>> etc. we should look into proper batch mode mechanisms. Let me think
>>> about it.
>> It may be helpful to add several arrays to record the first node of each batch
>> in each free list. Take 'percpu_pool' as an example:
>>
>> struct debug_percpu_free {
>> 	struct hlist_head	free_objs;
>> 	int			obj_free;
>> +	int			batch_idx;
>> +	struct hlist_node	*batch_first[4]; // ODEBUG_POOL_PERCPU_SIZE / ODEBUG_BATCH_SIZE
>> };
>>
>> A new free node is added to the header of the list, and the batch is cut from the tail
>> of the list.
>>   NodeA<-->...<-->NodeB<-->...<-->NodeC<-->NodeD<--> free_objs
>>     |---one batch---|---one batch---|
>>                     |               |
>>         batch_first[0]  batch_first[1]
> The current data structures are not fit for the purpose. Glueing
> workarounds into the existing mess makes it just worse.
> 
> So the data structures need to be redesigned from ground up to be fit
> for the purpose.
> 
> allocation:
> 
>    1) Using the global pool for single object allocations is wrong
> 
>       During boot this can be a completely disconnected list, which does
>       not need any accounting, does not need pool_lock and can be just
>       protected with irqsave like the per CPU pools. It's effectivly a
>       per CPU pool because at that point there is only one CPU and
>       everything is single threaded.
> 
>    2) The per CPU pool handling is backwards
> 
>       If the per CPU pool is empty, then the pool needs to be refilled
>       with a batch from the global pool and allocated from there.
> 
>       Allocation then always happens from the active per CPU batch slot.
> 
> free:
> 
>    1) Early boot
> 
>       Just put it back on the dedicated boot list and be done
> 
>    2) After obj_cache is initialized
> 
>       Put it back to the per CPU pool into the active batch slot.  If
>       the slot becomes full then make the next slot the active slot. It
>       the full slot was the top most slot then move that slot either
>       into the global pool when there is a free slot, or move it to the
>       to_free pool.
> 
> That means the per CPU pool is different from the global pools as it can
> allocate/free single objects, while the global pools are strictly stacks
> of batches. Any movement between per CPU pools and global pools is batch
> based and just moves lists from one head to another.
> 
> That minimizes the pool lock contention and the cache foot print. The
> global to free pool must have an extra twist to accomodate non-batch
> sized drops and to handle the all slots are full case, but that's just a
> trivial detail.

That's great. I really admire you for completing the refactor in such a
short of time. But I have a few minor comments.
1. When kmem_cache_zalloc() is called to allocate objs for filling,
   if less than one batch of objs are allocated, all of them can be
   pushed to the local CPU. That's, call pcpu_free() one by one.
   In this way, the number of free objs cached by pool_global and
   pool_to_free is always an integer multiple of ODEBUG_BATCH_SIZE.
2. Member tot_cnt of struct global_pool can be deleted. We can get it
   simply and quickly through (slot_idx * ODEBUG_BATCH_SIZE). Avoid
   redundant maintenance.
3. debug_objects_pool_min_level also needs to be adjusted accordingly,
   the number of batches of the min level.

> 
> See the completely untested combo patch against tip core/debugobjects
> below.
> 
> Thanks,
> 
>         tglx

-- 
Regards,
  Zhen Lei

