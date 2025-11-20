Return-Path: <linux-kselftest+bounces-46105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9176AC74385
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 9633D2CC7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 13:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FBC2882BE;
	Thu, 20 Nov 2025 13:25:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29CA21257E;
	Thu, 20 Nov 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645120; cv=none; b=TqsMDBJunpc9O4qSKzKNdiQ1dcU8WH8wIMCm0qAOzr1/6wgwS3gc/dPOu0nxyw8KtZg8KP2xmKDAkLUoOMN5b1Tijr6w7EKKWl10GxPymyWxiDL+7vb0OTbT3l2YSZWY0w5FEzhqPmqgd/vOc2rfiyDG3iYemMr9xwNi7LNwilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645120; c=relaxed/simple;
	bh=HWnTHI4ccYB9wpDY7/tCNmtUG5PSQOjy/t2vEeXGkvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOTiWjIIgthNr8JHbWfVlvel7+QMmP10DBNL9e7SZZ6kzCsYY9SB7izQxOXkID5+m3GCYCMLJ+/OfjwKCTnhx+fSz8sNZ7o0FrNY08CXEm/KRHFUWvfviuRzFCEbbbqRAa26zTyNiFZQhmowQc8X9gNWRGjUW6FtoduFExd3GtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dBzbN1P4JzYQv37;
	Thu, 20 Nov 2025 21:24:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1744B1A08FF;
	Thu, 20 Nov 2025 21:25:14 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgD3e0W4Fh9pKq+TBQ--.7121S2;
	Thu, 20 Nov 2025 21:25:13 +0800 (CST)
Message-ID: <37f4b54d-609c-4754-bfa2-51b1ddf43df0@huaweicloud.com>
Date: Thu, 20 Nov 2025 21:25:12 +0800
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
References: <06d74676-258e-43b7-ae61-d2102bab3926@huaweicloud.com>
 <20251120130750.1554604-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251120130750.1554604-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3e0W4Fh9pKq+TBQ--.7121S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4xCFW7Aw47XFyDtr4fKrg_yoWrCrW5pF
	W8KF1DJws5Xr1rCwsFqF17ZF42q3ZrZ3W7AFZ8Gr47JwnFv3Wqka1qkr9xW398J3s8GayU
	Z3y7Zr4Svr1DWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/20 21:07, Sun Shaojie wrote:
> Hi, Ridong,
> 
> On Thu, 20 Nov 2025 08:57:51, Chen Ridong wrote:
>> On 2025/11/19 21:20, Michal Koutný wrote:
>>> On Wed, Nov 19, 2025 at 06:57:49PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
>>>>  Table 2.1: Before applying this patch
>>>>  Step                                       | A1's prstate | B1's prstate |
>>>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>>>  #3> echo "2" > B1/cpuset.cpus              | root         | member       |
>>>>  #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>>>>  #5> echo "1-2" > B1/cpuset.cpus            | root invalid | root invalid |
>>>>
>>>> After step #4, B1 can exclusively use CPU 2. Therefore, at step #5,
>>>> regardless of what conflicting value B1 writes to cpuset.cpus, it will
>>>> always have at least CPU 2 available. This makes it unnecessary to mark
>>>> A1 as "root invalid".
>>>>
>>>>  Table 2.2: After applying this patch
>>>>  Step                                       | A1's prstate | B1's prstate |
>>>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>>>  #3> echo "2" > B1/cpuset.cpus              | root         | member       |
>>>>  #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>>>>  #5> echo "1-2" > B1/cpuset.cpus            | root         | root invalid |
>>>>
>>>> In summary, regardless of how B1 configures its cpuset.cpus, there will
>>>> always be available CPUs in B1's cpuset.cpus.effective. Therefore, there
>>>> is no need to change A1 from "root" to "root invalid".
>>>
>>> Admittedly, I don't like this change because it relies on implicit
>>> preference ordering between siblings (here first comes, first served)
>>
>> Agree. If we only invalidate the latter one, I think regardless of the implementation approach, we
>> may end up with different results depending on the order of operations.
> 
> 
> I don't understand the "order of operations" mentioned here. After reviewing
> the previous email content, are you referring to this?
> 
> On Sat, 15 Nov 2025 15:41:03, Chen Ridong wrote:
>> With the result you expect, would we observe the following behaviors:
>>
>> #1> mkdir -p A1
>> #2> mkdir -p B1
>> #3> echo "0-1"  > A1/cpuset.cpus
>> #4> echo "1-2"  > B1/cpuset.cpus
>> #5> echo "root" > A1/cpuset.cpus.partition
>> #6> echo "root" > B1/cpuset.cpus.partition # A1:root;B1:root invalid
>>
>> #1> mkdir -p A1
>> #2> mkdir -p B1
>> #3> echo "0-1"  > A1/cpuset.cpus
>> #4> echo "1-2"  > B1/cpuset.cpus
>> #5> echo "root" > B1/cpuset.cpus.partition
>> #6> echo "root" > A1/cpuset.cpus.partition # A1:root invalid;B1:root
>>
>> Do different operation orders yield different results? If so, this is not what we expect.
> 
> However, after applying this patch, the outcomes of these two examples are 
> as follows:
>  
>  #1> mkdir -p A1
>  #2> mkdir -p B1
>  #3> echo "0-1"  > A1/cpuset.cpus           | member       | member      |
>  #4> echo "1-2"  > B1/cpuset.cpus           | member       | member      |
>  #5> echo "root" > A1/cpuset.cpus.partition | root invalid | root        |
>  #6> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid|
> 
>  #1> mkdir -p A1
>  #2> mkdir -p B1
>  #3> echo "0-1"  > A1/cpuset.cpus           | member       | member      |
>  #4> echo "1-2"  > B1/cpuset.cpus           | member       | member      |
>  #5> echo "root" > B1/cpuset.cpus.partition | root         | root invalid|
>  #6> echo "root" > A1/cpuset.cpus.partition | root invalid | root invalid|
> 

How about the following two sequences of operations:

#1> mkdir -p A1
#2> mkdir -p B1
#3> echo "0-1"  > A1/cpuset.cpus
#4> echo "root" > A1/cpuset.cpus.partition
#5> echo "1-2"  > B1/cpuset.cpus
#6> echo "root" > B1/cpuset.cpus.partition


#1> mkdir -p A1
#2> mkdir -p B1
#5> echo "1-2"  > B1/cpuset.cpus
#6> echo "root" > B1/cpuset.cpus.partition
#3> echo "0-1"  > A1/cpuset.cpus
#4> echo "root" > A1/cpuset.cpus.partition

Will these two sequences yield the same result?

As a key requirement: Regardless of the order in which we apply the configurations, identical final
settings should always result in identical system states. We need to confirm if this holds true here.

> Moreover, even without applying this patch, the result remains the same,
> because modifying cpuset.cpus.partition does not disable its siblings' partitions.
> 
> So, what are the specific issues that you believe would arise?
> 
> 
> Thanks,
> Sun Shaojie

-- 
Best regards,
Ridong


