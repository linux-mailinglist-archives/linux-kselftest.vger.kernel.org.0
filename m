Return-Path: <linux-kselftest+bounces-45599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF260C5AD8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 01:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6EDE35266C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 00:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3C721E097;
	Fri, 14 Nov 2025 00:50:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC9163;
	Fri, 14 Nov 2025 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763081417; cv=none; b=PXHOHi9TrKaXFcqwPUObTvG4x9uBYRYar4Y1ZZIa4gVS5ek70p2tzvaajhmKGauimUFu28YvAWJSRZ0E888GJvpv2DzSlxiWhFqfrbf6bReYzPLvae+wArTlnOrha+DI0jRFh1eCdg6eDTVmRywwj1YLoMfTbvZcqoDCr4ioMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763081417; c=relaxed/simple;
	bh=xAxOvXP86nakyrMrBn+/Yx2U7yB+cawtLydJdkIsyR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emhjBOO/yfefuMRB69J5wXLnk32gpE3/hltjS/Iugew3Ntf680HCkK8cTwHQSDlWPXUf+D9a0SKsfDY7MK9oQXU6GCE4k5rrRJ7nB0xeFTcvRYm52HIOiJzy/HI6SEZbtxEkquNQnjh1pbbzQ9F8fOMUaUEow6+Mk/WcPh4Yxig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d6z7M1HRJzKHM0B;
	Fri, 14 Nov 2025 08:49:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0A3451A13E5;
	Fri, 14 Nov 2025 08:50:11 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgA3cku_fBZpDTKfAg--.32867S2;
	Fri, 14 Nov 2025 08:50:08 +0800 (CST)
Message-ID: <19fa5a93-4cc9-4f84-891c-b3b096a68799@huaweicloud.com>
Date: Fri, 14 Nov 2025 08:50:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
To: Sun Shaojie <sunshaojie@kylinos.cn>, llong@redhat.com
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mkoutny@suse.com, shuah@kernel.org, tj@kernel.org
References: <20251113131434.606961-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251113131434.606961-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgA3cku_fBZpDTKfAg--.32867S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr43Gr1UWw1fGFWDJw1rtFb_yoW7JFykpF
	ykKr1jvw4YgF1jkwnFgF18XwsYqw12qF1UJwn8Jw1xZF9rJFnrur1qk39xJFW5ur45Gw15
	u39xZ393WFsIq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/11/13 21:14, Sun Shaojie wrote:
> In cgroup v2, a mutual overlap check is required when at least one of two
> cpusets is exclusive. However, this check should be relaxed and limited to
> cases where both cpusets are exclusive.
> 
> The table 1 shows the partition states of A1 and B1 after each step before
> applying this patch.
> 
> Table 1: Before applying the patch
>  Step                                       | A1's prstate | B1's prstate |
>  #1> mkdir -p A1                            | member       |              |
>  #2> echo "0-1" > A1/cpuset.cpus            | member       |              |
>  #3> echo "root" > A1/cpuset.cpus.partition | root         |              |
>  #4> mkdir -p B1                            | root         | member       |
>  #5> echo "0-3" > B1/cpuset.cpus            | root invalid | member       |
>  #6> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid |
> 
> After step #5, A1 changes from "root" to "root invalid" because its CPUs
> (0-1) overlap with those requested by B1 (0-3). However, B1 can actually
> use CPUs 2-3, so it would be more reasonable for A1 to remain as "root."
> 
> This patch relaxes the exclusive cpuset check for cgroup v2 while
> preserving the current cgroup v1 behavior.
> 
> Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
> 
> ---
> v1 -> v2:
>   - Keeps the current cgroup v1 behavior unchanged
>   - Link: https://lore.kernel.org/cgroups/c8e234f4-2c27-4753-8f39-8ae83197efd3@redhat.com
> ---
>  kernel/cgroup/cpuset.c                            |  9 +++++++--
>  tools/testing/selftests/cgroup/test_cpuset_prs.sh | 10 +++++-----
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 52468d2c178a..3240b3ab5998 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -592,8 +592,13 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>   */
>  static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>  {
> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
> +	/* If both cpusets are exclusive, check if they are mutually exclusive */
> +	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
> +		return !cpusets_are_exclusive(cs1, cs2);
> +
> +	/* In cgroup-v1, if either cpuset is exclusive, check if they are mutually exclusive */
> +	if (!is_in_v2_mode() &&
> +	    (is_cpu_exclusive(cs1) != is_cpu_exclusive(cs2)))
>  		return !cpusets_are_exclusive(cs1, cs2);
>  

I prefer adding a helper function in the cpuset-v1.c file, similar to cpus_excl_conflict_legacy().

For cpuset v1, it can simply return cpus_excl_conflict_legacy(). It seems that other rules are not
relevant to v1.

>  	/* Exclusive_cpus cannot intersect */
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


