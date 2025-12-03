Return-Path: <linux-kselftest+bounces-46938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A2C9EECB
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 13:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 403D9341BAE
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A6D2F6164;
	Wed,  3 Dec 2025 12:00:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EDB29D267;
	Wed,  3 Dec 2025 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764763200; cv=none; b=KUibkavvsqEpWuVbxOln8cIk0loiMVb6eO5Sj7Td1ZQFwBaVVUfU6ttkL1GuTnz/1Qv2T/pQAjmL30aUKBKMBpdQLK6dpgUTRwfd1YUYKPelgccf6gd0lsxYOpq3O/OOkaxbwQCnU565Ma8kQAFfmNTA90U4Eh3V85H+b49tniY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764763200; c=relaxed/simple;
	bh=+zzEaWXtyZ7umn8MB+f3TPY1SSUIZgG84dCtfu2zMWw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EWQx0klogmV1M+v4CYsfHKeV/WUt/Mc3eHd25/pK8l6a/scm5hE2IcgBVOjCdKNDGUrwdEdkdbW57Tl2GJVBr0Mw0J5gAnNb1oW5JNMMkQGIuf+8NMDIgCzKi6tGMQkePCVJAN85Q9cWbF4rjuYaGMz3T/uIXsNYSKSHahczgtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9425e766d03f11f0a38c85956e01ac42-20251203
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5b83410b-1a13-40e2-9e25-4f438dd71b9a,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:5b83410b-1a13-40e2-9e25-4f438dd71b9a,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:161b65e2e8a1b24f3f8f0378b4a6013a,BulkI
	D:251120233527X6NZUQMX,BulkQuantity:2,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9425e766d03f11f0a38c85956e01ac42-20251203
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.24.105] [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1309268471; Wed, 03 Dec 2025 19:59:53 +0800
Message-ID: <440f6a44-5d1a-44d6-b776-ec58e6c79f37@kylinos.cn>
Date: Wed, 3 Dec 2025 19:59:46 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: cgroup: make test_memcg_sock robust against
 delayed sock stats
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 lance.yang@linux.dev, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251120060406.2846257-1-zhangguopeng@kylinos.cn>
 <p655qedqjaakrnqpytc6dltejfluxo6jrffcltfz2ivonmk6lb@bxf5xlgo4iw2>
 <f7553219-e19d-4172-90da-a2077cb574cc@kylinos.cn>
In-Reply-To: <f7553219-e19d-4172-90da-a2077cb574cc@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/21/25 15:47, Guopeng Zhang wrote:
> 
> 
> On 11/20/25 23:35, Michal Koutný wrote:
>> Hello Guopeng.
>>
>> +Cc Leon Huang Fu <leon.huangfu@shopee.com>   
>>
>> On Thu, Nov 20, 2025 at 02:04:06PM +0800, Guopeng Zhang <zhangguopeng@kylinos.cn> wrote:
>>> test_memcg_sock() currently requires that memory.stat's "sock " counter
>>> is exactly zero immediately after the TCP server exits. On a busy system
>>> this assumption is too strict:
>>>
>>>   - Socket memory may be freed with a small delay (e.g. RCU callbacks).
>>
>> (FTR, I remember there is `echo 1 > /sys/module/rcutree/parameters/do_rcu_barrier`,
>> however, I'm not sure it works always as expected (a reader may actually
>> wait for multi-stage RCU pipeline), so plain timeout is more reliable.)
>>
> Hi Michal,
> 
> Thank you for the suggestion.
> 
> I tested using `echo 1 > /sys/module/rcutree/parameters/do_rcu_barrier`, but
> unfortunately the effect was not very good on my setup. As you mentioned, a
> reader may actually wait for the multi-stage RCU pipeline, so a plain timeout
> seems more reliable here.
>>>   - memcg statistics are updated asynchronously via the rstat flushing
>>>     worker, so the "sock " value in memory.stat can stay non-zero for a
>>>     short period of time even after all socket memory has been uncharged.
>>>
>>> As a result, test_memcg_sock() can intermittently fail even though socket
>>> memory accounting is working correctly.
>>>
>>> Make the test more robust by polling memory.stat for the "sock "
>>> counter and allowing it some time to drop to zero instead of checking
>>> it only once.
>>
>> I like the approach of adaptive waiting to settle in such tests.
>>
>>> The timeout is set to 3 seconds to cover the periodic rstat flush
>>> interval (FLUSH_TIME = 2*HZ by default) plus some scheduling slack. If
>>> the counter does not become zero within the timeout, the test still
>>> fails as before.
>>>
>>> On my test system, running test_memcontrol 50 times produced:
>>>
>>>   - Before this patch:  6/50 runs passed.
>>>   - After this patch:  50/50 runs passed.
>>
>> BTW Have you looked into the number of retries until success?
>> Was it in accordance with the flushing interval?
>>
> Yes. From my observations, it usually succeeds after about 10–15 retries on
> average (roughly 1–1.5 seconds), and occasionally it takes more than 20 retries
> (>2 seconds). This looks broadly in line with the periodic rstat flushing
> interval (~2 seconds) plus some scheduling slack.
>>>
>>> Suggested-by: Lance Yang <lance.yang@linux.dev>
>>> Reviewed-by: Lance Yang <lance.yang@linux.dev>
>>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>>> ---
>>> v3:
>>>  - Move MEMCG_SOCKSTAT_WAIT_* defines after the #include block as
>>>    suggested.
>>> v2:
>>>  - Mention the periodic rstat flush interval (FLUSH_TIME = 2*HZ) in
>>>    the comment and clarify the rationale for the 3s timeout.
>>>  - Replace the hard-coded retry count and wait interval with macros
>>>    to avoid magic numbers and make the 3s timeout calculation explicit.
>>> ---
>>>  .../selftests/cgroup/test_memcontrol.c        | 30 ++++++++++++++++++-
>>>  1 file changed, 29 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
>>> index 4e1647568c5b..8ff7286fc80b 100644
>>> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
>>> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
>>> @@ -21,6 +21,9 @@
>>>  #include "kselftest.h"
>>>  #include "cgroup_util.h"
>>>  
>>> +#define MEMCG_SOCKSTAT_WAIT_RETRIES        30              /* 3s total */
>>> +#define MEMCG_SOCKSTAT_WAIT_INTERVAL_US    (100 * 1000)    /* 100 ms */
>>> +
>>>  static bool has_localevents;
>>>  static bool has_recursiveprot;
>>>  
>>> @@ -1384,6 +1387,8 @@ static int test_memcg_sock(const char *root)
>>>  	int bind_retries = 5, ret = KSFT_FAIL, pid, err;
>>>  	unsigned short port;
>>>  	char *memcg;
>>> +	long sock_post = -1;
>>> +	int i;
>>>  
>>>  	memcg = cg_name(root, "memcg_test");
>>>  	if (!memcg)
>>> @@ -1432,7 +1437,30 @@ static int test_memcg_sock(const char *root)
>>>  	if (cg_read_long(memcg, "memory.current") < 0)
>>>  		goto cleanup;
>>>  
>>> -	if (cg_read_key_long(memcg, "memory.stat", "sock "))
>>> +	/*
>>> +	 * memory.stat is updated asynchronously via the memcg rstat
>>> +	 * flushing worker, which runs periodically (every 2 seconds,
>>> +	 * see FLUSH_TIME). On a busy system, the "sock " counter may
>>> +	 * stay non-zero for a short period of time after the TCP
>>> +	 * connection is closed and all socket memory has been
>>> +	 * uncharged.
>>> +	 *
>>> +	 * Poll memory.stat for up to 3 seconds (~FLUSH_TIME plus some
>>> +	 * scheduling slack) and require that the "sock " counter
>>> +	 * eventually drops to zero.
>>> +	 */
>>> +	for (i = 0; i < MEMCG_SOCKSTAT_WAIT_RETRIES; i++) {
>>> +		sock_post = cg_read_key_long(memcg, "memory.stat", "sock ");
>>> +		if (sock_post < 0)
>>> +			goto cleanup;
>>> +
>>> +		if (!sock_post)
>>> +			break;
>>> +
>>> +		usleep(MEMCG_SOCKSTAT_WAIT_INTERVAL_US);
>>> +	}
>>
>> I think this may be useful also for othe tests (at least other
>> memory.stat checks), so some encapsulated implementation like a macro
>> with parameters
>> 	cg_read_assert_gt_with_retries(cg, file, field, exp, timeout, retries)
>> WDYT?
>>
>> Michal
> 
> That’s a great idea. I agree this pattern could be useful for other
> `memory.stat` checks as well, and I will implement an encapsulated helper/macro
> along those lines as per your suggestion.
> 
> Thanks,
> Guopeng
> 
Hi Michal,

Thanks again for your earlier suggestion about encapsulating this pattern
into a helper/macro like:

    cg_read_assert_gt_with_retries(cg, file, field, exp, timeout, retries)

In v5 I tried to follow that direction by introducing a generic helper
function:

    cg_read_key_long_poll()

in cgroup_util.[ch]. This helper encapsulates the "poll with retries"
logic and returns the final value, while leaving the actual assertion
to the callers. Tests like test_memcg_sock() and test_kmem_dead_cgroups()
then decide what condition they want to check (e.g. == 0, > 0, etc.),
which seemed a bit more flexible and reusable for other cgroup stats.

Please let me know if you think this direction makes sense or if you have
any further suggestions.

Thanks again for the suggestion and for your feedback.

Best regards,
Guopeng

