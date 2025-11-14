Return-Path: <linux-kselftest+bounces-45601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD34C5AEA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 02:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CEA934AF87
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 01:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1319A239E9D;
	Fri, 14 Nov 2025 01:29:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1C24B28;
	Fri, 14 Nov 2025 01:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763083769; cv=none; b=VWYTZ02i9Ad8M4+9+Cc8fwWu8JPyJykUfRoiqC7bfZp8i03gTibyvt/0PTd7yVB9OUl8wlZa1+QtaQbSEG9sL0wKdYZgMkj00waBH9mvga++KHgI28CELus5f2ZmBwTG5L+KpwinUKncnbzTSZqm9yZhOvwC1a1uURB9+h74Ipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763083769; c=relaxed/simple;
	bh=J4PSsUlbui6Htfj00DRKS6H3KmzLIqqzup1GWaXoP98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FM6jZHPSFYAiQy2oA0kZQc62NS1DJmuq8XZ5WwXT5Kh3VMv3syQlIWBv1feK/QHj/qTJ0gGgOccgg03ye5P8A4H9k+4m6zeebtsrumQdUClinBSwtCwz45EkuQ1KGrB/IUiTvrgRgAkOMBpdbOz/MUhV3KMse2G8p8ge5P30XcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d700Z20GXzKHMY3;
	Fri, 14 Nov 2025 09:29:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 26F491A0CDC;
	Fri, 14 Nov 2025 09:29:22 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgA3ckvwhRZpoGWiAg--.40420S2;
	Fri, 14 Nov 2025 09:29:21 +0800 (CST)
Message-ID: <2ca99986-b15b-45bc-b2ee-23d9e5395691@huaweicloud.com>
Date: Fri, 14 Nov 2025 09:29:20 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Sun Shaojie <sunshaojie@kylinos.cn>
Cc: llong@redhat.com, cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, tj@kernel.org
References: <20251113131434.606961-1-sunshaojie@kylinos.cn>
 <lhfcykirz5afdzdc6wnroubsdhasww4gsfri4dxpzagiejjbep@322rtmyvwiyd>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <lhfcykirz5afdzdc6wnroubsdhasww4gsfri4dxpzagiejjbep@322rtmyvwiyd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3ckvwhRZpoGWiAg--.40420S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyDCF45JrWDGryUuF4xXrb_yoW5AF43pF
	W0k3Wftw4vqr1rCwsrJ3ZrZF1Sv3ZFvF1YyF95Wr1fAasrJ3Wvkw1qy3sxua9xWwn5Gw1j
	v39xZ393ZryDuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/11/14 1:07, Michal Koutný wrote:
> Hello.
> 
> On Thu, Nov 13, 2025 at 09:14:34PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
>> In cgroup v2, a mutual overlap check is required when at least one of two
>> cpusets is exclusive. However, this check should be relaxed and limited to
>> cases where both cpusets are exclusive.
>>
>> The table 1 shows the partition states of A1 and B1 after each step before
>> applying this patch.
>>
>> Table 1: Before applying the patch
>>  Step                                       | A1's prstate | B1's prstate |
>>  #1> mkdir -p A1                            | member       |              |
>>  #2> echo "0-1" > A1/cpuset.cpus            | member       |              |
>>  #3> echo "root" > A1/cpuset.cpus.partition | root         |              |
>>  #4> mkdir -p B1                            | root         | member       |
>>  #5> echo "0-3" > B1/cpuset.cpus            | root invalid | member       |
>>  #6> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid |
>>
>> After step #5, A1 changes from "root" to "root invalid" because its CPUs
>> (0-1) overlap with those requested by B1 (0-3). However, B1 can actually
>> use CPUs 2-3, so it would be more reasonable for A1 to remain as "root."
> 
> I remember there was the addition of cgroup_file_notify() for the
> cpuset.cpus.partition so that such changes can be watched for.
> 

This behavior is visible to user space, I think.

After further consideration, I still suggest retaining this rule.

If we relax this rule, the following checks should also be relaxed?

	/* The cpus_allowed of one cpuset cannot be a subset of another cpuset's exclusive_cpus */
	if (!cpumask_empty(cs1->cpus_allowed) &&
	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
		return true;

	if (!cpumask_empty(cs2->cpus_allowed) &&
	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
		return true;


For am example:
  Step                                       | A1's prstate | B1's prstate |
  #1> mkdir -p A1                            | member       |              |
  #2> echo "0-1" > A1/cpuset.cpus.exclusive  | member       |              |
  #3> echo "root" > A1/cpuset.cpus.partition | root         |              |
  #4> mkdir -p B1                            | root         | member       |
  #5> echo "0" > B1/cpuset.cpus              | root invalid | member       |

Currently, we mark A1 as invalid. But similar to the logic in this patch, why must A1 be
invalidated? B1 could also use the parent's effective CPUs, right?

This raises the question: Should we relax the restriction to allow a cpuset's cpus to be a subset of
its siblings' exclusive_cpus, thereby keeping A1 valid? If we do this, users may struggle to
understand what their cpuset.cpus.effective value is (and why it has that value)—contrary to their
expectations.

> I may not be seeing whole picture, so I ask -- why would it be "more
> reasonable" for A1 to remain root. From this description it looks like
> you'd silently convert B1's effective cpus to 2-3 but IIUC the code
> change that won't happen but you'd reject the write of "0-3" instead.
> 
> Isn't here missing Table 2: After applying the patch? I'm asking because
> of the number 1 but also because it'd make the intention clearer
> ;-), perhaps with a column for cpuset.cpus.effective.
> 
> Thanks,
> Michal

-- 
Best regards,
Ridong


