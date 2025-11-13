Return-Path: <linux-kselftest+bounces-45513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D513BC55EC8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 07:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB37F4E45F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 06:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C138320A01;
	Thu, 13 Nov 2025 06:26:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9CDDD2;
	Thu, 13 Nov 2025 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763015194; cv=none; b=A92XJDzhKHuqnZiI4rRrIfmODlBuZI+YV7gsAOS6UXGnTozkITHQJh0Fd1GXhjk5waZC5E8hyRg9iQwe9UlfiISLyrPcRz/zbwYKzYEJC8aWUYvDo1RE2RmTjy076Yf9qZYJ8mYE4BiGDDzo2g/VNQXI3zTAXamDui1P1djdi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763015194; c=relaxed/simple;
	bh=vDVGkh4WF79UE66l4neDxZvGMG2WNiegP5HSrpxDaRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaQ3zy0yubK0K+a7acyvrtvEgjxV2BrKjNnD6MQJiaB/DFvfDfBwd46uZZWGPbBE9nMv9X7yeflhH6PMIahMrvDIoGFDcZqJ4G86/lth1OzHq+qksxu3mmhlkp4GEW78aC+mdFrSFf+RNMmdrNHELWjl9Kp3mBmbl2byRoCnb9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d6VdZ0yTpzYQtyC;
	Thu, 13 Nov 2025 14:25:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BFB531A0C36;
	Thu, 13 Nov 2025 14:26:23 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgCnBHsOehVpykRMAg--.57065S2;
	Thu, 13 Nov 2025 14:26:23 +0800 (CST)
Message-ID: <575be198-b52f-4a4a-a551-ce5058584786@huaweicloud.com>
Date: Thu, 13 Nov 2025 14:26:22 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
To: Sun Shaojie <sunshaojie@kylinos.cn>, longman@redhat.com
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <b9dce00a-4728-4ac8-ae38-7f41114c7c81@redhat.com>
 <20251113033322.431859-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251113033322.431859-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnBHsOehVpykRMAg--.57065S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWUtryfZr4fCrW7Kr47CFg_yoW8WFWrpF
	y8KF1UXayvgr1rCwsrt3Wxuw4ay3ZrZF17AF98Gw48Ar9rt3Wvk3Wqyr9xG398X3s5Ga4j
	v3y7Zw4SvFWDW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/13 11:33, Sun Shaojie wrote:
> On 2025/11/13 09:21, Chen Ridong wrote:
>>
>> Hi, Longman.
>>
>> It did not fail to set cupset.cpus, but invalidated the sibling cpuset partition.
>>
>> If we relax this rule, we should consider:
>>
>>  What I want to note is this: what if we run echo root > /sys/fs/cgroup/B1/cpuset.cpus.partition
>> after step #5? There’s no conflict check when enabling the partition.
>>
>> -- 
>> Best regards,
>> Ridong
> 
> Hi, Ridong.
> 
> I understand your concern, and there is a conflict check when enabling 
> partitions. Below, I will use two tables to show the partition states of A1
> and B1 before applying this patch and after applying it.(All the steps in 
> the table are by default under the path /sys/fs/cgroup)
> 
> Table 1: Before applying the patch
>                                             | A1's prstate | B1's prstate |
>  #1> mkdir -p A1                            | member       |              |
>  #2> echo "0-1" > A1/cpuset.cpus            | member       |              |
>  #3> echo "root" > A1/cpuset.cpus.partition | root         |              |
>  #4> mkdir -p B1                            | root         | member       |
>  #5> echo "0-3" > B1/cpuset.cpus            | root invalid | member       |
>  #6> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid |
> 
> Table 2: After applying the patch
>                                             | A1's prstate | B1's prstate |
>  #1> mkdir -p A1                            | member       |              |
>  #2> echo "0-1" > A1/cpuset.cpus            | member       |              |
>  #3> echo "root" > A1/cpuset.cpus.partition | root         |              |
>  #4> mkdir -p B1                            | root         | member       |
>  #5> echo "0-3" > B1/cpuset.cpus            | root         | member       |
>  #6> echo "root" > B1/cpuset.cpus.partition | root         | root invalid |
> 

Thank you for your clarification.

I missed exclusive conflict will be checked with:

update_prstate
update_partition_exclusive_flag
cpuset_update_flag
validate_change

-- 
Best regards,
Ridong


