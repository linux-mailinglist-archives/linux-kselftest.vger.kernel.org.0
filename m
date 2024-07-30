Return-Path: <linux-kselftest+bounces-14441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21CE9405C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 05:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD722824C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 03:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EE484D34;
	Tue, 30 Jul 2024 03:22:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB381854;
	Tue, 30 Jul 2024 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722309721; cv=none; b=QVEaQaP1i00fKcMUEaAG9LTrnMJ/dV7CYZzMyXWUDfdTISP7wB+NsJkeVm6xImerEb7fHNGBGnKqu/mF3rWmCnBdz5pMbWQEsMN//tgErsQD6SF0i2kLyaroHJBPB0/E2blrGfH9H9kZhtBB+p5oUv4KOIPHaA//jfBBqWD/NfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722309721; c=relaxed/simple;
	bh=EVEz++G7tSv3Kol7NsraWR4CcbTy4nHUfFS4zm3vCDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gckKt5tETbOKA46RGpm5f4FLVf3RLdHEZu2zjH4fjKrDsxhCy3yB+eQlbhtMGCXquaVBn11me3G65TPmgm5VrrxGWvzH8Y3ydh3hg1ZoIT7QzFZXziyeMTeZAi287cSEh/DLR8SmTT0wgFsd51gf/UgUapzTo8dJfCP53B1Rqw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WY0rK2xsnz4f3jHc;
	Tue, 30 Jul 2024 11:21:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3AD7E1A018D;
	Tue, 30 Jul 2024 11:21:50 +0800 (CST)
Received: from [10.67.110.112] (unknown [10.67.110.112])
	by APP2 (Coremail) with SMTP id Syh0CgB3YL9MXKhmwu_8AA--.26046S2;
	Tue, 30 Jul 2024 11:21:49 +0800 (CST)
Message-ID: <ffdb6f77-89b4-cb54-4333-c5d63ef0a698@huaweicloud.com>
Date: Tue, 30 Jul 2024 11:21:37 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 2/5] cgroup/pids: Make event counters hierarchical
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20240521092130.7883-1-mkoutny@suse.com>
 <20240521092130.7883-3-mkoutny@suse.com>
 <f124ce60-196e-2392-c4a9-11cdcacf9927@huawei.com>
 <cb0efc16-6df2-72b7-47ea-ce524d428cc1@huawei.com>
 <hs3oag7blyg5kkdu6ikbw7f6hefkdfk2qgqqnpothq7yx4qsts@gv2v4dbpfmv6>
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <hs3oag7blyg5kkdu6ikbw7f6hefkdfk2qgqqnpothq7yx4qsts@gv2v4dbpfmv6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3YL9MXKhmwu_8AA--.26046S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1rJF1UZF1xCF48uw17KFg_yoW8ur48pa
	9ayFs3KFWkJ3saywnaqrn7tryFvwsYyFn8XFs8J3y8trZrKry3urW7CF15uFy5A34xCr42
	qa1jgay3AryjyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/



On 2024/7/25 17:38, Michal Koutný wrote:
> Hello Jianfeng.
> 
> On Tue, Jul 16, 2024 at 11:27:39AM GMT, xiujianfeng <xiujianfeng@huawei.com> wrote:
>> On 2024/7/3 14:59, xiujianfeng wrote:
> ...
>>>         for (; parent_pids(p); p = parent_pids(p)) {
>>>                 if (p == pids_over_limit) {
>>>                         limit = true;
>>>                         atomic64_inc(&p->events_local[PIDCG_MAX]);
>>>                         cgroup_file_notify(&p->events_local_file);
>>>                 }
>>>                 if (limit)
>>>                         atomic64_inc(&p->events[PIDCG_MAX]);
>>>
>>>                 cgroup_file_notify(&p->events_file);
>>>         }
>>> }
>>>
>>> Consider this scenario: there are 4 groups A, B, C,and D. The
>>> relationships are as follows, the latter is the child of the former:
>>>
>>> root->A->B->C->D
>>>
>>> Then the user is polling on C.pids.events. When a process in D forks and
>>> fails due to B.max restrictions(pids_forking is D, and pids_over_limit
>>> is B), the user is awakened. However, when the user reads C.pids.events,
>>> he will find that the content has not changed. because the 'limit' is
>>> set to true started from B, and C.pids.events shows as below:
>>>
>>> seq_printf(sf, "max %lld\n", (s64)atomic64_read(&events[PIDCG_MAX]));
>>>
>>> Wouldn't this behavior confuse the user? Should the code to be changed
>>> to this?
> 
> Two generic notes:
> - event notifications can be rate limited, so users won't necessarily
>   see every change,
> - upon notification it's better to read the event counter/status anyway
>   to base a response on it.
> 
> But your remark is justified, there is no reason in this case for
> "spurious" event notification. It's an omission from v3 version of the
> patch when there had been also pids.events:max.imposed (that'd trigger
> events from D up to the root, it's only internal PIDCG_FORKFAIL now).
> 
> The upwards traversal loop can be simplified and fixed with only
> PIDCG_MAX exposed. Can you send it as a separate patch please?

Hi Michal,

Thanks for your feedback. and I'm sorry I forgot to reply this thread
after sending the patch.

> 
> (Apologies for late response, somehow I didn't see your e-mails.)
> 
> Michal


