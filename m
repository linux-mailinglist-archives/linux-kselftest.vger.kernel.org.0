Return-Path: <linux-kselftest+bounces-46065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 456E7C724C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 07:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCA2234C23F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 06:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E02426F2B9;
	Thu, 20 Nov 2025 06:09:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB2372AA1;
	Thu, 20 Nov 2025 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763618969; cv=none; b=cen/W4+iIOfx3pCZmQpiQxewFLlrUVVyknzBtS1m0QJ+hU0ZtSnZrr/DTfjB5S+kymiblEHiw/OCv/slf/SsgkiHa6+qYRfHGoJYOtr2LXMOSUSbSf4idreH/EOmjeoEaZols96+mi3CWQ5CA4L3n00pEwBXlYlRhO5udyDCpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763618969; c=relaxed/simple;
	bh=8zVqg0xOhXG8/2wy94SKdregLsVCiRFEZuM90JOX/oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+z8BEMeELG49A4C1626F6SSnxkYMI5F3G0Mz0rrbAY5z9YpiHT6Uz3C2MW5PUxW5qmgwMEZlOVNDiEJnvW88B2Z+cpgp+w5FB79h2VYT0eT+AVzRyiYg6Rmv0CwkWvCCsPa5MwJGpgOCVWw0uFrUiU4P7rEh8el/q0GWbAqOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 72d87d48c5d711f0a38c85956e01ac42-20251120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:35555e7c-4513-473d-942b-10595bd58636,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:35555e7c-4513-473d-942b-10595bd58636,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:a52600f6b0d97fa4666b3ab345936255,BulkI
	D:251120134057RJ6KFBKQ,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|841,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 72d87d48c5d711f0a38c85956e01ac42-20251120
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.24.105] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 913754144; Thu, 20 Nov 2025 14:09:18 +0800
Message-ID: <2fda06e4-19ac-497d-8f42-73972bdd761e@kylinos.cn>
Date: Thu, 20 Nov 2025 14:09:14 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: cgroup: make test_memcg_sock robust against
 delayed sock stats
To: Lance Yang <lance.yang@linux.dev>
Cc: shuah@kernel.org, mkoutny@suse.com, linux-mm@kvack.org,
 muchun.song@linux.dev, linux-kselftest@vger.kernel.org,
 shakeel.butt@linux.dev, linux-kernel@vger.kernel.org, tj@kernel.org,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev
References: <20251120031619.1828911-1-zhangguopeng@kylinos.cn>
 <5ad2b75f-748a-4e93-8d11-63295bda0cbf@linux.dev>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <5ad2b75f-748a-4e93-8d11-63295bda0cbf@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/20/25 13:40, Lance Yang wrote:
> 
> 
> On 2025/11/20 11:16, Guopeng Zhang wrote:
>> test_memcg_sock() currently requires that memory.stat's "sock " counter
>> is exactly zero immediately after the TCP server exits. On a busy system
>> this assumption is too strict:
>>
>>    - Socket memory may be freed with a small delay (e.g. RCU callbacks).
>>    - memcg statistics are updated asynchronously via the rstat flushing
>>      worker, so the "sock " value in memory.stat can stay non-zero for a
>>      short period of time even after all socket memory has been uncharged.
>>
>> As a result, test_memcg_sock() can intermittently fail even though socket
>> memory accounting is working correctly.
>>
>> Make the test more robust by polling memory.stat for the "sock "
>> counter and allowing it some time to drop to zero instead of checking
>> it only once. The timeout is set to 3 seconds to cover the periodic
>> rstat flush interval (FLUSH_TIME = 2*HZ by default) plus some
>> scheduling slack. If the counter does not become zero within the
>> timeout, the test still fails as before.
>>
>> On my test system, running test_memcontrol 50 times produced:
>>
>>    - Before this patch:  6/50 runs passed.
>>    - After this patch:  50/50 runs passed.
>>
>> Suggested-by: Lance Yang <lance.yang@linux.dev>
>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>> ---
>> v2:
>>   - Mention the periodic rstat flush interval (FLUSH_TIME = 2*HZ) in
>>     the comment and clarify the rationale for the 3s timeout.
>>   - Replace the hard-coded retry count and wait interval with macros
>>     to avoid magic numbers and make the 3s timeout calculation explicit.
>> ---
>>   .../selftests/cgroup/test_memcontrol.c        | 30 ++++++++++++++++++-
>>   1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
>> index 4e1647568c5b..7bea656658a2 100644
>> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
>> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
>> @@ -24,6 +24,9 @@
>>   static bool has_localevents;
>>   static bool has_recursiveprot;
>>   +#define MEMCG_SOCKSTAT_WAIT_RETRIES        30              /* 3s total */
>> +#define MEMCG_SOCKSTAT_WAIT_INTERVAL_US    (100 * 1000)    /* 100 ms */
> 
> Nit: Defines are usually placed at the top of the file (e.g., after the
> #include block). Placing them between global variables and functions
> looks a bit out of place, IMHO ...
> Otherwise, feel free to add:
> 
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> [...]
> 
> Cheers,
> Lance
Thanks for the review and the suggestion!

Good point about the placement of the defines — I’ll move
MEMCG_SOCKSTAT_WAIT_* after the #include block in v3 as you suggested,
and I’ll add your:

    Reviewed-by: Lance Yang <lance.yang@linux.dev>

as well.

Thanks again!

Best regards,
Guopeng


