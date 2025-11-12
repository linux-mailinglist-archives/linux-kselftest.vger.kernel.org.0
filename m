Return-Path: <linux-kselftest+bounces-45373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8AFC506AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 04:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B41F1890680
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 03:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8015023BD1B;
	Wed, 12 Nov 2025 03:33:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE228B652;
	Wed, 12 Nov 2025 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762918411; cv=none; b=M3/fh6dVWkWoCfMh78UedeaBOrG65UsXwz72bN+U8r1qg4DEsovogxh20VZcwXY35SV10ii/tBg+1y16R9WWkuwAEkR0tTfCO+olI+SIwI5sQtLz5+1z/PqAWlv6m7tt2DYkxyvuwBf6TcQDDXfWBpnzywd3yz02cX7JRQUuf4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762918411; c=relaxed/simple;
	bh=m6oI5hrMk+/WG4ZUT582FYnudlzi+ZnfDEEbwSfeIqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hu6mm2YXOackDAeJAOsYFwhp+of5Rslea8koRj0Ze1k+fQ98oeva8Hp9cu9nIdmmkI5Iyp03if3QDg672y7o+dAupv8cJ+V8Z7Yx6X5ZU/rI8u5HBOCq6X+WtNanWqimhHHGeddVDYfFjJ5r6JCaJI4L2pLK1RtRdEERE2QYw4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5prd3lVxzKHMX9;
	Wed, 12 Nov 2025 11:33:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8140B1A08AC;
	Wed, 12 Nov 2025 11:33:22 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgC3YXgBABRp6VHJAQ--.51983S2;
	Wed, 12 Nov 2025 11:33:22 +0800 (CST)
Message-ID: <380567da-9079-4a4d-afae-42bde42d2a58@huaweicloud.com>
Date: Wed, 12 Nov 2025 11:33:21 +0800
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
References: <20251112021120.248778-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251112021120.248778-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3YXgBABRp6VHJAQ--.51983S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XryUZw4kAw18urWfKw17Jrb_yoWxJry7pF
	ykGr4jvw4YgF15C3srCF18WrsYqwsFqF17Jwn8Jr1xZF9xJFn29rnYk3sxJrWj9rWUGw15
	u39av3yfXanIq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/11/12 10:11, Sun Shaojie wrote:
Hello Shaojie,

> Currently, when a non-exclusive cpuset's "cpuset.cpus" overlaps with a
> partitioned sibling, the sibling's partition state becomes invalid.
> However, this invalidation is often unnecessary.
> 
> This can be observed in specific configuration sequences:
> 
> Case 1: Partition created first, then non-exclusive cpuset overlaps
>  #1> mkdir -p /sys/fs/cgroup/A1
>  #2> echo "0-1" > /sys/fs/cgroup/A1/cpuset.cpus
>  #3> echo "root" > /sys/fs/cgroup/A1/cpuset.cpus.partition
>  #4> mkdir -p /sys/fs/cgroup/B1
>  #5> echo "0-3" > /sys/fs/cgroup/B1/cpuset.cpus
>  // A1's partition becomes "root invalid" - this is unnecessary
> 
> Case 2: Non-exclusive cpuset exists first, then partition created
>  #1> mkdir -p /sys/fs/cgroup/B1
>  #2> echo "0-1" > /sys/fs/cgroup/B1/cpuset.cpus
>  #3> mkdir -p /sys/fs/cgroup/A1
>  #4> echo "0-1" > /sys/fs/cgroup/A1/cpuset.cpus
>  #5> echo "root" > /sys/fs/cgroup/A1/cpuset.cpus.partition
>  // A1's partition becomes "root invalid" - this is unnecessary
> 
> In Case 1, the effective CPU mask of B1 can differ from its requested
> mask. B1 can use CPUs 2-3 which don't overlap with A1's exclusive
> CPUs (0-1), thus not violating A1's exclusivity requirement.
> 
> In Case 2, B1 can inherit the effective CPUs from its parent, so there
> is no need to invalidate A1's partition state.
> 
> This patch relaxes the overlap check to only consider conflicts between
> partitioned siblings, not between a partitioned cpuset and a regular
> non-exclusive one.
> 

Does this rule have any negative impact on your products?

The CPUs specified by the user (including cpuset.cpus and cpuset.cpus.exclusive) can be treated as
the dedicated exclusive CPUs for the partition. For the cases you provided, both siblings can be
partitions. For example, in case 1, A1 can also be converted to a partition. If this rule is
relaxed, I don’t see any check for exclusive conflicts when A1 becomes a partition.

Additionally, I think we should preserve the CPU affinity as the user intends as much as possible.

> Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
> ---
>  kernel/cgroup/cpuset.c                            |  8 ++++----
>  tools/testing/selftests/cgroup/test_cpuset_prs.sh | 10 +++++-----
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 52468d2c178a..e0d27c9a101a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -586,14 +586,14 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>   * Returns: true if CPU exclusivity conflict exists, false otherwise
>   *
>   * Conflict detection rules:
> - * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
> + * 1. If both cpusets are exclusive, they must be mutually exclusive
>   * 2. exclusive_cpus masks cannot intersect between cpusets
>   * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
>   */
>  static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>  {
> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
> +	/* If both cpusets are exclusive, check if they are mutually exclusive */
> +	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
>  		return !cpusets_are_exclusive(cs1, cs2);
>  
>  	/* Exclusive_cpus cannot intersect */
> @@ -695,7 +695,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>  		goto out;
>  
>  	/*
> -	 * If either I or some sibling (!= me) is exclusive, we can't
> +	 * If both I and some sibling (!= me) are exclusive, we can't
>  	 * overlap. exclusive_cpus cannot overlap with each other if set.
>  	 */
>  	ret = -EINVAL;
> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> index a17256d9f88a..903dddfe88d7 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> @@ -269,7 +269,7 @@ TEST_MATRIX=(
>  	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X3:P2    .      .     0 A1:0-2|A2:3|A3:3 A1:P0|A2:P2 3"
>  	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3  X2-3:P2   .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
>  	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:C3 .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
> -	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-3|A2:1-3|A3:2-3|B1:2-3 A1:P0|A3:P0|B1:P-2"
> +	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-1|A2:1|A3:1|B1:2-3 A1:P0|A3:P0|B1:P2 2-3"
>  	" C0-3:S+ C1-3:S+ C2-3   C4-5     .      .      .      P2    0 B1:4-5 B1:P2 4-5"
>  	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3  X2-3:P2   P2    0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
>  	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3 X2-3:P2:C1-3 P2  0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
> @@ -318,7 +318,7 @@ TEST_MATRIX=(
>  	# Invalid to valid local partition direct transition tests
>  	" C1-3:S+:P2 X4:P2  .      .      .      .      .      .     0 A1:1-3|XA1:1-3|A2:1-3:XA2: A1:P2|A2:P-2 1-3"
>  	" C1-3:S+:P2 X4:P2  .      .      .    X3:P2    .      .     0 A1:1-2|XA1:1-3|A2:3:XA2:3 A1:P2|A2:P2 1-3"
> -	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:4-6 A1:P-2|B1:P0"
> +	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:5-6 A1:P2|B1:P0 0-4"
>  	"  C0-3:P2   .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3|B1:4-6 A1:P2|B1:P0 0-3"
>  
>  	# Local partition invalidation tests
> @@ -388,10 +388,10 @@ TEST_MATRIX=(
>  	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1|A2:1 A1:P0|A2:P-2"
>  	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0|A2:1 A1:P1|A2:P2 0-1|1"
>  
> -	# A non-exclusive cpuset.cpus change will invalidate partition and its siblings
> -	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P0"
> +	# A non-exclusive cpuset.cpus change will not invalidate partition and its siblings
> +	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:3 A1:P1|B1:P0"
>  	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P-1"
> -	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P0|B1:P-1"
> +	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|B1:2-3 A1:P0|B1:P1"
>  
>  	# cpuset.cpus can overlap with sibling cpuset.cpus.exclusive but not subsumed by it
>  	"   C0-3     .      .    C4-5     X5     .      .      .     0 A1:0-3|B1:4-5"

-- 
Best regards,
Ridong


