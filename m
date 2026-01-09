Return-Path: <linux-kselftest+bounces-48579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C48BD06BE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 02:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83A7A3031CDB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 01:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B53238C2A;
	Fri,  9 Jan 2026 01:30:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4D23D2B4;
	Fri,  9 Jan 2026 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767922219; cv=none; b=HKAvK9fb6SYHo9j8di/WLAzaBBVI9tDrh1WTQngSlu3PwlnY01kAEMfCOq5MrRHV0SrW6eqBKO04VhqszPLt083HKJnOLusISBHSMtIFNnz9FiLw0G7UkzDYB33W7H7NkMPhOiqDIn5Iex0FqZfzjgpKkvasNhhzM2xhZSQuNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767922219; c=relaxed/simple;
	bh=tzHOmAkyFFGA57fpCqgyXY7C9MCjDMsEQYiSchHr5BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7wvDIoADI9SY11WCE6ihMOZ7igIioANOZscB62mcfMEePP8LL7AuK6RM2wDba7TlLjhKITsYUP2GmqYiykpaKP3jYb1LCMl40sMgx9C2UHxtDuOO2xy0VXWk/Vz5bQnfQYpogTL4uXht8iA6diE74twKRqw9Q50MXB3/AKJZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dnPMB34t7zKHMK1;
	Fri,  9 Jan 2026 09:29:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 11D014058D;
	Fri,  9 Jan 2026 09:30:10 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA35vYgWmBpTk2JDA--.2321S2;
	Fri, 09 Jan 2026 09:30:09 +0800 (CST)
Message-ID: <990be63e-3884-4933-9ad7-bfd9f2be05df@huaweicloud.com>
Date: Fri, 9 Jan 2026 09:30:08 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH v2 4/4] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-5-longman@redhat.com>
 <chijw6gvtql74beputm3ue2zu2vmrwvtg5a2bn3wabgkqldq4d@obrdh4znejaw>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <chijw6gvtql74beputm3ue2zu2vmrwvtg5a2bn3wabgkqldq4d@obrdh4znejaw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA35vYgWmBpTk2JDA--.2321S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1fKw1ktw15Ww4UtFWrZrb_yoWxJFW8pF
	W8KF13Jas0gF15Cw42q3WxWr1FqanrZF1DJrs8Gr1xZ3yfXF1vyrn5tanxuFyUXwn8Ga4j
	vrZrZw4fXFnxArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2026/1/9 3:04, Michal Koutný wrote:
> Hi.
> 
> On Thu, Jan 01, 2026 at 02:15:58PM -0500, Waiman Long <longman@redhat.com> wrote:
>> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
>> with the cpuset.cpus/cpuset.cpus.exclusive of a sibling partition,
>> the sibling's partition state becomes invalid. This is overly harsh and
>> is probably not necessary.
>>
>> The cpuset.cpus.exclusive control file, if set, will override the
>> cpuset.cpus of the same cpuset when creating a cpuset partition.
>> So cpuset.cpus has less priority than cpuset.cpus.exclusive in setting up
>> a partition.  However, it cannot override a conflicting cpuset.cpus file
>> in a sibling cpuset and the partition creation process will fail. This
>> is inconsistent.  That will also make using cpuset.cpus.exclusive less
>> valuable as a tool to set up cpuset partitions as the users have to
>> check if such a cpuset.cpus conflict exists or not.
>>
>> Fix these problems by strictly adhering to the setting of the
>> following control files in descending order of priority when setting
>> up a partition.
>>
>>  1. cpuset.cpus.exclusive.effective of a valid partition
>>  2. cpuset.cpus.exclusive
>>  3. cpuset.cpus
> 
> 
>>
>> So once a cpuset.cpus.exclusive is set without failure, it will
>> always be allowed to form a valid partition as long as at least one
>> CPU can be granted from its parent irrespective of the state of the
>> siblings' cpuset.cpus values. Of course, setting cpuset.cpus.exclusive
>> will fail if it conflicts with the cpuset.cpus.exclusive or the
>> cpuset.cpus.exclusive.effective value of a sibling.
> 
> Concept question: 
> When a/b/cpuset.cpus.exclusive ⊂ a/b/cpuset.cpus (proper subset)
> and a/b/cpuset.cpus.partition == root, a/cpuset.cpus.partition == root
> (b is valid partition)
> should a/b/cpuset.cpus.exclusive.effective be equal to cpuset.cpus (as
> all of them happen to be exclusive) or "only" cpuset.cpus.exclusive?
> 

The value of cpuset.cpus will not affect cpuset.cpus.exclusive.effective when cpuset.cpus.exclusive
is set.

Therefore, the answer: only cpuset.cpus.exclusive.

If cpuset.cpus could not be used for exclusive CPU allocation in a partition, it would be easier to
understand the settings of cpuset.cpus.exclusive and cpuset.cpus.partition. This means that only
when cpuset.cpus.exclusive is set can the cpuset be a partition (it has nothing to do with
cpuset.cpus). However, for historical and compatibility reasons, cpuset.cpus is considered as the
exclusive CPUs if cpuset.cpus.exclusive is not set.

>> Partition can still be created by setting only cpuset.cpus without
>> setting cpuset.cpus.exclusive. However, any conflicting CPUs in sibling's
>> cpuset.cpus.exclusive.effective and cpuset.cpus.exclusive values will
>> be removed from its cpuset.cpus.exclusive.effective as long as there
>> is still one or more CPUs left and can be granted from its parent. This
>> CPU stripping is currently done in rm_siblings_excl_cpus().
>>
>> The new code will now try its best to enable the creation of new
>> partitions with only cpuset.cpus set without invalidating existing ones.
> 
> OK. (After I re-learnt benefits of remote partitions or more precisely
> cpuset.cpus.effective.)
> 
>> However it is not guaranteed that all the CPUs requested in cpuset.cpus
>> will be used in the new partition even when all these CPUs can be
>> granted from the parent.
>>
>> This is similar to the fact that cpuset.cpus.effective may not be
>> able to include all the CPUs requested in cpuset.cpus. In this case,
>> the parent may not able to grant all the exclusive CPUs requested in
>> cpuset.cpus to cpuset.cpus.exclusive.effective if some of them have
>> already been granted to other partitions earlier.
>>
>> With the creation of multiple sibling partitions by setting
>> only cpuset.cpus, this does have the side effect that their exact
>> cpuset.cpus.exclusive.effective settings will depend on the order of
>> partition creation if there are conflicts. Due to the exclusive nature
>> of the CPUs in a partition, it is not easy to make it fair other than
>> the old behavior of invalidating all the conflicting partitions.
>>
>> For example,
>>   # echo "0-2" > A1/cpuset.cpus
>>   # echo "root" > A1/cpuset.cpus.partition
>>   # echo A1/cpuset.cpus.partition
>>   root
>>   # echo A1/cpuset.cpus.exclusive.effective
>>   0-2
>>   # echo "2-4" > B1/cpuset.cpus
>>   # echo "root" > B1/cpuset.cpus.partition
>>   # echo B1/cpuset.cpus.partition
>>   root
>>   # echo B1/cpuset.cpus.exclusive.effective
>>   3-4
>>   # echo B1/cpuset.cpus.effective
>>   3-4
>>
>> For users who want to be sure that they can get most of the CPUs they
>> want,
> 
> Slightly OT but I'd say that users want:
> a) confinement (some cpuset.cpus in leaves)
> b) isolation (cpuset.cpus.exclusive in leaves)
> c) hierarchical organization
>   - confinment generalizes OK
>   - children can only claim what parent allowed
> 
> Conflicting exclusivity configs should be no users intention or a want :-p
> 
> 
>> cpuset.cpus.exclusive should be used instead if they can set
>> it successfully without failure. Setting cpuset.cpus.exclusive will
>> guarantee that sibling conflicts from then onward is no longer possible.
> 
> I think the background idea of the paragraph (shift away from local to
> remote partitions, also mentioned the other day) could be somehow fitted
> into the Documentation/ hunks.
> 
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> ...
>> @@ -2632,6 +2641,9 @@ Cpuset Interface Files
>>  
>>  	The root cgroup is always a partition root and its state cannot
>>  	be changed.  All other non-root cgroups start out as "member".
>> +	Even though the "cpuset.cpus.exclusive*" control files are not
>> +	present in the root cgroup, they are implicitly the same as
>> +	"cpuset.cpus".
> 
> Even "cpuset.cpus" have CFTYPE_NOT_ON_ROOT, so this formulation might be
> confusing. Maybe it's same as "cpuset.cpus.effective"?
> 
> Thanks,
> Michal

-- 
Best regards,
Ridong


