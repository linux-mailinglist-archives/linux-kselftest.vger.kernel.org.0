Return-Path: <linux-kselftest+bounces-46381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EACC8038B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 12:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45944344702
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 11:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12FD2F1FF4;
	Mon, 24 Nov 2025 11:34:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567935959;
	Mon, 24 Nov 2025 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763984046; cv=none; b=iKUqbPsKReyCX/Fp/6cCo/AnbIEtRgFrYMKjxRDV78Qz9NV4A/138gCsxbZEWWVHDGCs1jau9v9LPfKuAWaBRAo9R5kQTX/9/zWKJHwuvNd6Xd6uZ3M4x5D83wwpQqURp1R/3ikDOuKsPCADlT74aOpPsA8JQ/aZ/43Z1taOTtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763984046; c=relaxed/simple;
	bh=e8x4+7Pv2Jhk1EcyNugPzKY+gxDNCJ9trL4AVFQUv7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJS6v7aYD6bOZO39OCnewq0+mlin1Prcbr75A/ETTAlRAdvSSR1Y8XGYpfIl2SWw1A83pBcbAKKrTZr4bQ8hLTrv+Y4Dkeqt5itaspoP3O00nOYs5RwZaujFazYxcECvycZZDH0n+xYxqL1odpFSsplrYm6j8G1tE4qoEssWcAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dFNwz1j0GzYQv40;
	Mon, 24 Nov 2025 19:33:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AA87A1A058E;
	Mon, 24 Nov 2025 19:33:55 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgAHZHqiQiRp0AdsBw--.35066S2;
	Mon, 24 Nov 2025 19:33:55 +0800 (CST)
Message-ID: <921ab4b4-0713-4c33-9c11-eac234ab9d39@huaweicloud.com>
Date: Mon, 24 Nov 2025 19:33:54 +0800
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
References: <0c409964-c4aa-4d41-aae5-cd0626015eeb@huaweicloud.com>
 <20251124102024.1768386-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251124102024.1768386-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHZHqiQiRp0AdsBw--.35066S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4UZF4kZrWrGr47JFyrWFg_yoW5tr4fpF
	WxK3WDJwsYqr1rCwsFq3Z7Zr15tanrAF17XFn8Gr17Jwn2qF1vk3W0krZIgrs8Xr9xGr1U
	ZrW3urW3ZF1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/24 18:20, Sun Shaojie wrote:
> Hi, Ridong,
> 
> On Sat, 22 Nov 2025 09:33:34, Chen Ridong wrote:
>> On 2025/11/21 18:32, Sun Shaojie wrote:
>>> Hi, Ridong,
>>>
>>> On Thu, 20 Nov 2025 21:45:16, Chen Ridong wrote:
>>>> On 2025/11/20 21:07, Sun Shaojie wrote:
>>>>> I have carefully considered the scenario where parent effective CPUs are 
>>>>> empty, which corresponds to the following two cases. (After apply this patch).
>>>>>
>>>>>    root cgroup
>>>>>         |
>>>>>        A1
>>>>>       /  \
>>>>>     A2    A3
>>>>>
>>>>> Case 1:
>>>>>  Step:
>>>>>  #1> echo "0-1" > A1/cpuset.cpus
>>>>>  #2> echo "root" > A1/cpuset.cpus.partition
>>>>>  #3> echo "0-1" > A2/cpuset.cpus
>>>>>  #4> echo "root" > A2/cpuset.cpus.partition
>>>>>
>>>>>  After step #4, 
>>>>>
>>>>>                 |      A1      |      A2      |      A3      |
>>>>>  cpus_allowed   | 0-1          | 0-1          |              |
>>>>>  effective_cpus |              | 0-1          |              |
>>>>>  prstate        | root         | root         | member       |
>>>>>
>>>>>  After step #4, A3's effective CPUs is empty.
>>>>>
>>>>
>>>> That may be a corner case is unexpected.
>>>>
>>>>>  #5> echo "0-1" > A3/cpuset.cpus
>>>>>
>>>>
>>>> If we create subdirectories (e.g., A4, A5, ...) under the A1 cpuset and then configure cpuset.cpus
>>>> for A1 (a common usage scenario), processes can no longer be migrated into these subdirectories (A4,
>>>> A5, ...) afterward. However, prior to your patch, this migration was allowed.
>>>
>>> Are you referring to creating subdirectories (A4, A5, ...) after step #4? 
>>> And what parameters should be configured for A1's cpuset.cpus?
>>> Could you provide a specific example?
>>>
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
>> You might be going to argue that we haven't set the cpus for A4/A5..., yeah, maybe a corner case.
>>
>> However, it’s common practice to configure a cpuset’s cpus first and then migrate processes—this is
>> a typical usage scenario.
>>
> 
> I'm sorry, I didn't quite understand the point you were trying to make with this example.
> 
> If that's the case
> 
>      root cgroup
>           |
>           A1
>        / /  \ \
>      A2 A3  A4 A5
> 
>  #1> echo "0-1" > A1/cpuset.cpus
>  #2> echo "root" > A1/cpuset.cpus.partition
>  #3> echo "0-1" > A2/cpuset.cpus
>  #4> echo "root" > A2/cpuset.cpus.partition
>  mkdir A4
>  mkdir A5
>  echo "0" > A4/cpuset.cpus

If we don't apply your patch, A2 will be invalidated.

>  echo $$ > A4/cgroup.procs  ->This will return an error because A4's effective CPUs are empty.
>  echo "1" > A5/cpuset.cpus
>  echo $$ > A5/cgroup.procs  ->This will return an error because A5's effective CPUs are empty.
> 
> Even with this patch applied, this result will not change.
> 

You can have a try, the result I got:

# mkdir A1
# echo "0-1" > A1/cpuset.cpus
# echo "root" > A1/cpuset.cpus.partition
# cd A1/
# mkdir A2
# mkdir A4
# mkdir A5
# echo "0-1" > A2/cpuset.cpus
# echo "root" > A2/cpuset.cpus.partition
#
# echo "0" > A4/cpuset.cpus
# cat A2/cpuset.cpus
0-1
# cat A2/cpuset.cpus.partition
root invalid
# cat A4/cpuset.cpus.effective
0

>>
>>> Additionally, processes cannot be migrated into a cgroup whose 
>>> cpuset.cpus.effective is empty. However, this patch does not modify this behavior.
>>>
>>> So why does applying this patch enable such migration?
> 
> Thanks,
> Sun Shaojie

-- 
Best regards,
Ridong


