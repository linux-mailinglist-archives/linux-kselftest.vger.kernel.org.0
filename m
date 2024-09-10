Return-Path: <linux-kselftest+bounces-17566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9329727C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 06:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BF728569C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 04:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BC81514DA;
	Tue, 10 Sep 2024 04:01:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440C14EC64;
	Tue, 10 Sep 2024 04:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725940864; cv=none; b=YIOBW72vWAQEN2F180P2WmWC47S3D8gLHc8fd/rnQRCQN64JC4VcvxGv9paTwPIB2CTKKbRLPqT2z4XGwvdg1zV7kuTXvgSz5onunGc3wvQw9y0Q0Eop4ZMg2ZdpUMeJlh/xuoJjLUGRxmdDCoClXNylfGEaE//fOhpJdfiBxhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725940864; c=relaxed/simple;
	bh=z+KSQy+Jyde9Pg4JmjRwplgN8RLOa40KJ91ZBR9RNrk=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iAqOs8KPJVj4V5mNevuOw+eoh/FeHpCIgUbEp9Cm72mXDBqD0nHwYNvdsIGOmk2+OrbFJyGzcZumkmvsr49dQ40imVNAT9ZZ2lrIAL2YPf24H+l/7IO6CXh8Wkb55Sweoy9ZUuCCmYRttUIujVvAc8b8AAP90TFzf/xKf/s7wDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X2qkG11brz69RR;
	Tue, 10 Sep 2024 12:00:54 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id E89C714037E;
	Tue, 10 Sep 2024 12:00:58 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Sep 2024 12:00:58 +0800
Subject: Re: [PATCH 3/3] debugobjects: Use hlist_cut_number() to optimize
 performance and improve readability
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, David Gow
	<davidgow@google.com>, <linux-kselftest@vger.kernel.org>,
	<kunit-dev@googlegroups.com>
References: <20240904134152.2141-1-thunder.leizhen@huawei.com>
 <20240904134152.2141-4-thunder.leizhen@huawei.com> <87jzfkbrgf.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5333927d-3f21-b7cc-8c57-6e21f1b4a3e5@huawei.com>
Date: Tue, 10 Sep 2024 12:00:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87jzfkbrgf.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/10 2:41, Thomas Gleixner wrote:
> On Wed, Sep 04 2024 at 21:41, Zhen Lei wrote:
> 
>> Currently, there are multiple instances where several nodes are extracted
>> from one list and added to another list. One by one extraction, and then
>> one by one splicing, not only low efficiency, readability is also poor.
>> The work can be done well with hlist_cut_number() and hlist_splice_init(),
>> which move the entire sublist at once.
>>
>> When the number of nodes expected to be moved is less than or equal to 0,
>> or the source list is empty, hlist_cut_number() safely returns 0. The
>> splicing is performed only when the return value of hlist_cut_number() is
>> greater than 0.
>>
>> For two calls to hlist_cut_number() in __free_object(), the result is
>> obviously positive, the check of the return value is omitted.
> 
> Sure but hlist_cut_number() suffers from the same problem as the current
> code. If is a massive cache line chase as you actually have to walk the
> list to figure out where to cut it off.
> 
> All related functions have this problem and all of this code is very
> strict about boundaries. Instead of accurately doing the refill, purge
> etc. we should look into proper batch mode mechanisms. Let me think
> about it.

It may be helpful to add several arrays to record the first node of each batch
in each free list. Take 'percpu_pool' as an example:

struct debug_percpu_free {
	struct hlist_head	free_objs;
	int			obj_free;
+	int			batch_idx;
+	struct hlist_node	*batch_first[4]; // ODEBUG_POOL_PERCPU_SIZE / ODEBUG_BATCH_SIZE
};

A new free node is added to the header of the list, and the batch is cut from the tail
of the list.
  NodeA<-->...<-->NodeB<-->...<-->NodeC<-->NodeD<--> free_objs
    |---one batch---|---one batch---|
                    |               |
        batch_first[0]  batch_first[1]

__free_object():
	//add obj into percpu_pool
	obj_free++;
	if (obj_free % ODEBUG_BATCH_SIZE == 0) {
		idx = 0x3 & (batch_idx + (obj_free / ODEBUG_BATCH_SIZE) - 1);
		//update batch_first[idx]
	}

	if (obj_free >= ODEBUG_POOL_PERCPU_SIZE) {
		//move one batch
		//cut batch at 'batch_idx' into obj_to_free (or obj_pool, if less than debug_objects_pool_min_level)
		batch_idx++;
		obj_free -= ODEBUG_BATCH_SIZE
	}

> 
> Thanks,
> 
>         tglx
> 
> 
> .
> 

-- 
Regards,
  Zhen Lei

