Return-Path: <linux-kselftest+bounces-45690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F01C602B8
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 10:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2CC3B9E55
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 09:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F852820A9;
	Sat, 15 Nov 2025 09:51:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B73D2749E6;
	Sat, 15 Nov 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763200292; cv=none; b=MijyzMhNXfqeDY1gi3jGnBbx+syKKyVjS1L+HalJlxkNI6gVXNl2eQln2ocjaecNGTrpV7OLpuJidWYTD5Yp+lowMzh9jSL5XbH9ygpzi25+qw+KjZKnNEwZZcA110bxOaXb5/71xTbA0KHma5S1q27vCIDJUutz+rbEE9dDEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763200292; c=relaxed/simple;
	bh=yw8tQBOyB93srTjowAcCDv2klbNxg0UIg/9aUexsWMM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d2bqFP1gU215CDk5YIAAfdOqlGv6NzArQa87kulDHcwq71pKKUZsSpkZGtVy0GR89UBTX7uMNIv9RR+EAnycECP0GhbSQ4PIGxnmMdSIpfGW36LYLcLxVW8P+D+RwKsn8Y7J1fRPIROmRSv9u2ENEi7yY76tuV63it8mazKwWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d7q5N2ch9zKHMfb;
	Sat, 15 Nov 2025 17:51:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 479AA1A07BB;
	Sat, 15 Nov 2025 17:51:26 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgD3MkwbTRhpgUs_Aw--.16577S2;
	Sat, 15 Nov 2025 17:51:25 +0800 (CST)
Message-ID: <b6d9088e-bd35-47c5-a891-4ad3705fd1a6@huaweicloud.com>
Date: Sat, 15 Nov 2025 17:51:23 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
From: Chen Ridong <chenridong@huaweicloud.com>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Sun Shaojie <sunshaojie@kylinos.cn>
Cc: llong@redhat.com, cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, tj@kernel.org
References: <19fa5a93-4cc9-4f84-891c-b3b096a68799@huaweicloud.com>
 <20251114062448.685754-1-sunshaojie@kylinos.cn>
 <4b7znoqq6sdtutcn3jafyrucpqe5jylryvoeooz5ah54vbei4f@wxhsd7gkj3tp>
 <765120d5-1887-4376-b779-8294df137b9d@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <765120d5-1887-4376-b779-8294df137b9d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3MkwbTRhpgUs_Aw--.16577S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4Utr1DKw4UKw15Jw4xWFg_yoW5uw1UpF
	yrKF15Ja4F9r15Cw42q3WxWr4YqanrZF1UArnxG3yxJws2q3WqkF1jkrZxX3s8XwsxGryj
	vay7uw4FqFnrG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/15 10:01, Chen Ridong wrote:
> 
> 
> On 2025/11/15 0:15, Michal Koutný wrote:
>> On Fri, Nov 14, 2025 at 02:24:48PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
>>> The desired outcome is that after step #5, although B1 writes "0-3" to 
>>> cpuset.cpus, A1 can still remain as "root", and B1 ends up with effective 
>>> CPUs of 2-3. In summary, We want to avoid A1's invalidation when B1 
>>> changes its cpuset.cpus. Because cgroup v2 allows the effective CPU mask 
>>> of a cpuset to differ from its requested mask.
>>
>> So the new list of reasons why configured cpuset's cpus change are:
>> - hotplug,
>> - ancestor's config change,
>> - stealing by a sibling (new).
>>
>> IIUC, the patch proposes this behavior:
>>
>>   echo root >A1.cpuset.partition
>>   echo 0-1 >A1.cpuset.cpus
>>   
>>   echo root >B1.cpuset.partition
>>   echo 1-2 >B1.cpuset.cpus	# invalidates A1
>>   
>>   echo 0-1 >A1.cpuset.cpus	# invalidates B1
>>   
>>   ping-pong over CPU 1 ad libitum
>>
>> I think the right (tm) behavior would be not to depend on the order in
>> which config is applied to siblings, i.e.
>>
>>   echo root >A1.cpuset.partition
>>   echo 0-1 >A1.cpuset.cpus
>>   
>>   echo root >B1.cpuset.partition
>>   echo 1-2 >B1.cpuset.cpus	# invalidates both A1 and B1
>>
>>   echo 0-1 >A1.cpuset.cpus	# no change anymore
>>
>> (I hope my example sheds some light on my understanding of the situation
>> and desired behavior.)
> 
> Before applying the patch, the behavior I got:
> 
> 	# cd /sys/fs/cgroup/
> 	# mkdir A1
> 	# mkdir B1
> 	# echo root > A1/cpuset.cpus.partition
> 	# echo 0-1 > A1/cpuset.cpus
> 	# cat A1/cpuset.cpus.partition
> 	root
> 	# echo root > B1/cpuset.cpus.partition
> 	# echo 1-2 > B1/cpuset.cpus  # A1 is exclusive, invalidate both A1 and B1
> 	# cat A1/cpuset.cpus.partition
> 	root invalid
> 	# cat B1/cpuset.cpus.partition
> 	root invalid (cpuset.cpus and cpuset.cpus.exclusive are empty)
> 	# echo root > B1/cpuset.cpus.partition
> 	# cat B1/cpuset.cpus.partition
> 	root invalid (Cpu list in cpuset.cpus not exclusive)
> 	# echo root > A1/cpuset.cpus.partition
> 	# cat A1/cpuset.cpus.partition
> 	root invalid (Cpu list in cpuset.cpus not exclusive)
> 	#
> 
> After applying the patch, the behavior I got:
> 
> 	# cd /sys/fs/cgroup/
> 	# mkdir A1
> 	#  mkdir B1
> 	# echo root > A1/cpuset.cpus.partition
> 	# echo 0-1 > A1/cpuset.cpus
> 	# cat A1/cpuset.cpus.partition
> 	root
> 	# echo root > B1/cpuset.cpus.partition
> 	# echo 1-2 > B1/cpuset.cpus # A1 is exclusive, B1 is going to be exclusive
> 	# cat A1/cpuset.cpus.partition
> 	root
> 	# cat B1/cpuset.cpus.partition # A1 and B1 should be invalid.
> 	root
> 	# echo member > B1/cpuset.cpus.partition
> 	# echo root > B1/cpuset.cpus.partition
> 	# cat A1/cpuset.cpus.partition
> 	root
> 	# cat B1/cpuset.cpus.partition
> 	root invalid (Cpu list in cpuset.cpus not exclusive)
> 	# echo member > A1/cpuset.cpus.partition
> 	# echo root > B1/cpuset.cpus.partition
> 	# echo root > A1/cpuset.cpus.partition
> 	# cat A1/cpuset.cpus.partition
> 	root invalid (Cpu list in cpuset.cpus not exclusive)
> 	# cat B1/cpuset.cpus.partition
> 	root
> 
> After applying the patch, The result is unexpected.
> 

This may trigger another related corner case, I sent a patch to fix it:

https://lore.kernel.org/cgroups/20251115093140.1121329-1-chenridong@huaweicloud.com/T/#mfc4157e23d253b71ef9a2cfa5cb54bf41449840c

-- 
Best regards,
Ridong


