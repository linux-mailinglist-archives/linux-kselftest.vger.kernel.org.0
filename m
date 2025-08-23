Return-Path: <linux-kselftest+bounces-39774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDA1B3263E
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 03:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A86B03896
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 01:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9FA1C84B2;
	Sat, 23 Aug 2025 01:45:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E168E18DB02;
	Sat, 23 Aug 2025 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755913535; cv=none; b=IBebMxIJSnuf/wb0N2g8WZe5dQvZamLOOa+nqwK198nzGH/cshPUB4mRNYN86iAJaeTJGdy/Z6fKIcfrbuyJAYdyHrKLgpuXy0U80EYrzmT+QWbSzfB1sTUEc/7WnFAPO7ks7dXmHBjyslPEqAmktchfCX2CjXJgl7x1epwZb4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755913535; c=relaxed/simple;
	bh=/kz7kzrF2bxsIH48726DRXFxWy6o0FBrqLUdO+M67lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ooZ5bbIiE4Y0iiVzNVJj54tzcexLu1b+8/GjkkCWNlzm5OkCHo8zIaIM3LL8Wek+VLfogZM6BcitZlH7R0lsJJwDrQYtAPOOCZlYVZlVuesXOp2YNBRCGDwwZ5wAwpE9z2vlNq13YuOjgZmYIQpCHB1yv5OYi23ZW74gf8PWCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c80Hs1tL2zYQvGx;
	Sat, 23 Aug 2025 09:45:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C6EBE1A0C5E;
	Sat, 23 Aug 2025 09:45:27 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgBHDg82HalogetwEg--.14802S2;
	Sat, 23 Aug 2025 09:45:27 +0800 (CST)
Message-ID: <1b6498f3-ca07-41d5-9637-f20a58184e60@huaweicloud.com>
Date: Sat, 23 Aug 2025 09:45:26 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cgroup: cgroup.stat.local time accounting
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Chen Ridong <chenridong@huawei.com>, kernel-team@android.com,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250822013749.3268080-6-ynaffit@google.com>
 <20250822013749.3268080-7-ynaffit@google.com>
 <552a7f82-2735-47a5-9abd-a9ae845f4961@huaweicloud.com>
 <a309c2b5-5425-428c-a034-d5ebc68cb304@huaweicloud.com>
 <dbx8ms7r885f.fsf@ynaffit-andsys.c.googlers.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <dbx8ms7r885f.fsf@ynaffit-andsys.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHDg82HalogetwEg--.14802S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw45CFy7XF45ArW5Gw17Wrg_yoWrCr45pa
	9YyF4Yy395twnayrsFv3sFgFy0vrZ5J3Z8Gr95JFy8Ar43X3WSgr47urZ0gr1UZr4xJ34U
	JF1Yvwn7uFnFqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/23 3:32, Tiffany Yang wrote:
> Hi Chen,
> 
> Thanks again for taking a look!
> 
> Chen Ridong <chenridong@huaweicloud.com> writes:
> 
>> On 2025/8/22 14:14, Chen Ridong wrote:
> 
> 
>>> On 2025/8/22 9:37, Tiffany Yang wrote:
>>>> There isn't yet a clear way to identify a set of "lost" time that
>>>> everyone (or at least a wider group of users) cares about. However,
>>>> users can perform some delay accounting by iterating over components of
>>>> interest. This patch allows cgroup v2 freezing time to be one of those
>>>> components.
> 
>>>> Track the cumulative time that each v2 cgroup spends freezing and expose
>>>> it to userland via a new local stat file in cgroupfs. Thank you to
>>>> Michal, who provided the ASCII art in the updated documentation.
> 
>>>> To access this value:
>>>>    $ mkdir /sys/fs/cgroup/test
>>>>    $ cat /sys/fs/cgroup/test/cgroup.stat.local
>>>>    freeze_time_total 0
> 
>>>> Ensure consistent freeze time reads with freeze_seq, a per-cgroup
>>>> sequence counter. Writes are serialized using the css_set_lock.
> 
> ...
> 
>>>>       spin_lock_irq(&css_set_lock);
>>>> -    if (freeze)
>>>> +    write_seqcount_begin(&cgrp->freezer.freeze_seq);
>>>> +    if (freeze) {
>>>>           set_bit(CGRP_FREEZE, &cgrp->flags);
>>>> -    else
>>>> +        cgrp->freezer.freeze_start_nsec = ts_nsec;
>>>> +    } else {
>>>>           clear_bit(CGRP_FREEZE, &cgrp->flags);
>>>> +        cgrp->freezer.frozen_nsec += (ts_nsec -
>>>> +            cgrp->freezer.freeze_start_nsec);
>>>> +    }
>>>> +    write_seqcount_end(&cgrp->freezer.freeze_seq);
>>>>       spin_unlock_irq(&css_set_lock);
> 
> 
>>> Hello Tiffany,
> 
>>> I wanted to check if there are any specific considerations regarding how we should input the ts_nsec
>>> value.
> 
>>> Would it be possible to define this directly within the cgroup_do_freeze function rather than
>>> passing it as a parameter? This approach might simplify the implementation and potentially improve
>>> timing accuracy when it have lots of descendants.
> 
> 
>> I revisited v3, and this was Michal's point.
>>     p
>>       /  |  \
>>      1  ...  n
>> When we freeze the parent group p, is it expected that all descendant cgroups (1 to n) should share
>> the same frozen timestamp?
> 
> 
> Yes, this is the expectation from the current change. I understand your
> concern about the accuracy of this measurement (especially when there
> are many descendants), but I agree with Michal's point that the time to
> traverse the descendant cgroups is basically noise relative to the
> quantity we're trying to measure here.
> 
>> If the cgroup tree structure is stable, the exact frozen time may not be really matter. However, if
>> the tree is not stable, obtaining the same frozen time is acceptable?
> 
> I'm a little unclear as to what you mean about when the cgroup tree is
> unstable. In the case where a new descendant of p is being created, I
> believe the cgroup_mutex prevents that from happening at the same time
> as we are freezing p's other descendants. If it won the race, was
> created unfrozen under p, and then became frozen during cgroup_freeze,
> it would have the same timestamp as the other descendants. If it lost
> the race and was created as a frozen cgroup under p, it would get its
> own timestamp in cgroup_create, so its freezing duration would be
> slightly less than that of the others in the hierarchy. Both values
> would be acceptable for our purposes, but if there was a different case
> you had in mind, please let me know!
> 
> Thanks,

What I mean by "stable" is that while cgroup 1 through n might be deleted or have more descendants
created. For example:

         n  n-1  n-2  ... 1
frozen   a  a+1  a+2     a+n
unfozen  b  b+1  b+2  ... b+n
nsec     b-a ...

In this case, all frozen_nsec values are b - a, which I believe is correct.
However, consider a scenario where some cgroups are deleted:

         n  n-1  n-2  ... 1
frozen   a  a+1  a+2     a+n
// 2 ... n-1 are deleted.
unfozen  b               b+1

Here, the frozen_nsec for cgroup n would be b - a, but for cgroup 1 it would be (b + 1) - (a + n).
This could introduce some discrepancy / timing inaccuracies.

-- 
Best regards,
Ridong


