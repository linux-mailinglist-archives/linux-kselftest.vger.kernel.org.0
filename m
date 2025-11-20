Return-Path: <linux-kselftest+bounces-46035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D2BC71A04
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 01:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA4C14E2B7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 00:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958D5204F93;
	Thu, 20 Nov 2025 00:57:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EA5322A;
	Thu, 20 Nov 2025 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600277; cv=none; b=gtyBXgBBAn89uksNrlkcrkHW0zFrfvrF6RCeKtZbOaSAdiLjJKiVaNXn4H3uopABOdO4x+oe0RQRj/3gR+rTSaxEj4U/PiD3ABYQoc1aUcI11ZJ/0+faYMT1a21nCzTiP8I86k4sa/ZoxoC0bfumwa4bFtBv07eFxDwQNXNt9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600277; c=relaxed/simple;
	bh=HD4FvgXwrqeA7YIj/qM+7gIyeMp1HiiScAbshKa1Zdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVGRrJgg58QFjsu3IOA7Xn6oOvcmWTSGkbq0TdJ6fTKis5VwioY9eC+TsmK2LOzw8CwHz1ERxDK+GwKY1j5Yt1+HFBKHvE0F8TDk38q0cmkMftFCZYfDjfsG5DX7JRrX5mCW1N12lbEsB6yfPWxW63qd/bna3UOpz6WWEBFr9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dBg132m79zYQtpP;
	Thu, 20 Nov 2025 08:57:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 629C91A0939;
	Thu, 20 Nov 2025 08:57:52 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBXzFmPZx5pUvplBQ--.10207S2;
	Thu, 20 Nov 2025 08:57:52 +0800 (CST)
Message-ID: <06d74676-258e-43b7-ae61-d2102bab3926@huaweicloud.com>
Date: Thu, 20 Nov 2025 08:57:51 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Sun Shaojie <sunshaojie@kylinos.cn>
Cc: llong@redhat.com, cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, tj@kernel.org
References: <f32d2f31-630f-450b-911f-b512bbeb380a@huaweicloud.com>
 <20251119105749.1385946-1-sunshaojie@kylinos.cn>
 <unk64xmcj5kt5c5gaauwaeld5qsshaldw7utgzk362w33y3zr7@s765trmj5ccs>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <unk64xmcj5kt5c5gaauwaeld5qsshaldw7utgzk362w33y3zr7@s765trmj5ccs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXzFmPZx5pUvplBQ--.10207S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4xKr43GF13Gr4rJw4xZwb_yoW5Zw43pF
	W8KF18Ja1kXr1rGwsFq3WxXF4aq3ZrZF17AF98Gr40ywnFk3WkCF4qyr9xWFZ8J39xGw4j
	g3y7ZrWfZryUXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/19 21:20, Michal Koutný wrote:
> On Wed, Nov 19, 2025 at 06:57:49PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
>> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
>> with its sibling partition, the sibling's partition state becomes invalid.
>> However, this invalidation is often unnecessary. If the cpuset being
>> modified is exclusive, it should invalidate itself upon conflict.
>>
>> This patch applies only to the following two cases：
>>
>> Assume the machine has 4 CPUs (0-3).
>>
>>    root cgroup
>>       /    \
>>     A1      B1
>>
>> Case 1: A1 is exclusive, B1 is non-exclusive, set B1's cpuset.cpus
>>
>>  Table 1.1: Before applying this patch
>>  Step                                       | A1's prstate | B1's prstate |
>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>  #3> echo "0" > B1/cpuset.cpus              | root invalid | member       |
>>
>> After step #3, A1 changes from "root" to "root invalid" because its CPUs
>> (0-1) overlap with those requested by B1 (0). However, B1 can actually
>> use CPUs 2-3(from B1's parent), so it would be more reasonable for A1 to
>> remain as "root."
>>
>>  Table 1.2: After applying this patch
>>  Step                                       | A1's prstate | B1's prstate |
>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>  #3> echo "0" > B1/cpuset.cpus              | root         | member       |
>>
>> Case 2: Both A1 and B1 are exclusive, set B1's cpuset.cpus
> 
> (Thanks for working this out, Shaojie.)
> 
>>
>>  Table 2.1: Before applying this patch
>>  Step                                       | A1's prstate | B1's prstate |
>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>  #3> echo "2" > B1/cpuset.cpus              | root         | member       |
>>  #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>>  #5> echo "1-2" > B1/cpuset.cpus            | root invalid | root invalid |
>>
>> After step #4, B1 can exclusively use CPU 2. Therefore, at step #5,
>> regardless of what conflicting value B1 writes to cpuset.cpus, it will
>> always have at least CPU 2 available. This makes it unnecessary to mark
>> A1 as "root invalid".
>>
>>  Table 2.2: After applying this patch
>>  Step                                       | A1's prstate | B1's prstate |
>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>  #3> echo "2" > B1/cpuset.cpus              | root         | member       |
>>  #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>>  #5> echo "1-2" > B1/cpuset.cpus            | root         | root invalid |
>>
>> In summary, regardless of how B1 configures its cpuset.cpus, there will
>> always be available CPUs in B1's cpuset.cpus.effective. Therefore, there
>> is no need to change A1 from "root" to "root invalid".
> 
> Admittedly, I don't like this change because it relies on implicit
> preference ordering between siblings (here first comes, first served)

Agree. If we only invalidate the latter one, I think regardless of the implementation approach, we
may end up with different results depending on the order of operations.

> and so the effective config cannot be derived just from the applied
> values :-/
> 
> Do you actually want to achieve this or is it an implementation
> side-effect of the Case 1 scenario that you want to achieve?
> 
> 
> Thanks,
> Michal

-- 
Best regards,
Ridong


