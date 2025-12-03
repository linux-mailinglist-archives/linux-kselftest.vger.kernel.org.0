Return-Path: <linux-kselftest+bounces-46927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53CEC9DA4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 04:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECA33A69FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 03:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1286E246783;
	Wed,  3 Dec 2025 03:28:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34B622B8CB;
	Wed,  3 Dec 2025 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764732480; cv=none; b=SZ7Qh9QrurHfQVXJGXVfsoMp/+HIcOV4sRyfmV383Xd2F7gYVj+asdRxMuzLCch7TBhgvukGLa2B8RbQ4PYsLJDsa5ETr+0kTz+hF7pdvMmrpjJ4uSFwd3QkP6XinBjgqc3om7c389FNtLBDZHEP+QLc4PcmCdlfQzj8FrNJcbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764732480; c=relaxed/simple;
	bh=lMVj545GHgY2Yys5sjuTY81j7hqS9MZ4VS/0OSgEzJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDhubQmDMAiYNki79bbjwrMeRmMyMd2DAbrOmApnscnZG3MCkmRjf8BK6EFqlKTLEdwa6uczyPWMJ/3nFeVPzCbbMVNRPenjquaqQCRXbOoPkxlRllgcXos2FGIrIJ7tn/lwANlbDCPmv/0OB6ra/4nspaGCOebhon0Nm1cjY+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0bef3c36cff811f0a38c85956e01ac42-20251203
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ad37dd2f-44d2-4f3c-991a-89a4075088f5,IP:10,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:7
X-CID-INFO: VERSION:1.3.6,REQID:ad37dd2f-44d2-4f3c-991a-89a4075088f5,IP:10,URL
	:0,TC:0,Content:2,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:7
X-CID-META: VersionHash:a9d874c,CLOUDID:a4568913cfbad42cd49316be8af8bbac,BulkI
	D:251127185555KE68HCIH,BulkQuantity:4,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:4|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0bef3c36cff811f0a38c85956e01ac42-20251203
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.24.105] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 718298084; Wed, 03 Dec 2025 11:27:50 +0800
Message-ID: <240ebe22-6e1c-4481-8a5e-b929bbfad178@kylinos.cn>
Date: Wed, 3 Dec 2025 11:27:47 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] selftests: cgroup: make test_memcg_sock robust
 against delayed sock stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, mkoutny@suse.com, muchun.song@linux.dev,
 lance.yang@linux.dev, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251124123816.486164-1-zhangguopeng@kylinos.cn>
 <20251124123816.486164-3-zhangguopeng@kylinos.cn>
 <me7djjzkgufieiyvrsbezi4i4t6v5zsbonirjlacce6hgilb2c@sxnifdeh2gnv>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <me7djjzkgufieiyvrsbezi4i4t6v5zsbonirjlacce6hgilb2c@sxnifdeh2gnv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/3/25 07:12, Shakeel Butt wrote:
> On Mon, Nov 24, 2025 at 08:38:15PM +0800, Guopeng Zhang wrote:
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
>> Make the test more robust by polling memory.stat for the "sock "
>> counter and allowing it some time to drop to zero instead of checking
>> it only once. The timeout is set to 3 seconds to cover the periodic
>> rstat flush interval (FLUSH_TIME = 2*HZ by default) plus some
>> scheduling slack. If the counter does not become zero within the
>> timeout, the test still fails as before.
>>
>> On my test system, running test_memcontrol 50 times produced:
>>
>>   - Before this patch:  6/50 runs passed.
>>   - After this patch:  50/50 runs passed.
>>
>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>> Suggested-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>  .../selftests/cgroup/test_memcontrol.c        | 20 ++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
>> index 4e1647568c5b..dda12e5c6457 100644
>> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
>> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
>> @@ -21,6 +21,8 @@
>>  #include "kselftest.h"
>>  #include "cgroup_util.h"
>>  
>> +#define MEMCG_SOCKSTAT_WAIT_RETRIES        30              /* 3s total */
> 
> No need for the comment at the end as it will be stale when someone
> change DEFAULT_WAIT_INTERVAL_US in future.
> 
> Anyways it's a nit.
> 
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Hi Shakeel,

Thanks for the review and for the Reviewed-by.

Good point about the comment. I’ll drop the "/* 3s total */" part in the next version so it does not become stale if DEFAULT_WAIT_INTERVAL_US changes.

Thanks,
Guopeng


