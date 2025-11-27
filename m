Return-Path: <linux-kselftest+bounces-46629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E09BC8DFA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 12:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9D63B5488
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CA932D422;
	Thu, 27 Nov 2025 11:18:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512C32D426;
	Thu, 27 Nov 2025 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242319; cv=none; b=lNgo8MtRX37biIF5HJj9eTgb4j/YuuaSA8llhjCDlEXAwdN4aorNOCaUJ37nv0f3R2eKmIkzLB+o6qCUfcNAz8QQzKsYjfZht7p7gwxEv18RjOsUslYURCmY3UadRJDUO7acpACMEZAccXDrR/y1C8qAug4+IY6j7sYdHc55o44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242319; c=relaxed/simple;
	bh=UiiU7wqvWJPByc9jdlvqpibW8b8ecq/TZytSdozNz9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayiEzTfKsOgQpyRfbpyAElvkFg9pOJNXu7sECGydb7WfYfzBlVm4gOwP9dyfarvtOgR7C/JD6830ZrtMXs09VJZE/8c3PHDUzJheM6BHVsI1rMyG4j/SBNbQofdjbflKlQsjmTZtH6b8qfBk+iHCR8PZz8ThzCAN6x4NE9XpzDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c7fe0a6ccb8211f0a38c85956e01ac42-20251127
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ad6b010e-7e9c-454f-8d10-440a32aef2ad,IP:20,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:ad6b010e-7e9c-454f-8d10-440a32aef2ad,IP:20,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:ac23435250749fcb68881771cadf2b61,BulkI
	D:251127185555KE68HCIH,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:1,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c7fe0a6ccb8211f0a38c85956e01ac42-20251127
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.24.105] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1804284380; Thu, 27 Nov 2025 19:18:20 +0800
Message-ID: <07b9bdd1-3499-41a7-bef2-9428935fd3f1@kylinos.cn>
Date: Thu, 27 Nov 2025 19:18:15 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] selftests: cgroup: make test_memcg_sock robust
 against delayed sock stats
To: Lance Yang <lance.yang@linux.dev>
Cc: shuah@kernel.org, muchun.song@linux.dev, mkoutny@suse.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev,
 linux-kernel@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev,
 Andrew Morton <akpm@linux-foundation.org>
References: <20251124123816.486164-1-zhangguopeng@kylinos.cn>
 <20251124123816.486164-3-zhangguopeng@kylinos.cn>
 <8ce13061-b4a7-4474-9e57-bab9b1a62b63@linux.dev>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <8ce13061-b4a7-4474-9e57-bab9b1a62b63@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/27/25 18:55, Lance Yang wrote:
> 
> 
> On 2025/11/24 20:38, Guopeng Zhang wrote:
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
>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>> Suggested-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   .../selftests/cgroup/test_memcontrol.c        | 20 ++++++++++++++++++-
>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
>> index 4e1647568c5b..dda12e5c6457 100644
>> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
>> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
>> @@ -21,6 +21,8 @@
>>   #include "kselftest.h"
> 
> This patch fails to apply to mm-new ...
> 
> Hmm, it expects #include "kselftest.h" here, but the tree uses
> #include "../kselftest.h".
> 
> Which is odd, as that line hasn't been touched in years ...
Hi,lance

Thanks for your review.

When I prepared this patch I was working on linux-next, where
tools/testing/selftests/cgroup/test_memcontrol.c already uses:

    #include "kselftest.h"

I just checked, and this change comes from the following commit:

    1aaedc385b9b278dcf91f4e9d0c3e1a078804ff1
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20251127&id=1aaedc385b9b278dcf91f4e9d0c3e1a078804ff1

So the patch applies cleanly on top of the latest linux-next, but not on
mm-new which still has `#include "../kselftest.h"`.

Thanks,
Guopeng



