Return-Path: <linux-kselftest+bounces-45502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84485C553CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 02:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CF81345EC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 01:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828E02638BA;
	Thu, 13 Nov 2025 01:21:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1925A33F;
	Thu, 13 Nov 2025 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762996906; cv=none; b=L+DJF2Sz+cJMLIs2Gi4LuwMwlUD1BZB2WRzNEPmzcI+FMeDdFeZSMlQVBjgMr+Xw6JtWuFRd75pidZxMPRfI/bCFYJbiIzBhtjJLxmznlgCAAXA4G6DMeZhl078ORHKSW3eGpI8CqOlo6ArAEPp8PTStAitgrhEKwFYleHFwdZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762996906; c=relaxed/simple;
	bh=MvRL7rpYLgibW2DCccoXSo/lpnB5jFWoYIQwGKLtd5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjor6p9FiY1bFN/FawM/WoS7pvpEClX6rlDDqzwnurzR7/oQ7nr/FxNFprwo1RT3YDUMIiKzyC9XC59Tq7QL0BHoUDmDLGQMVMcOZHOw37ni0YAVsJ9Eh6TuG8/pB4Vr/H7f2VsGN9cUfoKL7i9t6EOrvVHPATTt5zFrzr9uiAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d6MtB19VCzKHMVh;
	Thu, 13 Nov 2025 09:21:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 83CAE1A1B1C;
	Thu, 13 Nov 2025 09:21:40 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgC3E3qiMhVpGGMzAg--.47040S2;
	Thu, 13 Nov 2025 09:21:40 +0800 (CST)
Message-ID: <975bf7c2-aa47-4ec2-b71f-d3e31644947d@huaweicloud.com>
Date: Thu, 13 Nov 2025 09:21:38 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
To: Waiman Long <llong@redhat.com>, Sun Shaojie <sunshaojie@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <b9dce00a-4728-4ac8-ae38-7f41114c7c81@redhat.com>
 <20251112094610.386299-1-sunshaojie@kylinos.cn>
 <85f438b2-5131-4794-bb2d-09ca611fb246@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <85f438b2-5131-4794-bb2d-09ca611fb246@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3E3qiMhVpGGMzAg--.47040S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFW8Zw4UCw15KF4UtFWrZrb_yoW5tryxpF
	WDKF4Yyan5W342kwsFqwn7Xr4rta97uFsrJr15Jr1xCrW5uF1vyrs0ywsIgFy5W3yrJ34Y
	vrWqqwn3ZF1qyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/13 2:05, Waiman Long wrote:
> On 11/12/25 4:46 AM, Sun Shaojie wrote:
>> Hi Ridong,
>>
>> Thank you for your response.
>>
>>  From your reply "in case 1, A1 can also be converted to a partition," I
>> realize there might be a misunderstanding. The scenario I'm addressing
>> involves two sibling cgroups where one is an effective partition root and
>> the other is not, and both have empty cpuset.cpus.exclusive. Let me
>> explain the intention behind case 1 in detail, which will also illustrate
>> why this has negative impacts on our product.
>>
>> In case 1, after #3 completes, A1 is already a valid partition root - this
>> is correct.After #4, B1 was generated, and B1 is no-exclusive. After #5,
>> A1 changes from "root" to "root invalid". But A1 becoming "root invalid"
>> could be unnecessary because having A1 remain as "root" might be more
>> acceptable. Here's the analysis:
>>
>> As documented in cgroup-v2.rst regarding cpuset.cpus: "The actual list of
>> CPUs to be granted, however, is subjected to constraints imposed by its
>> parent and can differ from the requested CPUs". This means that although
>> we're requesting CPUs 0-3 for B1, we can accept that the actual available
>> CPUs in B1 might not be 0-3.
>>
>> Based on this characteristic, in our product's implementation for case 1,
>> before writing to B1's cpuset.cpus in #5, we check B1's parent
>> cpuset.cpus.effective and know that the CPUs available for B1 don't include
>> 0-1 (since 0-1 are exclusively used by A1). However, we still want to set
>> B1's cpuset.cpus to 0-3 because we hope that when 0-1 become available in
>> the future, B1 can use them without affecting the normal operation of other
>> cgroups.
>>
>> The reality is that because B1's requested cpuset.cpus (0-3) conflicts with
>> A1's exclusive CPUs (0-1) at that moment, it destroys the validity of A1's
>> partition root. So why must the current rule sacrifice A1's validity to
>> accommodate B1's CPU request? In this situation, B1 can clearly use 2-3
>> while A1 exclusively uses 0-1 - they don't need to conflict.
>>
>> This patch narrows the exclusivity conflict check scope to only between
>> partitions. Moreover, user-specified CPUs (including cpuset.cpus and
>> cpuset.cpus.exclusive) only have true exclusive meaning within effective
>> partitions. So why should the current rule perform exclusivity conflict
>> checks between an exclusive partition and a non-exclusive member? This is
>> clearly unnecessary.
> 
> As I have said in the other thread, v2 exclusive cpuset checking follows the v1 rule. However, the
> behavior of setting cpuset.cpus differs between v1 and v2. In v1, setting cpuset.cpus can fail if
> there is some conflict. In v2, users are allow to set whatever value they want without failure, but
> the effective CPUs granted will be subjected to constraints and differ from cpuset.cpus. So in that
> sense, I think it makes sense to relax the exclusive cpuset check for v2, but we still need to keep
> the current v1 behavior. Please update your patch to do that.
> 
> Cheers,
> Longman
> 

Hi, Longman.

It did not fail to set cupset.cpus, but invalidated the sibling cpuset partition.

If we relax this rule, we should consider:

  What I want to note is this: what if we run echo root > /sys/fs/cgroup/B1/cpuset.cpus.partition
after step #5? There’s no conflict check when enabling the partition.

-- 
Best regards,
Ridong


