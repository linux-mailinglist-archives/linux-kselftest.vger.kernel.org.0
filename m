Return-Path: <linux-kselftest+bounces-45679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED3FC5FC9D
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 01:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 384264E635C
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 00:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BDE18DB2A;
	Sat, 15 Nov 2025 00:58:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA28F49;
	Sat, 15 Nov 2025 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763168300; cv=none; b=ddkDTJmxHlmc0ObL07SElsEHfBQ02D0Op1p9EZFhS/821wY0aoVWLuncqLzPWEJf2kniDK7PkaMY+gj1SBl05wN6Bl0/tITbksEURyqD+bcCcZ3VZb4wt+anHGd+MXhTF4ddC0cDEoUa1yccAyfKtPcp+UD0irQFJehw7SPsSBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763168300; c=relaxed/simple;
	bh=8IL0zhAcSQsz89HwY+L9Qfb3uIAAaM75wCR11nPqZcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVATk7OnHu3LgAOeduibTPGm81b1/N2M60kl1xQR4PD047cJlO2Fbho2Yuwe4sCNYsblwK3vR4jaE3AKiVtp1vS/PdB82RtwJKPUgSeQuBldjZEzgQCxl1ECNKqCy9ikJcOnZppc0f5ACp/JLfXDDw1it4A1AJg3NUl6abm43sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d7bG16PMjzKHMN2;
	Sat, 15 Nov 2025 08:57:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3F2971A08CA;
	Sat, 15 Nov 2025 08:58:07 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgDX_lsd0BdpinYcAw--.896S2;
	Sat, 15 Nov 2025 08:58:07 +0800 (CST)
Message-ID: <4ff564c4-a2c3-4599-8e7f-762380f44153@huaweicloud.com>
Date: Sat, 15 Nov 2025 08:58:05 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Sun Shaojie <sunshaojie@kylinos.cn>, llong@redhat.com,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, tj@kernel.org
References: <20251113131434.606961-1-sunshaojie@kylinos.cn>
 <lhfcykirz5afdzdc6wnroubsdhasww4gsfri4dxpzagiejjbep@322rtmyvwiyd>
 <2ca99986-b15b-45bc-b2ee-23d9e5395691@huaweicloud.com>
 <4gzorntzaig4vnskzkumnpvpqfbqrzaahlkn5c33cgtjdm5eef@gtvm3p2rihm7>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <4gzorntzaig4vnskzkumnpvpqfbqrzaahlkn5c33cgtjdm5eef@gtvm3p2rihm7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDX_lsd0BdpinYcAw--.896S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4DXF13tFy8try7Ww4kWFg_yoW8Kr47pr
	y8Ka17JaykuF1UCws2gwnrXFsYva12qFsxJrn5Xw18A3sxJF1q9wn5AwsxJayDJrsxW3ya
	q39rZaySgFn8uaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/11/15 0:14, Michal Koutný wrote:
> On Fri, Nov 14, 2025 at 09:29:20AM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> After further consideration, I still suggest retaining this rule.
> 
> Apologies, I'm slightly lost which rule. I hope the new iteration from
> Shaojie with both before/after tables will explain it.
> 

The rule has changed in this patch from "If either cpuset is exclusive, check if they are mutually
exclusive" to
"If both cpusets are exclusive, check if they are mutually exclusive"

  -	/* If either cpuset is exclusive, check if they are mutually exclusive */
  -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
  +	/* If both cpusets are exclusive, check if they are mutually exclusive */
  +	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
  +		return !cpusets_are_exclusive(cs1, cs2);

I suggest not modifying this rule and keeping the original logic intact:

>> For am example:
>>   Step                                       | A1's prstate | B1's prstate |
>>   #1> mkdir -p A1                            | member       |              |
>>   #2> echo "0-1" > A1/cpuset.cpus.exclusive  | member       |              |
>>   #3> echo "root" > A1/cpuset.cpus.partition | root         |              |
>>   #4> mkdir -p B1                            | root         | member       |
>>   #5> echo "0" > B1/cpuset.cpus              | root invalid | member       |
>>
>> Currently, we mark A1 as invalid. But similar to the logic in this patch, why must A1 be
>> invalidated?
> 
> A1 is invalidated becase it doesn't have exclusive ownership of CPU 0
> anymore.
> 
>> B1 could also use the parent's effective CPUs, right?
> 
> Here you assume some ordering between siblings treating A1 more
> important than B1. But it's symmetrical in principle, no?
> 

I’m using an example to illustrate that if Shaojie’s patch is accepted, other rules could be relaxed
following the same logic—but I’m not in favor of doing so.

>> This raises the question: Should we relax the restriction to allow a cpuset's cpus to be a subset of
>> its siblings' exclusive_cpus, thereby keeping A1 valid? If we do this, users may struggle to
>> understand what their cpuset.cpus.effective value is (and why it has that value)—contrary to their
>> expectations.
> 
> Not only users, not only users. I think struggle is reduced when
> the resulting state (valid/invalid, effective) doesn't depend on the
> order in which individual cgroups are configured.
> 
> 0.02€,
> Michal

-- 
Best regards,
Ridong


