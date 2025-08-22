Return-Path: <linux-kselftest+bounces-39657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E814DB30FA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 08:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1E11CC6954
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 06:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E632E5B08;
	Fri, 22 Aug 2025 06:58:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA3C296BD0;
	Fri, 22 Aug 2025 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845936; cv=none; b=nOH12nYrDG/Xm9VY5RsIYU4J2w0qJhtvkS2w7S+WEBFwGT3VxcKNisLqYBycX1/HbEIRPORVS1QFlpMXZ68LtteCi6s16NJdY757FggEcEhc8VDD9huJVY0dh0UGCcfqiNZgQVigbXRkMi+TJYrZGj2T9qpHi1a5PxiWzVsC1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845936; c=relaxed/simple;
	bh=DtBOtyja9oaFsqArnMz5V4Hl/4aCTCe6Aw+SSt12Z80=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fmUx6MRkGMj+kH+temoBVfILM++Z5WgJpYSv2MKg3nwEZmJvG6csheDVwS6b2k1PIqvosd/mknIRGsPRrUnkb2u4fjOT7/WemEwtTgONUH8yPm+oLAipowSHInLAMk8IqESXDMihKH5+pTF9IDVYa6iEDRCaAHV9J+E6hPhyvTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c7WHv1LsbzKHNXd;
	Fri, 22 Aug 2025 14:58:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AD0A11A1446;
	Fri, 22 Aug 2025 14:58:50 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgCXXNcpFaho8_HCEQ--.46529S2;
	Fri, 22 Aug 2025 14:58:50 +0800 (CST)
Message-ID: <a309c2b5-5425-428c-a034-d5ebc68cb304@huaweicloud.com>
Date: Fri, 22 Aug 2025 14:58:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cgroup: cgroup.stat.local time accounting
From: Chen Ridong <chenridong@huaweicloud.com>
To: Tiffany Yang <ynaffit@google.com>, linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>,
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
Content-Language: en-US
In-Reply-To: <552a7f82-2735-47a5-9abd-a9ae845f4961@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXXNcpFaho8_HCEQ--.46529S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jry7tF48WF1UZr1xWFWUtwb_yoW3Aw47pa
	yDA3W3tw4FqF12vr4Sy34qvFySgr48tw4UKr9rJa4xAFnIq3Wktr1xAr15WF1UAFZ7K3W8
	Ja4Y9ryfCrnFvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/8/22 14:14, Chen Ridong wrote:
> 
> 
> On 2025/8/22 9:37, Tiffany Yang wrote:
>> There isn't yet a clear way to identify a set of "lost" time that
>> everyone (or at least a wider group of users) cares about. However,
>> users can perform some delay accounting by iterating over components of
>> interest. This patch allows cgroup v2 freezing time to be one of those
>> components.
>>
>> Track the cumulative time that each v2 cgroup spends freezing and expose
>> it to userland via a new local stat file in cgroupfs. Thank you to
>> Michal, who provided the ASCII art in the updated documentation.
>>
>> To access this value:
>>   $ mkdir /sys/fs/cgroup/test
>>   $ cat /sys/fs/cgroup/test/cgroup.stat.local
>>   freeze_time_total 0
>>
>> Ensure consistent freeze time reads with freeze_seq, a per-cgroup
>> sequence counter. Writes are serialized using the css_set_lock.
>>
>> Signed-off-by: Tiffany Yang <ynaffit@google.com>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Michal Koutný <mkoutny@suse.com>
>> ---
>> v3 -> v4:
>> * Replace "freeze_time_total" with "frozen" and expose stats via
>>   cgroup.stat.local, as recommended by Tejun.
>> * Use the same timestamp when freezing/unfreezing a cgroup as its
>>   descendants, as suggested by Michal.
>>
>> v2 -> v3:
>> * Use seqcount along with css_set_lock to guard freeze time accesses, as
>>   suggested by Michal.
>>
>> v1 -> v2:
>> * Track per-cgroup freezing time instead of per-task frozen time, as
>>   suggested by Tejun.
>> ---
>>  Documentation/admin-guide/cgroup-v2.rst | 18 ++++++++++++++++
>>  include/linux/cgroup-defs.h             | 17 +++++++++++++++
>>  kernel/cgroup/cgroup.c                  | 28 +++++++++++++++++++++++++
>>  kernel/cgroup/freezer.c                 | 16 ++++++++++----
>>  4 files changed, 75 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 51c0bc4c2dc5..a1e3d431974c 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -1001,6 +1001,24 @@ All cgroup core files are prefixed with "cgroup."
>>  		Total number of dying cgroup subsystems (e.g. memory
>>  		cgroup) at and beneath the current cgroup.
>>  
>> +  cgroup.stat.local
>> +	A read-only flat-keyed file which exists in non-root cgroups.
>> +	The following entry is defined:
>> +
>> +	  frozen_usec
>> +		Cumulative time that this cgroup has spent between freezing and
>> +		thawing, regardless of whether by self or ancestor groups.
>> +		NB: (not) reaching "frozen" state is not accounted here.
>> +
>> +		Using the following ASCII representation of a cgroup's freezer
>> +		state, ::
>> +
>> +			       1    _____
>> +			frozen 0 __/     \__
>> +			          ab    cd
>> +
>> +		the duration being measured is the span between a and c.
>> +
>>    cgroup.freeze
>>  	A read-write single value file which exists on non-root cgroups.
>>  	Allowed values are "0" and "1". The default is "0".
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index 6b93a64115fe..539c64eeef38 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -433,6 +433,23 @@ struct cgroup_freezer_state {
>>  	 * frozen, SIGSTOPped, and PTRACEd.
>>  	 */
>>  	int nr_frozen_tasks;
>> +
>> +	/* Freeze time data consistency protection */
>> +	seqcount_t freeze_seq;
>> +
>> +	/*
>> +	 * Most recent time the cgroup was requested to freeze.
>> +	 * Accesses guarded by freeze_seq counter. Writes serialized
>> +	 * by css_set_lock.
>> +	 */
>> +	u64 freeze_start_nsec;
>> +
>> +	/*
>> +	 * Total duration the cgroup has spent freezing.
>> +	 * Accesses guarded by freeze_seq counter. Writes serialized
>> +	 * by css_set_lock.
>> +	 */
>> +	u64 frozen_nsec;
>>  };
>>  
>>  struct cgroup {
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 312c6a8b55bb..ab096b884bbc 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -3763,6 +3763,27 @@ static int cgroup_stat_show(struct seq_file *seq, void *v)
>>  	return 0;
>>  }
>>  
>> +static int cgroup_core_local_stat_show(struct seq_file *seq, void *v)
>> +{
>> +	struct cgroup *cgrp = seq_css(seq)->cgroup;
>> +	unsigned int sequence;
>> +	u64 freeze_time;
>> +
>> +	do {
>> +		sequence = read_seqcount_begin(&cgrp->freezer.freeze_seq);
>> +		freeze_time = cgrp->freezer.frozen_nsec;
>> +		/* Add in current freezer interval if the cgroup is freezing. */
>> +		if (test_bit(CGRP_FREEZE, &cgrp->flags))
>> +			freeze_time += (ktime_get_ns() -
>> +					cgrp->freezer.freeze_start_nsec);
>> +	} while (read_seqcount_retry(&cgrp->freezer.freeze_seq, sequence));
>> +
>> +	seq_printf(seq, "frozen_usec %llu\n",
>> +		   (unsigned long long) freeze_time / NSEC_PER_USEC);
>> +
>> +	return 0;
>> +}
>> +
>>  #ifdef CONFIG_CGROUP_SCHED
>>  /**
>>   * cgroup_tryget_css - try to get a cgroup's css for the specified subsystem
>> @@ -5354,6 +5375,11 @@ static struct cftype cgroup_base_files[] = {
>>  		.name = "cgroup.stat",
>>  		.seq_show = cgroup_stat_show,
>>  	},
>> +	{
>> +		.name = "cgroup.stat.local",
>> +		.flags = CFTYPE_NOT_ON_ROOT,
>> +		.seq_show = cgroup_core_local_stat_show,
>> +	},
>>  	{
>>  		.name = "cgroup.freeze",
>>  		.flags = CFTYPE_NOT_ON_ROOT,
>> @@ -5763,6 +5789,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
>>  	 * if the parent has to be frozen, the child has too.
>>  	 */
>>  	cgrp->freezer.e_freeze = parent->freezer.e_freeze;
>> +	seqcount_init(&cgrp->freezer.freeze_seq);
>>  	if (cgrp->freezer.e_freeze) {
>>  		/*
>>  		 * Set the CGRP_FREEZE flag, so when a process will be
>> @@ -5771,6 +5798,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
>>  		 * consider it frozen immediately.
>>  		 */
>>  		set_bit(CGRP_FREEZE, &cgrp->flags);
>> +		cgrp->freezer.freeze_start_nsec = ktime_get_ns();
>>  		set_bit(CGRP_FROZEN, &cgrp->flags);
>>  	}
>>  
>> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
>> index bf1690a167dd..6c18854bff34 100644
>> --- a/kernel/cgroup/freezer.c
>> +++ b/kernel/cgroup/freezer.c
>> @@ -171,7 +171,7 @@ static void cgroup_freeze_task(struct task_struct *task, bool freeze)
>>  /*
>>   * Freeze or unfreeze all tasks in the given cgroup.
>>   */
>> -static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze)
>> +static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze, u64 ts_nsec)
>>  {
>>  	struct css_task_iter it;
>>  	struct task_struct *task;
>> @@ -179,10 +179,16 @@ static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze)
>>  	lockdep_assert_held(&cgroup_mutex);
>>  
>>  	spin_lock_irq(&css_set_lock);
>> -	if (freeze)
>> +	write_seqcount_begin(&cgrp->freezer.freeze_seq);
>> +	if (freeze) {
>>  		set_bit(CGRP_FREEZE, &cgrp->flags);
>> -	else
>> +		cgrp->freezer.freeze_start_nsec = ts_nsec;
>> +	} else {
>>  		clear_bit(CGRP_FREEZE, &cgrp->flags);
>> +		cgrp->freezer.frozen_nsec += (ts_nsec -
>> +			cgrp->freezer.freeze_start_nsec);
>> +	}
>> +	write_seqcount_end(&cgrp->freezer.freeze_seq);
>>  	spin_unlock_irq(&css_set_lock);
>>
> 
> Hello Tiffany,
> 
> I wanted to check if there are any specific considerations regarding how we should input the ts_nsec
> value.
> 
> Would it be possible to define this directly within the cgroup_do_freeze function rather than
> passing it as a parameter? This approach might simplify the implementation and potentially improve
> timing accuracy when it have lots of descendants.
> 

I revisited v3, and this was Michal's point.
	p
     /  |  \
    1  ...  n
When we freeze the parent group p, is it expected that all descendant cgroups (1 to n) should share
the same frozen timestamp?

If the cgroup tree structure is stable, the exact frozen time may not be really matter. However, if
the tree is not stable, obtaining the same frozen time is acceptable?

-- 
Best regards,
Ridong


