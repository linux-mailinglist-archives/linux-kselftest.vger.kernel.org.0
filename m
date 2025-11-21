Return-Path: <linux-kselftest+bounces-46200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56969C77BEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 08:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEED3351EDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 07:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6057428D8D0;
	Fri, 21 Nov 2025 07:47:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDAA23AB8A;
	Fri, 21 Nov 2025 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763711276; cv=none; b=KdDrScQPrQ2a5JLebZL7eFA4OzkZMeHPllHBLo/22wXTPC62FVcmd9Kw56m78UiG2lP5h/jWTqkGKF06BFWNXa9MftLHFWdnCE47YjVS1BRpe/vDCcwChkIjcnB/+RgqDnudlEvU1ineq/CTjxayznEd+hD0G+ln6pAVUn1zjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763711276; c=relaxed/simple;
	bh=1CXyyfR3TBKufsEIccWMysCnNvbUO/wchP7sL1WGubo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVqjOp1zUXJ9aTkqUI/CfqNLzi4DUsLWLXaJNLsf+AqgbhEX3f4rqM2I5L77dfwMVpP+yUIOO+04V36FwXWPQqDOoWUkNsnqdB0EQva0aygzx/CKpPUtIyC5AmStk3QmKJoLsOQge95r0gHLatTZDOFYxLq4sICnguMbZa1s7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5c6868fcc6ae11f0a38c85956e01ac42-20251121
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:c47afd99-8d09-4ddf-aff3-c959e8862316,IP:20,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:c47afd99-8d09-4ddf-aff3-c959e8862316,IP:20,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:ed791c21fc197a444815489b1aed3c13,BulkI
	D:251120233527X6NZUQMX,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5c6868fcc6ae11f0a38c85956e01ac42-20251121
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.24.105] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1849455201; Fri, 21 Nov 2025 15:47:42 +0800
Message-ID: <f7553219-e19d-4172-90da-a2077cb574cc@kylinos.cn>
Date: Fri, 21 Nov 2025 15:47:39 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: cgroup: make test_memcg_sock robust against
 delayed sock stats
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 lance.yang@linux.dev, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251120060406.2846257-1-zhangguopeng@kylinos.cn>
 <p655qedqjaakrnqpytc6dltejfluxo6jrffcltfz2ivonmk6lb@bxf5xlgo4iw2>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <p655qedqjaakrnqpytc6dltejfluxo6jrffcltfz2ivonmk6lb@bxf5xlgo4iw2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/20/25 23:35, Michal Koutný wrote:
> Hello Guopeng.
> 
> +Cc Leon Huang Fu <leon.huangfu@shopee.com>   
> 
> On Thu, Nov 20, 2025 at 02:04:06PM +0800, Guopeng Zhang <zhangguopeng@kylinos.cn> wrote:
>> test_memcg_sock() currently requires that memory.stat's "sock " counter
>> is exactly zero immediately after the TCP server exits. On a busy system
>> this assumption is too strict:
>>
>>   - Socket memory may be freed with a small delay (e.g. RCU callbacks).
> 
> (FTR, I remember there is `echo 1 > /sys/module/rcutree/parameters/do_rcu_barrier`,
> however, I'm not sure it works always as expected (a reader may actually
> wait for multi-stage RCU pipeline), so plain timeout is more reliable.)
> 
Hi Michal,

Thank you for the suggestion.

I tested using `echo 1 > /sys/module/rcutree/parameters/do_rcu_barrier`, but
unfortunately the effect was not very good on my setup. As you mentioned, a
reader may actually wait for the multi-stage RCU pipeline, so a plain timeout
seems more reliable here.
>>   - memcg statistics are updated asynchronously via the rstat flushing
>>     worker, so the "sock " value in memory.stat can stay non-zero for a
>>     short period of time even after all socket memory has been uncharged.
>>
>> As a result, test_memcg_sock() can intermittently fail even though socket
>> memory accounting is working correctly.
>>
>> Make the test more robust by polling memory.stat for the "sock "
>> counter and allowing it some time to drop to zero instead of checking
>> it only once.
> 
> I like the approach of adaptive waiting to settle in such tests.
> 
>> The timeout is set to 3 seconds to cover the periodic rstat flush
>> interval (FLUSH_TIME = 2*HZ by default) plus some scheduling slack. If
>> the counter does not become zero within the timeout, the test still
>> fails as before.
>>
>> On my test system, running test_memcontrol 50 times produced:
>>
>>   - Before this patch:  6/50 runs passed.
>>   - After this patch:  50/50 runs passed.
> 
> BTW Have you looked into the number of retries until success?
> Was it in accordance with the flushing interval?
> 
Yes. From my observations, it usually succeeds after about 10–15 retries on
average (roughly 1–1.5 seconds), and occasionally it takes more than 20 retries
(>2 seconds). This looks broadly in line with the periodic rstat flushing
interval (~2 seconds) plus some scheduling slack.
>>
>> Suggested-by: Lance Yang <lance.yang@linux.dev>
>> Reviewed-by: Lance Yang <lance.yang@linux.dev>
>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>> ---
>> v3:
>>  - Move MEMCG_SOCKSTAT_WAIT_* defines after the #include block as
>>    suggested.
>> v2:
>>  - Mention the periodic rstat flush interval (FLUSH_TIME = 2*HZ) in
>>    the comment and clarify the rationale for the 3s timeout.
>>  - Replace the hard-coded retry count and wait interval with macros
>>    to avoid magic numbers and make the 3s timeout calculation explicit.
>> ---
>>  .../selftests/cgroup/test_memcontrol.c        | 30 ++++++++++++++++++-
>>  1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
>> index 4e1647568c5b..8ff7286fc80b 100644
>> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
>> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
>> @@ -21,6 +21,9 @@
>>  #include "kselftest.h"
>>  #include "cgroup_util.h"
>>  
>> +#define MEMCG_SOCKSTAT_WAIT_RETRIES        30              /* 3s total */
>> +#define MEMCG_SOCKSTAT_WAIT_INTERVAL_US    (100 * 1000)    /* 100 ms */
>> +
>>  static bool has_localevents;
>>  static bool has_recursiveprot;
>>  
>> @@ -1384,6 +1387,8 @@ static int test_memcg_sock(const char *root)
>>  	int bind_retries = 5, ret = KSFT_FAIL, pid, err;
>>  	unsigned short port;
>>  	char *memcg;
>> +	long sock_post = -1;
>> +	int i;
>>  
>>  	memcg = cg_name(root, "memcg_test");
>>  	if (!memcg)
>> @@ -1432,7 +1437,30 @@ static int test_memcg_sock(const char *root)
>>  	if (cg_read_long(memcg, "memory.current") < 0)
>>  		goto cleanup;
>>  
>> -	if (cg_read_key_long(memcg, "memory.stat", "sock "))
>> +	/*
>> +	 * memory.stat is updated asynchronously via the memcg rstat
>> +	 * flushing worker, which runs periodically (every 2 seconds,
>> +	 * see FLUSH_TIME). On a busy system, the "sock " counter may
>> +	 * stay non-zero for a short period of time after the TCP
>> +	 * connection is closed and all socket memory has been
>> +	 * uncharged.
>> +	 *
>> +	 * Poll memory.stat for up to 3 seconds (~FLUSH_TIME plus some
>> +	 * scheduling slack) and require that the "sock " counter
>> +	 * eventually drops to zero.
>> +	 */
>> +	for (i = 0; i < MEMCG_SOCKSTAT_WAIT_RETRIES; i++) {
>> +		sock_post = cg_read_key_long(memcg, "memory.stat", "sock ");
>> +		if (sock_post < 0)
>> +			goto cleanup;
>> +
>> +		if (!sock_post)
>> +			break;
>> +
>> +		usleep(MEMCG_SOCKSTAT_WAIT_INTERVAL_US);
>> +	}
> 
> I think this may be useful also for othe tests (at least other
> memory.stat checks), so some encapsulated implementation like a macro
> with parameters
> 	cg_read_assert_gt_with_retries(cg, file, field, exp, timeout, retries)
> WDYT?
> 
> Michal

That’s a great idea. I agree this pattern could be useful for other
`memory.stat` checks as well, and I will implement an encapsulated helper/macro
along those lines as per your suggestion.

Thanks,
Guopeng


