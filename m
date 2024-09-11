Return-Path: <linux-kselftest+bounces-17738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F265F974ECD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 11:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82388B29A43
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 09:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EE817C7CA;
	Wed, 11 Sep 2024 09:38:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2603C183CA1;
	Wed, 11 Sep 2024 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047523; cv=none; b=kdQxVUeJ4Etim7Srqh3ndrCaUZSPmjxQq5MsjRWCLzcAsWQvAGl1I9xmXuUIY0OzfY/DnxQ54blJCh0oQbR/1bTirakx2CVyOfNYuo38yvL+koI3D2FbTLODzRRiJYsUa2MHeT9qEG4IY9ZWxpNAxQPlFpMwXM2gK/GruX+ADTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047523; c=relaxed/simple;
	bh=1XdogLv4I3RF6PQaq27ulG6D0GvjJvypUyJUpS3eFBk=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LcZtcRP42WVDw111o4M9mD49tRKhTf9BNd8e2T6TqVuHSnIDWu8aIwaospgD3bLPdZNfBkAbD7rnu8lFf2vZzpT8fHWshnR4R9Cy1tGHHjpLFjJ9OrrF/soPWF+ng+Y8qUuaAa8iljAhCseuCjs8qNn+upq+p/L15gQ3Ml55Qcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X3b8D1m4lzyQKn;
	Wed, 11 Sep 2024 17:37:32 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 139B0180AF6;
	Wed, 11 Sep 2024 17:38:39 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Sep 2024 17:38:38 +0800
Subject: Re: [PATCH 3/3] debugobjects: Use hlist_cut_number() to optimize
 performance and improve readability
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, David Gow
	<davidgow@google.com>, <linux-kselftest@vger.kernel.org>,
	<kunit-dev@googlegroups.com>
References: <20240904134152.2141-1-thunder.leizhen@huawei.com>
 <20240904134152.2141-4-thunder.leizhen@huawei.com> <87jzfkbrgf.ffs@tglx>
 <5333927d-3f21-b7cc-8c57-6e21f1b4a3e5@huawei.com> <87bk0vbumx.ffs@tglx>
 <85a8aa26-f135-fdde-fadf-c2b38a563805@huawei.com> <878qvya7u6.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c7c42fef-187b-a218-f4dd-cc21aa733a90@huawei.com>
Date: Wed, 11 Sep 2024 17:38:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <878qvya7u6.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/11 16:54, Thomas Gleixner wrote:
> On Wed, Sep 11 2024 at 15:44, Leizhen wrote:
>> On 2024/9/10 19:44, Thomas Gleixner wrote:
>>> That minimizes the pool lock contention and the cache foot print. The
>>> global to free pool must have an extra twist to accomodate non-batch
>>> sized drops and to handle the all slots are full case, but that's just a
>>> trivial detail.
>>
>> That's great. I really admire you for completing the refactor in such a
>> short of time.
> 
> The trick is to look at it from the data model and not from the
> code. You need to sit down and think about which data model is required
> to achieve what you want. So the goal was batching, right?

Yes, when I found a hole in the road, I thought about how to fill it. But
you think more deeply, why is there a pit, is there a problem with the
foundation? I've benefited a lot from communicating with you these days.

> 
> That made it clear that the global pools need to be stacks of batches
> and never handle single objects because that makes it complex. As a
> consequence the per cpu pool is the one which does single object
> alloc/free and then either gets a full batch from the global pool or
> drops one into it. The rest is just mechanical.
> 
>> But I have a few minor comments.
>> 1. When kmem_cache_zalloc() is called to allocate objs for filling,
>>    if less than one batch of objs are allocated, all of them can be
>>    pushed to the local CPU. That's, call pcpu_free() one by one.
> 
> If that's the case then we should actually immediately give them back
> because thats a sign of memory pressure.

Yes, that makes sense, and that's a solution too.

> 
>> 2. Member tot_cnt of struct global_pool can be deleted. We can get it
>>    simply and quickly through (slot_idx * ODEBUG_BATCH_SIZE). Avoid
>>    redundant maintenance.
> 
> Agreed.
> 
>> 3. debug_objects_pool_min_level also needs to be adjusted accordingly,
>>    the number of batches of the min level.
> 
> Sure. There are certainly more problems with that code. As I said, it's
> untested and way to big to be reviewed. I'll split it up into more
> manageable bits and pieces.

Looking forward to...

> 
> Thanks,
> 
>         tglx
> .
> 

-- 
Regards,
  Zhen Lei

