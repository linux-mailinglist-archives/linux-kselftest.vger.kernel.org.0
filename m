Return-Path: <linux-kselftest+bounces-45713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40820C623CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 04:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26E544E1BD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 03:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A61A2E92D4;
	Mon, 17 Nov 2025 03:23:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9E1F17E8;
	Mon, 17 Nov 2025 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763349824; cv=none; b=JUiBfrAo3w5zOo29ZJ2ZEB8P2N8DdDm5Sv+Dawua6ZETCSfzyB1Pp07tbGfJOmF2mTHNHpf0m80zvo+t4Q6O+Eh4pJQlqcrWxSHGzRSpOXLdb8BKn7NSj9g5V/bJxuEhB2bT2P22P3wwd4iBO1PT/F0PCOd2KLa9sA/BNsszh64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763349824; c=relaxed/simple;
	bh=nKuoB07EcDlVtm9AxhElVEsilfrWUwPj5O2a+UEZjkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEZAfmpVIuopBKPbqU+j6K+koIiKuXByhPgYCFGSG0hIaOHKrhqNOzBQqwCAagZtHZJiO4GwCaD5j1+YzKjvxMTRkncIc4f+N00Cj5Rr/iuI1C3QA9dV0sIuGS8s4Dv9rVOnyzEecPyG7HbiLqJrDtOAX55IoQBxEAGLZNc7WVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d8tNk5YVrzYQtlM;
	Mon, 17 Nov 2025 11:23:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E3F2C1A0FC6;
	Mon, 17 Nov 2025 11:23:38 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAXP1w4lRppjBITBA--.24837S2;
	Mon, 17 Nov 2025 11:23:37 +0800 (CST)
Message-ID: <4366cedd-b9c7-48de-bb48-f3c4ff81e73e@huaweicloud.com>
Date: Mon, 17 Nov 2025 11:23:36 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] cpuset: relax the overlap check for cgroup-v2
To: Sun Shaojie <sunshaojie@kylinos.cn>, llong@redhat.com
Cc: mkoutny@suse.com, cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, tj@kernel.org
References: <20251117015708.977585-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251117015708.977585-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXP1w4lRppjBITBA--.24837S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4xWF4DZr1kKr4kZFyfXrb_yoW5XF4fpF
	y8Kr1rXw4rXr1rG3ZIgw17ZF43tw48ZFnrAFZ8Kr1rAa9FqF1UAF1DAr9IgFZ8JrZxW3Wj
	v3y3u3yfZrWqqF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/17 9:57, Sun Shaojie wrote:
> In cgroup v2, a mutual overlap check is required when at least one of two
> cpusets is exclusive. However, this check should be relaxed and limited to
> cases where both cpusets are exclusive.
> 
> This patch ensures that for sibling cpusets A1 (exclusive) and B1
> (non-exclusive), change B1 cannot affect A1's exclusivity.
> 
> for example. Assume a machine has 4 CPUs (0-3).
> 
>    root cgroup
>       /    \
>     A1      B1
> 
> Case 1:
>  Table 1.1: Before applying the patch
>  Step                                       | A1's prstate | B1'sprstate |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      |
>  #3> echo "0" > B1/cpuset.cpus              | root invalid | member      |
> 
> After step #3, A1 changes from "root" to "root invalid" because its CPUs
> (0-1) overlap with those requested by B1 (0-3). However, B1 can actually
> use CPUs 2-3(from B1's parent), so it would be more reasonable for A1 to
> remain as "root."
> 
>  Table 1.2: After applying the patch
>  Step                                       | A1's prstate | B1'sprstate |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      |
>  #3> echo "0" > B1/cpuset.cpus              | root         | member      |
> 
> Case 2: (This situation remains unchanged from before)
>  Table 2.1: Before applying the patch
>  Step                                       | A1's prstate | B1'sprstate |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
>  #3> echo "1-2" > B1/cpuset.cpus            | member       | member      |
>  #2> echo "root" > A1/cpuset.cpus.partition | root invalid | member      |
> 
>  Table 2.2: After applying the patch
>  Step                                       | A1's prstate | B1'sprstate |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      |
>  #3> echo "1-2" > B1/cpuset.cpus            | member       | member      |
>  #2> echo "root" > A1/cpuset.cpus.partition | root invalid | member      |
> 
> All other cases remain unaffected. For example, cgroup-v1, both A1 and
> B1 are exclusive or non-exlusive.
> 
> ---
> v3 -> v4:
>   - Adjust the test_cpuset_prt.sh test file to align with the current
>     behavior.
> 
> v2 -> v3:
>   - Ensure compliance with constraints such as cpuset.cpus.exclusive.
>   - Link: https://lore.kernel.org/cgroups/20251113131434.606961-1-sunshaojie@kylinos.cn/
> 
> v1 -> v2:
>   - Keeps the current cgroup v1 behavior unchanged
>   - Link: https://lore.kernel.org/cgroups/c8e234f4-2c27-4753-8f39-8ae83197efd3@redhat.com
> 
> ---
>  kernel/cgroup/cpuset-internal.h               |  3 ++
>  kernel/cgroup/cpuset-v1.c                     | 20 +++++++++
>  kernel/cgroup/cpuset.c                        | 43 ++++++++++++++-----
>  .../selftests/cgroup/test_cpuset_prs.sh       |  5 ++-
>  4 files changed, 58 insertions(+), 13 deletions(-)
> 
Is this a cover letter?

The cover letter is labeled as v3, while the patch itself is v4.

For a single patch, I don’t think a cover letter is necessary.

-- 
Best regards,
Ridong


