Return-Path: <linux-kselftest+bounces-45681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FFCC5FD96
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 03:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3043BE9FD
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 02:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7951B78F3;
	Sat, 15 Nov 2025 02:01:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB88F49;
	Sat, 15 Nov 2025 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172089; cv=none; b=sM+J4vybRM+CQxEfb0lFYfzDxM1m2PywV8deM+WBHZs2otn2VvvJBwaYp6pCv1TH34ZxgKAagOnWPUgYg3GkIMpZPuafkMIgFAmeHynPNwoLifQBbI3V9npdMP9s0ExTYDsoEDgubMTc0BV5B8mB43C2POVx1bFYHitUWnAZjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172089; c=relaxed/simple;
	bh=xulWlloRTt2fMT+e7eu0oaTbEedI/Z4Ig8oGACvttNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6N2inJfalLI1BPlp9CZdrmDlddqejVj77CJoA1N6ibPRh0ZiATcX2Iss7EnvbDSWQy2Yd25PXkCjBxq+GgI0m4Ky0PHgqAc/x32d3GcL0gFtXD1q1uBYjO9quZi+kMLP4+vRxl3vWJyokQrofSCbJZrMp/hRunGugqikPOPlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d7cg14tvnzKHLxW;
	Sat, 15 Nov 2025 10:01:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1DAB41A018D;
	Sat, 15 Nov 2025 10:01:23 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBXgF3x3hdpWbMhAw--.61029S2;
	Sat, 15 Nov 2025 10:01:22 +0800 (CST)
Message-ID: <765120d5-1887-4376-b779-8294df137b9d@huaweicloud.com>
Date: Sat, 15 Nov 2025 10:01:21 +0800
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
References: <19fa5a93-4cc9-4f84-891c-b3b096a68799@huaweicloud.com>
 <20251114062448.685754-1-sunshaojie@kylinos.cn>
 <4b7znoqq6sdtutcn3jafyrucpqe5jylryvoeooz5ah54vbei4f@wxhsd7gkj3tp>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <4b7znoqq6sdtutcn3jafyrucpqe5jylryvoeooz5ah54vbei4f@wxhsd7gkj3tp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXgF3x3hdpWbMhAw--.61029S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXryxGrWxGFyDXFyxAFy7Wrg_yoW5AFyxpF
	y8KF15J3WY9r1UCw42q3WxCr4Yq3ZrZF12yrsxGrWxJws2q3Wqy3Wqya9xX398JwsxGryj
	vrW7uw4FqFnrC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/11/15 0:15, Michal Koutný wrote:
> On Fri, Nov 14, 2025 at 02:24:48PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
>> The desired outcome is that after step #5, although B1 writes "0-3" to 
>> cpuset.cpus, A1 can still remain as "root", and B1 ends up with effective 
>> CPUs of 2-3. In summary, We want to avoid A1's invalidation when B1 
>> changes its cpuset.cpus. Because cgroup v2 allows the effective CPU mask 
>> of a cpuset to differ from its requested mask.
> 
> So the new list of reasons why configured cpuset's cpus change are:
> - hotplug,
> - ancestor's config change,
> - stealing by a sibling (new).
> 
> IIUC, the patch proposes this behavior:
> 
>   echo root >A1.cpuset.partition
>   echo 0-1 >A1.cpuset.cpus
>   
>   echo root >B1.cpuset.partition
>   echo 1-2 >B1.cpuset.cpus	# invalidates A1
>   
>   echo 0-1 >A1.cpuset.cpus	# invalidates B1
>   
>   ping-pong over CPU 1 ad libitum
> 
> I think the right (tm) behavior would be not to depend on the order in
> which config is applied to siblings, i.e.
> 
>   echo root >A1.cpuset.partition
>   echo 0-1 >A1.cpuset.cpus
>   
>   echo root >B1.cpuset.partition
>   echo 1-2 >B1.cpuset.cpus	# invalidates both A1 and B1
> 
>   echo 0-1 >A1.cpuset.cpus	# no change anymore
> 
> (I hope my example sheds some light on my understanding of the situation
> and desired behavior.)

Before applying the patch, the behavior I got:

	# cd /sys/fs/cgroup/
	# mkdir A1
	# mkdir B1
	# echo root > A1/cpuset.cpus.partition
	# echo 0-1 > A1/cpuset.cpus
	# cat A1/cpuset.cpus.partition
	root
	# echo root > B1/cpuset.cpus.partition
	# echo 1-2 > B1/cpuset.cpus  # A1 is exclusive, invalidate both A1 and B1
	# cat A1/cpuset.cpus.partition
	root invalid
	# cat B1/cpuset.cpus.partition
	root invalid (cpuset.cpus and cpuset.cpus.exclusive are empty)
	# echo root > B1/cpuset.cpus.partition
	# cat B1/cpuset.cpus.partition
	root invalid (Cpu list in cpuset.cpus not exclusive)
	# echo root > A1/cpuset.cpus.partition
	# cat A1/cpuset.cpus.partition
	root invalid (Cpu list in cpuset.cpus not exclusive)
	#

After applying the patch, the behavior I got:

	# cd /sys/fs/cgroup/
	# mkdir A1
	#  mkdir B1
	# echo root > A1/cpuset.cpus.partition
	# echo 0-1 > A1/cpuset.cpus
	# cat A1/cpuset.cpus.partition
	root
	# echo root > B1/cpuset.cpus.partition
	# echo 1-2 > B1/cpuset.cpus # A1 is exclusive, B1 is going to be exclusive
	# cat A1/cpuset.cpus.partition
	root
	# cat B1/cpuset.cpus.partition # A1 and B1 should be invalid.
	root
	# echo member > B1/cpuset.cpus.partition
	# echo root > B1/cpuset.cpus.partition
	# cat A1/cpuset.cpus.partition
	root
	# cat B1/cpuset.cpus.partition
	root invalid (Cpu list in cpuset.cpus not exclusive)
	# echo member > A1/cpuset.cpus.partition
	# echo root > B1/cpuset.cpus.partition
	# echo root > A1/cpuset.cpus.partition
	# cat A1/cpuset.cpus.partition
	root invalid (Cpu list in cpuset.cpus not exclusive)
	# cat B1/cpuset.cpus.partition
	root

After applying the patch, The result is unexpected.

-- 
Best regards,
Ridong


