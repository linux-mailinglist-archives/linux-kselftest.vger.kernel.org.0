Return-Path: <linux-kselftest+bounces-46050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 51477C71CC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 041023448C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 02:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A9D18FDBD;
	Thu, 20 Nov 2025 02:12:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B66F1C5D59;
	Thu, 20 Nov 2025 02:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604731; cv=none; b=Ucy/ZIyQ2Iq7/+swlpVInruSlRWUqyAPSKQUPGd6YNluVuxhNBNGfGPrP3xm3ISNn+TrMcnXPfBNpRhUAJLDdAtPa/qsjnWn+OJoHVSMp5FmpebNO5OkCILRUutNmvKsO0J8tZdWeQP6qInx5PS0NOe44ZCrNQP6GhNvLuRqEdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604731; c=relaxed/simple;
	bh=xabPgUOeZhZguIEbrO1XA+1LdYKCnr/gMAvqqY4N3s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWe6Xx936c76Dz6VS3BJJvKk932jy7g2/pwFgQF6dobudagzrNUvJstYXNd4cxKQheEXCZAOJLNunMduumiQ/BE7KmnkFTwpkDoPbzT69OnrEbHXuetN7DMSJgKYpUNs0TwA0Qw6+yqt4IfhcQkro7yjZNty/wj06wq+t94Cb7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4d46b0d4c5b611f0a38c85956e01ac42-20251120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ef79d8a0-0334-43ca-b31d-7b08ab0dca32,IP:20,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:ef79d8a0-0334-43ca-b31d-7b08ab0dca32,IP:20,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:5e05ec9e36a263da29547234aa54b56b,BulkI
	D:251119202822NBVZVXBR,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|841,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4d46b0d4c5b611f0a38c85956e01ac42-20251120
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.24.105] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1050465187; Thu, 20 Nov 2025 10:12:01 +0800
Message-ID: <2c276ed9-626f-4bae-9d42-727dd176ec74@kylinos.cn>
Date: Thu, 20 Nov 2025 10:11:49 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: cgroup: make test_memcg_sock robust against
 delayed sock stats
To: Lance Yang <ioworker0@gmail.com>
Cc: hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
 mkoutny@suse.com, muchun.song@linux.dev, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, shuah@kernel.org, tj@kernel.org,
 leon.huangfu@shopee.com, Lance Yang <lance.yang@linux.dev>
References: <20251119105216.1675608-1-zhangguopeng@kylinos.cn>
 <20251119122758.85610-1-ioworker0@gmail.com>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <20251119122758.85610-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/19/25 20:27, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> 
> On Wed, 19 Nov 2025 18:52:16 +0800, Guopeng Zhang wrote:
>> test_memcg_sock() currently requires that memory.stat's "sock " counter
>> is exactly zero immediately after the TCP server exits. On a busy system
>> this assumption is too strict:
>>
>>   - Socket memory may be freed with a small delay (e.g. RCU callbacks).
>>   - memcg statistics are updated asynchronously via the rstat flushing
>>     worker, so the "sock " value in memory.stat can stay non-zero for a
>>     short period of time even after all socket memory has been uncharged.
>>
>> As a result, test_memcg_sock() can intermittently fail even though socket
>> memory accounting is working correctly.
>>
>> Make the test more robust by polling memory.stat for the "sock " counter
>> and allowing it some time to drop to zero instead of checking it only
>> once. If the counter does not become zero within the timeout, the test
>> still fails as before.
>>
>> On my test system, running test_memcontrol 50 times produced:
>>
>>   - Before this patch:  6/50 runs passed.
>>   - After this patch:  50/50 runs passed.
Hi Lance,

Thanks a lot for your review and helpful comments!
> 
> Good catch! Thanks!
> 
> With more CPU cores, updates may be distributed across cores, making it
> slower to reach the per-CPU flush threshold, IIUC :)
> 
Yes, that matches what I’ve seen as well — on larger systems it indeed
takes longer for the stats to converge due to per-CPU distribution and
the flush threshold.
>>
>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>> ---
>>  .../selftests/cgroup/test_memcontrol.c        | 24 ++++++++++++++++++-
>>  1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
>> index 4e1647568c5b..86d9981cddd8 100644
>> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
>> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
>> @@ -1384,6 +1384,8 @@ static int test_memcg_sock(const char *root)
>>  	int bind_retries = 5, ret = KSFT_FAIL, pid, err;
>>  	unsigned short port;
>>  	char *memcg;
>> +	long sock_post = -1;
>> +	int i, retries = 30;
>>  
>>  	memcg = cg_name(root, "memcg_test");
>>  	if (!memcg)
>> @@ -1432,7 +1434,27 @@ static int test_memcg_sock(const char *root)
>>  	if (cg_read_long(memcg, "memory.current") < 0)
>>  		goto cleanup;
>>  
>> -	if (cg_read_key_long(memcg, "memory.stat", "sock "))
>> +	/*
>> +	 * memory.stat is updated asynchronously via the memcg rstat
>> +	 * flushing worker, so the "sock " counter may stay non-zero
>> +	 * for a short period of time after the TCP connection is
>> +	 * closed and all socket memory has been uncharged.
>> +	 *
>> +	 * Poll memory.stat for up to 3 seconds and require that the
>> +	 * "sock " counter eventually drops to zero.
> 
> It might be worth mentioning that the current periodic rstat flush happens
> every 2 seconds (#define FLUSH_TIME (2UL*HZ)). Adding this context to the
> comment would explain why the 3-second timeout was chosen ;)
> 
Good idea,I actually started with a 2-second timeout to match the rstat flush
interval (FLUSH_TIME = 2*HZ), and that already reduced the flakiness
compared to the original code. However, on my test system there were
still a few intermittent failures over multiple runs. Bumping the
timeout to 3 seconds made the test stable (50/50 runs passed), so I
went with a slightly larger value to cover the periodic flush plus
scheduling noise on busy machines. I’ll update the comment in v2 to
spell out this rationale.
>> +	 */
>> +	for (i = 0; i < retries; i++) {
>> +		sock_post = cg_read_key_long(memcg, "memory.stat", "sock ");
>> +		if (sock_post < 0)
>> +			goto cleanup;
>> +
>> +		if (!sock_post)
>> +			break;
>> +
>> +		usleep(100 * 1000); /* 100ms */
> 
> Nit: It would be better to define the retry count and interval as macros
> (e.g., MAX_RETRIES, WAIT_INTERVAL) to avoid magic numbers and make the 3s
> timeout calculation explicit.
> 
Makes sense. I’ll introduce macros for the retry count and the wait
interval in v2 so that the 3s timeout is explicit and we don’t rely on
magic numbers.

I’ll send a v2 shortly.

Best regards,
Guopeng
>> +	}
>> +
>> +	if (sock_post)
>>  		goto cleanup;
>>  
>>  	ret = KSFT_PASS;
> 
> Thanks,
> Lance


