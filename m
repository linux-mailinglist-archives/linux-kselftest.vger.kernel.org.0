Return-Path: <linux-kselftest+bounces-46634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754BBC8E0E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 12:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D363AA48E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 11:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8955A32863F;
	Thu, 27 Nov 2025 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SI3P/f4k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6249632D0CA
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764243021; cv=none; b=J16EuBbLo7qMMtnQnWpsO/+hBUNSQ2UPkHO2N/aDUUgdVto/1Q4RSxgVvyAf8fQMa6Wspx2Ico4jMpSkdGzerfiNm83/2c3EirsfZQClcUfFiW/GDuZblz+Eod3oPbFUSCaFKhQMf+Se0XpkqAsoH2p8xgduM0XrmFk7kE3YQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764243021; c=relaxed/simple;
	bh=e/8qyL9WnzF0uxj7if7UxvR04+zBw419mrHQinra2sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwBKsnMN7BNhbX0hfu7xUz8YA/WTHWwsa3DA1t4coVnB050IYrVYLJIV9TYBjFYiTeWEwdSGqqRbasCM78gEacWa/hYQrhVRWpvQ2zUWEllnZlUZtn+7+G4cug57AjePX8xD7qgFLZrTVzju69H7yztBudMX67b/gWYv61YhwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SI3P/f4k; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4056b77f-ea23-4c49-975c-006a4a8b4733@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764243007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZ2vKUZnYoEZ15SSkH2UVnB4dLdcLSe3Y7SscFwSwJk=;
	b=SI3P/f4kCIFCa2CK/7Ve19704PX3asqZfw1eur6iqTnQ2DcyEYnafSAgjfNkaVEAWIdf6F
	4y/29YH5E+YbKOhori+Tcfdn1zDKxrKXDUdJ4VsrgTDSsir+6RS4CenyUPjQViU15MV41/
	cRdA6/m2N/dRT/uH76Sh1mT8V24Y+9M=
Date: Thu, 27 Nov 2025 19:29:58 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/3] selftests: cgroup: make test_memcg_sock robust
 against delayed sock stats
Content-Language: en-US
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: shuah@kernel.org, muchun.song@linux.dev, mkoutny@suse.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev,
 linux-kernel@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev,
 Andrew Morton <akpm@linux-foundation.org>
References: <20251124123816.486164-1-zhangguopeng@kylinos.cn>
 <20251124123816.486164-3-zhangguopeng@kylinos.cn>
 <8ce13061-b4a7-4474-9e57-bab9b1a62b63@linux.dev>
 <07b9bdd1-3499-41a7-bef2-9428935fd3f1@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <07b9bdd1-3499-41a7-bef2-9428935fd3f1@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/27 19:18, Guopeng Zhang wrote:
> 
> 
> On 11/27/25 18:55, Lance Yang wrote:
>>
>>
>> On 2025/11/24 20:38, Guopeng Zhang wrote:
>>> test_memcg_sock() currently requires that memory.stat's "sock " counter
>>> is exactly zero immediately after the TCP server exits. On a busy system
>>> this assumption is too strict:
>>>
>>>     - Socket memory may be freed with a small delay (e.g. RCU callbacks).
>>>     - memcg statistics are updated asynchronously via the rstat flushing
>>>       worker, so the "sock " value in memory.stat can stay non-zero for a
>>>       short period of time even after all socket memory has been uncharged.
>>>
>>> As a result, test_memcg_sock() can intermittently fail even though socket
>>> memory accounting is working correctly.
>>>
>>> Make the test more robust by polling memory.stat for the "sock "
>>> counter and allowing it some time to drop to zero instead of checking
>>> it only once. The timeout is set to 3 seconds to cover the periodic
>>> rstat flush interval (FLUSH_TIME = 2*HZ by default) plus some
>>> scheduling slack. If the counter does not become zero within the
>>> timeout, the test still fails as before.
>>>
>>> On my test system, running test_memcontrol 50 times produced:
>>>
>>>     - Before this patch:  6/50 runs passed.
>>>     - After this patch:  50/50 runs passed.
>>>
>>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>>> Suggested-by: Lance Yang <lance.yang@linux.dev>
>>> ---
>>>    .../selftests/cgroup/test_memcontrol.c        | 20 ++++++++++++++++++-
>>>    1 file changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
>>> index 4e1647568c5b..dda12e5c6457 100644
>>> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
>>> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
>>> @@ -21,6 +21,8 @@
>>>    #include "kselftest.h"
>>
>> This patch fails to apply to mm-new ...
>>
>> Hmm, it expects #include "kselftest.h" here, but the tree uses
>> #include "../kselftest.h".
>>
>> Which is odd, as that line hasn't been touched in years ...
> Hi,lance
> 
> Thanks for your review.
> 
> When I prepared this patch I was working on linux-next, where
> tools/testing/selftests/cgroup/test_memcontrol.c already uses:
> 
>      #include "kselftest.h"
> 
> I just checked, and this change comes from the following commit:
> 
>      1aaedc385b9b278dcf91f4e9d0c3e1a078804ff1
>      https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20251127&id=1aaedc385b9b278dcf91f4e9d0c3e1a078804ff1
> 
> So the patch applies cleanly on top of the latest linux-next, but not on
> mm-new which still has `#include "../kselftest.h"`.

Ahh, I see, thanks!

