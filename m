Return-Path: <linux-kselftest+bounces-45610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3EDC5BA9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DAB04F065C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 06:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33FB2F49FC;
	Fri, 14 Nov 2025 06:59:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB86258EF6;
	Fri, 14 Nov 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103563; cv=none; b=dIqJJERJ3lOlt5a/+E4YrGMEO1IK63fOwhaAghFkakZwgqb9DeFn185tmVVoR14wI3OhsrPfxtsr7uVJ0g0K8sywSCUjyaWtZgQDrKlTIFfjOPKFXQPCNDUbaM+rO06cepmahisO3vIMz6ZdOppN3oB51SdsfI0iNyvklNd6hpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103563; c=relaxed/simple;
	bh=D9rlh996XyNhieXxG50mRFT4YEPy8/v/mffeNcfemEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbOzglSJj0rKdNFMBg0MzXh7JY9tknM6wrO/uuQOHds0WWY2SgM9ZwPm16bhlVAP6xTwfw38T+3BZlB9i/WBNHfeT7ItCqRKXN1DM6Zhoe1sJxcfdIE7VbRnPG5T5A7UJvDumGvbbNoNCi6WuAW62fKXzwXA4ctW0NHq1U9aJKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d77Jt4r8HzYQv74;
	Fri, 14 Nov 2025 14:58:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0D3D61A07C0;
	Fri, 14 Nov 2025 14:59:10 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgDnsBI80xZpNUa3Ag--.58933S2;
	Fri, 14 Nov 2025 14:59:09 +0800 (CST)
Message-ID: <df95cda2-71b5-403c-8644-3c114f69ba1a@huaweicloud.com>
Date: Fri, 14 Nov 2025 14:59:08 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: mkoutny@suse.com, llong@redhat.com, cgroups@vger.kernel.org,
 hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, tj@kernel.org
References: <19fa5a93-4cc9-4f84-891c-b3b096a68799@huaweicloud.com>
 <20251114063312.687950-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251114063312.687950-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDnsBI80xZpNUa3Ag--.58933S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWDZr4DJr1xXF1DJryrJFb_yoW8Ar1rpF
	ykGF12ya1j9F1UC3yrtrnYgwsYqw42qFnrJwn8Jr1rAFZrtF17Arn5uwnxAr15Zrs5G34a
	van8X39a9F4rKFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/14 14:33, Sun Shaojie wrote:
> On 2025/11/14 08:50, Chen Ridong Wrote:
>> On 2025/11/13 21:14, Sun Shaojie wrote:
>>> ...
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 52468d2c178a..3240b3ab5998 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -592,8 +592,13 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>>>   */
>>>  static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>>>  {
>>> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
>>> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>>> +	/* If both cpusets are exclusive, check if they are mutually exclusive */
>>> +	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
>>> +		return !cpusets_are_exclusive(cs1, cs2);
>>> +
>>> +	/* In cgroup-v1, if either cpuset is exclusive, check if they are mutually exclusive */
>>> +	if (!is_in_v2_mode() &&
>>> +	    (is_cpu_exclusive(cs1) != is_cpu_exclusive(cs2)))
>>>  		return !cpusets_are_exclusive(cs1, cs2);
>>>  
>>
>> I prefer adding a helper function in the cpuset-v1.c file, similar to cpus_excl_conflict_legacy().
>>
>> For cpuset v1, it can simply return cpus_excl_conflict_legacy(). It seems that other rules are not
>> relevant to v1.
>>
>>>  	/* Exclusive_cpus cannot intersect */
> 
> Hi, Ridong,
> 
> Thank you for the suggestion.I will update the patch accordingly.
> 

If we are ready to relax this rule, adding the v1 logic in cpuset1_validate_change might be
appropriate. However, as I mentioned in my reply to Michal, I believe further discussion is needed.

-- 
Best regards,
Ridong


