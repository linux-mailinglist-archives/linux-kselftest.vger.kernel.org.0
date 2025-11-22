Return-Path: <linux-kselftest+bounces-46295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1ACC7C156
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 02:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D28234E937
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 01:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD8E2749C1;
	Sat, 22 Nov 2025 01:19:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB229ACC6;
	Sat, 22 Nov 2025 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763774391; cv=none; b=UAj5Aany7C5rA3/yvP5j2irZbUHMr/unq4g+gjOZByFMIWaTDpHlXY5YHmJOU6j+7UJv9h+JlOOuPY4q+LiP/ACV+JN3qN7b2hgZYSEjoG5BGrMl+Z3d3IsaUn7e/rhfhd9xHJ5UeRw3AHu8Jhy3tZkWNtyYoqxH0OJGhtkZbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763774391; c=relaxed/simple;
	bh=y3BmQ6bnnYa+QWl98z6nxIBTOOjPPKArTyICqHBn/xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlxG9L1hugTaYmL2OOaPzvWDIWQi8uXDnELN1SWhRyk/e1fb5FU7rnop6Aj5yLZW6KBD9OjzO+as0ZOBVgsXGj6MK4IFlcxIufRVmDDuFNI4kTVJi7vPIKwhkkv7DXvk4WEAGSNelaKhnxTCMkb7kW0EsQCLCrtkkJypbbSTAEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dCvPT1wcKzKHLyj;
	Sat, 22 Nov 2025 09:19:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3ACE61A07BD;
	Sat, 22 Nov 2025 09:19:41 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgBH8XerDyFpV1pRBg--.38043S2;
	Sat, 22 Nov 2025 09:19:41 +0800 (CST)
Message-ID: <a2c5266a-60af-4a1a-8a99-a0b0c596aee6@huaweicloud.com>
Date: Sat, 22 Nov 2025 09:19:39 +0800
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
References: <37f4b54d-609c-4754-bfa2-51b1ddf43df0@huaweicloud.com>
 <20251121103308.1661628-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251121103308.1661628-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBH8XerDyFpV1pRBg--.38043S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyfXr4xJFy8tr13uFWruFg_yoWrCFW8pF
	y8KF1UJ39Yqr1rCwsrtF17ZF43t3ZrZ3ZrZFZ8Gr18JrsFq3Wqk3WqkrZxW398Xr98Ga4U
	Z3y7ur4fZr1DWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/21 18:33, Sun Shaojie wrote:
> Hi, Ridong,
> 
> Thu, 20 Nov 2025 21:25:12, Chen Ridong wrote:
>> On 2025/11/20 21:07, Sun Shaojie wrote:
>>> I don't understand the "order of operations" mentioned here. After reviewing
>>> the previous email content, are you referring to this?
>>>
>>> On Sat, 15 Nov 2025 15:41:03, Chen Ridong wrote:
>>>> With the result you expect, would we observe the following behaviors:
>>>>
>>>> #1> mkdir -p A1
>>>> #2> mkdir -p B1
>>>> #3> echo "0-1"  > A1/cpuset.cpus
>>>> #4> echo "1-2"  > B1/cpuset.cpus
>>>> #5> echo "root" > A1/cpuset.cpus.partition
>>>> #6> echo "root" > B1/cpuset.cpus.partition # A1:root;B1:root invalid
>>>>
>>>> #1> mkdir -p A1
>>>> #2> mkdir -p B1
>>>> #3> echo "0-1"  > A1/cpuset.cpus
>>>> #4> echo "1-2"  > B1/cpuset.cpus
>>>> #5> echo "root" > B1/cpuset.cpus.partition
>>>> #6> echo "root" > A1/cpuset.cpus.partition # A1:root invalid;B1:root
>>>>
>>>> Do different operation orders yield different results? If so, this is not what we expect.
>>>
>>> However, after applying this patch, the outcomes of these two examples are 
>>> as follows:
>>>  
>>>  #1> mkdir -p A1
>>>  #2> mkdir -p B1
>>>  #3> echo "0-1"  > A1/cpuset.cpus           | member       | member      |
>>>  #4> echo "1-2"  > B1/cpuset.cpus           | member       | member      |
>>>  #5> echo "root" > A1/cpuset.cpus.partition | root invalid | root        |
>>>  #6> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid|
>>>
>>>  #1> mkdir -p A1
>>>  #2> mkdir -p B1
>>>  #3> echo "0-1"  > A1/cpuset.cpus           | member       | member      |
>>>  #4> echo "1-2"  > B1/cpuset.cpus           | member       | member      |
>>>  #5> echo "root" > B1/cpuset.cpus.partition | root         | root invalid|
>>>  #6> echo "root" > A1/cpuset.cpus.partition | root invalid | root invalid|
>>>
>>
>> How about the following two sequences of operations:
>>
>> #1> mkdir -p A1
>> #2> mkdir -p B1
>> #3> echo "0-1"  > A1/cpuset.cpus
>> #4> echo "root" > A1/cpuset.cpus.partition
>> #5> echo "1-2"  > B1/cpuset.cpus
>> #6> echo "root" > B1/cpuset.cpus.partition
>>
>>
>> #1> mkdir -p A1
>> #2> mkdir -p B1
>> #5> echo "1-2"  > B1/cpuset.cpus
>> #6> echo "root" > B1/cpuset.cpus.partition
>> #3> echo "0-1"  > A1/cpuset.cpus
>> #4> echo "root" > A1/cpuset.cpus.partition
>>
>> Will these two sequences yield the same result?
> 
>> As a key requirement: Regardless of the order in which we apply the configurations, identical final
>> settings should always result in identical system states. We need to confirm if this holds true here.
> 
> Is this truly a key requirement? It appears this requirement wasn't met even
> before applying my patch.
> 

I believe it requires, it may some corner cases we should fix.

> The example below, which does not use this patch, demonstrates how different
> sequences with identical configurations can still lead to different system
> states.
> 
>  #1> mkdir -p A1
>  #2> mkdir -p B1                            | A1's prstate | B1's prstate |
>  #3> echo "0-1"  > A1/cpuset.cpus           | member       | member       |
>  #4> echo "0-1"  > A1/cpuset.cpus.exclusive | member       | member       |
>  #5> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>  #6> echo "1-2"  > B1/cpuset.cpus           | root invalid | member       |
>  #7> echo "2-3"  > B1/cpuset.cpus.exclusive | root invalid | member       |
>  #8> echo "root" > B1/cpuset.cpus.partition | root invalid | root         |
> 

IIUC, you've created this example with the expectation that both A1 and B1 should serve as root
partitions. However, we currently lack a mechanism where modifying a cpuset's state (e.g., cpus,
cpus.exclusive, or cpus.partition) can transition its sibling from an invalid to a valid partition.

The behavior observed before step #6 is acceptable. Proactively setting B1 as a partition in step #8
is permitted, given that B1 does not conflict with A1. However, we do not have a mechanism to
passively and automatically transition A1 to a valid partition state.

>  #1> mkdir -p A1
>  #2> mkdir -p B1                            | A1's prstate | B1's prstate |
>  #3> echo "0-1"  > A1/cpuset.cpus           | member       | member       |
>  #4> echo "0-1"  > A1/cpuset.cpus.exclusive | member       | member       |
>  #5> echo "2-3"  > B1/cpuset.cpus.exclusive | member       | member       |
>  #6> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>  #7> echo "1-2"  > B1/cpuset.cpus           | root         | member       |
>  #8> echo "root" > B1/cpuset.cpus.partition | root         | root         |
> 
> Even without this patch, the result can still differ.
> 
> 
> Thanks,
> Sun Shaojie

-- 
Best regards,
Ridong


