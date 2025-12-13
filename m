Return-Path: <linux-kselftest+bounces-47544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9BDCBA218
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Dec 2025 01:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C68E307F8D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Dec 2025 00:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C0A2253EF;
	Sat, 13 Dec 2025 00:52:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7FC1DF748;
	Sat, 13 Dec 2025 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765587139; cv=none; b=cBR+oJlmnO5RflFtieBxkGLX1G/+c6TtDgJ5N9zxwByC2UGrzxB1Ym/4m72GPuRziVCcN88IF5w1KOI0aTHTAhtZ0DUJAg1QlMrEaAHJWK4jC23ryGzoHPmnfF3kE35fuKJ1Rl4VQRKl4xVbs1x4KW8sWkyyJrSygudBMYqd62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765587139; c=relaxed/simple;
	bh=hSf6OhBwSO5bj3V01S56t7c+MIR2jA5g6auz6Bl3sUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZ4Vex6SOwwN0bQCNNOiHYfwGPJq+LhfoqNmBnnD6XE/XbpbrIMKB7DkkycZ4hlmCqtH9z3jMulxPyA5MegiqcBKzEvQQE0k5qdG56wh31auv/u7RDVFK5toYgaBtyIvLuJMnP+tyO+DO/QHlwUEfHRC8Mn2zwRMev46BH+09Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dSnpL270VzYQtlK;
	Sat, 13 Dec 2025 08:51:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 991CF1A07BD;
	Sat, 13 Dec 2025 08:52:13 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgAH51C8uDxpYxE0Bg--.5936S2;
	Sat, 13 Dec 2025 08:52:13 +0800 (CST)
Message-ID: <4ab8a086-4200-45c0-9583-abf6e52a354a@huaweicloud.com>
Date: Sat, 13 Dec 2025 08:52:11 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llong@redhat.com, mkoutny@suse.com, shuah@kernel.org, tj@kernel.org
References: <45f5e2c6-42ec-4d77-9c2d-0e00472a05de@huaweicloud.com>
 <20251201094447.108278-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251201094447.108278-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAH51C8uDxpYxE0Bg--.5936S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3WrW8Ar17XryfuF1UGFg_yoW8trWUpF
	yxK3WDta90qr1rCws2qr4qvF1Fqa4kuF17JFs8GryxGrs5JF1vy3W7CrnxurZ8Xr95Gr1j
	v3y5uws3CF4DXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/12/1 17:44, Sun Shaojie wrote:
> Hi, Ridong,
> 
> On Thu, 27 Nov 2025 09:55:21, Chen Ridong wrote:
>> I have to admit that I prefer the current implementation.
>>
>> At the very least, it ensures that all partitions are treated fairly[1]. Relaxing this rule would
>> make it more difficult for users to understand why the cpuset.cpus they configured do not match the
>> effective CPUs in use, and why different operation orders yield different results.
> 
> As for "different operation orders yield different results", Below is an
> example that is not a corner case.
> 
>     root cgroup
>       /    \
>      A1    B1
> 
>  #1> echo "0" > A1/cpuset.cpus
>  #2> echo "0-1" > B1/cpuset.cpus.exclusive --> return error
> 
>  #1> echo "0-1" > B1/cpuset.cpus.exclusive
>  #2> echo "0" > A1/cpuset.cpus
> 

You're looking at one rule, but there's another one—Longman pointed out that setting cpuset.cpu
should never fail.

>>
>> In another scenario, if we do not invalidate the siblings, new leaf cpusets (marked as member)
>> created under A1 will end up with empty effective CPUs—and this is not a desired behavior.
>>
>>   root cgroup
>>        |
>>       A1
>>      /  \
>>    A2    A3...
>>
>> #1> echo "0-1" > A1/cpuset.cpus
>> #2> echo "root" > A1/cpuset.cpus.partition
>> #3> echo "0-1" > A2/cpuset.cpus
>> #4> echo "root" > A2/cpuset.cpus.partition
>> mkdir A4
>> mkdir A5
>> echo "0" > A4/cpuset.cpus
>> echo $$ > A4/cgroup.procs
>> echo "1" > A5/cpuset.cpus
>> echo $$ > A5/cgroup.procs
>>
> 
> If A2...A5 all belong to the same user, and that user wants both A4 and A5 
> to have effective CPUs, then the user should also understand that A2 needs
> to be adjusted to "member" instead of "root".
> 
> if A2...A5 belong to different users, must satisfying user A4’s requirement
> come at the expense of user A2’s requirement? That is not fair.
> 

Regarding cpuset usage with Docker: when binding CPUs at container startup, do you check the sibling
CPUs in use? Without this check, A2 will not be invalidated.

Your patch has been discussed for a while. It seems to make the rules more complex.

>>
>> [1]: "B1 is a second-class partition only because it starts later or why is it OK to not fulfill its
>> requirement?" --Michal.
> 
> Thanks,
> Sun Shaojie

-- 
Best regards,
Ridong


