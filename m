Return-Path: <linux-kselftest+bounces-46599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E2DC8C9D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 02:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D4594E1638
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 01:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D78B239E88;
	Thu, 27 Nov 2025 01:55:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A721CA0D;
	Thu, 27 Nov 2025 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764208528; cv=none; b=jeSFHf4+s+feyBrP/vXZfjvRSgpoYvWLUT8tp+tVtEMgI4iq0E+WLukyFSnwy+3njp2A8AASOoAj8QL4OryUgCK0QAs8Adjf7kipNaUYqdLU4gLkWhOSKFM4nQi1iXsf2gPMC+RDcfKNULhen4dJIZ/q8gNGiLUOJewsqMf2hPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764208528; c=relaxed/simple;
	bh=f8HaffxYEDyziCrJawQYJ2johcAMb8sTSL7E9pblxt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jltFgzB1vAE2FbztRiWdwm0oEKN9f3Tgr6CS0kA3dX0eJNPrxmf5jAP4ONUE/w7FrnKaI760pqv2NFFB41FqfG50JNNHgyghZMNlMkcoj42mpwDfd4mOjIJ0AulnlMJGFvSzwbRtAB234nLDjgYJxmcJsxtU8cQ1XDJCGYIrnsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dGzyC1Z58zKHMNR;
	Thu, 27 Nov 2025 09:54:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C85721A14F9;
	Thu, 27 Nov 2025 09:55:22 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCH+leJrydpATOYCA--.59813S2;
	Thu, 27 Nov 2025 09:55:22 +0800 (CST)
Message-ID: <45f5e2c6-42ec-4d77-9c2d-0e00472a05de@huaweicloud.com>
Date: Thu, 27 Nov 2025 09:55:21 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
To: Waiman Long <llong@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Sun Shaojie <sunshaojie@kylinos.cn>, cgroups@vger.kernel.org,
 hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, tj@kernel.org
References: <f32d2f31-630f-450b-911f-b512bbeb380a@huaweicloud.com>
 <20251119105749.1385946-1-sunshaojie@kylinos.cn>
 <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
 <ur4ukfqtqq5jfmuia4tbvsdz3jn3zk6nx2ok4xtnlxth6ulrql@nmetgsxm3lik>
 <d5d635df-94f3-4909-afe3-f2e6141afa32@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <d5d635df-94f3-4909-afe3-f2e6141afa32@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH+leJrydpATOYCA--.59813S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW5Ar1fKFyxtr1fJrW5Wrg_yoW5Ww47pF
	W8Kr43t3Z5WF1rCws7XFs7Wr1Fqa97ZF1UJFZ5Gr18GwnxX3Wvyw1qkwsIvFWUXrykGFyj
	vrWj9w4fZFnrAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/27 3:43, Waiman Long wrote:
> On 11/26/25 9:13 AM, Michal Koutný wrote:
>> On Mon, Nov 24, 2025 at 05:30:47PM -0500, Waiman Long <llong@redhat.com> wrote:
>>> In the example above, the final configuration is A1:0-1 & B1:1-2. As the cpu
>>> lists overlap, we can't have both of them as valid partition roots. So
>>> either one of A1 or B1 is valid or they are both invalid. The current code
>>> makes them both invalid no matter the operation ordering.  This patch will

I have to admit that I prefer the current implementation.

At the very least, it ensures that all partitions are treated fairly[1]. Relaxing this rule would
make it more difficult for users to understand why the cpuset.cpus they configured do not match the
effective CPUs in use, and why different operation orders yield different results.

In another scenario, if we do not invalidate the siblings, new leaf cpusets (marked as member)
created under A1 will end up with empty effective CPUs—and this is not a desired behavior.

   root cgroup
        |
       A1
      /  \
    A2    A3...

 #1> echo "0-1" > A1/cpuset.cpus
 #2> echo "root" > A1/cpuset.cpus.partition
 #3> echo "0-1" > A2/cpuset.cpus
 #4> echo "root" > A2/cpuset.cpus.partition
 mkdir A4
 mkdir A5
 echo "0" > A4/cpuset.cpus
 echo $$ > A4/cgroup.procs
 echo "1" > A5/cpuset.cpus
 echo $$ > A5/cgroup.procs


[1]: "B1 is a second-class partition only because it starts later or why is it OK to not fulfill its
requirement?" --Michal.

>>> make one of them valid given the operation ordering above. To minimize
>>> partition invalidation, we will have to live with the fact that it will be
>>> first-come first-serve as noted by Michal. I am not against this, we just
>>> have to document it. However, the following operation order will still make
>>> both of them invalid:
>> I'm skeptical of the FCFS behavior since I'm afraid it may be subject to
>> race conditions in practice.
>> BTW should cpuset.cpus and cpuset.cpus.exclusive have different behavior
>> in this regard?
> 
> Modification to cpumasks are all serialized by the cpuset_mutex. If you are referring to 2 or more
> tasks doing parallel updates to various cpuset control files of sibling cpusets, the results can
> actually vary depending on the actual serialization results of those operations.
> 
> One difference between cpuset.cpus and cpuset.cpus.exclusive is the fact that operations on
> cpuset.cpus.exclusive can fail if the result is not exclusive WRT sibling cpusets, but becoming a
> valid partition is guaranteed unless none of the exclusive CPUs are passed down from the parent. The
> use of cpuset.cpus.exclusive is required for creating remote partition.
> 
> OTOH, changes to cpuset.cpus will never fail, but becoming a valid partition root is not guaranteed
> and is limited to the creation of local partition only.
> 
> Does that answer your question?
> 
> Cheers,
> Longman
> 

-- 
Best regards,
Ridong


