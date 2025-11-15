Return-Path: <linux-kselftest+bounces-45689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2FDC60138
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 08:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C40734E34FE
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594C01DF970;
	Sat, 15 Nov 2025 07:41:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F1D7E792;
	Sat, 15 Nov 2025 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763192471; cv=none; b=FXfD4LLAKBcO9yUsySmEG+w8+czqiWxku5+6FzXWxx9YT0Z2jsPWqd2nBCWtCGusZ+fuMvriYh3fOmagljuf6nnkKU6EJjetn4pPimituGKIHhPMpTDBdYGxDqVClPlDxlzb2zkEw4rwCddqugnHgc2yQI48u8oF6ZlV+LM7JM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763192471; c=relaxed/simple;
	bh=YnS28CBlm2kdudtLHIY39jdmTBBK9VFE6DFQehs4kCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tv8HsHFyk7AHbBKLhZ8k2n7gtdy1gQsM5q32PiZLDx3KKf3WrCiW3SVcRIeBvXJXr4vOmjbIPjR0DOJQKnkhqiVO5d1XuozkQhoVQ/tgnq1vw2fb9grAEK8h2QCDJNuX/SpZX3SOpWL9xYCjPSggrR9BANGnP+sMnewIsgSujPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d7mBz3RBBzKHMPh;
	Sat, 15 Nov 2025 15:40:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 40FDD1A07BB;
	Sat, 15 Nov 2025 15:41:05 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgDXTFqPLhhpJl09Aw--.58092S2;
	Sat, 15 Nov 2025 15:41:05 +0800 (CST)
Message-ID: <d9332ba1-2614-44c2-b2e8-eab213f196bc@huaweicloud.com>
Date: Sat, 15 Nov 2025 15:41:03 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
To: Sun Shaojie <sunshaojie@kylinos.cn>, mkoutny@suse.com, llong@redhat.com
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, tj@kernel.org
References: <19fa5a93-4cc9-4f84-891c-b3b096a68799@huaweicloud.com>
 <20251115060211.853449-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251115060211.853449-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXTFqPLhhpJl09Aw--.58092S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1fCw48CryUXr1xKw15urg_yoWxWw1UpF
	W8KFn8Jw4kXF15CwsIqFn7Wa1aya9FqFsrXF95Gry0yr9rtF1qy3WvyrZIk3y5Wr95Gay2
	qrZFvrWSvFyDXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/15 14:02, Sun Shaojie wrote:
> On 2015/11/15 08:58, Chen Ridong wrote:
>> On 2025/11/15 0:14, Michal Koutný wrote:
>>> On Fri, Nov 14, 2025 at 09:29:20AM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>>> After further consideration, I still suggest retaining this rule.
>>>
>>> Apologies, I'm slightly lost which rule. I hope the new iteration from
>>> Shaojie with both before/after tables will explain it.
>>>
>>
>> The rule has changed in this patch from "If either cpuset is exclusive, check if they are mutually
>> exclusive" to
>> "If both cpusets are exclusive, check if they are mutually exclusive"
>>
>>  -    /* If either cpuset is exclusive, check if they are mutually exclusive */
>>  -    if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>>  +    /* If both cpusets are exclusive, check if they are mutually exclusive */
>>  +    if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
>>  +        return !cpusets_are_exclusive(cs1, cs2);
>>
>> I suggest not modifying this rule and keeping the original logic intact:
>>
>>>> For am example:
>>>>   Step                                       | A1's prstate | B1's prstate |
>>>>   #1> mkdir -p A1                            | member       |              |
>>>>   #2> echo "0-1" > A1/cpuset.cpus.exclusive  | member       |              |
>>>>   #3> echo "root" > A1/cpuset.cpus.partition | root         |              |
>>>>   #4> mkdir -p B1                            | root         | member       |
>>>>   #5> echo "0" > B1/cpuset.cpus              | root invalid | member       |
>>>>
>>>> Currently, we mark A1 as invalid. But similar to the logic in this patch, why must A1 be
>>>> invalidated?
>>>
>>> A1 is invalidated becase it doesn't have exclusive ownership of CPU 0
>>> anymore.
>>>
>>>> B1 could also use the parent's effective CPUs, right?
>>>
>>> Here you assume some ordering between siblings treating A1 more
>>> important than B1. But it's symmetrical in principle, no?
>>>
>>
>> I’m using an example to illustrate that if Shaojie’s patch is accepted, other rules could be relaxed
>> following the same logic—but I’m not in favor of doing so.
> 
> Hi, Ridong,
> 
> Thank you for pointing out the issue with the current patch; this is indeed
> not what our product intends. I must admit that I haven't thoroughly tested
> on such recent kernel versions.
> 
> Obviously, this patch is flawed. However, patch v3 is needed. Regarding the
> "other rules" you mentioned, we do not intend to relax them. On the 
> contrary, we aim to maintain them firmly.
> 
> Our product need ensure the following behavior: in cgroup-v2, user 
> modifications to one cpuset should not affect the partition state of its 
> sibling cpusets. This is justified and meaningful, as it aligns with the 
> isolation characteristics of cgroups.
> 

This is ideal in theory, but I don’t think it’s practical in reality.

> This can be divided into two scenarios:
> Scenario 1: Only one of A1 and B1 is "root".
> Scenario 2: Both A1 and B1 are "root".
> 
> We plan to implement Scenario 1 first. This is the goal of patch v2.
> However, patch v2 is flawed because it does not strictly adhere to the 
> following existing rule.
> 
> However, it is worth noting that the current cgroup v2 implementation does 
> not strictly adhere to the following rule either (which is also an 
> objective for patch v3 to address).
> 
> Rule 1: "cpuset.cpus" cannot be a subset of a sibling's "cpuset.cpus.exclusive".
> 
> Using your example to illustrate.
>  Step (refer to the steps in the table below）
>  #1> mkdir -p A1                           
>  #2> echo "0-1" > A1/cpuset.cpus.exclusive 
>  #3> echo "root" > A1/cpuset.cpus.partition
>  #4> mkdir -p B1               
>  #5> echo "0" > B1/cpuset.cpus 
> 
> Table 1: Current result
>  Step | return | A1's excl_cpus | B1's cpus | A1's prstate | B1's prstate |
>  #1   | 0      |                |           | member       |              |
>  #2   | 0      | 0-1            |           | member       |              |
>  #3   | 0      | 0-1            |           | root         |              |
>  #4   | 0      | 0-1            |           | root         | member       |
>  #5   | 0      | 0-1            | 0         | root invalid | member       |
> 

I think this what we expect.

> Table 2: Expected result
>  Step | return | A1's excl_cpus | B1's cpus | A1's prstate | B1's prstate |
>  #1   | 0      |                |           | member       |              |
>  #2   | 0      | 0-1            |           | member       |              |
>  #3   | 0      | 0-1            |           | root         |              |
>  #4   | 0      | 0-1            |           | root         | member       |
>  #5   | error  | 0-1            |           | root         | member       |
> 

Step 5 should not return an error. As Longman pointed out, in cgroup-v2, setting cpuset.cpus should
never fail.

> Currently, after step #5, the operation returns success, which clearly 
> violates Rule 1, as B1's "cpuset.cpus" is a subset of A1's 
> "cpuset.cpus.exclusive".
> 
> Therefore, after step #5, the operation should return error, with A1 
> remaining as "root". This better complies with the Rule 1.
> 

This is an exclusivity rule. Since it violates the exclusivity rules, A1 should be invalidated.

> ------
> The following content is provided for reference, and we hope it may be 
> adopted in the future.
> !!These are not part of what patch v3 will implement.
> 
> As for Scenario 2 (Both A1 and B1 are "root")， we will retain the current 
> cgroup v2 behavior. This patch series does not modify it, but we hope to 
> draw the maintainers' attention, as we indeed have plans for future 
> modifications. Our intent can be seen from the following examples.
> 
> For example:
>  Step (refer to the steps in the table below）
>  #1> mkdir -p A1                           
>  #2> echo "0-1"  > A1/cpuset.cpus 
>  #3> echo "root" > A1/cpuset.cpus.partition
>  #4> mkdir -p B1               
>  #5> echo "2-3"  > B1/cpuset.cpus 
>  #6> echo "root" > B1/cpuset.cpus.partition
>  #7> echo "1-2"  > B1/cpuset.cpus
> 
> Table 1: Current result
>  Step | A1's eft_cpus | B1's eft_cpus | A1's prstate | B1's prstate |
>  #1   | from parent   |               | member       |              |
>  #2   | 0-1           |               | member       |              |
>  #3   | 0-1           |               | root         |              |
>  #4   | 0-1           | from parent   | root         | member       |
>  #5   | 0-1           | 2-3           | root         | member       |
>  #6   | 0-1           | 2-3           | root         | root         |
>  #7   | 0-1           | 1-2           | root invalid | root invalid |
> 
> Table 2: Expected result
>  Step | A1's eft_cpus | B1's eft_cpus | A1's prstate | B1's prstate |
>  #1   | from parent   |               | member       |              |
>  #2   | 0-1           |               | member       |              |
>  #3   | 0-1           |               | root         |              |
>  #4   | 0-1           | from parent   | root         | member       |
>  #5   | 0-1           | 2-3           | root         | member       |
>  #6   | 0-1           | 2-3           | root         | root         |
>  #7   | 0-1           | 2             | root         | root invalid |
> 
> After step #7, we expect A1 to remain "root" (unaffected), while only B1 
> becomes "root invalid".
> 

With the result you expect, would we observe the following behaviors:

#1> mkdir -p A1
#2> mkdir -p B1
#3> echo "0-1"  > A1/cpuset.cpus
#4> echo "1-2"  > B1/cpuset.cpus
#5> echo "root" > A1/cpuset.cpus.partition
#6> echo "root" > B1/cpuset.cpus.partition # A1:root;B1:root invalid

#1> mkdir -p A1
#2> mkdir -p B1
#3> echo "0-1"  > A1/cpuset.cpus
#4> echo "1-2"  > B1/cpuset.cpus
#5> echo "root" > B1/cpuset.cpus.partition
#6> echo "root" > A1/cpuset.cpus.partition # A1:root invalid;B1:root

Do different operation orders yield different results? If so, this is not what we expect.

-- 
Best regards,
Ridong


